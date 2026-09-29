// AVX2 building blocks for the matrix_product kernels (exploration 013, step 2).
//
// Representations (P = 998244353, H = (P-1)/2 = 499122176):
//  * canonical: u32 in [0, P).
//  * centered:  i32 in [-H, H]; |x*y| <= H^2 = 2.49122e17.
//  * "A side" operands carry a Montgomery factor R = 2^32 (a' = a*R mod P) so that the final
//    REDC of an accumulated dot product returns sum(a*b) mod P without another multiply.
//
// Signed accumulation (vpmuldq, 64-bit lanes): a fold keeps |x| <= 2^31*C32 + 2^32 < 6.4852e17;
// 32 centered products add at most 7.9719e18, total < 8.6205e18 < 2^63, so folding every 32
// products (or starting from zero) never overflows.
// Unsigned accumulation (vpmuludq): the "shrink" subtracts 2P*2^32 when the high word is
// >= 2P (min_epu32 trick); from high word < 2P, 8 canonical products keep it < 3.85P < 4P.
#pragma once
#include <immintrin.h>

#include <cstdint>

#include "common.hpp"

namespace mp::simd {
using V = __m256i;
#define MP_AI __attribute__((always_inline)) inline

constexpr u32 H = (P - 1) / 2;
constexpr u32 C32 = u32((u64(1) << 32) % P);  // 301989884 < 2^31
constexpr u32 NINV = 998244351;               // -P^-1 mod 2^32
static_assert(u32(P * NINV) == 0xffffffffu);
constexpr u32 R1 = C32;                        // 2^32 mod P (Montgomery factor)
constexpr u32 R1_SHOUP = u32((u64(R1) << 32) / P);

// ---- scalar conversions ----
// a * 2^32 mod P via Shoup multiplication by the constant R1 (q may be one short).
MP_AI u32 to_mont(u32 a) {
    const u32 q = u32((u64(a) * R1_SHOUP) >> 32);
    u32 r = a * R1 - q * P;  // in [0, 2P)
    return r >= P ? r - P : r;
}
MP_AI i32 center(u32 x) { return x > H ? i32(x) - i32(P) : i32(x); }

// ---- loads (all pure load-port ops on Zen 3 when the memory form is kept) ----
MP_AI V bcast(const void* p) { return _mm256_castps_si256(_mm256_broadcast_ss(static_cast<const float*>(p))); }
MP_AI V ldup(const void* p) { return _mm256_castps_si256(_mm256_moveldup_ps(_mm256_loadu_ps(static_cast<const float*>(p)))); }
MP_AI V hdup(const void* p) { return _mm256_castps_si256(_mm256_movehdup_ps(_mm256_loadu_ps(static_cast<const float*>(p)))); }
// Hide pointer identity so GCC keeps two memory-form dup loads instead of CSE-ing them into
// one load plus two register shuffles (FP1/FP2 ops).
template <class T> MP_AI T* opaque(T* p) { asm("" : "+r"(p)); return p; }

// ---- signed (centered) path ----
MP_AI V fold_s(V x) {  // x congruent, |result| < 6.4852e17
    const V hi = _mm256_srli_epi64(x, 32);
    const V lo = _mm256_blend_epi32(x, _mm256_setzero_si256(), 0xAA);
    return _mm256_add_epi64(_mm256_mul_epi32(hi, _mm256_set1_epi64x(C32)), lo);
}
// REDC of |x| < 2^62: returns y whose high words hold r = x * 2^-32 mod P, r in (-2^30, 2^30 + P).
MP_AI V redc_hi(V x) {
    const V q = _mm256_mul_epu32(x, _mm256_set1_epi64x(NINV));
    return _mm256_add_epi64(x, _mm256_mul_epu32(q, _mm256_set1_epi64x(P)));
}
// Pack the high words of e (columns 0,2,4,6) and o (1,3,5,7) into 8 lanes.
MP_AI V pack_hi(V e, V o) { return _mm256_blend_epi32(_mm256_srli_epi64(e, 32), o, 0xAA); }
// r in (-P, 2P) as i32/u32 -> canonical.
MP_AI V canon_from_redc(V r) {
    const V p = _mm256_set1_epi32(P);
    V v = _mm256_add_epi32(r, p);                  // (0, 3P) as u32
    v = _mm256_min_epu32(v, _mm256_sub_epi32(v, p));
    return _mm256_min_epu32(v, _mm256_sub_epi32(v, p));
}
// Final reduction of signed accumulators (|x| < 2^63) for 8 columns -> canonical u32 x8.
MP_AI V finish_s(V e, V o) { return canon_from_redc(pack_hi(redc_hi(fold_s(e)), redc_hi(fold_s(o)))); }

// ---- unsigned (canonical) path ----
MP_AI V shrink_u(V x) {  // high word < 4P -> < 2P
    const V bound = _mm256_set1_epi64x(i64(u64(2 * P) << 32));
    return _mm256_min_epu32(x, _mm256_sub_epi32(x, bound));
}
MP_AI V finish_u(V e, V o) {  // e, o < 4P*2^32
    e = shrink_u(e), o = shrink_u(o);  // < 2P*2^32; REDC result < 3P
    const V r = pack_hi(redc_hi(e), redc_hi(o));
    const V p = _mm256_set1_epi32(P);
    V v = _mm256_min_epu32(r, _mm256_sub_epi32(r, p));
    return _mm256_min_epu32(v, _mm256_sub_epi32(v, p));
}
}  // namespace mp::simd

