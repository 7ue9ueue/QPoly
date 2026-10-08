// Exploration 014: ablation variants of the ms2 step loop (diagnostic only, not a parser).
// Runs the four-stream chunk loop of qp_parse_ms2 (32 KiB sub-chunks) over a text and returns a
// checksum; per-chunk leftovers and validation are skipped. MODE selects what one step does:
//   0  full ms2 step (two() x4, combine, four 8-byte stores)            = the deliverable's step
//   1  full step, result XORed into a register instead of stored        (store/aliasing cost)
//   2  two() x4 only, groups XORed into a register (no combine)         (combine cost)
//   3  scan chain only: load, compare, movemask, tzcnt, blsr, tzcnt, advance (no windows/rows)
//   4  chain + window and row loads + subs + pshufb, XORed (no maddubs/madd/combine)
//   5  mode 3 with the second token's window loaded and XORed (one extra dependent load)
#pragma once
#include "../io_large/parse_ms2.inc"

namespace qp_ablate {
using qp_parse_ms2::snap;
using qp_parse_ms2::row;

__attribute__((always_inline)) inline uint32_t chain(char*& s) {
    const __m256i y = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s));
    const uint32_t m = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), y)));
    const uint32_t t1 = _tzcnt_u32(m), t2 = _tzcnt_u32(_blsr_u32(m));
    s += t2 + 1;
    return t1;
}
__attribute__((always_inline)) inline __m256i chain_win(char*& s) {
    const __m256i y = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s));
    const uint32_t m = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), y)));
    const uint32_t t1 = _tzcnt_u32(m), t2 = _tzcnt_u32(_blsr_u32(m));
    const __m256i w = _mm256_inserti128_si256(y, _mm_loadu_si128(reinterpret_cast<const __m128i*>(s + t1 + 1)), 1);
    s += t2 + 1;
    return w;
}
__attribute__((always_inline)) inline __m256i shuffled(char*& s) {   // two() without the multiply-adds
    const __m256i y = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s));
    const uint32_t m = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), y)));
    const uint32_t t1 = _tzcnt_u32(m), t2 = _tzcnt_u32(_blsr_u32(m));
    const __m256i w = _mm256_inserti128_si256(y, _mm_loadu_si128(reinterpret_cast<const __m128i*>(s + t1 + 1)), 1);
    const __m256i r = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(row(t1 + 1))), _mm_load_si128(row(t2 - t1)), 1);
    s += t2 + 1;
    return _mm256_shuffle_epi8(_mm256_subs_epu8(w, _mm256_set1_epi8('0')), r);
}

