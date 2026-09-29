// Register-tiled AVX2 micro-kernel shared by the step-2 variants (exploration 013).
// C[0..rows) x [0..cols) (row stride ldc) = canonical( A-panel x B-panel ) where the A panel is
// [t][MR] (Montgomery factor, rep-specific values) and the B panel [t][NR], NR = 8*NRV, depth m
// a multiple of U. See kernels/step2.cpp for the Rep/Load parameters. Must be included from a
// translation unit compiled with -O3 semantics (the step-2 TUs use #pragma GCC optimize("O3")):
// at plain -O2 GCC keeps the accumulator array in memory.
#pragma once
#include <algorithm>
#include <cstring>

#include "simd.hpp"

namespace mp::simd {
template <int Rep, int Load, int MR, int NRV, int U>
MP_AI void micro(const u32* pa, const u32* pb, int m, u32* c, int ldc, int rows, int cols) {
    constexpr int NR = 8 * NRV, Q = 2 * NRV, F = Rep ? 32 : 8;
    static_assert(F % U == 0);
    V acc[MR][Q];
#pragma GCC unroll 16
    for (int r = 0; r < MR; ++r)
#pragma GCC unroll 4
        for (int q = 0; q < Q; ++q) acc[r][q] = _mm256_setzero_si256();
    const u32* pbo = opaque(pb);
    for (int t0 = 0; t0 < m; t0 += F) {
        const int te = std::min(m, t0 + F);
        for (int t = t0; t < te; t += U) {
#pragma GCC unroll 8
            for (int u = 0; u < U; ++u) {
                V bv[Q];
#pragma GCC unroll 2
                for (int v = 0; v < NRV; ++v) {
                    const u32* p = pb + std::size_t(t + u) * NR + 8 * v;
                    if constexpr (Load == 1) {
                        bv[2 * v] = ldup(p);
                        bv[2 * v + 1] = hdup(pbo + std::size_t(t + u) * NR + 8 * v);
                    } else {
                        const V raw = _mm256_loadu_si256(reinterpret_cast<const V*>(p));
                        bv[2 * v] = raw;
                        bv[2 * v + 1] = _mm256_srli_epi64(raw, 32);
                    }
                }
#pragma GCC unroll 16
                for (int r = 0; r < MR; ++r) {
                    const u32* ap = pa + std::size_t(t + u) * MR + r;
                    const V x = Load == 1 ? bcast(ap) : _mm256_set1_epi32(int(*ap));
#pragma GCC unroll 4
                    for (int q = 0; q < Q; ++q) {
                        acc[r][q] = _mm256_add_epi64(acc[r][q], Rep ? _mm256_mul_epi32(x, bv[q]) : _mm256_mul_epu32(x, bv[q]));
                        asm("" : "+x"(acc[r][q]));  // keep one add chain per accumulator (no reassociation/spills)
                    }
                }
            }
        }
        if (te < m) {
#pragma GCC unroll 16
            for (int r = 0; r < MR; ++r)
#pragma GCC unroll 4
                for (int q = 0; q < Q; ++q) acc[r][q] = Rep ? fold_s(acc[r][q]) : shrink_u(acc[r][q]);
        }
    }
    if (rows == MR && cols == NR) {
#pragma GCC unroll 16
        for (int r = 0; r < MR; ++r)
#pragma GCC unroll 2
            for (int v = 0; v < NRV; ++v) {
                const V out = Rep ? finish_s(acc[r][2 * v], acc[r][2 * v + 1]) : finish_u(acc[r][2 * v], acc[r][2 * v + 1]);
                _mm256_storeu_si256(reinterpret_cast<V*>(c + std::size_t(r) * ldc + 8 * v), out);
            }
    } else {
        alignas(32) u32 tmp[MR][NR];
        for (int r = 0; r < MR; ++r)
            for (int v = 0; v < NRV; ++v) {
                const V out = Rep ? finish_s(acc[r][2 * v], acc[r][2 * v + 1]) : finish_u(acc[r][2 * v], acc[r][2 * v + 1]);
                _mm256_store_si256(reinterpret_cast<V*>(&tmp[r][8 * v]), out);
            }
        for (int r = 0; r < rows; ++r) std::memcpy(c + std::size_t(r) * ldc, tmp[r], std::size_t(cols) * 4);
    }
}


// ---- Winograd inner-product (1968) micro-kernel, 4 x 8, centered inputs ----
// For a k-pair (2s, 2s+1): sum_t a_t b_t = (a_2s + b_2s+1)(a_2s+1 + b_2s) - a_2s a_2s+1 - b_2s b_2s+1.
// Halves the multiplies (and replaces them with 32-bit adds); on Zen 3 the mix of 25%
// multiplies (FP0/FP3) and 75% adds keeps all four vector pipes busy, unlike the direct
// kernel's 1:1 mix. alpha[r] = sum_s a_2s a_2s+1 and beta[j] = sum_s b_2s b_2s+1 (centered
// residues) are subtracted by initializing the accumulators with -(alpha + beta).
// Bounds: |a|, |b| <= H so each factor is <= 2H = P-1 < 2^30 and each product <= (P-1)^2;
// fold residual 6.4852e17 + 8 products 7.9719e18 < 2^63, so fold every 8 k-pairs.
// m must be even (a multiple of 2*U2). alpha: 4 centered values, beta: 8 centered values.
template <int U2>
MP_AI void micro_wip(const u32* pa, const u32* pb, int m, const i32* alpha, const i32* beta, u32* c, int ldc, int rows, int cols) {
    static_assert(8 % U2 == 0);
    V acc[4][2];
    {
        const V be = _mm256_cvtepi32_epi64(_mm_setr_epi32(beta[0], beta[2], beta[4], beta[6]));
        const V bo = _mm256_cvtepi32_epi64(_mm_setr_epi32(beta[1], beta[3], beta[5], beta[7]));
#pragma GCC unroll 4
        for (int r = 0; r < 4; ++r) {
            const V ar = _mm256_set1_epi64x(alpha[r]);
            acc[r][0] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, be));
            acc[r][1] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, bo));
        }
    }
    const u32* pbo = opaque(pb);
    for (int t0 = 0; t0 < m; t0 += 16) {
        const int te = std::min(m, t0 + 16);
        for (int t = t0; t < te; t += 2 * U2) {
#pragma GCC unroll 8
            for (int u = 0; u < U2; ++u) {
                const std::size_t k0 = std::size_t(t + 2 * u), k1 = k0 + 1;
                const V be0 = ldup(pb + k0 * 8), bo0 = hdup(pbo + k0 * 8);
                const V be1 = ldup(pb + k1 * 8), bo1 = hdup(pbo + k1 * 8);
#pragma GCC unroll 4
                for (int r = 0; r < 4; ++r) {
                    const V x0 = bcast(pa + k0 * 4 + r), x1 = bcast(pa + k1 * 4 + r);
                    acc[r][0] = _mm256_add_epi64(acc[r][0], _mm256_mul_epi32(_mm256_add_epi32(x0, be1), _mm256_add_epi32(x1, be0)));
                    asm("" : "+x"(acc[r][0]));
                    acc[r][1] = _mm256_add_epi64(acc[r][1], _mm256_mul_epi32(_mm256_add_epi32(x0, bo1), _mm256_add_epi32(x1, bo0)));
                    asm("" : "+x"(acc[r][1]));
                }
            }
        }
        if (te < m) {
#pragma GCC unroll 4
            for (int r = 0; r < 4; ++r) acc[r][0] = fold_s(acc[r][0]), acc[r][1] = fold_s(acc[r][1]);
        }
    }
    if (rows == 4 && cols == 8) {
#pragma GCC unroll 4
        for (int r = 0; r < 4; ++r)
            _mm256_storeu_si256(reinterpret_cast<V*>(c + std::size_t(r) * ldc), finish_s(acc[r][0], acc[r][1]));
    } else {
        alignas(32) u32 tmp[4][8];
        for (int r = 0; r < 4; ++r) _mm256_store_si256(reinterpret_cast<V*>(tmp[r]), finish_s(acc[r][0], acc[r][1]));
        for (int r = 0; r < rows; ++r) std::memcpy(c + std::size_t(r) * ldc, tmp[r], std::size_t(cols) * 4);
    }
}

