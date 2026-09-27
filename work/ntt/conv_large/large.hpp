// Exploration 010: large cyclic convolutions modulo 998244353 (Library Checker
// convolution_mod_large: N, M <= 2^24, transform length up to 2^25).
//
// Building block: the exploration-009 kernel work/ntt/asm_explore/kernels/qasm.hpp
// (branch claude/ntt-asm-explore 1e64289), used unchanged. Its transform splits
// x^n - 1 down to x^8 - w (w over the (n/8)-th roots of unity) and multiplies the
// degree-7 leaves directly, so the only roots needed have order n/8 <= 2^23: the
// arithmetic already supports n <= 2^26. What changes here is the traversal:
//
//  * run_b0: qasm's depth-first radix-4 recursion over the whole array (the design
//    of the current Library Checker leaders), with full-size root tables.
//  * run_top: a fused "top pass" does the first levels (optional radix-2, then L
//    radix-4 levels) in one sweep over memory, column panel by column panel: each
//    panel gathers R = rows rows x w vectors into an L1/L2 buffer, transforms, and
//    scatters back. Then every subtree (row) of S = nv/R vectors runs qasm's fused
//    recursion (forward a and b, leaf products, inverse) while it is cache resident.
//    A mirrored inverse top pass finishes and applies the 1/n scale.
//
// Contract (all drivers): n = 2^lg, 2^9 <= n <= 2^26; a, b hold n canonical values,
// 64-byte aligned, disjoint, with 16 readable padding words after each (qasm LdOdd).
// a receives the canonical cyclic convolution, b is destroyed. nza/nzb bound the
// number of leading entries that may be nonzero; [nz, n) must read as zero, except
// that when nz <= n/2 the upper half [n/2, n) is never read (the zero-upper shortcut)
// and may hold anything (run_b0 without zero_even reads it at even log2(n/8)).
// Ranges and Shoup/Montgomery conventions are qasm's: forward values < 4P, inverse
// values < 2P. Single-threaded; tables and panel buffers are caller-owned.
#pragma once
#include "../asm_explore/kernels/qasm.hpp"
#include <cstddef>
#include <cstring>

namespace qlarge {
using namespace qasm;

// Exploration 009 selected configuration (Library Checker submission kernel).
using Sel = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 23, 0, 2, 2, 104>;

// Root tables in qasm's block layout: n/16 entries -> n/8 words each (+16 padding).
struct Tables {
    U* r = nullptr; U* ir = nullptr; int size = 0;
};
inline size_t table_words(int lg) { return (size_t(1) << lg) / 8 + 16; }

// Optional phase timers (bench "phases" mode); off unless a callback is set.
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
struct Drivers {
    using K = Kernel<C>;
    static Fixed scale_factor(int nv) {
        // Result so far carries nv*R^-1; scale by nv^-1*R (normal form, Shoup quotient).
        const U s_norm = mont(power(U(nv), P - 2)), s_mont = mont(s_norm);
        return Fixed(splat(s_norm), splat(s_mont * NI));
    }
    static QA_AI V scale1(const Fixed& s, V x) { return shrink(s.mul<2, false, false, true>(x), P); }

    // qasm run() generalized to n <= 2^26 (assert removed, 64-bit-safe loops) plus an
    // optional zero-upper radix-4 top for even log2(nv).
    static void run_b0(int lg, U* aa, U* bb, Tables& T, long nza, long nzb, bool zero_even) {
        const int n = 1 << lg, nv = n / 8;
        K::tables(n / 16, T.r, T.ir, T.size, true);
        K job(T.r, T.ir);
        V *a = (V*)aa, *b = (V*)bb;
        const Fixed scale = scale_factor(nv);
        phase(0);
        if (__builtin_ctz(unsigned(nv)) & 1) {
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
        } else {
            const bool za = nza <= n / 2, zb = nzb <= n / 2;
            if (zero_even && (za || zb)) {
                const int h = nv / 4;
                const Fixed z = job.template fixed_at<false>(1);
                const Twiddle t0 = job.template twiddle<false>(0);
                if (za) { for (int j = 0; j < h; ++j) top4_zero_body(a, h, j, z); } else fwd4<C, true>(a, h, t0);
                if (zb) { for (int j = 0; j < h; ++j) top4_zero_body(b, h, j, z); } else fwd4<C, true>(b, h, t0);
                phase(1);
                job.visit_rest(a, b, nv, 0);
            } else {
                phase(1);
                job.visit(a, b, nv, 0);
            }
            phase(2);
            for (int i = 0; i < nv; ++i) a[i] = scale1(scale, a[i]);
        }
        phase(3);
    }

