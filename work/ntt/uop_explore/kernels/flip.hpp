// Round-7 kernel family "flip": cyclic convolution modulo P=998244353, AVX2.
// Written for this exploration; structure follows the user's h14/mullo_bottom
// lineage (radix-4 recursion, 256-vector fixed tiles, fused h=1 bottom stage,
// direct degree-7 leaf products, O(N/16) root tables, fused top/scale stage).
//
// New ideas (each a template switch so they can be measured separately):
//  * Flip: a Montgomery product for 8 lanes ends with the high words of two 64-bit
//    product vectors e (lanes 0,2,4,6) and o (lanes 1,3,5,7). The usual repack is
//    shift+blend (2 uops). vshufps(e,o,0xDD) is 1 uop but yields lanes in order
//    sigma = (0 2 1 3) per 128-bit half. sigma is an involution, so a multiply maps
//    "natural" <-> "swapped" storage. In a Cooley-Tukey butterfly X+wY, X-wY the
//    product must match X, so Y must be stored with the opposite permutation of X.
//    Storing vector i with permutation parity(i) (parity of the index bits still to
//    be processed) satisfies that at every forward layer, and Gentleman-Sande
//    inverse layers recreate exactly that layout. Seeding costs one vpermd per
//    vector in the top forward stage; the final scale multiply undoes it with a
//    vshufps+vpermd pair (same uop count as the ordinary repack). Identity twiddle
//    groups use an explicit sigma shuffle instead of a multiply.
//  * Pair: twiddle table stores (w, w*NI mod 2^32) pairs, so a Fixed operand is
//    two broadcast loads instead of broadcast + multiply.
//  * LeafOdd: in the direct8 leaf the odd lanes of window load i equal the even
//    lanes of window load i-1, so 7 of 8 odd-lane shifts become plain loads.
//  * Mullo: Montgomery quotient for all 8 lanes via one vpmulld (previous
//    exploration's best); false uses two vpmuludq like h14.
//
// Contract: n power of two, 64 <= n <= 2^22. a,b canonical, 32-byte aligned,
// disjoint. a receives canonical result, b destroyed. r/ir hold >= n/8 uint32
// (pairs) or n/16 (plain); `size` records how many roots are valid (reuse).
// Ranges: forward values < 4P, inverse values < 2P, as in h14 (proofs unchanged:
// Montgomery accepts any x < 2^32 with w < P and returns < 2P).
#pragma once
#include <immintrin.h>
#include <cstdint>
#include <algorithm>
#include <cassert>
#include <type_traits>

