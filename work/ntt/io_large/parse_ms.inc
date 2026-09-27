// Multi-stream token parser (QPoly exploration 011), written for this exploration; digit
// weighting and right-alignment follow the exploration-007 parsers (qp_parse_flat).
//
// Idea: a per-token parser is short (16-byte load, separator movemask, tzcnt = length,
// length-indexed right-align shuffle, multiply-add reduction) but each token's start depends on
// the previous token's length, a ~11-cycle chain. Here the input is cut into chunks of CH bytes,
// each chunk into K sub-chunks at token boundaries, and the K streams advance in lockstep, so K
// independent chains overlap; values of one step are stored together (tmp[step][stream]) and
// copied into place stream by stream after the chunk. No separator-position array (qp_parse_flat's
// stage 1) is built. The tail of the input (where a whole chunk could hold more than `count`
// tokens) is parsed by qp_parse_flat.
//
// Contract: as qp_parse_flat for the tail; the chunked part additionally assumes exactly one
// separator byte (<= ' ') after every token, as Library Checker's validated input has. An
// empty token (two adjacent separators) is detected per chunk and the chunk is re-parsed with
// qp_parse_flat, so other whitespace is still parsed correctly, only slower. Tokens have 1..9
// digits; at least 64 readable bytes follow the last token's separator.
#pragma once
#include <immintrin.h>
#include <cstddef>
#include <cstdint>

namespace qp_parse_ms {
struct RightAlign { alignas(16) int8_t row[17][16]; };
constexpr RightAlign make_right_align() {
    RightAlign t{};
    for (int len = 0; len <= 16; ++len)
        for (int j = 0; j < 16; ++j) t.row[len][j] = int8_t(j >= 16 - len ? j - (16 - len) : -128);
    return t;
}
inline constexpr RightAlign right_align = make_right_align();

// First byte after the first separator at or after q (tokens are at most 9 digits long).
__attribute__((always_inline)) inline char* snap(char* q) {
    const __m256i x = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(q));
    const uint32_t m = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), x)));
    return q + _tzcnt_u32(m) + 1;
}
// One token starting at p: returns its 16 digit bytes right-aligned, and its length.
__attribute__((always_inline)) inline __m128i window(const char* p, unsigned& len) {
    const __m128i w = _mm_loadu_si128(reinterpret_cast<const __m128i*>(p));
    len = _tzcnt_u32(unsigned(_mm_movemask_epi8(_mm_cmpgt_epi8(_mm_set1_epi8(' ' + 1), w))));
    return w;
}
__attribute__((always_inline)) inline __m256i groups(__m256i digits) {
    return _mm256_madd_epi16(_mm256_maddubs_epi16(digits, _mm256_set1_epi16(0x010a)), _mm256_set1_epi32(0x00010064));
}
__attribute__((always_inline)) inline __m256i lanes(__m128i lo, __m128i hi) {
    return _mm256_inserti128_si256(_mm256_castsi128_si256(lo), hi, 1);
}
// Four tokens (one per stream) -> 4 values in stream order [A, B, C, D].
__attribute__((always_inline)) inline __m128i four(__m128i wa, __m128i wb, __m128i wc, __m128i wd,
                                                  unsigned la, unsigned lb, unsigned lc, unsigned ld) {
    const __m256i zero = _mm256_set1_epi8('0');
    const __m256i r0 = lanes(_mm_load_si128(reinterpret_cast<const __m128i*>(right_align.row[la])),
                             _mm_load_si128(reinterpret_cast<const __m128i*>(right_align.row[lb])));
    const __m256i r1 = lanes(_mm_load_si128(reinterpret_cast<const __m128i*>(right_align.row[lc])),
                             _mm_load_si128(reinterpret_cast<const __m128i*>(right_align.row[ld])));
    const __m256i v = groups(_mm256_shuffle_epi8(_mm256_subs_epu8(lanes(wa, wb), zero), r0));   // lanes A | B
    const __m256i w = groups(_mm256_shuffle_epi8(_mm256_subs_epu8(lanes(wc, wd), zero), r1));   // lanes C | D
    const __m256i x = _mm256_madd_epi16(_mm256_packus_epi32(v, w), _mm256_set1_epi32(0x00012710));
    const __m256i values = _mm256_add_epi32(_mm256_mullo_epi32(x, _mm256_set1_epi32(100000000)), _mm256_srli_epi64(x, 32));
    // values: dword 0 = A, 2 = C (lane 0); 4 = B, 6 = D (lane 1).
    return _mm256_castsi256_si128(_mm256_permutevar8x32_epi32(values, _mm256_setr_epi32(0, 4, 2, 6, 0, 4, 2, 6)));
}
__attribute__((always_inline)) inline uint32_t one(const char* p, unsigned len) {
    __m128i x = _mm_subs_epu8(_mm_loadu_si128(reinterpret_cast<const __m128i*>(p)), _mm_set1_epi8('0'));
    x = _mm_shuffle_epi8(x, _mm_load_si128(reinterpret_cast<const __m128i*>(right_align.row[len < 16 ? len : 16])));
    x = _mm_madd_epi16(_mm_maddubs_epi16(x, _mm_set1_epi16(0x010a)), _mm_set1_epi32(0x00010064));
    x = _mm_madd_epi16(_mm_packus_epi32(x, x), _mm_set1_epi32(0x00012710));
    const uint64_t both = uint64_t(_mm_cvtsi128_si64(x));
    return uint32_t(both) * 100000000u + uint32_t(both >> 32);
}

