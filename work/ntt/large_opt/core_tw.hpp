// Exploration 014 (N1): the exploration-010 driver qlarge::Core<C>::run with the twiddles of the
// bottom radix-4 level (h = 1, fused with the leaves in the exploration-009 asm bottom stage)
// generated incrementally instead of read from the root tables.
//
// Why: the bottom level reads table entries k (x), 2k and 2k+1 (y, z) for every group k < n/32,
// so the tables need n/16 entries each (2 x 16 MiB at n = 2^25: built, first-touched and streamed
// from DRAM on every call). All other levels (h >= 4) only read entries below n/64. Generating the
// bottom twiddles shrinks both tables 4x.
//
// Generator: with Q[b] the normal form of qasm::constants.q[b] (iq for the inverse table), entry
// k of the block table is r[k] = prod Q[b] over the set bits b of k (Kernel::tables builds exactly
// that by doubling). Bottom groups are visited in increasing k (depth-first recursion, tiles in
// order), so r[k+1] = r[k] * S[t] and r[2k+2] = r[2k] * S2[t] with t = ctz(~k),
// S[t] = Q[t] / prod_{b<t} Q[b], S2[t] = Q[t+1] / prod_{b<t} Q[b+1]; z = r[2k+1] = r[2k] * Q[0].
// Values are canonical normal-form residues and quotients floor(w * 2^32 / P) = mont(w) * NI, the
// same words the table holds, so results are bit-identical to Core<C>::run (checked by
// bench_ntt check). Scalar Shoup products only (~36 integer multiplies per group of 4 vectors,
// next to ~147 cycles of vector work). A seek re-initializes from the bits of k if a tile starts
// elsewhere (never happens in Core's traversal).
//
// Contract: as qlarge::Core<C>::run (n = 2^lg, 9 <= lg <= 26, see large_core.hpp) with C::AsmBottom
// != 0, except that the tables need only table_words_tw(lg) words each.
#pragma once
#include "../conv_large/large_core.hpp"

namespace qopt {
using namespace qasm;
using qlarge::Tables;

constexpr U RMODP = U((W(1) << 32) % P);
static_assert(U(R2 * NI) == U((W(RMODP) << 32) / P));
// Shoup product w * c mod P for canonical w, c with cq = floor(c * 2^32 / P); canonical result.
QA_AI U shoup1(U w, U c, U cq) {
    const U q = U((W(w) * cq) >> 32);
    const U r = w * c - q * P;   // true value in [0, 2P)
    return r >= P ? r - P : r;
}
QA_AI U quotient(U w) { return shoup1(w, RMODP, U(R2 * NI)) * NI; }   // mont(w) * NI = floor(w * 2^32 / P)
constexpr U pw(U a, U e) { U r = 1; for (; e; e >>= 1, a = U(W(a) * a % P)) if (e & 1) r = U(W(r) * a % P); return r; }

struct TwSteps {
    U Q[22]{}, S[21]{}, Sq[21]{}, S2[21]{}, S2q[21]{}, q0q = 0;
    constexpr explicit TwSteps(bool inv) {
        for (int b = 0; b < 22; ++b) Q[b] = muls(inv ? constants.iq[b] : constants.q[b], 1);
        for (int t = 0; t < 21; ++t) {
            U s = Q[t], s2 = t + 1 < 22 ? Q[t + 1] : 1;
            for (int b = 0; b < t; ++b) { s = U(W(s) * pw(Q[b], P - 2) % P); s2 = U(W(s2) * pw(Q[b + 1], P - 2) % P); }
            S[t] = s; S2[t] = s2;
            Sq[t] = U((W(s) << 32) / P); S2q[t] = U((W(s2) << 32) / P);
        }
        q0q = U((W(Q[0]) << 32) / P);
    }
};
inline constexpr TwSteps tw_fwd{false}, tw_inv{true};

struct TwGen {
    const TwSteps* st;
    U X = 1, Y = 1;   // r[k], r[2k]
    long k = -1;
    explicit TwGen(const TwSteps& s) : st(&s) {}
    void seek(long k0) {
        if (k0 == k) return;
        X = Y = 1;
        for (int b = 0; b < 21; ++b) if ((k0 >> b) & 1) { X = U(W(X) * st->Q[b] % P); Y = U(W(Y) * st->Q[b + 1] % P); }
        k = k0;
    }
    // Block-table layout read by the asm: px[0] = x, px[8] = x'; py[0] = y, py[1] = z, py[8] = y', py[9] = z'.
    QA_AI void emit_advance(U* px, U* py) {
        const U z = shoup1(Y, st->Q[0], st->q0q);
        px[0] = X; px[8] = quotient(X);
        py[0] = Y; py[1] = z; py[8] = quotient(Y); py[9] = quotient(z);
        const int t = __builtin_ctzl(~k);
        X = shoup1(X, st->S[t], st->Sq[t]); Y = shoup1(Y, st->S2[t], st->S2q[t]);
        ++k;
    }
};

inline size_t table_words_tw(int lg) { return (size_t(1) << lg) / 32 + 16; }   // n/64 entries in block layout

// Bottom-level driver with optional generated twiddles (TW) and per-group scalar inputs prepared
// AHEAD groups before the asm call that reads them (exploration 014). The asm bottom stage reads its
// leaf weights (lw) ~150-310 instructions and its twiddles ~10-110 instructions into a ~550-
// instruction block; computed right before the call (qasm Kernel::leaves, AHEAD = 0) their scalar
// latency (Montgomery products -> stores -> broadcast loads) can stall it. With AHEAD = 2 the inputs
// of group k are computed while the asm of group k - 2 runs, into a 4-slot ring.
// TW = false keeps the root-table pointers (the original kernel's table reads, n/16 entries).
template<class C, bool TW, int AHEAD>
struct KernelAh : Kernel<C> {
    static_assert(C::AsmBottom != 0, "replaces the asm bottom stage's driver loop");
    static_assert(AHEAD >= 0 && AHEAD <= 2);
    TwGen gf{tw_fwd}, gi{tw_inv};
    KernelAh(const U* r, const U* ir) : Kernel<C>(r, ir) {}

