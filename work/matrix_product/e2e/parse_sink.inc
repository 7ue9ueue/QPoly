// Chunked multi-stream parser with a sink (QPoly exploration 013): exploration 011's qp_parse_ms2
// chunk loop (parse_ms2.inc, whose step functions it uses unchanged) with all four streams writing
// into static regions and the parsed values handed to sink(values, n) in input order, chunk by
// chunk, instead of being copied into one destination array. The sink can place values directly
// into their final layout while they are hot in L1/L2. Contract as parse_ms2 (tokens of 1..9
// digits, one separator byte on the fast path, >= 64 readable bytes after the last token's
// separator); the sink sees every value exactly once, in order, in runs of at most CH / 2 + 64.
#pragma once
#include "parse_ms2.inc"

namespace qp_parse_ms2 {
template<size_t CH, char* (*Tail)(char*, uint32_t*, size_t), class Sink>
__attribute__((noinline)) char* parse_tokens_sink(char* p, size_t count, Sink& sink) {
    // A step advances a stream by >= 2 bytes and emits 2 values (empty tokens included), so a
    // stream of <= SUB + 33 bytes emits <= SUB + 33 values; regions are static (untouched pages
    // stay unfaulted).
    constexpr size_t SUB = CH / 4, CAP = SUB + 64;
    alignas(64) static uint32_t region[4][CAP];
    alignas(64) static uint32_t tailbuf[CH / 2 + 64];   // >= tokens of a flagged chunk and of the final tail
    while (count > CH / 2 + 64) {   // a chunk holds at most (CH + 33) / 2 tokens, all of this array
        char *s0 = p, *s1 = snap(p + SUB), *s2 = snap(p + 2 * SUB), *s3 = snap(p + 3 * SUB);
        char *const e0 = s1, *const e1 = s2, *const e2 = s3, *const e3 = snap(p + CH);
        uint32_t *const o0 = region[0], *const o1 = region[1], *const o2 = region[2], *const o3 = region[3];
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
        while (s0 < e0 && n0 < CAP) o0[n0++] = one(s0, flags);
        while (s1 < e1 && n1 < CAP) o1[n1++] = one(s1, flags);
        while (s2 < e2 && n2 < CAP) o2[n2++] = one(s2, flags);
        while (s3 < e3 && n3 < CAP) o3[n3++] = one(s3, flags);
        const bool bad = (uint32_t(_mm256_movemask_epi8(flags)) & 0x80008000u) | (s0 != e0) | (s1 != e1) | (s2 != e2) | (s3 != e3);
        if (__builtin_expect(bad, 0)) {   // robust path: tokens in [p, e3) = token bytes after a separator (or at p)
            size_t total = 0;
            for (char* q = p; q < e3; ++q) total += size_t(*q > ' ' && (q == p || q[-1] <= ' '));
            Tail(p, tailbuf, total);   // total <= (CH + 33) / 2 < CH / 2 + 64
            sink(tailbuf, total);
            count -= total; p = e3;
            continue;
        }
        sink(o0, n0); sink(o1, n1); sink(o2, n2); sink(o3, n3);
        count -= n0 + n1 + n2 + n3; p = e3;
    }
    p = Tail(p, tailbuf, count);   // count <= CH / 2 + 64
    sink(tailbuf, count);
    return p;
}
}  // namespace qp_parse_ms2