namespace qflip {
using U = uint32_t; using W = uint64_t; using V = __m256i;
constexpr U P = 998244353, P2 = 2 * P, NI = 998244351, R2 = 932051910;  // NI = -P^-1 mod 2^32, R2 = 2^64 mod P
static_assert(W(4) * P < (W(1) << 32));
static_assert(U(P * NI) == U(-1));
#define QF_AI __attribute__((always_inline)) inline

constexpr U muls(U a, U b) { W x = W(a) * b; U c = U(x) * NI; U z = U((x + W(c) * P) >> 32); return z >= P ? z - P : z; }
constexpr U power(U a, U e) { U r = 1; for (; e; e >>= 1, a = U(W(a) * a % P)) if (e & 1) r = U(W(r) * a % P); return r; }
constexpr U mont(U a) { return muls(a, R2); }
constexpr U ONE = mont(1);

QF_AI V splat(U x) { return _mm256_set1_epi32(int(x)); }
QF_AI V plus(V x, V y) { return _mm256_add_epi32(x, y); }
QF_AI V minus(V x, V y) { return _mm256_sub_epi32(x, y); }
QF_AI V shrink(V x, U p) { return _mm256_min_epu32(x, minus(x, splat(p))); }
QF_AI V low(V x) { return shrink(x, P2); }
QF_AI V canonical(V x) { return shrink(low(x), P); }
QF_AI V diff(V x, V y) { return minus(plus(x, splat(P2)), y); }
QF_AI V odd(V x) { return _mm256_srli_epi64(x, 32); }
QF_AI V sigma(V x) { return _mm256_shuffle_epi32(x, 0xD8); }  // lanes 1<->2 in each half

// e,o: 64-bit sums whose high words are the results of lanes (0,2,4,6)/(1,3,5,7).
template<bool Flip> QF_AI V combine(V e, V o) {
    if constexpr (Flip) return _mm256_castps_si256(_mm256_shuffle_ps(_mm256_castsi256_ps(e), _mm256_castsi256_ps(o), 0xDD));
    else return _mm256_blend_epi32(odd(e), o, 0xAA);
}
// Montgomery REDC of two 64-bit accumulator vectors (sum < 2^64 - 2^32*P).
template<bool Flip> QF_AI V reduce(V e, V o) {
    const V m = splat(NI), p = splat(P);
    e = _mm256_add_epi64(e, _mm256_mul_epu32(_mm256_mul_epu32(e, m), p));
    o = _mm256_add_epi64(o, _mm256_mul_epu32(_mm256_mul_epu32(o, m), p));
    return combine<Flip>(e, o);
}

struct Fixed {
    V w, wi;  // w < P (Montgomery form) and w*NI mod 2^32, in every lane
    QF_AI Fixed() : w(), wi() {}
    QF_AI Fixed(V w_, V wi_) : w(w_), wi(wi_) {}
    QF_AI static Fixed scalar(U x) { return Fixed(splat(x), splat(x * NI)); }
    QF_AI static Fixed vec(V x) { return Fixed(x, _mm256_mullo_epi32(x, splat(NI))); }
    // x < 2^32 -> x*w/2^32 mod P, in [0,2P).
    template<bool Mullo, bool Flip> QF_AI V mul(V x) const {
        const V p = splat(P);
        V xo = odd(x), e, o;
        if constexpr (Mullo) {
            V q = _mm256_mullo_epi32(x, wi);
            e = _mm256_add_epi64(_mm256_mul_epu32(x, w), _mm256_mul_epu32(q, p));
            o = _mm256_add_epi64(_mm256_mul_epu32(xo, w), _mm256_mul_epu32(odd(q), p));
        } else {
            e = _mm256_add_epi64(_mm256_mul_epu32(x, w), _mm256_mul_epu32(_mm256_mul_epu32(x, wi), p));
            o = _mm256_add_epi64(_mm256_mul_epu32(xo, w), _mm256_mul_epu32(_mm256_mul_epu32(xo, wi), p));
        }
        return combine<Flip>(e, o);
    }
};

// q[j] = 3^((P-1)/2^(j+2)) (Montgomery form); r[k] = prod q[b] over set bits b of k.
struct Constants {
    U q[22]{}, iq[22]{}, even_step[21]{};
    alignas(32) U perm_idx[2][8]{};
    constexpr Constants() {
        q[21] = mont(power(3, (P - 1) >> 23)); iq[21] = mont(power(power(3, (P - 1) >> 23), P - 2));
        for (int j = 20; j >= 0; --j) { q[j] = muls(q[j + 1], q[j + 1]); iq[j] = muls(iq[j + 1], iq[j + 1]); }
        U c = ONE;
        for (int j = 0; j < 21; ++j) { even_step[j] = muls(q[j + 1], c); c = muls(c, iq[j + 1]); }
        for (int l = 0; l < 8; ++l) { perm_idx[0][l] = U(l); perm_idx[1][l] = U((l & 4) | ((l & 1) << 1) | ((l >> 1) & 1)); }
    }
};
inline constexpr Constants constants{};

template<bool Mullo_, bool Flip_, bool Pair_, bool LeafOdd_>
struct Cfg { static constexpr bool Mullo = Mullo_, Flip = Flip_, Pair = Pair_, LeafOdd = LeafOdd_; };

struct Twiddle { Fixed x, y, z; };

// Forward Cooley-Tukey radix-4 on f[j + t*h], t=0..3, j<h (inputs/outputs < 4P):
//   A=a+x*c, C=a-x*c, B=b+x*d, D=b-x*d; out = A+y*B, A-y*B, C+z*D, C-z*D.
// Flip layout: perms a:p b:~p c:~p d:p -> all outputs p.
template<class C, bool Identity>
QF_AI void fwd4(V* f, int h, const Twiddle& t) {
    constexpr bool M = C::Mullo, F = C::Flip;
    for (int j = 0; j < h; ++j) {
        V a = low(f[j]), b = low(f[j + h]), c = f[j + 2 * h], d = f[j + 3 * h];
        if constexpr (Identity) {
            c = low(c); d = low(d);
            if constexpr (F) { c = sigma(c); d = sigma(d); }
        } else { c = t.x.mul<M, F>(c); d = t.x.mul<M, F>(d); }
        V ac = low(plus(a, c)), amc = low(diff(a, c));
        V bd = plus(b, d), bmd = diff(b, d);
        if constexpr (Identity) { bd = low(bd); if constexpr (F) bd = sigma(bd); }
        else bd = t.y.mul<M, F>(bd);
        bmd = t.z.mul<M, F>(bmd);
        f[j] = plus(ac, bd); f[j + h] = diff(ac, bd); f[j + 2 * h] = plus(amc, bmd); f[j + 3 * h] = diff(amc, bmd);
    }
}
// Inverse Gentleman-Sande radix-4 (inputs/outputs < 2P).
// Flip layout: inputs all q -> outputs q,~q,~q,q.
template<class C, bool Identity>
QF_AI void inv4(V* f, int h, const Twiddle& t) {
    constexpr bool M = C::Mullo, F = C::Flip;
    for (int j = 0; j < h; ++j) {
        V a = f[j], b = f[j + h], c = f[j + 2 * h], d = f[j + 3 * h];
        V ab = low(plus(a, b)), cd = low(plus(c, d)), amb = diff(a, b), cmd = diff(c, d);
        if constexpr (Identity) { amb = low(amb); if constexpr (F) amb = sigma(amb); }
        else amb = t.y.mul<M, F>(amb);
        cmd = t.z.mul<M, F>(cmd);
        V o0 = low(plus(ab, cd)), o1 = low(plus(amb, cmd)), o2 = diff(ab, cd), o3 = diff(amb, cmd);
        if constexpr (Identity) {
            o2 = low(o2); o3 = low(o3);
            if constexpr (F) { o2 = sigma(o2); o3 = sigma(o3); }
        } else { o2 = t.x.mul<M, F>(o2); o3 = t.x.mul<M, F>(o3); }
        f[j] = o0; f[j + h] = o1; f[j + 2 * h] = o2; f[j + 3 * h] = o3;
    }
}

// Direct product of 4 leaves: a[t] = a[t]*b[t] mod (x^8 - w[t]) (times R^-1 scale
// handled by the final constant). Inputs < 4P, natural lane order; output < 2P with
// permutation sigma when Flip. Sum bound 8(P-1)^2 + (2^32-1)P < 2^64.
template<class C>
QF_AI void leaf4(V* a, V* b, const U* weights) {
    alignas(32) U window[4][16], coeff[4][8];
    V e[4], o[4];
    for (int t = 0; t < 4; ++t) {
        V x = canonical(a[t]);
        _mm256_store_si256((V*)window[t], shrink(Fixed::scalar(weights[t]).mul<C::Mullo, false>(x), P));
        _mm256_store_si256((V*)(window[t] + 8), x);
        _mm256_store_si256((V*)coeff[t], canonical(b[t]));
        e[t] = o[t] = _mm256_setzero_si256();
    }
    auto step = [&](int i, auto reuse) __attribute__((always_inline)) {
        for (int t = 0; t < 4; ++t) {
            V x = _mm256_loadu_si256((const V*)(window[t] + 8 - i)), y = splat(coeff[t][i]);
            V xo;
            // Even lanes of the load at offset 9-i are the odd lanes of x (i>0).
            if constexpr (decltype(reuse)::value) xo = _mm256_loadu_si256((const V*)(window[t] + 9 - i));
            else xo = odd(x);
            e[t] = _mm256_add_epi64(e[t], _mm256_mul_epu32(x, y));
            o[t] = _mm256_add_epi64(o[t], _mm256_mul_epu32(xo, y));
        }
    };
    if constexpr (C::LeafOdd) {
        step(0, std::false_type{});
#pragma GCC unroll 1
        for (int i = 1; i < 8; ++i) step(i, std::true_type{});
    } else {
#pragma GCC unroll 2
        for (int i = 0; i < 8; ++i) step(i, std::false_type{});
    }
    for (int t = 0; t < 4; ++t) a[t] = low(reduce<C::Flip>(e[t], o[t]));
}

template<class C>
struct Kernel {
    static constexpr int Tile = 256;
    const U *rt, *irt;
    U leaf_cursor = ONE;
    Kernel(const U* r, const U* ir) : rt(r), irt(ir) {}

