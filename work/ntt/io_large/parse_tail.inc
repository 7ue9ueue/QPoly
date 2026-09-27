// Parser variants for exploration 011, derived from the exploration-007 two-stage AVX2 parser
// qp_parse_flat (work/ntt/io_yosupo/parse_flat.inc): stage 1 (separator offsets from 64-byte
// bitmasks) is unchanged. Stage 2 loads, for each token, the 16 bytes that END just before its
// separator, so the token is already right-aligned; the bytes before it are cleared with an AND
// against a length-indexed mask row instead of a length-indexed pshufb (qp_parse_flat), which
// moves two shuffle-port uops per 4 tokens to any ALU port.
//
// Contract: as qp_parse_flat (1..9 digit tokens separated by bytes <= ' ', 64 readable bytes after
// the last token's separator) plus 16 readable bytes before the first token (window of a 1-digit
// first token); the exploration-011 input mapping provides a guard page before the file.
#pragma once
#include <immintrin.h>
#include <cstddef>
#include <cstdint>

namespace qp_parse_tail {
struct TailMask { alignas(16) uint8_t row[17][16]; };   // row[len][j] = 0xff for j >= 16 - len
constexpr TailMask make_tail_mask() {
    TailMask t{};
    for (int len = 0; len <= 16; ++len)
        for (int j = 0; j < 16; ++j) t.row[len][j] = j >= 16 - len ? 0xff : 0;
    return t;
}
inline constexpr TailMask tail_mask = make_tail_mask();

__attribute__((always_inline)) inline uint64_t separators(const char* p) {
    const __m256i limit = _mm256_set1_epi8(' ' + 1);
    const uint32_t lo = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(limit,
        _mm256_loadu_si256(reinterpret_cast<const __m256i*>(p)))));
    const uint32_t hi = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(limit,
        _mm256_loadu_si256(reinterpret_cast<const __m256i*>(p + 32)))));
    return uint64_t(hi) << 32 | lo;
}
__attribute__((always_inline)) inline __m256i pair(const void* lo, const void* hi) {
    return _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(static_cast<const __m128i*>(lo))),
                                   _mm_loadu_si128(static_cast<const __m128i*>(hi)), 1);
}
__attribute__((always_inline)) inline __m256i groups(__m256i digits) {
    return _mm256_madd_epi16(_mm256_maddubs_epi16(digits, _mm256_set1_epi16(0x010a)), _mm256_set1_epi32(0x00010064));
}
// One token of 1..16 bytes whose separator is at `end` (window [end-16, end)).
__attribute__((always_inline)) inline uint32_t parse_one(const char* end, unsigned len) {
    __m128i x = _mm_subs_epu8(_mm_loadu_si128(reinterpret_cast<const __m128i*>(end - 16)), _mm_set1_epi8('0'));
    x = _mm_and_si128(x, _mm_load_si128(reinterpret_cast<const __m128i*>(tail_mask.row[len])));
    x = _mm_madd_epi16(_mm_maddubs_epi16(x, _mm_set1_epi16(0x010a)), _mm_set1_epi32(0x00010064));
    x = _mm_madd_epi16(_mm_packus_epi32(x, x), _mm_set1_epi32(0x00012710));
    const uint64_t both = uint64_t(_mm_cvtsi128_si64(x));
    return uint32_t(both) * 100000000u + uint32_t(both >> 32);
}
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    constexpr size_t chunk = 32;  // Blocks per stage-1 pass (2 KiB of input).
    alignas(64) uint32_t pos[chunk * 64 + 64];
    const char* const origin = p - 1;  // Offset 0 is the separator before p.
    size_t have = 1, i = 0, scan = 1;
    pos[0] = 0;
    while (count) {
        if (i) {
            for (size_t k = i; k < have; ++k) pos[k - i] = pos[k];
            have -= i, i = 0;
        }
        for (size_t b = 0; b < chunk && count > have - 1; ++b, scan += 64) {
            uint64_t m = separators(origin + scan);
            const size_t found = size_t(__builtin_popcountll(m));
            uint32_t* out = pos + have;
            do {
                for (int j = 0; j < 8; ++j) out[j] = uint32_t(scan + _tzcnt_u64(m)), m = _blsr_u64(m);
                out += 8;
            } while (m);
            have += found;
        }
        for (;;) {
            if (count >= 4 && i + 4 < have) {
                const uint32_t s0 = pos[i], s1 = pos[i + 1], s2 = pos[i + 2], s3 = pos[i + 3], s4 = pos[i + 4];
                const unsigned l0 = s1 - s0 - 1, l1 = s2 - s1 - 1, l2 = s3 - s2 - 1, l3 = s4 - s3 - 1;
                if (__builtin_expect(((l0 - 1) | (l1 - 1) | (l2 - 1) | (l3 - 1)) < 16, 1)) {
                    const __m256i zero = _mm256_set1_epi8('0');
                    __m256i v = _mm256_subs_epu8(pair(origin + s1 - 16, origin + s2 - 16), zero);
                    __m256i w = _mm256_subs_epu8(pair(origin + s3 - 16, origin + s4 - 16), zero);
                    v = groups(_mm256_and_si256(v, pair(tail_mask.row[l0], tail_mask.row[l1])));
                    w = groups(_mm256_and_si256(w, pair(tail_mask.row[l2], tail_mask.row[l3])));
                    const __m256i x = _mm256_madd_epi16(_mm256_packus_epi32(v, w), _mm256_set1_epi32(0x00012710));
                    const __m256i values = _mm256_add_epi32(_mm256_mullo_epi32(x, _mm256_set1_epi32(100000000)),
                                                            _mm256_srli_epi64(x, 32));
                    const __m256i ordered = _mm256_permutevar8x32_epi32(values, _mm256_setr_epi32(0, 4, 2, 6, 0, 4, 2, 6));
                    _mm_storeu_si128(reinterpret_cast<__m128i*>(dst), _mm256_castsi256_si128(ordered));
                    dst += 4, count -= 4, i += 4;
                    continue;
                }
            } else if (!count || i + 1 >= have) {
                break;
            }
            const unsigned len = pos[i + 1] - pos[i] - 1;  // One token, possibly empty.
            if (len) *dst++ = parse_one(origin + pos[i + 1], len < 16 ? len : 16), --count;
            ++i;
        }
    }
    return const_cast<char*>(origin) + pos[i] + 1;
}
}  // namespace qp_parse_tail