template<int MODE>
__attribute__((noinline)) uint64_t run(char* p, size_t bytes, uint32_t* out) {
    constexpr size_t D = 32768, CHB = 4 * D;
    alignas(64) static uint32_t region[3][D + 64];
    __m256i acc = _mm256_setzero_si256();
    uint64_t sacc = 0;
    for (char* const end = p + bytes - CHB - 64; p < end;) {
        char *s0 = p, *s1 = snap(p + D), *s2 = snap(p + 2 * D), *s3 = snap(p + 3 * D);
        char *const e0 = s1, *const e1 = s2, *const e2 = s3, *const e3 = snap(p + CHB);
        uint32_t *const o0 = out, *const o1 = region[0], *const o2 = region[1], *const o3 = region[2];
        __m256i flags = _mm256_setzero_si256();
        size_t j = 0;
        for (;;) {
            const size_t left = size_t(std::min(std::min(e0 - s0, e1 - s1), std::min(e2 - s2, e3 - s3)));
            size_t steps = left / 33;
            if (!steps) break;
            do {
                if constexpr (MODE == 0 || MODE == 1) {
                    const __m256i gA = qp_parse_ms2::two(s0, flags), gB = qp_parse_ms2::two(s1, flags);
                    const __m256i gC = qp_parse_ms2::two(s2, flags), gD = qp_parse_ms2::two(s3, flags);
                    const __m256i k = _mm256_set1_epi32(0x00012710);
                    const __m256 xAB = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gA, gB), k));
                    const __m256 xCD = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gC, gD), k));
                    const __m256i hi = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0x88));
                    const __m256i lo = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0xDD));
                    const __m256i v = _mm256_add_epi32(_mm256_mullo_epi32(hi, _mm256_set1_epi32(100000000)), lo);
                    const __m256i q = _mm256_permutevar8x32_epi32(v, _mm256_setr_epi32(0, 4, 1, 5, 2, 6, 3, 7));
                    if constexpr (MODE == 0) {
                        const __m128i qa = _mm256_castsi256_si128(q), qc = _mm256_extracti128_si256(q, 1);
                        _mm_storel_epi64(reinterpret_cast<__m128i*>(o0 + j), qa);
                        _mm_storeh_pd(reinterpret_cast<double*>(o1 + j), _mm_castsi128_pd(qa));
                        _mm_storel_epi64(reinterpret_cast<__m128i*>(o2 + j), qc);
                        _mm_storeh_pd(reinterpret_cast<double*>(o3 + j), _mm_castsi128_pd(qc));
                    } else acc = _mm256_xor_si256(acc, q);
                } else if constexpr (MODE == 2) {
                    acc = _mm256_xor_si256(acc, _mm256_xor_si256(_mm256_xor_si256(qp_parse_ms2::two(s0, flags), qp_parse_ms2::two(s1, flags)),
                                                                 _mm256_xor_si256(qp_parse_ms2::two(s2, flags), qp_parse_ms2::two(s3, flags))));
                } else if constexpr (MODE == 3) {
                    sacc += chain(s0) + chain(s1) + chain(s2) + chain(s3);
                } else if constexpr (MODE == 4) {
                    acc = _mm256_xor_si256(acc, _mm256_xor_si256(_mm256_xor_si256(shuffled(s0), shuffled(s1)), _mm256_xor_si256(shuffled(s2), shuffled(s3))));
                } else {
                    acc = _mm256_xor_si256(acc, _mm256_xor_si256(_mm256_xor_si256(chain_win(s0), chain_win(s1)), _mm256_xor_si256(chain_win(s2), chain_win(s3))));
                }
                j += 2;
            } while (--steps);
        }
        sacc += j + uint32_t(_mm256_movemask_epi8(flags)) + size_t(e0 - s0);
        p = e3;
        (void)e1; (void)e2;
    }
    alignas(32) uint64_t lanes[4];
    _mm256_store_si256(reinterpret_cast<__m256i*>(lanes), acc);
    return sacc + lanes[0] + lanes[1] + lanes[2] + lanes[3];
}
// Conversion only (diagnostic): the q4 per-token work (16-byte windows at precomputed token starts,
// length-indexed shuffle rows, maddubs/madd, exploration-011 combine, one 16-byte store per stream)
// for 16 tokens per step, with token end offsets precomputed outside the timer (sep[i] = offset of
// the separator ending token i, sep[-1] = -1). Four "streams" = four interleaved token ranges.
__attribute__((always_inline)) inline void conv4(const char* text, const int32_t* e, __m256i& g12, __m256i& g34) {
    const int32_t p0 = e[-1], t1 = e[0], t2 = e[1], t3 = e[2], t4 = e[3];
    const __m256i w12 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(reinterpret_cast<const __m128i*>(text + p0 + 1))),
                                                _mm_loadu_si128(reinterpret_cast<const __m128i*>(text + t1 + 1)), 1);
    const __m256i w34 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(reinterpret_cast<const __m128i*>(text + t2 + 1))),
                                                _mm_loadu_si128(reinterpret_cast<const __m128i*>(text + t3 + 1)), 1);
    const __m256i r12 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(qp_parse_ms2::row(uint32_t(t1 - p0)))),
                                                _mm_load_si128(qp_parse_ms2::row(uint32_t(t2 - t1))), 1);
    const __m256i r34 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(qp_parse_ms2::row(uint32_t(t3 - t2)))),
                                                _mm_load_si128(qp_parse_ms2::row(uint32_t(t4 - t3))), 1);
    const __m256i zero = _mm256_set1_epi8('0'), k1 = _mm256_set1_epi16(0x010a), k2 = _mm256_set1_epi32(0x00010064);
    g12 = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_shuffle_epi8(_mm256_subs_epu8(w12, zero), r12), k1), k2);
    g34 = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_shuffle_epi8(_mm256_subs_epu8(w34, zero), r34), k1), k2);
}
__attribute__((always_inline)) inline __m256i combine4(__m256i gA, __m256i gB, __m256i gC, __m256i gD) {
    const __m256i k = _mm256_set1_epi32(0x00012710);
    const __m256 xAB = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gA, gB), k));
    const __m256 xCD = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gC, gD), k));
    const __m256i hi = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0x88));
    const __m256i lo = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0xDD));
    const __m256i v = _mm256_add_epi32(_mm256_mullo_epi32(hi, _mm256_set1_epi32(100000000)), lo);
    return _mm256_permutevar8x32_epi32(v, _mm256_setr_epi32(0, 4, 1, 5, 2, 6, 3, 7));
}
// ntok divisible by 4 * S; stream k covers tokens [k S, (k + 1) S).
__attribute__((noinline)) uint64_t conv_only(const char* text, const int32_t* sep, size_t ntok, uint32_t* out) {
    const size_t S = ntok / 4;
    for (size_t i = 0; i + 4 <= S; i += 4) {
        __m256i a12, a34, b12, b34, c12, c34, d12, d34;
        conv4(text, sep + i, a12, a34); conv4(text, sep + S + i, b12, b34);
        conv4(text, sep + 2 * S + i, c12, c34); conv4(text, sep + 3 * S + i, d12, d34);
        const __m256i q12 = combine4(a12, b12, c12, d12), q34 = combine4(a34, b34, c34, d34);
        const __m256i ac = _mm256_unpacklo_epi64(q12, q34), bd = _mm256_unpackhi_epi64(q12, q34);
        _mm_storeu_si128(reinterpret_cast<__m128i*>(out + i), _mm256_castsi256_si128(ac));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(out + S + i), _mm256_castsi256_si128(bd));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(out + 2 * S + i), _mm256_extracti128_si256(ac, 1));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(out + 3 * S + i), _mm256_extracti128_si256(bd, 1));
    }
    return out[S / 2];
}
}  // namespace qp_ablate
