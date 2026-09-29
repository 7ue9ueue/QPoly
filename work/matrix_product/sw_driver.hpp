// Strassen-Winograd driver over packed-panel leaves (exploration 013, steps 2b/3).
// Shared by kernels/step2_sw.cpp and kernels/step3_asm.cpp; see step2_sw.cpp for the layout.
#pragma once
#include <algorithm>
#include <cstring>

#include "common.hpp"
#include "simd.hpp"
#include "simd_kernel.hpp"
#include "strassen.hpp"

namespace mp::sw {
using namespace mp::simd;
inline std::size_t round_up(std::size_t x, std::size_t r) { return (x + r - 1) / r * r; }

// x, y in [-H, H] (as i32 bit patterns) -> x +/- y reduced to [-H, H].
MP_AI V center_reduce(V s) {
    const V h = _mm256_set1_epi32(int(H)), nh = _mm256_set1_epi32(-int(H)), p = _mm256_set1_epi32(int(P));
    const V gt = _mm256_cmpgt_epi32(s, h), lt = _mm256_cmpgt_epi32(nh, s);
    return _mm256_add_epi32(_mm256_sub_epi32(s, _mm256_and_si256(gt, p)), _mm256_and_si256(lt, p));
}
MP_AI i32 center_reduce(i32 s) { return s > i32(H) ? s - i32(P) : s < -i32(H) ? s + i32(P) : s; }
struct CenteredOps {
    static void add(const u32* x, const u32* y, u32* z, std::size_t len) {
        std::size_t i = 0;
        for (; i + 8 <= len; i += 8) {
            const V a = _mm256_loadu_si256(reinterpret_cast<const V*>(x + i)), b = _mm256_loadu_si256(reinterpret_cast<const V*>(y + i));
            _mm256_storeu_si256(reinterpret_cast<V*>(z + i), center_reduce(_mm256_add_epi32(a, b)));
        }
        for (; i < len; ++i) z[i] = u32(center_reduce(i32(x[i]) + i32(y[i])));
    }
    static void sub(const u32* x, const u32* y, u32* z, std::size_t len) {
        std::size_t i = 0;
        for (; i + 8 <= len; i += 8) {
            const V a = _mm256_loadu_si256(reinterpret_cast<const V*>(x + i)), b = _mm256_loadu_si256(reinterpret_cast<const V*>(y + i));
            _mm256_storeu_si256(reinterpret_cast<V*>(z + i), center_reduce(_mm256_sub_epi32(a, b)));
        }
        for (; i < len; ++i) z[i] = u32(center_reduce(i32(x[i]) - i32(y[i])));
    }
};
struct CanonicalOps {
    static void add(const u32* x, const u32* y, u32* z, std::size_t len) {
        const V p = _mm256_set1_epi32(int(P));
        std::size_t i = 0;
        for (; i + 8 <= len; i += 8) {
            const V a = _mm256_loadu_si256(reinterpret_cast<const V*>(x + i)), b = _mm256_loadu_si256(reinterpret_cast<const V*>(y + i));
            const V s = _mm256_add_epi32(a, b);
            _mm256_storeu_si256(reinterpret_cast<V*>(z + i), _mm256_min_epu32(s, _mm256_sub_epi32(s, p)));
        }
        for (; i < len; ++i) { const u32 s = x[i] + y[i]; z[i] = s >= P ? s - P : s; }
    }
    static void sub(const u32* x, const u32* y, u32* z, std::size_t len) {
        const V p = _mm256_set1_epi32(int(P));
        std::size_t i = 0;
        for (; i + 8 <= len; i += 8) {
            const V a = _mm256_loadu_si256(reinterpret_cast<const V*>(x + i)), b = _mm256_loadu_si256(reinterpret_cast<const V*>(y + i));
            const V s = _mm256_add_epi32(_mm256_sub_epi32(a, b), p);
            _mm256_storeu_si256(reinterpret_cast<V*>(z + i), _mm256_min_epu32(s, _mm256_sub_epi32(s, p)));
        }
        for (; i < len; ++i) { const u32 s = x[i] - y[i] + P; z[i] = s >= P ? s - P : s; }
    }
};

template <int MR, int NRV, int U>
struct SimdLeaf {
    using E = u32;
    static constexpr int NR = 8 * NRV;
    static void multiply(const u32* a, const u32* b, u32* c, std::size_t n, std::size_t m, std::size_t k) {
        const std::size_t np = n / MR, kp = k / NR;
        for (std::size_t jp = 0; jp < kp; ++jp)
            for (std::size_t ip = 0; ip < np; ++ip)
                micro<1, 1, MR, NRV, U>(a + ip * MR * m, b + jp * NR * m, int(m), c + (ip * kp + jp) * MR * NR, NR, MR, NR);
    }
};

// Vectorized conversions for MR = 4, NR = 8 leaves; scalar fallback for partial chunks.
inline void pack_a_leaf4(const u32* a, int n, int m, u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
    for (std::size_t p = 0; p < lr / 4; ++p) {
        u32* dst = blk + p * lc * 4;
        const std::size_t gr = r0 + 4 * p;
        std::size_t t = 0;
        if (gr + 4 <= std::size_t(n)) {
            const u32* src = a + gr * m + c0;
            for (; t + 8 <= lc && c0 + t + 8 <= std::size_t(m); t += 8) {
                V x[4];
                for (int i = 0; i < 4; ++i)
                    x[i] = center8(to_mont8(_mm256_loadu_si256(reinterpret_cast<const V*>(src + std::size_t(i) * m + t))));
                transpose4x8_store(x[0], x[1], x[2], x[3], dst + t * 4);
            }
        }
        for (; t < lc; ++t)
            for (int i = 0; i < 4; ++i) {
                const std::size_t row = gr + i, col = c0 + t;
                dst[t * 4 + i] = row < std::size_t(n) && col < std::size_t(m) ? u32(center(to_mont(a[row * m + col]))) : 0;
            }
    }
}
inline void pack_b_leaf8(const u32* b, int m, int k, u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
    for (std::size_t j = 0; j < lc / 8; ++j) {
        u32* dst = blk + j * lr * 8;
        const std::size_t gc = c0 + 8 * j;
        for (std::size_t t = 0; t < lr; ++t) {
            const std::size_t gr = r0 + t;
            if (gr < std::size_t(m) && gc + 8 <= std::size_t(k)) {
                _mm256_storeu_si256(reinterpret_cast<V*>(dst + t * 8),
                                    center8(_mm256_loadu_si256(reinterpret_cast<const V*>(b + gr * k + gc))));
            } else {
                for (int q = 0; q < 8; ++q)
                    dst[t * 8 + q] = gr < std::size_t(m) && gc + q < std::size_t(k) ? u32(center(b[gr * k + gc + q])) : 0;
            }
        }
    }
}
inline void unpack_c_leaf4x8(const u32* blk, int n, int k, u32* c, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
    const std::size_t kp = lc / 8;
    for (std::size_t p = 0; p < lr / 4; ++p)
        for (std::size_t j = 0; j < kp; ++j) {
            const u32* tile = blk + (p * kp + j) * 32;
            for (int i = 0; i < 4; ++i) {
                const std::size_t row = r0 + 4 * p + i, col = c0 + 8 * j;
                if (row >= std::size_t(n)) break;
                if (col + 8 <= std::size_t(k))
                    _mm256_storeu_si256(reinterpret_cast<V*>(c + row * k + col), _mm256_loadu_si256(reinterpret_cast<const V*>(tile + i * 8)));
                else
                    for (std::size_t q = 0; col + q < std::size_t(k); ++q) c[row * k + col + q] = tile[i * 8 + q];
            }
        }
}

template <int D, int MR, int NRV, int U, int Phases = 7, bool Vec = false, class LeafT = SimdLeaf<MR, NRV, U>>  // Phases: 1 pack, 2 multiply, 4 unpack
void sw_simd(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    static_assert(!Vec || (MR == 4 && NRV == 1));
    using Leaf = LeafT;
    using SW = StrassenWinograd<Leaf, CenteredOps, CanonicalOps>;
    constexpr int NR = Leaf::NR;
    const std::size_t N = round_up(n, std::size_t(MR) << D), M = round_up(m, std::size_t(U) << D),
                      K = round_up(k, std::size_t(NR) << D);
    const std::size_t sa = round_up(N * M, 16), sb = round_up(M * K, 16), sc = round_up(N * K, 16);
    u32* base = static_cast<u32*>(scratch((sa + sb + sc + SW::workspace(N, M, K, D)) * 4 + 64, 3));
    u32 *pa = base, *pb = pa + sa, *pc = pb + sb, *work = pc + sc;
    if constexpr (Vec) {
        if (Phases & 1) {
            for_each_leaf(pa, N, M, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
                pack_a_leaf4(a, n, m, blk, r0, c0, lr, lc);
            });
            for_each_leaf(pb, M, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
                pack_b_leaf8(b, m, k, blk, r0, c0, lr, lc);
            });
        }
        if (Phases & 2) SW::multiply(pa, pb, pc, N, M, K, D, work);
        if (Phases & 4)
            for_each_leaf(pc, N, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
                unpack_c_leaf4x8(blk, n, k, c, r0, c0, lr, lc);
            });
        return;
    }
    if (Phases & 1) for_each_leaf(pa, N, M, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        for (std::size_t r = 0; r < lr; ++r) {
            u32* dst = blk + (r / MR) * (lc * MR) + (r % MR);
            const std::size_t gr = r0 + r;
            for (std::size_t t = 0; t < lc; ++t) {
                const std::size_t gc = c0 + t;
                dst[t * MR] = gr < std::size_t(n) && gc < std::size_t(m) ? u32(center(to_mont(a[gr * m + gc]))) : 0;
            }
        }
    });
    if (Phases & 1) for_each_leaf(pb, M, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        for (std::size_t t = 0; t < lr; ++t) {
            const std::size_t gr = r0 + t;
            for (std::size_t j = 0; j < lc; ++j) {
                const std::size_t gc = c0 + j;
                blk[(j / NR) * (lr * NR) + t * NR + (j % NR)] =
                    gr < std::size_t(m) && gc < std::size_t(k) ? u32(center(b[gr * k + gc])) : 0;
            }
        }
    });
    if (Phases & 2) SW::multiply(pa, pb, pc, N, M, K, D, work);
    if (Phases & 4) for_each_leaf(pc, N, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        const std::size_t kp = lc / NR;
        for (std::size_t r = 0; r < lr && r0 + r < std::size_t(n); ++r)
            for (std::size_t j = 0; j < lc && c0 + j < std::size_t(k); ++j)
                c[(r0 + r) * k + c0 + j] = blk[((r / MR) * kp + j / NR) * MR * NR + (r % MR) * NR + (j % NR)];
    });
}
}  // namespace mp::sw
