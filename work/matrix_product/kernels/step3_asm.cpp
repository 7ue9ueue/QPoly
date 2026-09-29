// Step 3: generated inline-asm micro-kernels (gen_asm.py -> asm_kernels.hpp) inside the
// Strassen-Winograd driver (exploration 013). Leaves are 4x8 tiles over packed panels; the
// Winograd kernels start from the -(alpha + beta) corrections, the direct kernel from zero.
// Depth handling: full periods in the main asm loop (fold at the top of every period but
// the first), then the remaining units in the tail loop (which folds first).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3")
#endif
#include "../common.hpp"
#include "../simd.hpp"
#include "../simd_kernel.hpp"
#include "../asm_kernels.hpp"
#include "../strassen.hpp"
#include "../sw_driver.hpp"

using namespace mp;
using namespace mp::simd;

namespace {
using namespace mp::sw;

#define MP_KERN(NAME, WIP)                                                               \
    struct K_##NAME {                                                                    \
        static constexpr bool wip = WIP;                                                 \
        static constexpr int period = asm_##NAME##_period, unit = asm_##NAME##_unit;     \
        static void main(const u32* pa, const u32* pb, long n, V (&acc)[8]) { asm_##NAME(pa, pb, n, acc); } \
        static void tail(const u32* pa, const u32* pb, long n, V (&acc)[8]) { asm_##NAME##_tail(pa, pb, n, acc); } \
    };
MP_KERN(wipp_s0, true)
MP_KERN(wipp_i2, true)
MP_KERN(wip_s0, true)
MP_KERN(direct_g_s0, false)
MP_KERN(wipp_sh, true)

template <class K>
MP_AI void tile(const u32* pa, const u32* pb, std::size_t m, const i32* alpha, const i32* beta, u32* c, std::size_t ldc) {
    V acc[8];
    if constexpr (K::wip) {
        const V be = _mm256_cvtepi32_epi64(_mm_setr_epi32(beta[0], beta[2], beta[4], beta[6]));
        const V bo = _mm256_cvtepi32_epi64(_mm_setr_epi32(beta[1], beta[3], beta[5], beta[7]));
        for (int r = 0; r < 4; ++r) {
            const V ar = _mm256_set1_epi64x(alpha[r]);
            acc[2 * r] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, be));
            acc[2 * r + 1] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, bo));
        }
    } else {
        for (auto& x : acc) x = _mm256_setzero_si256();
    }
    const std::size_t periods = m / K::period, rest = (m % K::period) / K::unit;
    if (periods) K::main(pa, pb, long(periods), acc);
    if (rest) K::tail(pa + periods * K::period * 4, pb + periods * K::period * 8, long(rest), acc);
    for (int r = 0; r < 4; ++r) _mm256_storeu_si256(reinterpret_cast<V*>(c + r * ldc), finish_s(acc[2 * r], acc[2 * r + 1]));
}

struct NullLeafX {
    using E = u32;
    static void multiply(const u32*, const u32*, u32*, std::size_t, std::size_t, std::size_t) {}
};

template <class K>
struct AsmLeaf {
    using E = u32;
    static constexpr int NR = 8;
    static void multiply(const u32* a, const u32* b, u32* c, std::size_t n, std::size_t m, std::size_t k) {
        const std::size_t np = n / 4, kp = k / 8;
        i32* alpha = static_cast<i32*>(scratch((n + k) * 4 + 64, 4));
        i32* beta = alpha + n;
        if constexpr (K::wip) {
            for (std::size_t ip = 0; ip < np; ++ip) wip_alpha4(a + ip * 4 * m, int(m), alpha + 4 * ip);
            for (std::size_t jp = 0; jp < kp; ++jp) wip_beta8(b + jp * 8 * m, int(m), beta + 8 * jp);
        }
        for (std::size_t jp = 0; jp < kp; ++jp)
            for (std::size_t ip = 0; ip < np; ++ip)
                tile<K>(a + ip * 4 * m, b + jp * 8 * m, m, alpha + 4 * ip, beta + 8 * jp, c + (ip * kp + jp) * 32, 8);
    }
};