    // Top-pass geometry: optional radix-2 level (odd log2 nv), then L radix-4 levels.
    struct Geo {
        int nv, odd, L, R, R0, S;   // R rows of S vectors; R0 = R / (1 + odd)
        Geo(int nv_, int L_) : nv(nv_), odd(__builtin_ctz(unsigned(nv_)) & 1), L(L_) {
            R = (1 << odd) << (2 * L); R0 = R >> odd; S = nv / R;
        }
    };
    struct TopOpt {
        int w = 2;            // panel width in vectors (w * 32 bytes per row segment)
        int dist = 4;         // software prefetch distance in panels (0 = none)
        bool nt = false;      // non-temporal stores when scattering
    };

    static QA_AI void store_v(V* p, V x, bool nt) { if (nt) _mm256_stream_si256(p, x); else _mm256_store_si256(p, x); }

    // Forward top pass on a and b together. buf holds 2 * R * w vectors.
    static void top_forward(K& job, V* a, V* b, const Geo& g, const TopOpt& o, bool za, bool zb, V* buf) {
        const int R = g.R, S = g.S, w = o.w;
        V* pa = buf; V* pb = buf + size_t(R) * w;
        const Fixed z = job.template fixed_at<false>(1);
        for (int c0 = 0; c0 < S; c0 += w) {
            if (o.dist) {
                const int cp = c0 + o.dist * w;
                if (cp < S) {
                    const int ra = za ? R / 2 : R, rb = zb ? R / 2 : R;
                    for (int s = 0; s < ra; ++s) for (int i = 0; i < w; i += 2) _mm_prefetch((const char*)(a + size_t(s) * S + cp + i), _MM_HINT_T0);
                    for (int s = 0; s < rb; ++s) for (int i = 0; i < w; i += 2) _mm_prefetch((const char*)(b + size_t(s) * S + cp + i), _MM_HINT_T0);
                }
            }
            auto gather = [&](V* p, const V* f, int rows) __attribute__((always_inline)) {
                for (int s = 0; s < rows; ++s) for (int i = 0; i < w; ++i) p[s * w + i] = _mm256_load_si256(f + size_t(s) * S + c0 + i);
            };
            gather(pa, a, za ? R / 2 : R); gather(pb, b, zb ? R / 2 : R);
            // First level: radix-2 (odd) or radix-4 identity group.
            int d0 = 0;
            if (g.odd) {
                const int h = (R / 2) * w;
                auto r2 = [&](V* p, bool zero) __attribute__((always_inline)) {
                    if (zero) for (int j = 0; j < h; ++j) p[j + h] = p[j];
                    else for (int j = 0; j < h; ++j) { V x = p[j], y = p[j + h]; p[j] = low(plus(x, y)); p[j + h] = low(diff(x, y)); }
                };
                r2(pa, za); r2(pb, zb);
            } else {
                const int h = (R / 4) * w;
                if (za && zb) {
                    for (int j = 0; j < h; ++j) top4_zero_body(pa, h, j, z);
                    for (int j = 0; j < h; ++j) top4_zero_body(pb, h, j, z);
                } else {
                    if (za) for (int j = 0; j < h; ++j) top4_zero_body(pa, h, j, z);
                    if (zb) for (int j = 0; j < h; ++j) top4_zero_body(pb, h, j, z);
                    if (!za && !zb) job.template group<false>(pa, pb, h, 0);
                    else if (!za) fwd4<C, true>(pa, h, job.template twiddle<false>(0));
                    else if (!zb) fwd4<C, true>(pb, h, job.template twiddle<false>(0));
                }
                d0 = 1;
            }
            // Remaining radix-4 levels: depth d, block k in [0, B0*4^d).
            for (int d = d0; d < g.L; ++d) {
                const int blocks = (1 << g.odd) << (2 * d), rows = R / blocks, h = (rows / 4) * w;
                for (int k = 0; k < blocks; ++k) job.template group<false>(pa + size_t(k) * rows * w, pb + size_t(k) * rows * w, h, k);
            }
            for (int s = 0; s < R; ++s) for (int i = 0; i < w; ++i) {
                store_v(a + size_t(s) * S + c0 + i, pa[s * w + i], o.nt);
                store_v(b + size_t(s) * S + c0 + i, pb[s * w + i], o.nt);
            }
        }
        if (o.nt) _mm_sfence();
    }
    // Inverse top pass on a, including the final scale. buf holds R * w vectors.
    static void top_inverse(K& job, V* a, const Geo& g, const TopOpt& o, const Fixed& scale, V* buf) {
        const int R = g.R, S = g.S, w = o.w;
        for (int c0 = 0; c0 < S; c0 += w) {
            if (o.dist) {
                const int cp = c0 + o.dist * w;
                if (cp < S) for (int s = 0; s < R; ++s) for (int i = 0; i < w; i += 2) _mm_prefetch((const char*)(a + size_t(s) * S + cp + i), _MM_HINT_T0);
            }
            for (int s = 0; s < R; ++s) for (int i = 0; i < w; ++i) buf[s * w + i] = _mm256_load_si256(a + size_t(s) * S + c0 + i);
            const int dl = g.odd ? 0 : 1;
            for (int d = g.L - 1; d >= dl; --d) {
                const int blocks = (1 << g.odd) << (2 * d), rows = R / blocks, h = (rows / 4) * w;
                for (int k = 0; k < blocks; ++k) job.template group<true>(buf + size_t(k) * rows * w, nullptr, h, k);
            }
            if (g.odd) {
                const int h = (R / 2) * w;
                for (int j = 0; j < h; ++j) {
                    V x = buf[j], y = buf[j + h];
                    buf[j] = scale1(scale, plus(x, y)); buf[j + h] = scale1(scale, diff(x, y));
                }
            } else {
                // Identity inverse group at depth 0 fused with the scale.
                const int h = (R / 4) * w;
                const Twiddle t = job.template twiddle<true>(0);
                for (int j = 0; j < h; ++j) {
                    V p0 = buf[j], p1 = buf[j + h], p2 = buf[j + 2 * h], p3 = buf[j + 3 * h];
                    V ab = low(plus(p0, p1)), cd = low(plus(p2, p3)), amb = low(diff(p0, p1)), cmd = t.z.mul<2, false, false, true>(diff(p2, p3));
                    buf[j] = scale1(scale, plus(ab, cd)); buf[j + h] = scale1(scale, plus(amb, cmd));
                    buf[j + 2 * h] = scale1(scale, diff(ab, cd)); buf[j + 3 * h] = scale1(scale, diff(amb, cmd));
                }
            }
            for (int s = 0; s < R; ++s) for (int i = 0; i < w; ++i) store_v(a + size_t(s) * S + c0 + i, buf[s * w + i], o.nt);
        }
        if (o.nt) _mm_sfence();
    }

    // Top pass (L radix-4 levels, plus radix-2 if log2(nv) is odd), then qasm's fused
    // recursion per row, then the inverse top pass with scaling.
    static void run_top(int lg, U* aa, U* bb, Tables& T, long nza, long nzb, int L, const TopOpt& o, V* buf) {
        const int n = 1 << lg, nv = n / 8;
        K::tables(n / 16, T.r, T.ir, T.size, true);
        K job(T.r, T.ir);
        V *a = (V*)aa, *b = (V*)bb;
        const Geo g(nv, L);
        const Fixed scale = scale_factor(nv);
        phase(0);
        top_forward(job, a, b, g, o, nza <= n / 2, nzb <= n / 2, buf);
        phase(1);
        for (int K2 = 0; K2 < g.R; ++K2) job.visit(a + size_t(K2) * g.S, b + size_t(K2) * g.S, g.S, K2);
        phase(2);
        top_inverse(job, a, g, o, scale, buf);
        phase(3);
    }
};
}  // namespace qlarge