// Corrections for the Winograd kernel. A panel [t][4] -> alpha[4]; B panel [t][8] -> beta[8];
// m even. Products <= H^2, 32 per fold keep |acc| < 2^63; results are centered residues.
MP_AI i32 centered_mod(i64 x) {
    i64 r = x % i64(P);
    if (r > i64(H)) r -= P;
    if (r < -i64(H)) r += P;
    return i32(r);
}
inline void wip_alpha4(const u32* pa, int m, i32* alpha) {
    V acc = _mm256_setzero_si256();
    for (int t = 0; t < m; t += 2) {
        const V x0 = _mm256_cvtepi32_epi64(_mm_loadu_si128(reinterpret_cast<const __m128i*>(pa + std::size_t(t) * 4)));
        const V x1 = _mm256_cvtepi32_epi64(_mm_loadu_si128(reinterpret_cast<const __m128i*>(pa + std::size_t(t + 1) * 4)));
        acc = _mm256_add_epi64(acc, _mm256_mul_epi32(x0, x1));
        if ((t & 63) == 62) acc = fold_s(acc);
    }
    alignas(32) i64 v[4];
    _mm256_store_si256(reinterpret_cast<V*>(v), acc);
    for (int r = 0; r < 4; ++r) alpha[r] = centered_mod(v[r]);
}
inline void wip_beta8(const u32* pb, int m, i32* beta) {
    V ae = _mm256_setzero_si256(), ao = _mm256_setzero_si256();
    for (int t = 0; t < m; t += 2) {
        const V b0 = _mm256_loadu_si256(reinterpret_cast<const V*>(pb + std::size_t(t) * 8));
        const V b1 = _mm256_loadu_si256(reinterpret_cast<const V*>(pb + std::size_t(t + 1) * 8));
        ae = _mm256_add_epi64(ae, _mm256_mul_epi32(b0, b1));
        ao = _mm256_add_epi64(ao, _mm256_mul_epi32(_mm256_srli_epi64(b0, 32), _mm256_srli_epi64(b1, 32)));
        if ((t & 63) == 62) ae = fold_s(ae), ao = fold_s(ao);
    }
    alignas(32) i64 e[4], o[4];
    _mm256_store_si256(reinterpret_cast<V*>(e), ae);
    _mm256_store_si256(reinterpret_cast<V*>(o), ao);
    for (int q = 0; q < 4; ++q) beta[2 * q] = centered_mod(e[q]), beta[2 * q + 1] = centered_mod(o[q]);
}
}  // namespace mp::simd