    QA_AI void leaves(V* a, V* b, int nv, int first) {
        constexpr int R = 4;
        LeafBuf64 L[2];
        alignas(64) U lw[R][8];
        alignas(64) U fx[R][16], fy[R][16], ix[R][16], iy[R][16];
        const int k0 = first / 4, klast = k0 + nv / 4 - 1;
        if constexpr (TW) { gf.seek(k0); gi.seek(k0); }
        int fk = k0, ik = k0;   // next group whose forward (lw, x, y, z) / inverse inputs are prepared
        auto prep_f = [&](int k) __attribute__((always_inline)) {
            this->leaf_weights(k, lw[k % R], lw[k % R] + 4);
            if constexpr (TW) gf.emit_advance(fx[k % R], fy[k % R]);
        };
        auto prep_i = [&](int k) __attribute__((always_inline)) { if constexpr (TW) gi.emit_advance(ix[k % R], iy[k % R]); };
        auto fpx = [&](int k) -> const U* { if constexpr (TW) return fx[k % R]; else return this->rt + Kernel<C>::blk(k); };
        auto fpy = [&](int k) -> const U* { if constexpr (TW) return fy[k % R]; else return this->rt + Kernel<C>::blk(2 * k); };
        auto ipx = [&](int k) -> const U* { if constexpr (TW) return ix[k % R]; else return this->irt + Kernel<C>::blk(k); };
        auto ipy = [&](int k) -> const U* { if constexpr (TW) return iy[k % R]; else return this->irt + Kernel<C>::blk(2 * k); };
        while (fk <= std::min(k0 + AHEAD, klast)) prep_f(fk++);
        bottom_s1(C::AsmBottom, a, b, &L[0], fpx(k0), fpy(k0), lw[k0 % R]);
        for (int j = 0; j < nv; j += 4) {
            const int cur = (j >> 2) & 1, kc = k0 + j / 4;
            while (fk <= std::min(kc + 1 + AHEAD, klast)) prep_f(fk++);
            while (ik <= std::min(kc + AHEAD, klast)) prep_i(ik++);
            if (j + 4 < nv) {
                const int kn = kc + 1;
                bottom_s12(C::AsmBottom, a + j + 4, b + j + 4, &L[cur ^ 1], fpx(kn), fpy(kn), lw[kn % R], a + j, &L[cur], ipx(kc), ipy(kc));
            } else {
                bottom_s2(C::AsmBottom, a + j, &L[cur], ipx(kc), ipy(kc));
            }
        }
    }
    template<int NV> __attribute__((noinline)) void fixed_tile(V* a, V* b, int k) {
        this->template tile_forward<NV, NV / 4>(a, b, k);
        leaves(a, b, NV, k * NV);
        this->template tile_inverse<NV, 4>(a, k);
    }
    void visit(V* a, V* b, int nv, int k) {
        if (nv <= C::Tile) {
            if (nv == 4) fixed_tile<4>(a, b, k);
            else if (nv == 16) fixed_tile<16>(a, b, k);
            else if (nv == 64) fixed_tile<64>(a, b, k);
            else if constexpr (C::Tile >= 256) {
                if (nv == 256) fixed_tile<256>(a, b, k);
                else if constexpr (C::Tile >= 1024) { if (nv == 1024) fixed_tile<1024>(a, b, k); }
            }
        } else {
            const int h = nv / 4;
            this->template group<false>(a, b, h, k);
            for (int t = 0; t < 4; ++t) visit(a + t * h, b + t * h, h, 4 * k + t);
            this->template group<true>(a, nullptr, h, k);
        }
    }
};
// Round-2 N1 entry (twiddles generated right before use): KernelAh<C, true, 0>.
template<class C> using KernelTw = KernelAh<C, true, 0>;

// qlarge::Core<C>::run with KernelAh (n/64-entry tables when TW); everything else identical.
template<class C, bool TW = true, int AHEAD = 0>
struct CoreAh {
    using K = KernelAh<C, TW, AHEAD>;
    using Base = qlarge::Core<C>;
    // a_top_done: the caller already ran a's zero-upper first radix-4 group (even log2(n/8), nza <= n/2;
    // see top_zero_unit()), e.g. interleaved with parsing b.
    static void run(int lg, U* aa, U* bb, Tables& T, long nza, long nzb, bool a_top_done = false) {
        const int n = 1 << lg, nv = n / 8;
        K::tables(TW ? n / 64 : n / 16, T.r, T.ir, T.size, true);
        K job(T.r, T.ir);
        V *a = (V*)aa, *b = (V*)bb;
        const Fixed scale = Base::scale_factor(nv);
        qlarge::phase(0);
        if (__builtin_ctz(unsigned(nv)) & 1) {
            const int h = nv / 2;
            auto top = [&](V* f, bool zero_upper) {
                if (zero_upper) { for (int i = 0; i < h; ++i) f[i + h] = f[i]; }
                else for (int i = 0; i < h; ++i) { V x = f[i], y = f[i + h]; f[i] = low(plus(x, y)); f[i + h] = low(diff(x, y)); }
            };
            top(a, nza <= n / 2); top(b, nzb <= n / 2);
            qlarge::phase(1);
            job.visit(a, b, h, 0); job.visit(a + h, b + h, h, 1);
            qlarge::phase(2);
            if constexpr (C::AsmScale != 0) {
                if (h % scale_step(C::AsmScale) == 0) {
                    alignas(32) U sc[16] = {};
                    sc[1] = U(_mm256_extract_epi32(scale.w, 0)); sc[9] = U(_mm256_extract_epi32(scale.wi, 0));
                    scale_asm(C::AsmScale, a, h, nullptr, sc);
                    qlarge::phase(3);
                    return;
                }
            }
            for (int i = 0; i < h; ++i) {
                V x = a[i], y = a[i + h];
                a[i] = Base::scale1(scale, plus(x, y)); a[i + h] = Base::scale1(scale, diff(x, y));
            }
        } else {
            const int h = nv / 4;
            const bool za = nza <= n / 2, zb = nzb <= n / 2;
            if (za || zb) {
                const Fixed z = job.template fixed_at<false>(1);
                const Twiddle t0 = job.template twiddle<false>(0);
                if (za) { if (!a_top_done) for (int j = 0; j < h; ++j) qlarge::top4_zero_body(a, h, j, z); } else fwd4<C, true>(a, h, t0);
                if (zb) { for (int j = 0; j < h; ++j) qlarge::top4_zero_body(b, h, j, z); } else fwd4<C, true>(b, h, t0);
            } else job.template group<false>(a, b, h, 0);
            qlarge::phase(1);
            for (int t = 0; t < 4; ++t) job.visit(a + size_t(t) * h, b + size_t(t) * h, h, t);
            qlarge::phase(2);
            const Fixed iz = job.template fixed_at<true>(1);
            for (int j = 0; j < h; ++j) Base::inv_identity_scale_body(a, h, j, iz, scale);
        }
        qlarge::phase(3);
    }
};
template<class C> using CoreTw = CoreAh<C, true, 0>;

// The zero-upper first group's twiddle z = r[1] without the tables: the normal form of
// qasm::constants.q[0] with Shoup quotient q[0] * NI (what Kernel::tables stores at blk(1), +8).
inline Fixed top_zero_twiddle() { return Fixed(splat(muls(constants.q[0], 1)), splat(constants.q[0] * NI)); }
// Applies when CoreAh::run would take the even branch with a zero upper half of a.
inline bool top_zero_applies(int lg, long nza) { return !(((lg - 3) & 1)) && nza <= (1L << lg) / 2; }
// Side job for the parser: one unit = one zero-upper first-group butterfly of a (n/32 units).
struct TopZeroSide {
    V* f; long h, j = 0; Fixed z;
    QA_AI void operator()() { if (j < h) { qlarge::top4_zero_body(f, h, j, z); ++j; } }
    void finish() { for (; j < h; ++j) qlarge::top4_zero_body(f, h, j, z); }
};
}  // namespace qopt
