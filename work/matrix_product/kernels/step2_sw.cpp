// Step 2b: Strassen-Winograd over the AVX2 micro-kernel (exploration 013).
//
// Recursive quadrant layout (strassen.hpp) whose leaves are already in the kernel's packed
// formats, so leaves need no packing:
//   A side (A, S): leaf n_l x m_l as MR-row panels [n_l/MR][m_l][MR], centered, Montgomery R.
//   B side (B, T): leaf m_l x k_l as NR-column panels [k_l/NR][m_l][NR], centered.
//   C side (P, C): leaf n_l x k_l as tiles [n_l/MR][k_l/NR][MR][NR], canonical.
// A/B-side additions reduce back to the centered range [-H, H] (the kernel's 32-product fold
// bound needs |x| <= H on both inputs); C-side additions stay canonical.
// Padding: n to MR*2^d, k to NR*2^d, m to U*2^d (zeros contribute nothing).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3")
#endif
#include "../common.hpp"
#include "../simd.hpp"
#include "../simd_kernel.hpp"
#include "../strassen.hpp"

#include <algorithm>
#include <cstring>

using namespace mp;
using namespace mp::simd;

namespace {
std::size_t round_up(std::size_t x, std::size_t r) { return (x + r - 1) / r * r; }

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

template <int D, int MR, int NRV, int U>
void sw_simd(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    using Leaf = SimdLeaf<MR, NRV, U>;
    using SW = StrassenWinograd<Leaf, CenteredOps, CanonicalOps>;
    constexpr int NR = Leaf::NR;
    const std::size_t N = round_up(n, std::size_t(MR) << D), M = round_up(m, std::size_t(U) << D),
                      K = round_up(k, std::size_t(NR) << D);
    const std::size_t sa = round_up(N * M, 16), sb = round_up(M * K, 16), sc = round_up(N * K, 16);
    u32* base = static_cast<u32*>(scratch((sa + sb + sc + SW::workspace(N, M, K, D)) * 4 + 64, 3));
    u32 *pa = base, *pb = pa + sa, *pc = pb + sb, *work = pc + sc;
    for_each_leaf(pa, N, M, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        for (std::size_t r = 0; r < lr; ++r) {
            u32* dst = blk + (r / MR) * (lc * MR) + (r % MR);
            const std::size_t gr = r0 + r;
            for (std::size_t t = 0; t < lc; ++t) {
                const std::size_t gc = c0 + t;
                dst[t * MR] = gr < std::size_t(n) && gc < std::size_t(m) ? u32(center(to_mont(a[gr * m + gc]))) : 0;
            }
        }
    });
    for_each_leaf(pb, M, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        for (std::size_t t = 0; t < lr; ++t) {
            const std::size_t gr = r0 + t;
            for (std::size_t j = 0; j < lc; ++j) {
                const std::size_t gc = c0 + j;
                blk[(j / NR) * (lr * NR) + t * NR + (j % NR)] =
                    gr < std::size_t(m) && gc < std::size_t(k) ? u32(center(b[gr * k + gc])) : 0;
            }
        }
    });
    SW::multiply(pa, pb, pc, N, M, K, D, work);
    for_each_leaf(pc, N, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        const std::size_t kp = lc / NR;
        for (std::size_t r = 0; r < lr && r0 + r < std::size_t(n); ++r)
            for (std::size_t j = 0; j < lc && c0 + j < std::size_t(k); ++j)
                c[(r0 + r) * k + c0 + j] = blk[((r / MR) * kp + j / NR) * MR * NR + (r % MR) * NR + (j % NR)];
    });
}
}  // namespace

MP_REGISTER(w11_sw1_s4x8u4, (sw_simd<1, 4, 1, 4>), "Strassen-Winograd depth 1 over signed sd 4x8 U4");
MP_REGISTER(w12_sw2_s4x8u4, (sw_simd<2, 4, 1, 4>), "Strassen-Winograd depth 2 over signed sd 4x8 U4");
MP_REGISTER(w13_sw3_s4x8u4, (sw_simd<3, 4, 1, 4>), "Strassen-Winograd depth 3 over signed sd 4x8 U4");
MP_REGISTER(w14_sw4_s4x8u4, (sw_simd<4, 4, 1, 4>), "Strassen-Winograd depth 4 over signed sd 4x8 U4");
MP_REGISTER(w15_sw5_s4x8u4, (sw_simd<5, 4, 1, 4>), "Strassen-Winograd depth 5 over signed sd 4x8 U4");
MP_REGISTER(w23_sw3_s4x8u1, (sw_simd<3, 4, 1, 1>), "Strassen-Winograd depth 3 over signed sd 4x8 U1");
MP_REGISTER(w33_sw3_s2x16u2, (sw_simd<3, 2, 2, 2>), "Strassen-Winograd depth 3 over signed sd 2x16 U2");
