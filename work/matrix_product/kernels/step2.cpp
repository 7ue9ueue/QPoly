// Step 2: explicit AVX2 micro-kernels (exploration 013), plain GEMM without Strassen.
//
// Micro-kernel: MR rows x NR = 8*NRV columns of C in 2*MR*NRV 64-bit accumulators
// (even columns 0,2,4,6 and odd columns 1,3,5,7 of each 8-column group).
//  Load=0 ("bs", the common form): A value via vpbroadcastd (an FP1/FP2 op on Zen 3), B row
//         segment via one load plus vpsrlq for the odd lanes (FP1/FP2).
//  Load=1 ("sd"): A value via vbroadcastss, B even/odd lanes via vmovsldup/vmovshdup, all
//         memory forms, which are pure load-port ops on Zen 3 (uops.info), so only the
//         multiplies (FP0/FP3) and adds (any pipe) use the vector pipes.
//  Rep=0: canonical inputs, vpmuludq, shrink every 8 products (2 ops per accumulator).
//  Rep=1: centered inputs, vpmuldq, fold every 32 products (4 ops per accumulator).
// A is packed in MR-row panels [t][MR] with the Montgomery factor 2^32; B in NR-column
// panels [t][NR]. Depth is padded with zeros to a multiple of U (unroll). Loop order:
// NC-column slabs of B (L2), all row panels, all column panels of the slab.
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3")
#endif
#include "../common.hpp"
#include "../simd.hpp"

#include <algorithm>
#include <cstring>

using namespace mp;
using namespace mp::simd;

namespace {
std::size_t round_up(std::size_t x, std::size_t r) { return (x + r - 1) / r * r; }

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
                        const V raw = _mm256_load_si256(reinterpret_cast<const V*>(p));
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

template <int Rep, int Load, int MR, int NRV, int U, int NC>
void gemm(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    constexpr int NR = 8 * NRV;
    static_assert(NC % NR == 0);
    const std::size_t N = round_up(n, MR), K = round_up(k, NR), M = round_up(m, U);
    u32* pa = static_cast<u32*>(scratch((N * M + K * M) * 4 + 64, 1));
    u32* pb = pa + N * M;
    // Pack A: panel p holds rows p*MR.. as [t][r]; Montgomery factor, representation.
    for (std::size_t p = 0; p < N / MR; ++p) {
        u32* dst = pa + p * MR * M;
        for (int r = 0; r < MR; ++r) {
            const std::size_t row = p * MR + r;
            if (row < std::size_t(n)) {
                const u32* src = a + row * m;
                for (int t = 0; t < m; ++t) {
                    const u32 x = to_mont(src[t]);
                    dst[std::size_t(t) * MR + r] = Rep ? u32(center(x)) : x;
                }
                for (std::size_t t = m; t < M; ++t) dst[t * MR + r] = 0;
            } else {
                for (std::size_t t = 0; t < M; ++t) dst[t * MR + r] = 0;
            }
        }
    }
    // Pack B: panel q holds columns q*NR.. as [t][j].
    for (std::size_t q = 0; q < K / NR; ++q) {
        u32* dst = pb + q * NR * M;
        const std::size_t c0 = q * NR, w = std::min<std::size_t>(NR, k - c0);
        for (std::size_t t = 0; t < M; ++t) {
            u32* d = dst + t * NR;
            if (t < std::size_t(m)) {
                const u32* src = b + t * k + c0;
                for (std::size_t j = 0; j < w; ++j) d[j] = Rep ? u32(center(src[j])) : src[j];
                for (std::size_t j = w; j < NR; ++j) d[j] = 0;
            } else {
                for (std::size_t j = 0; j < NR; ++j) d[j] = 0;
            }
        }
    }
    for (std::size_t jc = 0; jc < K; jc += NC) {
        const std::size_t je = std::min<std::size_t>(K, jc + NC);
        for (std::size_t p = 0; p < N / MR; ++p) {
            const int rows = int(std::min<std::size_t>(MR, n - p * MR));
            for (std::size_t j = jc; j < je; j += NR) {
                const int cols = int(std::min<std::size_t>(NR, k - j));
                micro<Rep, Load, MR, NRV, U>(pa + p * MR * M, pb + (j / NR) * NR * M, int(M), c + p * MR * k + j, k, rows, cols);
            }
        }
    }
}
}  // namespace

// Baseline shape and the two load styles / representations.
MP_REGISTER(v01_u_bs_4x8, (gemm<0, 0, 4, 1, 1, 64>), "unsigned, vpbroadcastd + vpsrlq, shrink/8, 4x8, U1");
MP_REGISTER(v02_u_sd_4x8, (gemm<0, 1, 4, 1, 1, 64>), "unsigned, vbroadcastss + vmovs[lh]dup, shrink/8, 4x8, U1");
MP_REGISTER(v03_s_bs_4x8, (gemm<1, 0, 4, 1, 1, 64>), "signed, vpbroadcastd + vpsrlq, fold/32, 4x8, U1");
MP_REGISTER(v04_s_sd_4x8, (gemm<1, 1, 4, 1, 1, 64>), "signed, vbroadcastss + vmovs[lh]dup, fold/32, 4x8, U1");
// Unrolling and tile shapes for the signed load-only form.
MP_REGISTER(v05_s_sd_4x8_u2, (gemm<1, 1, 4, 1, 2, 64>), "v04 unrolled x2");
MP_REGISTER(v06_s_sd_4x8_u4, (gemm<1, 1, 4, 1, 4, 64>), "v04 unrolled x4");
MP_REGISTER(v07_s_sd_6x8_u2, (gemm<1, 1, 6, 1, 2, 64>), "signed sd 6x8 (12 accumulators), U2");
MP_REGISTER(v08_s_sd_2x16_u2, (gemm<1, 1, 2, 2, 2, 64>), "signed sd 2x16 (8 accumulators), U2");
MP_REGISTER(v09_s_sd_4x8_u4_nc128, (gemm<1, 1, 4, 1, 4, 128>), "v06 with 128-column slabs");
MP_REGISTER(v10_s_sd_4x8_u4_nc32, (gemm<1, 1, 4, 1, 4, 32>), "v06 with 32-column slabs");