namespace mp::simd {
// ---- vectorized conversions (8 lanes) ----
// canonical x -> x * 2^32 mod P (canonical), Shoup multiplication by the constant R1.
MP_AI V to_mont8(V x) {
    const V s = _mm256_set1_epi64x(R1_SHOUP);
    const V qe = _mm256_srli_epi64(_mm256_mul_epu32(x, s), 32);
    const V qo = _mm256_mul_epu32(_mm256_srli_epi64(x, 32), s);
    const V q = _mm256_blend_epi32(qe, qo, 0xAA);  // floor(x * R1_SHOUP / 2^32)
    const V p = _mm256_set1_epi32(int(P));
    const V r = _mm256_sub_epi32(_mm256_mullo_epi32(x, _mm256_set1_epi32(int(R1))), _mm256_mullo_epi32(q, p));  // [0, 2P)
    return _mm256_min_epu32(r, _mm256_sub_epi32(r, p));
}
// canonical -> centered [-H, H].
MP_AI V center8(V x) {
    const V gt = _mm256_cmpgt_epi32(x, _mm256_set1_epi32(int(H)));
    return _mm256_sub_epi32(x, _mm256_and_si256(gt, _mm256_set1_epi32(int(P))));
}
// 4 rows of 8 -> 32 values in [t][row] order (t = column index), stored at dst (unaligned).
MP_AI void transpose4x8_store(V r0, V r1, V r2, V r3, u32* dst) {
    const V a = _mm256_unpacklo_epi32(r0, r1), b = _mm256_unpacklo_epi32(r2, r3);  // t0,t1 | t4,t5
    const V c = _mm256_unpackhi_epi32(r0, r1), d = _mm256_unpackhi_epi32(r2, r3);  // t2,t3 | t6,t7
    const V t04 = _mm256_unpacklo_epi64(a, b), t15 = _mm256_unpackhi_epi64(a, b);
    const V t26 = _mm256_unpacklo_epi64(c, d), t37 = _mm256_unpackhi_epi64(c, d);
    _mm256_storeu_si256(reinterpret_cast<V*>(dst), _mm256_permute2x128_si256(t04, t15, 0x20));       // t0 t1
    _mm256_storeu_si256(reinterpret_cast<V*>(dst + 8), _mm256_permute2x128_si256(t26, t37, 0x20));   // t2 t3
    _mm256_storeu_si256(reinterpret_cast<V*>(dst + 16), _mm256_permute2x128_si256(t04, t15, 0x31));  // t4 t5
    _mm256_storeu_si256(reinterpret_cast<V*>(dst + 24), _mm256_permute2x128_si256(t26, t37, 0x31));  // t6 t7
}
}  // namespace mp::simd
