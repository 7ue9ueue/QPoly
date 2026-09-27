// Multi-stream token parser, two tokens per stream step (QPoly exploration 011), written for this
// exploration; digit weighting follows the exploration-007 parsers (qp_parse_flat).
//
// A chunk of CH input bytes is cut at token boundaries into four sub-chunks (streams) that advance
// in lockstep. Each stream step loads 32 bytes at the stream position: the first two separators
// (movemask, tzcnt, blsr, tzcnt) give two tokens, so one load/compare/movemask serves two tokens
// and the loop-carried chain (load -> compare -> movemask -> tzcnt -> add) is paid once per two
// tokens. The second token's 16-byte window is loaded next to the first (vinserti128), both are
// right-aligned by one length-indexed shuffle and reduced together. Four streams give eight
// values per step, stored as two consecutive values per stream into per-stream regions (stream 0
// straight into the destination) and copied into place after the chunk.
// The step loop has no per-token bounds checks: a step advances a stream by at most 33 bytes
// (whatever the input), so min_k(bytes left in stream k) / 33 steps are run without checks,
// repeatedly; the few tokens left per stream are parsed one at a time.
// Validation without scalar work: tokens of length 0 (two adjacent separators) or > 16 select a
// shuffle row whose last byte is negative; the rows are ORed into a flag vector, checked once per
// chunk together with the stream end positions. A flagged chunk is re-parsed with Tail
// (qp_parse_flat), which accepts any whitespace; so does the input tail (last <= CH/2 + 64 tokens).
//
// Contract: as qp_parse_flat (tokens of 1..9 digits separated by bytes <= ' '); the chunked path
// is fastest with exactly one separator byte per token (Library Checker's validated format) and
// balanced token lengths. At least 64 readable bytes follow the last token's separator.
#pragma once
#include <immintrin.h>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstring>

namespace qp_parse_ms2 {
// Row l + 1 right-aligns a token of length l (-1 <= l <= 32) in a 16-byte window; lengths outside
// 1..16 give an all-zero row with byte 15 negative (flag).
struct RightAlign { alignas(16) int8_t row[34][16]; };
constexpr RightAlign make_right_align() {
    RightAlign t{};
    for (int l = -1; l <= 32; ++l)
        for (int j = 0; j < 16; ++j)
            t.row[l + 1][j] = int8_t(l >= 1 && l <= 16 && j >= 16 - l ? j - (16 - l) : -128);
    return t;
}
inline constexpr RightAlign right_align = make_right_align();

__attribute__((always_inline)) inline const __m128i* row(uint32_t index) {
    return reinterpret_cast<const __m128i*>(right_align.row[index]);
}
// First byte after the first separator at or after q (q + 33 if none within 32 bytes).
__attribute__((always_inline)) inline char* snap(char* q) {
    const __m256i x = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(q));
    return q + _tzcnt_u32(uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), x)))) + 1;
}
// Two tokens at s: returns their 4-digit groups as dwords [first: g0..g3 | second: g0..g3].
__attribute__((always_inline)) inline __m256i two(char*& s, __m256i& flags) {
    const __m256i y = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s));
    const uint32_t m = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), y)));
    const uint32_t t1 = _tzcnt_u32(m), t2 = _tzcnt_u32(_blsr_u32(m));   // lengths t1 and t2 - t1 - 1
    const __m256i w = _mm256_inserti128_si256(y, _mm_loadu_si128(reinterpret_cast<const __m128i*>(s + t1 + 1)), 1);
    const __m256i r = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(row(t1 + 1))), _mm_load_si128(row(t2 - t1)), 1);
    flags = _mm256_or_si256(flags, r);
    s += t2 + 1;
    const __m256i d = _mm256_shuffle_epi8(_mm256_subs_epu8(w, _mm256_set1_epi8('0')), r);
    return _mm256_madd_epi16(_mm256_maddubs_epi16(d, _mm256_set1_epi16(0x010a)), _mm256_set1_epi32(0x00010064));
}
// One token at s (drain).
__attribute__((always_inline)) inline uint32_t one(char*& s, __m256i& flags) {
    const __m128i w = _mm_loadu_si128(reinterpret_cast<const __m128i*>(s));
    const uint32_t t = _tzcnt_u32(uint32_t(_mm_movemask_epi8(_mm_cmpgt_epi8(_mm_set1_epi8(' ' + 1), w))));
    const __m128i r = _mm_load_si128(row(t + 1));
    flags = _mm256_or_si256(flags, _mm256_castsi128_si256(r));
    s += t + 1;
    __m128i x = _mm_shuffle_epi8(_mm_subs_epu8(w, _mm_set1_epi8('0')), r);
    x = _mm_madd_epi16(_mm_maddubs_epi16(x, _mm_set1_epi16(0x010a)), _mm_set1_epi32(0x00010064));
    x = _mm_madd_epi16(_mm_packus_epi32(x, x), _mm_set1_epi32(0x00012710));
    const uint64_t both = uint64_t(_mm_cvtsi128_si64(x));
    return uint32_t(both) * 100000000u + uint32_t(both >> 32);
}