    // Plain: r[k]. Pair: r[2k]=w_k, r[2k+1]=w_k*NI. Doubling from the valid prefix.
    static void tables(int count, U* r, U* ir, int& size, bool fresh) {
        if (fresh || size == 0) {
            if constexpr (C::Pair) { r[0] = ir[0] = ONE; r[1] = ir[1] = ONE * NI; }
            else r[0] = ir[0] = ONE;
            size = 1;
        }
        for (int h = size; h < count; h *= 2) {
            int s = __builtin_ctz(unsigned(h));
            for (int dir = 0; dir < 2; ++dir) {
                U* t = dir ? ir : r; U qs = dir ? constants.iq[s] : constants.q[s];
                if constexpr (C::Pair) {
                    if (h >= 4) {
                        const V w = splat(qs), wi = splat(qs * NI), p = splat(P), ni = splat(NI);
                        for (int j = 0; j < h; j += 4) {
                            V x = _mm256_load_si256((const V*)(t + 2 * j));   // [w0 wi0 w1 wi1 ...]
                            V m = _mm256_mul_epu32(x, wi);
                            V z = _mm256_srli_epi64(_mm256_add_epi64(_mm256_mul_epu32(x, w), _mm256_mul_epu32(m, p)), 32);
                            z = shrink(z, P);                                      // high words stay 0
                            V zi = _mm256_slli_epi64(_mm256_mul_epu32(z, ni), 32);
                            _mm256_store_si256((V*)(t + 2 * (h + j)), _mm256_or_si256(z, zi));
                        }
                    } else for (int j = 0; j < h; ++j) { U v = muls(t[2 * j], qs); t[2 * (h + j)] = v; t[2 * (h + j) + 1] = v * NI; }
                } else {
                    if (h >= 8) {
                        Fixed f = Fixed::scalar(qs);
                        for (int j = 0; j < h; j += 8)
                            _mm256_store_si256((V*)(t + h + j), shrink(f.mul<true, false>(_mm256_load_si256((const V*)(t + j))), P));
                    } else for (int j = 0; j < h; ++j) t[h + j] = muls(t[j], qs);
                }
            }
        }
        size = std::max(size, count);
    }
    template<bool Inv> QF_AI Fixed fixed_at(int k) const {
        const U* t = Inv ? irt : rt;
        if constexpr (C::Pair) return Fixed(splat(t[2 * k]), splat(t[2 * k + 1]));
        else return C::Mullo ? Fixed::vec(splat(t[k])) : Fixed::scalar(t[k]);
    }
    template<bool Inv> QF_AI Twiddle twiddle(int k) const { return Twiddle{fixed_at<Inv>(k), fixed_at<Inv>(2 * k), fixed_at<Inv>(2 * k + 1)}; }