// Plain GEMM with the asm kernel (no Strassen): packed panels, NC = 64 column slabs.
template <class K>
void gemm_asm(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    const std::size_t N = round_up(n, 4), K_ = round_up(k, 8), M = round_up(m, 2);
    const std::size_t sa = round_up(N * M, 16);
    u32* pa = static_cast<u32*>(scratch((sa + K_ * M) * 4 + 64, 1));
    u32* pb = pa + sa;
    i32* alpha = static_cast<i32*>(scratch((N + K_) * 4 + 64, 5));
    i32* beta = alpha + N;
    pack_a_leaf4(a, n, m, pa, 0, 0, N, M);
    pack_b_leaf8(b, m, k, pb, 0, 0, M, K_);
    if constexpr (K::wip) {
        for (std::size_t ip = 0; ip < N / 4; ++ip) wip_alpha4(pa + ip * 4 * M, int(M), alpha + 4 * ip);
        for (std::size_t jp = 0; jp < K_ / 8; ++jp) wip_beta8(pb + jp * 8 * M, int(M), beta + 8 * jp);
    }
    alignas(32) u32 tmp[32];
    for (std::size_t jc = 0; jc < K_; jc += 64) {
        const std::size_t je = std::min<std::size_t>(K_, jc + 64);
        for (std::size_t ip = 0; ip < N / 4; ++ip)
            for (std::size_t j = jc; j < je; j += 8) {
                const bool full = ip * 4 + 4 <= std::size_t(n) && j + 8 <= std::size_t(k);
                u32* dst = full ? c + ip * 4 * k + j : tmp;
                tile<K>(pa + ip * 4 * M, pb + (j / 8) * 8 * M, M, alpha + 4 * ip, beta + j, dst, full ? k : 8);
                if (!full)
                    for (std::size_t r = 0; r < 4 && ip * 4 + r < std::size_t(n); ++r)
                        for (std::size_t q = 0; q < 8 && j + q < std::size_t(k); ++q) c[(ip * 4 + r) * k + j + q] = tmp[r * 8 + q];
            }
    }
}
}  // namespace

MP_REGISTER(a01_gemm_wipp, gemm_asm<K_wipp_s0>, "plain packed GEMM, asm Winograd packed-B kernel");
MP_REGISTER(a02_gemm_direct_g, gemm_asm<K_direct_g_s0>, "plain packed GEMM, asm direct kernel (GCC-like order)");
MP_REGISTER(a12_sw2_wipp, (sw_simd<2, 4, 1, 2, 7, true, AsmLeaf<K_wipp_s0>>), "Strassen-Winograd depth 2, asm wipp_s0 leaf");
MP_REGISTER(a13_sw3_wipp, (sw_simd<3, 4, 1, 2, 7, true, AsmLeaf<K_wipp_s0>>), "Strassen-Winograd depth 3, asm wipp_s0 leaf");
MP_REGISTER(a14_sw4_wipp, (sw_simd<4, 4, 1, 2, 7, true, AsmLeaf<K_wipp_s0>>), "Strassen-Winograd depth 4, asm wipp_s0 leaf");
MP_REGISTER(a23_sw3_wippi2, (sw_simd<3, 4, 1, 2, 7, true, AsmLeaf<K_wipp_i2>>), "Strassen-Winograd depth 3, asm wipp_i2 leaf");
MP_REGISTER(a24_sw4_wippi2, (sw_simd<4, 4, 1, 2, 7, true, AsmLeaf<K_wipp_i2>>), "Strassen-Winograd depth 4, asm wipp_i2 leaf");
MP_REGISTER(a33_sw3_wip, (sw_simd<3, 4, 1, 2, 7, true, AsmLeaf<K_wip_s0>>), "Strassen-Winograd depth 3, asm wip_s0 leaf");
MP_REGISTER(a43_sw3_direct, (sw_simd<3, 4, 1, 2, 7, true, AsmLeaf<K_direct_g_s0>>), "Strassen-Winograd depth 3, asm direct_g leaf");
MP_REGISTER(a44_sw4_direct, (sw_simd<4, 4, 1, 2, 7, true, AsmLeaf<K_direct_g_s0>>), "Strassen-Winograd depth 4, asm direct_g leaf");
MP_REGISTER(f13_fused3_wippi2, (sw_fused<3, AsmLeaf<K_wipp_i2>>), "fused Strassen-Winograd depth 3, asm wipp_i2 leaf");
MP_REGISTER(f14_fused4_wippi2, (sw_fused<4, AsmLeaf<K_wipp_i2>>), "fused Strassen-Winograd depth 4, asm wipp_i2 leaf");
MP_REGISTER(f23_fused3_wippsh, (sw_fused<3, AsmLeaf<K_wipp_sh>>), "fused Strassen-Winograd depth 3, asm wipp_sh leaf");
MP_REGISTER(a53_sw3_wippsh, (sw_simd<3, 4, 1, 2, 7, true, AsmLeaf<K_wipp_sh>>), "Strassen-Winograd depth 3, asm wipp_sh leaf");
MP_REGISTER_DIAG(y13_fused3_adds_only, (sw_fused<3, NullLeafX, 2>), "fused depth-3 additions only");
MP_REGISTER_DIAG(y14_fused4_adds_only, (sw_fused<4, NullLeafX, 2>), "fused depth-4 additions only");