namespace qp_parse_tail8 {
using qp_parse_tail::tail_mask; using qp_parse_tail::separators; using qp_parse_tail::pair;
using qp_parse_tail::groups; using qp_parse_tail::parse_one;
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    constexpr size_t chunk = 32;  // Blocks per stage-1 pass (2 KiB of input).
    alignas(64) uint32_t pos[chunk * 64 + 64];
    const char* const origin = p - 1;  // Offset 0 is the separator before p.
    size_t have = 1, i = 0, scan = 1;
    pos[0] = 0;
    while (count) {
        if (i) {
            for (size_t k = i; k < have; ++k) pos[k - i] = pos[k];
            have -= i, i = 0;
        }
        for (size_t b = 0; b < chunk && count > have - 1; ++b, scan += 64) {
            uint64_t m = separators(origin + scan);
            const size_t found = size_t(__builtin_popcountll(m));
            uint32_t* out = pos + have;
            do {
                for (int j = 0; j < 8; ++j) out[j] = uint32_t(scan + _tzcnt_u64(m)), m = _blsr_u64(m);
                out += 8;
            } while (m);
            have += found;
        }
        for (;;) {
            if (count >= 8 && i + 8 < have) {   // eight tokens: two 4-token groups, one 256-bit store
                const uint32_t* s = pos + i;
                const unsigned l0 = s[1] - s[0] - 1, l1 = s[2] - s[1] - 1, l2 = s[3] - s[2] - 1, l3 = s[4] - s[3] - 1;
                const unsigned l4 = s[5] - s[4] - 1, l5 = s[6] - s[5] - 1, l6 = s[7] - s[6] - 1, l7 = s[8] - s[7] - 1;
                if (__builtin_expect(((l0 - 1) | (l1 - 1) | (l2 - 1) | (l3 - 1) | (l4 - 1) | (l5 - 1) | (l6 - 1) | (l7 - 1)) < 16, 1)) {
                    const __m256i zero = _mm256_set1_epi8('0');
                    auto grp = [&](unsigned a, unsigned b, unsigned la, unsigned lb) __attribute__((always_inline)) {
                        return groups(_mm256_and_si256(_mm256_subs_epu8(pair(origin + s[a] - 16, origin + s[b] - 16), zero),
                                                       pair(tail_mask.row[la], tail_mask.row[lb])));
                    };
                    const __m256i x0 = _mm256_madd_epi16(_mm256_packus_epi32(grp(1, 2, l0, l1), grp(3, 4, l2, l3)), _mm256_set1_epi32(0x00012710));
                    const __m256i x1 = _mm256_madd_epi16(_mm256_packus_epi32(grp(5, 6, l4, l5), grp(7, 8, l6, l7)), _mm256_set1_epi32(0x00012710));
                    const __m256i e = _mm256_set1_epi32(100000000);
                    const __m256i v0 = _mm256_add_epi32(_mm256_mullo_epi32(x0, e), _mm256_srli_epi64(x0, 32));   // t0 . t2 . | t1 . t3 .
                    const __m256i v1 = _mm256_add_epi32(_mm256_mullo_epi32(x1, e), _mm256_srli_epi64(x1, 32));   // t4 . t6 . | t5 . t7 .
                    const __m256i mixed = _mm256_blend_epi32(v0, _mm256_slli_epi64(v1, 32), 0xAA);               // t0 t4 t2 t6 | t1 t5 t3 t7
                    _mm256_storeu_si256(reinterpret_cast<__m256i*>(dst),
                                        _mm256_permutevar8x32_epi32(mixed, _mm256_setr_epi32(0, 4, 2, 6, 1, 5, 3, 7)));
                    dst += 8, count -= 8, i += 8;
                    continue;
                }
            }
            if (count >= 4 && i + 4 < have) {
                const uint32_t s0 = pos[i], s1 = pos[i + 1], s2 = pos[i + 2], s3 = pos[i + 3], s4 = pos[i + 4];
                const unsigned l0 = s1 - s0 - 1, l1 = s2 - s1 - 1, l2 = s3 - s2 - 1, l3 = s4 - s3 - 1;
                if (__builtin_expect(((l0 - 1) | (l1 - 1) | (l2 - 1) | (l3 - 1)) < 16, 1)) {
                    const __m256i zero = _mm256_set1_epi8('0');
                    __m256i v = _mm256_subs_epu8(pair(origin + s1 - 16, origin + s2 - 16), zero);
                    __m256i w = _mm256_subs_epu8(pair(origin + s3 - 16, origin + s4 - 16), zero);
                    v = groups(_mm256_and_si256(v, pair(tail_mask.row[l0], tail_mask.row[l1])));
                    w = groups(_mm256_and_si256(w, pair(tail_mask.row[l2], tail_mask.row[l3])));
                    const __m256i x = _mm256_madd_epi16(_mm256_packus_epi32(v, w), _mm256_set1_epi32(0x00012710));
                    const __m256i values = _mm256_add_epi32(_mm256_mullo_epi32(x, _mm256_set1_epi32(100000000)),
                                                            _mm256_srli_epi64(x, 32));
                    const __m256i ordered = _mm256_permutevar8x32_epi32(values, _mm256_setr_epi32(0, 4, 2, 6, 0, 4, 2, 6));
                    _mm_storeu_si128(reinterpret_cast<__m128i*>(dst), _mm256_castsi256_si128(ordered));
                    dst += 4, count -= 4, i += 4;
                    continue;
                }
            } else if (!count || i + 1 >= have) {
                break;
            }
            const unsigned len = pos[i + 1] - pos[i] - 1;  // One token, possibly empty.
            if (len) *dst++ = parse_one(origin + pos[i + 1], len < 16 ? len : 16), --count;
            ++i;
        }
    }
    return const_cast<char*>(origin) + pos[i] + 1;
}
}  // namespace qp_parse_tail8