    template<bool Inv, int H = 0>
    QF_AI void group(V* a, V* b, int h_, int k) {
        const int h = H ? H : h_;
        Twiddle t = twiddle<Inv>(k);
        if (k == 0) {
            if constexpr (Inv) inv4<C, true>(a, h, t); else { fwd4<C, true>(a, h, t); fwd4<C, true>(b, h, t); }
        } else {
            if constexpr (Inv) inv4<C, false>(a, h, t); else { fwd4<C, false>(a, h, t); fwd4<C, false>(b, h, t); }
        }
    }
    QF_AI void leaves(V* a, V* b, int nv, int first) {
        for (int j = 0; j < nv; j += 4) {
            int k = (first + j) / 4;
            group<false, 1>(a + j, b + j, 1, k);
            U w[4];
            w[0] = leaf_cursor; w[1] = P - w[0]; w[2] = muls(w[0], constants.q[0]); w[3] = P - w[2];
            leaf_cursor = muls(leaf_cursor, constants.even_step[__builtin_ctz(~unsigned(k))]);
            leaf4<C>(a + j, b + j, w);
            group<true, 1>(a + j, nullptr, 1, k);
        }
    }
    template<int NV, int H> QF_AI void tile_forward(V* a, V* b, int k) {
        if constexpr (H >= 4) {
#pragma GCC unroll 1
            for (int j = 0; j < NV; j += 4 * H) group<false, H>(a + j, b + j, H, k * (NV / (4 * H)) + j / (4 * H));
            tile_forward<NV, H / 4>(a, b, k);
        }
    }
    template<int NV, int H> QF_AI void tile_inverse(V* a, int k) {
        if constexpr (H < NV) {
#pragma GCC unroll 1
            for (int j = 0; j < NV; j += 4 * H) group<true, H>(a + j, nullptr, H, k * (NV / (4 * H)) + j / (4 * H));
            tile_inverse<NV, H * 4>(a, k);
        }
    }
    template<int NV> __attribute__((noinline)) void fixed_tile(V* a, V* b, int k) {
        tile_forward<NV, NV / 4>(a, b, k);
        leaves(a, b, NV, k * NV);
        tile_inverse<NV, 4>(a, k);
    }
    void visit(V* a, V* b, int nv, int k) {
        if (nv <= Tile) {
            switch (nv) {
                case 4: fixed_tile<4>(a, b, k); break;
                case 16: fixed_tile<16>(a, b, k); break;
                case 64: fixed_tile<64>(a, b, k); break;
                case 256: fixed_tile<256>(a, b, k); break;
                default: assert(false);
            }
        } else {
            int h = nv / 4;
            group<false>(a, b, h, k);
            for (int t = 0; t < 4; ++t) visit(a + t * h, b + t * h, h, 4 * k + t);
            group<true>(a, nullptr, h, k);
        }
    }
    // Permutation fixing vector i: sigma when parity(i) is odd (Flip layout only).
    static QF_AI V seed(V x, unsigned i) {
        if constexpr (C::Flip) return _mm256_permutevar8x32_epi32(x, _mm256_load_si256((const V*)constants.perm_idx[__builtin_parity(i)]));
        else return x;
    }
    static void run(int n, U* aa, U* bb, U* r, U* ir, int& size, bool fresh) {
        assert(n >= 64 && n <= (1 << 22) && (n & (n - 1)) == 0);
        tables(n / 16, r, ir, size, fresh);
        Kernel job(r, ir);
        V *a = (V*)aa, *b = (V*)bb;
        const int nv = n / 8;
        const Fixed scale = Fixed::scalar(mont(mont(power(U(nv), P - 2))));
        constexpr bool F = C::Flip;
        if (__builtin_ctz(unsigned(nv)) & 1) {
            const int h = nv / 2;
            for (int i = 0; i < h; ++i) {
                V x = a[i], y = a[i + h];
                a[i] = seed(low(plus(x, y)), i); a[i + h] = seed(low(diff(x, y)), i);
                x = b[i]; y = b[i + h];
                b[i] = seed(low(plus(x, y)), i); b[i + h] = seed(low(diff(x, y)), i);
            }
            job.visit(a, b, h, 0); job.visit(a + h, b + h, h, 1);
            // Values < 2P; sums/differences < 4P are valid multiply inputs.
            for (int i = 0; i < h; ++i) {
                V x = a[i], y = a[i + h];
                a[i] = seed(shrink(scale.mul<C::Mullo, F>(plus(x, y)), P), i);
                a[i + h] = seed(shrink(scale.mul<C::Mullo, F>(diff(x, y)), P), i);
            }
        } else {
            if constexpr (F) for (int i = 0; i < nv; ++i) { a[i] = seed(a[i], i); b[i] = seed(b[i], i); }
            job.visit(a, b, nv, 0);
            for (int i = 0; i < nv; ++i) a[i] = seed(shrink(scale.mul<C::Mullo, F>(a[i]), P), i);
        }
    }
};
}  // namespace qflip
