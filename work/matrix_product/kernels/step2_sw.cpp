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
#include "../sw_driver.hpp"

#include <algorithm>
#include <cstring>

using namespace mp;
using namespace mp::simd;

namespace {
using namespace mp::sw;
// Winograd inner-product leaf (4 x 8 tiles); m even (padding uses U >= 2).
struct WipLeaf {
    using E = u32;
    static constexpr int NR = 8;
    static void multiply(const u32* a, const u32* b, u32* c, std::size_t n, std::size_t m, std::size_t k) {
        const std::size_t np = n / 4, kp = k / 8;
        i32* alpha = static_cast<i32*>(scratch((n + k) * 4 + 64, 4));
        i32* beta = alpha + n;
        for (std::size_t ip = 0; ip < np; ++ip) wip_alpha4(a + ip * 4 * m, int(m), alpha + 4 * ip);
        for (std::size_t jp = 0; jp < kp; ++jp) wip_beta8(b + jp * 8 * m, int(m), beta + 8 * jp);
        for (std::size_t jp = 0; jp < kp; ++jp)
            for (std::size_t ip = 0; ip < np; ++ip)
                micro_wip<1>(a + ip * 4 * m, b + jp * 8 * m, int(m), alpha + 4 * ip, beta + 8 * jp, c + (ip * kp + jp) * 32, 8, 4, 8);
    }
};

// Diagnostic: a leaf that does nothing (times the Strassen additions alone).
struct NullLeaf {
    using E = u32;
    static constexpr int NR = 8;
    static void multiply(const u32*, const u32*, u32*, std::size_t, std::size_t, std::size_t) {}
};

}  // namespace

MP_REGISTER(w11_sw1_s4x8u4, (sw_simd<1, 4, 1, 4>), "Strassen-Winograd depth 1 over signed sd 4x8 U4");
MP_REGISTER(w12_sw2_s4x8u4, (sw_simd<2, 4, 1, 4>), "Strassen-Winograd depth 2 over signed sd 4x8 U4");
MP_REGISTER(w13_sw3_s4x8u4, (sw_simd<3, 4, 1, 4>), "Strassen-Winograd depth 3 over signed sd 4x8 U4");
MP_REGISTER(w14_sw4_s4x8u4, (sw_simd<4, 4, 1, 4>), "Strassen-Winograd depth 4 over signed sd 4x8 U4");
MP_REGISTER(w15_sw5_s4x8u4, (sw_simd<5, 4, 1, 4>), "Strassen-Winograd depth 5 over signed sd 4x8 U4");
MP_REGISTER(w23_sw3_s4x8u1, (sw_simd<3, 4, 1, 1>), "Strassen-Winograd depth 3 over signed sd 4x8 U1");
MP_REGISTER(w33_sw3_s2x16u2, (sw_simd<3, 2, 2, 2>), "Strassen-Winograd depth 3 over signed sd 2x16 U2");
MP_REGISTER_DIAG(x13_pack_only, (sw_simd<3, 4, 1, 4, 1>), "w13 input conversion/packing only");
MP_REGISTER_DIAG(x13_unpack_only, (sw_simd<3, 4, 1, 4, 4>), "w13 output unpacking only");
MP_REGISTER_DIAG(x13_mul_only, (sw_simd<3, 4, 1, 4, 2>), "w13 Strassen multiply only (packed inputs from the last call)");
MP_REGISTER(w43_sw3_vec, (sw_simd<3, 4, 1, 4, 7, true>), "w13 with vectorized conversions");
MP_REGISTER(w44_sw4_vec, (sw_simd<4, 4, 1, 4, 7, true>), "w14 with vectorized conversions");
MP_REGISTER_DIAG(x43_pack_only, (sw_simd<3, 4, 1, 4, 1, true>), "w43 input conversion/packing only");
MP_REGISTER_DIAG(x43_unpack_only, (sw_simd<3, 4, 1, 4, 4, true>), "w43 output unpacking only");
MP_REGISTER(w53_sw3_wip, (sw_simd<3, 4, 1, 2, 7, true, WipLeaf>), "Strassen-Winograd depth 3 over the Winograd inner-product 4x8 kernel");
MP_REGISTER(w54_sw4_wip, (sw_simd<4, 4, 1, 2, 7, true, WipLeaf>), "Strassen-Winograd depth 4 over the Winograd inner-product 4x8 kernel");
MP_REGISTER(w52_sw2_wip, (sw_simd<2, 4, 1, 2, 7, true, WipLeaf>), "Strassen-Winograd depth 2 over the Winograd inner-product 4x8 kernel");
MP_REGISTER_DIAG(x44_adds_only, (sw_simd<4, 4, 1, 4, 2, true, NullLeaf>), "w44 Strassen additions only (leaf products skipped)");
MP_REGISTER_DIAG(x43_adds_only, (sw_simd<3, 4, 1, 4, 2, true, NullLeaf>), "w43 Strassen additions only (leaf products skipped)");
MP_REGISTER_DIAG(x42_adds_only, (sw_simd<2, 4, 1, 4, 2, true, NullLeaf>), "depth-2 Strassen additions only (leaf products skipped)");
