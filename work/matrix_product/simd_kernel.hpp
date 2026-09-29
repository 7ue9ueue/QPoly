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

}  // namespace mp::simd
