// Exploration 014: qp_parse_ms2 (exploration 011, parse_ms2.inc) with configurable stream spacing
// and optional software prefetch. Written for this exploration; the step functions (two(), one(),
// snap(), the shuffle rows) are the exploration-011 ones, used unchanged.
//
// Hypothesis: ms2 cuts a 128 KiB chunk into four sub-chunks exactly 32 KiB apart, so the four
// lockstep input streams always sit in the same L1D set (32 KiB, 8-way: addresses 4 KiB apart share
// a set). Their loads are on the loop-carried chain (load -> compare -> movemask -> tzcnt -> next
// position), so set conflicts that push loads to L2 would lengthen every step.
// Here the streams start D = SUB + SKEW bytes apart (SKEW a multiple of 64 that is not a multiple
// of 4096, e.g. 17 lines), which spreads them over different L1 sets (and L2 sets). PF > 0 adds one
// prefetcht0 per stream and step, PF bytes ahead of the stream position.
//
// Contract: as qp_parse_ms2 (tokens of 1..9 digits separated by bytes <= ' '; at least 64 readable
// bytes after the last token's separator). A chunk spans 4D (+ <= 33) bytes and holds at most
// (4D + 33) / 2 tokens, so chunked parsing runs only while more than 2D + 64 tokens remain.
#pragma once
#include "../io_large/parse_ms2.inc"

namespace qp_parse_ms2s {
using qp_parse_ms2::snap;
using qp_parse_ms2::two;
using qp_parse_ms2::one;

// Side: a functor called once per stream step (8 tokens), for independent work interleaved with
// parsing (exploration 014 overlap experiments); NoSide compiles to nothing.
struct NoSide { __attribute__((always_inline)) void operator()() const {} };

template<size_t SUB, size_t SKEW, size_t PF, char* (*Tail)(char*, uint32_t*, size_t), class Side>
__attribute__((noinline)) char* parse_side(char* p, uint32_t* dst, size_t count, Side& side) {
    constexpr size_t D = SUB + SKEW, CHB = 4 * D, CAP = D + 64;
    alignas(64) static uint32_t region[3][CAP];
    while (count > CHB / 2 + 64) {
        char *s0 = p, *s1 = snap(p + D), *s2 = snap(p + 2 * D), *s3 = snap(p + 3 * D);
        char *const e0 = s1, *const e1 = s2, *const e2 = s3, *const e3 = snap(p + CHB);
        uint32_t *const o0 = dst, *const o1 = region[0], *const o2 = region[1], *const o3 = region[2];
        __m256i flags = _mm256_setzero_si256();
        size_t j = 0;
        for (;;) {
            const size_t left = size_t(std::min(std::min(e0 - s0, e1 - s1), std::min(e2 - s2, e3 - s3)));
            size_t steps = left / 33;
            if (!steps) break;
            do {
                side();
                if constexpr (PF != 0) {
                    _mm_prefetch(s0 + PF, _MM_HINT_T0); _mm_prefetch(s1 + PF, _MM_HINT_T0);
                    _mm_prefetch(s2 + PF, _MM_HINT_T0); _mm_prefetch(s3 + PF, _MM_HINT_T0);
                }
                const __m256i gA = two(s0, flags), gB = two(s1, flags), gC = two(s2, flags), gD = two(s3, flags);
                const __m256i k = _mm256_set1_epi32(0x00012710);
                const __m256 xAB = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gA, gB), k));
                const __m256 xCD = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gC, gD), k));
                const __m256i hi = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0x88));
                const __m256i lo = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0xDD));
                const __m256i v = _mm256_add_epi32(_mm256_mullo_epi32(hi, _mm256_set1_epi32(100000000)), lo);
                const __m256i q = _mm256_permutevar8x32_epi32(v, _mm256_setr_epi32(0, 4, 1, 5, 2, 6, 3, 7));
                const __m128i qa = _mm256_castsi256_si128(q), qc = _mm256_extracti128_si256(q, 1);
                _mm_storel_epi64(reinterpret_cast<__m128i*>(o0 + j), qa);
                _mm_storeh_pd(reinterpret_cast<double*>(o1 + j), _mm_castsi128_pd(qa));
                _mm_storel_epi64(reinterpret_cast<__m128i*>(o2 + j), qc);
                _mm_storeh_pd(reinterpret_cast<double*>(o3 + j), _mm_castsi128_pd(qc));
                j += 2;
            } while (--steps);
        }
        size_t n0 = j, n1 = j, n2 = j, n3 = j;
        while (s0 < e0) o0[n0++] = one(s0, flags);   // dst holds count > D + 33 values
        while (s1 < e1 && n1 < CAP) o1[n1++] = one(s1, flags);
        while (s2 < e2 && n2 < CAP) o2[n2++] = one(s2, flags);
        while (s3 < e3 && n3 < CAP) o3[n3++] = one(s3, flags);
        const bool bad = (uint32_t(_mm256_movemask_epi8(flags)) & 0x80008000u) | (s0 != e0) | (s1 != e1) | (s2 != e2) | (s3 != e3);
        if (__builtin_expect(bad, 0)) {   // robust path, as in qp_parse_ms2
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
template<size_t SUB, size_t SKEW, size_t PF, char* (*Tail)(char*, uint32_t*, size_t)>
char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    NoSide none;
    return parse_side<SUB, SKEW, PF, Tail>(p, dst, count, none);
}
}  // namespace qp_parse_ms2s
