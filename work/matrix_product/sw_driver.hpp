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

namespace mp::sw {
// Fused passes for StrassenWinogradFused (centered A/B side, canonical C side).
struct FusedOps {
    static void spass(const u32* a11, const u32* a12, const u32* a21, const u32* a22, u32* s1, u32* s2, u32* s3, u32* s4, std::size_t len) {
        std::size_t i = 0;
        for (; i + 8 <= len; i += 8) {
            const V x11 = _mm256_loadu_si256(reinterpret_cast<const V*>(a11 + i)), x12 = _mm256_loadu_si256(reinterpret_cast<const V*>(a12 + i));
            const V x21 = _mm256_loadu_si256(reinterpret_cast<const V*>(a21 + i)), x22 = _mm256_loadu_si256(reinterpret_cast<const V*>(a22 + i));
            const V v1 = center_reduce(_mm256_add_epi32(x21, x22));
            const V v2 = center_reduce(_mm256_sub_epi32(v1, x11));
            _mm256_storeu_si256(reinterpret_cast<V*>(s1 + i), v1);
            _mm256_storeu_si256(reinterpret_cast<V*>(s2 + i), v2);
            _mm256_storeu_si256(reinterpret_cast<V*>(s3 + i), center_reduce(_mm256_sub_epi32(x11, x21)));
            _mm256_storeu_si256(reinterpret_cast<V*>(s4 + i), center_reduce(_mm256_sub_epi32(x12, v2)));
        }
        for (; i < len; ++i) {
            const i32 x11 = i32(a11[i]), x12 = i32(a12[i]), x21 = i32(a21[i]), x22 = i32(a22[i]);
            const i32 v1 = center_reduce(x21 + x22), v2 = center_reduce(v1 - x11);
            s1[i] = u32(v1), s2[i] = u32(v2), s3[i] = u32(center_reduce(x11 - x21)), s4[i] = u32(center_reduce(x12 - v2));
        }
    }
    static void tpass(const u32* b11, const u32* b12, const u32* b21, const u32* b22, u32* t1, u32* t2, u32* t3, u32* t4, std::size_t len) {
        std::size_t i = 0;
        for (; i + 8 <= len; i += 8) {
            const V y11 = _mm256_loadu_si256(reinterpret_cast<const V*>(b11 + i)), y12 = _mm256_loadu_si256(reinterpret_cast<const V*>(b12 + i));
            const V y21 = _mm256_loadu_si256(reinterpret_cast<const V*>(b21 + i)), y22 = _mm256_loadu_si256(reinterpret_cast<const V*>(b22 + i));
            const V w1 = center_reduce(_mm256_sub_epi32(y12, y11));
            const V w2 = center_reduce(_mm256_sub_epi32(y22, w1));
            _mm256_storeu_si256(reinterpret_cast<V*>(t1 + i), w1);
            _mm256_storeu_si256(reinterpret_cast<V*>(t2 + i), w2);
            _mm256_storeu_si256(reinterpret_cast<V*>(t3 + i), center_reduce(_mm256_sub_epi32(y22, y12)));
            _mm256_storeu_si256(reinterpret_cast<V*>(t4 + i), center_reduce(_mm256_sub_epi32(w2, y21)));
        }
        for (; i < len; ++i) {
            const i32 y11 = i32(b11[i]), y12 = i32(b12[i]), y21 = i32(b21[i]), y22 = i32(b22[i]);
            const i32 w1 = center_reduce(y12 - y11), w2 = center_reduce(y22 - w1);
            t1[i] = u32(w1), t2[i] = u32(w2), t3[i] = u32(center_reduce(y22 - y12)), t4[i] = u32(center_reduce(w2 - y21));
        }
    }
    // c11 = P1, c22 = P5, c12 = P6, c21 = P7 on entry (canonical); outputs canonical.
    static void cpass(u32* c11, u32* c12, u32* c21, u32* c22, const u32* p2, const u32* p3, const u32* p4, std::size_t len) {
        const V p = _mm256_set1_epi32(int(P));
        auto red1 = [&](V x) { return _mm256_min_epu32(x, _mm256_sub_epi32(x, p)); };  // [0, 2P) -> [0, P)
        std::size_t i = 0;
        for (; i + 8 <= len; i += 8) {
            const V q1 = _mm256_loadu_si256(reinterpret_cast<const V*>(c11 + i)), q6 = _mm256_loadu_si256(reinterpret_cast<const V*>(c12 + i));
            const V q7 = _mm256_loadu_si256(reinterpret_cast<const V*>(c21 + i)), q5 = _mm256_loadu_si256(reinterpret_cast<const V*>(c22 + i));
            const V q2 = _mm256_loadu_si256(reinterpret_cast<const V*>(p2 + i)), q3 = _mm256_loadu_si256(reinterpret_cast<const V*>(p3 + i));
            const V q4 = _mm256_loadu_si256(reinterpret_cast<const V*>(p4 + i));
            const V u2 = red1(_mm256_add_epi32(q1, q6));      // P1 + P6
            const V u3 = red1(_mm256_add_epi32(u2, q7));      // U2 + P7
            _mm256_storeu_si256(reinterpret_cast<V*>(c11 + i), red1(_mm256_add_epi32(q1, q2)));
            _mm256_storeu_si256(reinterpret_cast<V*>(c12 + i), red1(_mm256_add_epi32(red1(_mm256_add_epi32(u2, q5)), q3)));
            _mm256_storeu_si256(reinterpret_cast<V*>(c21 + i), red1(_mm256_add_epi32(_mm256_sub_epi32(u3, q4), p)));
            _mm256_storeu_si256(reinterpret_cast<V*>(c22 + i), red1(_mm256_add_epi32(u3, q5)));
        }
        auto r1 = [](u32 x) { return x >= P ? x - P : x; };
        for (; i < len; ++i) {
            const u32 q1 = c11[i], q6 = c12[i], q7 = c21[i], q5 = c22[i];
            const u32 u2 = r1(q1 + q6), u3 = r1(u2 + q7);
            c11[i] = r1(q1 + p2[i]);
            c12[i] = r1(r1(u2 + q5) + p3[i]);
            c21[i] = r1(u3 - p4[i] + P);
            c22[i] = r1(u3 + q5);
        }
    }
};

// sw_simd with the fused recursion (vectorized conversions, MR = 4, NR = 8 leaves).
template <int D, class LeafT, int Phases = 7>
void sw_fused(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    using SW = StrassenWinogradFused<LeafT, FusedOps>;
    const std::size_t N = round_up(n, std::size_t(4) << D), M = round_up(m, std::size_t(2) << D),
                      K = round_up(k, std::size_t(8) << D);
    const std::size_t sa = round_up(N * M, 16), sb = round_up(M * K, 16), sc = round_up(N * K, 16);
    u32* base = static_cast<u32*>(scratch((sa + sb + sc + SW::workspace(N, M, K, D)) * 4 + 64, 6));
    u32 *pa = base, *pb = pa + sa, *pc = pb + sb, *work = pc + sc;
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
}
}  // namespace mp::sw