template<size_t CH, char* (*Tail)(char*, uint32_t*, size_t)>
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    // A step advances a stream by >= 2 bytes and emits 2 values (empty tokens included), so a
    // stream of <= SUB + 33 bytes emits <= SUB + 33 values; regions are static (untouched pages
    // stay unfaulted).
    constexpr size_t SUB = CH / 4, CAP = SUB + 64;
    alignas(64) static uint32_t region[3][CAP];
    while (count > CH / 2 + 64) {   // a chunk holds at most (CH + 33) / 2 tokens, all of this array
        char *s0 = p, *s1 = snap(p + SUB), *s2 = snap(p + 2 * SUB), *s3 = snap(p + 3 * SUB);
        char *const e0 = s1, *const e1 = s2, *const e2 = s3, *const e3 = snap(p + CH);
        uint32_t *const o0 = dst, *const o1 = region[0], *const o2 = region[1], *const o3 = region[2];
        __m256i flags = _mm256_setzero_si256();
        size_t j = 0;   // values per stream so far (two per step)
        for (;;) {
            const size_t left = size_t(std::min(std::min(e0 - s0, e1 - s1), std::min(e2 - s2, e3 - s3)));
            size_t steps = left / 33;
            if (!steps) break;
            do {
                const __m256i gA = two(s0, flags), gB = two(s1, flags), gC = two(s2, flags), gD = two(s3, flags);
                const __m256i k = _mm256_set1_epi32(0x00012710);
                const __m256 xAB = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gA, gB), k));   // [A1h A1l B1h B1l | A2h ..]
                const __m256 xCD = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gC, gD), k));
                const __m256i hi = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0x88));   // [A1h B1h C1h D1h | A2h ..]
                const __m256i lo = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0xDD));
                const __m256i v = _mm256_add_epi32(_mm256_mullo_epi32(hi, _mm256_set1_epi32(100000000)), lo);
                const __m256i q = _mm256_permutevar8x32_epi32(v, _mm256_setr_epi32(0, 4, 1, 5, 2, 6, 3, 7));   // [A1 A2 B1 B2 | C1 C2 D1 D2]
                const __m128i qa = _mm256_castsi256_si128(q), qc = _mm256_extracti128_si256(q, 1);
                _mm_storel_epi64(reinterpret_cast<__m128i*>(o0 + j), qa);
                _mm_storeh_pd(reinterpret_cast<double*>(o1 + j), _mm_castsi128_pd(qa));
                _mm_storel_epi64(reinterpret_cast<__m128i*>(o2 + j), qc);
                _mm_storeh_pd(reinterpret_cast<double*>(o3 + j), _mm_castsi128_pd(qc));
                j += 2;
            } while (--steps);
        }
        size_t n0 = j, n1 = j, n2 = j, n3 = j;
        while (s0 < e0) o0[n0++] = one(s0, flags);   // dst holds count > SUB + 33 values
        while (s1 < e1 && n1 < CAP) o1[n1++] = one(s1, flags);
        while (s2 < e2 && n2 < CAP) o2[n2++] = one(s2, flags);
        while (s3 < e3 && n3 < CAP) o3[n3++] = one(s3, flags);
        const bool bad = (uint32_t(_mm256_movemask_epi8(flags)) & 0x80008000u) | (s0 != e0) | (s1 != e1) | (s2 != e2) | (s3 != e3);
        if (__builtin_expect(bad, 0)) {   // robust path: tokens in [p, e3) = token bytes after a separator (or at p)
            size_t total = 0;
            for (char* q = p; q < e3; ++q) total += size_t(*q > ' ' && (q == p || q[-1] <= ' '));
            Tail(p, dst, total);
            dst += total; count -= total; p = e3;
            continue;
        }
        std::memcpy(dst + n0, o1, n1 * sizeof(uint32_t));
        std::memcpy(dst + n0 + n1, o2, n2 * sizeof(uint32_t));
        std::memcpy(dst + n0 + n1 + n2, o3, n3 * sizeof(uint32_t));
        const size_t total = n0 + n1 + n2 + n3;
        dst += total; count -= total; p = e3;
    }
    return Tail(p, dst, count);
}
}  // namespace qp_parse_ms2
