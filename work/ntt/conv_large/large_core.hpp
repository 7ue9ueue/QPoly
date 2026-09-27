// Exploration 010 final driver for large cyclic convolutions modulo 998244353
// (Library Checker convolution_mod_large: transform lengths 2^23..2^25; any power of two
// 2^9..2^26 is supported).
//
// Building block: the exploration-009 kernel qasm.hpp (branch claude/ntt-asm-explore 1e64289)
// with its selected Library Checker configuration, unchanged. That kernel splits x^n - 1 down
// to x^8 - w (w over the (n/8)-th roots of unity) and multiplies the degree-7 leaves directly,
// so only roots of order n/8 <= 2^23 are needed. Its depth-first radix-4 recursion (forward a
// and b, leaves, inverse, subtree by subtree) stays within ~5-15% of compute speed below the
// top level at 2^25 on Zen 3 (exploration 010 per-depth timers); the drivers tried instead
// (fused top passes over column panels, non-temporal stores, fusing the top levels into I/O)
// were slower. Changes relative to qasm's run() for even log2(n/8):
//  * zero-upper top: when an input has at most n/2 leading nonzeros (ordinary convolution),
//    its first radix-4 group reads only the lower half: outputs a+b, a-b, a+zb, a-zb from
//    a = f[j], b = f[j+h] (the radix-2 copy level and the next level fused, one multiply);
//  * the final 1/n scale is fused into the last inverse group instead of a separate pass
//    (-5.5 ms at 2^25 on EPYC 7763).
// Odd log2(n/8) is qasm's run() path (radix-2 copy/top, fused radix-2 + scale asm).
//
// Contract: n = 2^lg, 9 <= lg <= 26; a, b hold n canonical values, 32-byte aligned, disjoint,
// with 16 readable padding words after each (qasm LdOdd); r/ir tables of table_words(lg)
// words each (qasm block layout, n/16 entries, rebuilt on every call). a receives the canonical
// cyclic convolution, b is destroyed. nza/nzb: the number of leading entries that may be
// nonzero; [nz, n) must read as zero, except that when nz <= n/2 the upper half [n/2, n) is
// never read and may hold anything. Ranges are qasm's (forward < 4P, inverse < 2P).
// Single-threaded; no allocation.
#pragma once
#include "../asm_explore/kernels/qasm.hpp"
#include <cstddef>

namespace qlarge {
using namespace qasm;

// Exploration 009 selected configuration (Library Checker submission kernel).
using Sel = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 23, 0, 2, 2, 104>;

struct Tables { U* r = nullptr; U* ir = nullptr; int size = 0; };
inline size_t table_words(int lg) { return (size_t(1) << lg) / 8 + 16; }

// Optional phase timestamps (bench "phases" mode); a null check otherwise.
using PhaseHook = void (*)(int phase);
inline PhaseHook phase_hook = nullptr;
inline void phase(int p) { if (phase_hook) phase_hook(p); }

// Zero-upper-half identity radix-4 group: c = d = 0, inputs a = f[j], b = f[j+h]
// canonical (< P). Outputs a+b, a-b+2P, a+zb, a-zb+2P (all < 4P), z = r[1].
QA_AI void top4_zero_body(V* f, long h, long j, const Fixed& z) {
    const V a = f[j], b = f[j + h];
    const V zb = z.mul<2, false, false, true>(b);
    f[j] = plus(a, b); f[j + h] = diff(a, b); f[j + 2 * h] = plus(a, zb); f[j + 3 * h] = diff(a, zb);
}

template<class C>
struct Core {
    using K = Kernel<C>;
    // Result so far carries nv*R^-1; scale by nv^-1*R (normal form, Shoup quotient).
    static Fixed scale_factor(int nv) {
        const U s_norm = mont(power(U(nv), P - 2)), s_mont = mont(s_norm);
        return Fixed(splat(s_norm), splat(s_mont * NI));
    }
    static QA_AI V scale1(const Fixed& s, V x) { return shrink(s.mul<2, false, false, true>(x), P); }
    // Identity inverse radix-4 group (k = 0) fused with the final scale; inputs < 2P,
    // outputs canonical. Same arithmetic as inv4<C, true> followed by scale1.
    static QA_AI void inv_identity_scale_body(V* f, long h, long j, const Fixed& z, const Fixed& scale) {
        const V p0 = f[j], p1 = f[j + h], p2 = f[j + 2 * h], p3 = f[j + 3 * h];
        const V ab = low(plus(p0, p1)), cd = low(plus(p2, p3)), amb = low(diff(p0, p1));
        const V cmd = z.mul<2, false, false, true>(diff(p2, p3));
        f[j] = scale1(scale, plus(ab, cd)); f[j + h] = scale1(scale, plus(amb, cmd));
        f[j + 2 * h] = scale1(scale, diff(ab, cd)); f[j + 3 * h] = scale1(scale, diff(amb, cmd));
    }

    static void run(int lg, U* aa, U* bb, Tables& T, long nza, long nzb) {
        const int n = 1 << lg, nv = n / 8;
        K::tables(n / 16, T.r, T.ir, T.size, true);
        K job(T.r, T.ir);
        V *a = (V*)aa, *b = (V*)bb;
        const Fixed scale = scale_factor(nv);
        phase(0);
        if (__builtin_ctz(unsigned(nv)) & 1) {   // qasm run(), odd branch (non-Flip Shoup config)
            const int h = nv / 2;
            auto top = [&](V* f, bool zero_upper) {
                if (zero_upper) { for (int i = 0; i < h; ++i) f[i + h] = f[i]; }
                else for (int i = 0; i < h; ++i) { V x = f[i], y = f[i + h]; f[i] = low(plus(x, y)); f[i + h] = low(diff(x, y)); }
            };
            top(a, nza <= n / 2); top(b, nzb <= n / 2);
            phase(1);
            job.visit(a, b, h, 0); job.visit(a + h, b + h, h, 1);
            phase(2);
            if constexpr (C::AsmScale != 0) {
                if (h % scale_step(C::AsmScale) == 0) {
                    alignas(32) U sc[16] = {};
                    sc[1] = U(_mm256_extract_epi32(scale.w, 0)); sc[9] = U(_mm256_extract_epi32(scale.wi, 0));
                    scale_asm(C::AsmScale, a, h, nullptr, sc);
                    phase(3);
                    return;
                }
            }
            for (int i = 0; i < h; ++i) {
                V x = a[i], y = a[i + h];
                a[i] = scale1(scale, plus(x, y)); a[i + h] = scale1(scale, diff(x, y));
            }
        } else {   // equivalent to job.visit(a, b, nv, 0) followed by a scale pass
            const int h = nv / 4;
            const bool za = nza <= n / 2, zb = nzb <= n / 2;
            if (za || zb) {
                const Fixed z = job.template fixed_at<false>(1);
                const Twiddle t0 = job.template twiddle<false>(0);
                if (za) { for (int j = 0; j < h; ++j) top4_zero_body(a, h, j, z); } else fwd4<C, true>(a, h, t0);
                if (zb) { for (int j = 0; j < h; ++j) top4_zero_body(b, h, j, z); } else fwd4<C, true>(b, h, t0);
            } else job.template group<false>(a, b, h, 0);
            phase(1);
            for (int t = 0; t < 4; ++t) job.visit(a + size_t(t) * h, b + size_t(t) * h, h, t);
            phase(2);
            const Fixed iz = job.template fixed_at<true>(1);
            for (int j = 0; j < h; ++j) inv_identity_scale_body(a, h, j, iz, scale);
        }
        phase(3);
    }
};
}  // namespace qlarge