template<int K, size_t CH, char* (*Tail)(char*, uint32_t*, size_t)>
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    static_assert(K == 4 || K == 8, "streams come in groups of four");
    // [step][stream]. Every step advances each stream by at least one byte (empty tokens, which
    // trigger the robust path, advance by exactly one), and a sub-chunk spans at most
    // CH/K + 10 bytes, so steps * K <= CH + 10K.
    alignas(32) uint32_t tmp[CH + 16 * K + 64];
    uint32_t drain[K][64];                       // per-stream leftovers after the lockstep phase
    while (count > CH / 2 + 64) {                // a chunk of CH bytes holds at most CH/2 tokens
        char* s[K]; char* e[K];
        s[0] = p;
        for (int k = 1; k < K; ++k) s[k] = e[k - 1] = snap(p + k * (CH / K));
        e[K - 1] = snap(p + CH);
        unsigned bad = 0;
        size_t steps = 0;
        for (;;) {
            bool live = true;
            for (int k = 0; k < K; ++k) live &= s[k] < e[k];
            if (!live) break;
            for (int g = 0; g < K; g += 4) {
                unsigned l0, l1, l2, l3;
                const __m128i w0 = window(s[g], l0), w1 = window(s[g + 1], l1), w2 = window(s[g + 2], l2), w3 = window(s[g + 3], l3);
                s[g] += l0 + 1; s[g + 1] += l1 + 1; s[g + 2] += l2 + 1; s[g + 3] += l3 + 1;
                bad |= (l0 - 1) | (l1 - 1) | (l2 - 1) | (l3 - 1);   // >= 2^31 iff some length is 0
                _mm_store_si128(reinterpret_cast<__m128i*>(tmp + steps * K + g), four(w0, w1, w2, w3, l0, l1, l2, l3));
            }
            ++steps;
        }
        size_t nd[K];
        for (int k = 0; k < K; ++k) {
            nd[k] = 0;
            while (s[k] < e[k] && nd[k] < 64) {
                unsigned l; const __m128i w = window(s[k], l); (void)w;
                bad |= l - 1;
                drain[k][nd[k]++] = one(s[k], l);
                s[k] += l + 1;
            }
            bad |= unsigned(s[k] < e[k]) << 31;   // more than 64 leftovers: treat as irregular
        }
        if (__builtin_expect(bad >= (1u << 31), 0)) {   // empty token or imbalance: robust path
            size_t total = 0;   // tokens in [p, end): token bytes preceded by a separator (or at p)
            for (char* q = p; q < e[K - 1]; ++q) total += size_t(*q > ' ' && (q == p || q[-1] <= ' '));
            Tail(p, dst, total);
            dst += total; count -= total; p = e[K - 1];
            continue;
        }
        for (int k = 0; k < K; ++k) {
            for (size_t t = 0; t < steps; ++t) *dst++ = tmp[t * K + k];
            for (size_t t = 0; t < nd[k]; ++t) *dst++ = drain[k][t];
            count -= steps + nd[k];
        }
        p = e[K - 1];
    }
    return Tail(p, dst, count);
}
}  // namespace qp_parse_ms
