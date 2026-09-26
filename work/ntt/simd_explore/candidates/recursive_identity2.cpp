// Frozen from generator at native-tested commit 7722004b7925454eaa7d4c3272d2d3804dabb4f5.
#include "../common.hpp"
namespace recursive_identity2 {
//refractor butterfly function

using u32 = uint32_t;
using u64 = uint64_t;

typedef __m256i v8i;

// ============================================================================
// Constants
// ============================================================================
constexpr uint32_t MOD = 998244353;
constexpr uint32_t WMOD = 1996488706;
constexpr uint32_t R2_MOD = 932051910;
constexpr uint32_t M_INV = 998244351;
constexpr uint32_t PRIM_ROOT = 3;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_m = _mm256_set1_epi32(M_INV);
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);
const v8i v_one = _mm256_set1_epi32(1);
const v8i v_zero = _mm256_setzero_si256();

constexpr int maxn = 1 << 22; 
constexpr int maxn8 = maxn >> 3;

// ============================================================================
// Modular Arithmetic Helpers
// ============================================================================
[[gnu::always_inline]] inline uint32_t mont_mul(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint64_t m = (uint64_t)((uint32_t)t * M_INV) * MOD;
    uint32_t r = (t + m) >> 32;
    return r >= MOD ? r - MOD : r;
}

inline uint32_t to_mont(uint32_t x) { return mont_mul(x, R2_MOD); }
inline uint32_t from_mont(uint32_t x) { return mont_mul(x, 1); }

uint32_t pow_mod(uint32_t base, uint32_t exp) {
    uint32_t result = 1;
    while (exp > 0) {
        if (exp & 1) {
            result = (uint64_t)result * base % MOD;
        }
        base = (uint64_t)base * base % MOD;
        exp >>= 1;
    }
    return result;
}

uint32_t inv_mod(uint32_t x) { return pow_mod(x, MOD - 2); }

// ============================================================================
// Vector Modular Arithmetic
// ============================================================================
inline v8i lmove(v8i x) {
    return _mm256_bsrli_epi128(x, 4);
}

[[gnu::always_inline]]
inline v8i reduce(v8i x0246, v8i x1357) {
    v8i x0246_ninv = _mm256_mul_epu32(x0246, v_m);
    v8i x1357_ninv = _mm256_mul_epu32(x1357, v_m);
    v8i x0246_res = _mm256_add_epi64(x0246, _mm256_mul_epu32(x0246_ninv, v_mod));
    v8i x1357_res = _mm256_add_epi64(x1357, _mm256_mul_epu32(x1357_ninv, v_mod));
    v8i res = _mm256_or_si256(_mm256_bsrli_epi128(x0246_res, 4), x1357_res);
    return res;
}

[[gnu::always_inline]]
inline v8i _mm256_mont_mul(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b);
    v8i x0246_ninv = _mm256_mul_epu32(x0246, v_m);
    v8i x1357_ninv = _mm256_mul_epu32(x1357, v_m);
    v8i x0246_res = _mm256_add_epi64(x0246, _mm256_mul_epu32(x0246_ninv, v_mod));
    v8i x1357_res = _mm256_add_epi64(x1357, _mm256_mul_epu32(x1357_ninv, v_mod));
    v8i res = _mm256_or_si256(_mm256_bsrli_epi128(x0246_res, 4), x1357_res);
    return res;
}

[[gnu::always_inline]]
inline v8i _mm256_mont_mul_fixed(v8i a, v8i b, v8i bninv) {
    v8i cc = _mm256_mul_epu32(a, bninv);
    v8i c = _mm256_mul_epu32(a, b);
    v8i aa = lmove(a);
    v8i dd = _mm256_mul_epu32(aa, bninv);
    v8i d = _mm256_mul_epu32(aa, b);
    cc = _mm256_mul_epu32(cc, v_mod);
    dd = _mm256_mul_epu32(dd, v_mod);
    return _mm256_or_si256(lmove(_mm256_add_epi64(c, cc)), _mm256_add_epi64(d, dd));
}

[[gnu::always_inline]]
inline v8i _mm256_mont_mul_pointwise(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i b_sh = _mm256_bsrli_epi128(b, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b_sh);
    return reduce(x0246, x1357);
}

[[gnu::always_inline]]
inline v8i _mm256_mod(v8i a) {
    return _mm256_min_epu32(a, _mm256_sub_epi32(a, v_mod));
}

[[gnu::always_inline]]
inline v8i _mm256_add_mod(v8i a, v8i b) {
    v8i sum = _mm256_add_epi32(a, b);
    return _mm256_min_epu32(sum, _mm256_sub_epi32(sum, v_wmod));
}

[[gnu::always_inline]]
inline v8i _mm256_sub_mod(v8i a, v8i b) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i diff_m = _mm256_add_epi32(diff, v_wmod);
    return _mm256_min_epu32(diff, diff_m);
}

// ============================================================================
// Butterfly Operations - DIF (Decimation in Frequency)
// ============================================================================
[[gnu::always_inline]] 
inline void butterfly_dif_radix2(v8i* f0, v8i* f1, int len8, v8i v_w, v8i v_w_inv) {
    for (int p = 0; p < len8; ++p) {
        v8i v_q = f1[p];
        v8i v_u = f0[p];
        v8i v_v = _mm256_mont_mul_fixed(v_q, v_w, v_w_inv);
        f0[p] = _mm256_add_mod(v_u, v_v);
        f1[p] = _mm256_sub_mod(v_u, v_v);
    }
}

[[gnu::always_inline]] 
inline void butterfly_dif_radix4(v8i* f0, v8i* f1, v8i* f2, v8i* f3, int len8,
                                  v8i v_w0, v8i v_w1, v8i v_w2,
                                  v8i v_w0_inv, v8i v_w1_inv, v8i v_w2_inv) {
    for (int p = 0; p < len8; ++p) {
        v8i a3 = f3[p];
        v8i a2 = f2[p];
        v8i a1 = f1[p];
        v8i a0 = f0[p];

        v8i w0_a3 = _mm256_mont_mul_fixed(a3, v_w0, v_w0_inv);
        v8i w0_a2 = _mm256_mont_mul_fixed(a2, v_w0, v_w0_inv);
        
        v8i t1 = _mm256_add_mod(a1, w0_a3);
        v8i t3 = _mm256_sub_mod(a1, w0_a3);
        
        v8i t0 = _mm256_add_mod(a0, w0_a2);
        v8i t2 = _mm256_sub_mod(a0, w0_a2);

        v8i w1_t1 = _mm256_mont_mul_fixed(t1, v_w1, v_w1_inv);
        v8i w2_t3 = _mm256_mont_mul_fixed(t3, v_w2, v_w2_inv);

        f0[p] = _mm256_add_mod(t0, w1_t1);
        f2[p] = _mm256_add_mod(t2, w2_t3);
        f1[p] = _mm256_sub_mod(t0, w1_t1);
        f3[p] = _mm256_sub_mod(t2, w2_t3);
    }
}

[[gnu::always_inline]]
inline void butterfly_dif_size4(v8i* f, int n8, const uint32_t* rt) {
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_set1_epi32(rt[k]);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20);
    }
}

[[gnu::always_inline]]
inline void butterfly_dif_size2(v8i* f, int n8, const uint32_t* rt) {
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j << 1)))), perm_i2);
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v_mont = _mm256_mont_mul(v_v, v_rt);
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_mont), _mm256_sub_mod(v_u, v_v_mont));
    }
}

[[gnu::always_inline]]
inline void butterfly_dif_size1(v8i* f, int n8, const uint32_t* rt) {
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + (j << 2)))), perm_i1);
        v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        v8i v_nq = _mm256_sub_mod(v_u, v_v);
        v8i v_np = _mm256_add_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
}

// ============================================================================
// Butterfly Operations - DIT (Decimation in Time)
// ============================================================================
[[gnu::always_inline]]
inline void butterfly_dit_radix2(v8i* f0, v8i* f1, int len8, v8i v_w, v8i v_w_inv) {
    for (int p = 0; p < len8; ++p) {
        v8i v_u = f0[p];
        v8i v_v = f1[p];
        f0[p] = _mm256_add_mod(v_u, v_v);
        f1[p] = _mm256_mont_mul_fixed(_mm256_sub_mod(v_u, v_v), v_w, v_w_inv);
    }
}

[[gnu::always_inline]]
inline void butterfly_dit_radix4(v8i* f0, v8i* f1, v8i* f2, v8i* f3, int len8,
                                  v8i v_iw0, v8i v_iw1, v8i v_iw2,
                                  v8i v_iw0_inv, v8i v_iw1_inv, v8i v_iw2_inv) {
    for (int p = 0; p < len8; ++p) {
        v8i a0 = f0[p];
        v8i a1 = f1[p];
        v8i a2 = f2[p];
        v8i a3 = f3[p];
        
        v8i s1 = _mm256_sub_mod(a0, a1);
        v8i s2 = _mm256_sub_mod(a2, a3);
        
        v8i t0 = _mm256_add_mod(a0, a1);
        v8i t2 = _mm256_add_mod(a2, a3);

        v8i t1 = _mm256_mont_mul_fixed(s1, v_iw1, v_iw1_inv);
        v8i t3 = _mm256_mont_mul_fixed(s2, v_iw2, v_iw2_inv);

        v8i p1 = _mm256_sub_mod(t0, t2);
        v8i p2 = _mm256_sub_mod(t1, t3);

        v8i r0 = _mm256_add_mod(t0, t2);
        v8i r1 = _mm256_add_mod(t1, t3);
        
        f2[p] = _mm256_mont_mul_fixed(p1, v_iw0, v_iw0_inv);
        f3[p] = _mm256_mont_mul_fixed(p2, v_iw0, v_iw0_inv);

        f0[p] = r0;       
        f1[p] = r1;           
    }
}

[[gnu::always_inline]]
inline void butterfly_dit_size1(v8i* f, int n8, const uint32_t* irt) {
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + (j << 2)))), perm_i1);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_diff = _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt);
        v8i v_sum = _mm256_add_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_sum, _mm256_shuffle_epi32(v_diff, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
}

[[gnu::always_inline]]
inline void butterfly_dit_size2(v8i* f, int n8, const uint32_t* irt) {
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + (j << 1)))), perm_i2);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt));
    }
}

[[gnu::always_inline]]
inline void butterfly_dit_size4(v8i* f, int n8, const uint32_t* irt) {
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_set1_epi32(irt[k]);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt), 0x20);
    }
}

// ============================================================================
// Root Generation
// ============================================================================
void reset_roots(uint32_t* roots, uint32_t* inv_roots, int& root_size) {
    roots[0] = to_mont(1);
    inv_roots[0] = to_mont(1);
    root_size = 1;
}

void get_root_mont(uint32_t* roots, uint32_t* inv_roots, int& root_size, int n) {
    if (root_size < n) {
        int i = root_size;
        uint32_t* root_ptr = roots;
        uint32_t* inv_root_ptr = inv_roots;
        
        for (; i != n; i <<= 1) {
            uint32_t pm = pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2));
            uint32_t w = to_mont(pm);
            uint32_t iw = to_mont(inv_mod(pm));
            if (i >= 8) {
                v8i v_w = _mm256_set1_epi32(w);
                v8i v_iw = _mm256_set1_epi32(iw);
                v8i v_w_rt = _mm256_set1_epi32(w * M_INV);
                v8i v_iw_rt = _mm256_set1_epi32(iw * M_INV);
                for (int j = 0; j < i; j += 8) {
                    v8i v_root = _mm256_loadu_si256((v8i*)(root_ptr + j));
                    v8i v_inv_root = _mm256_loadu_si256((v8i*)(inv_root_ptr + j));
                    
                    v8i new_root = _mm256_mont_mul_fixed(v_root, v_w, v_w_rt);
                    v8i new_inv_root = _mm256_mont_mul_fixed(v_inv_root, v_iw, v_iw_rt);
                    
                    _mm256_storeu_si256((v8i*)(root_ptr + i + j), new_root);
                    _mm256_storeu_si256((v8i*)(inv_root_ptr + i + j), new_inv_root);
                }
            } 
            else {
                for (int j = 0; j < i; ++j) {
                    roots[i + j] = mont_mul(roots[j], w);
                    inv_roots[i + j] = mont_mul(inv_roots[j], iw);
                }
            }
        }            
        root_size = n;
    }
}

// ============================================================================
// DIF NTT (using butterfly functions)
// ============================================================================
inline v8i dif8(v8i v_f, int j, const uint32_t* rt) {
{
    
        
        v8i v_rt = _mm256_set1_epi32(rt[j]);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        v_f = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20);
    }
{
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    
        
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j << 1)))), perm_i2);
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v_mont = _mm256_mont_mul(v_v, v_rt);
        v_f = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_mont), _mm256_sub_mod(v_u, v_v_mont));
    }
{
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
        
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + (j << 2)))), perm_i1);
        v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        v8i v_nq = _mm256_sub_mod(v_u, v_v);
        v8i v_np = _mm256_add_mod(v_u, v_v);
        v_f = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
return v_f;
}
inline v8i dit8(v8i v_f, int j, const uint32_t* irt) {
{
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
        
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + (j << 2)))), perm_i1);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_diff = _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt);
        v8i v_sum = _mm256_add_mod(v_u, v_v);
        v_f = _mm256_blend_epi32(v_sum, _mm256_shuffle_epi32(v_diff, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
{
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    
        
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + (j << 1)))), perm_i2);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v_f = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt));
    }
{
    
        
        v8i v_irt = _mm256_set1_epi32(irt[j]);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v_f = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt), 0x20);
    }
return v_f;
}

[[gnu::always_inline]] inline void butterfly_dif_radix4_trivial(v8i* f0, v8i* f1, v8i* f2, v8i* f3, int len8,
                                  v8i v_w0, v8i v_w1, v8i v_w2,
                                  v8i v_w0_inv, v8i v_w1_inv, v8i v_w2_inv) {
    for (int p = 0; p < len8; ++p) {
        v8i a3 = f3[p];
        v8i a2 = f2[p];
        v8i a1 = f1[p];
        v8i a0 = f0[p];

        v8i w0_a3 = a3;
        v8i w0_a2 = a2;
        
        v8i t1 = _mm256_add_mod(a1, w0_a3);
        v8i t3 = _mm256_sub_mod(a1, w0_a3);
        
        v8i t0 = _mm256_add_mod(a0, w0_a2);
        v8i t2 = _mm256_sub_mod(a0, w0_a2);

        v8i w1_t1 = t1;
        v8i w2_t3 = _mm256_mont_mul_fixed(t3, v_w2, v_w2_inv);

        f0[p] = _mm256_add_mod(t0, w1_t1);
        f2[p] = _mm256_add_mod(t2, w2_t3);
        f1[p] = _mm256_sub_mod(t0, w1_t1);
        f3[p] = _mm256_sub_mod(t2, w2_t3);
    }
}
[[gnu::always_inline]] inline void butterfly_dit_radix4_trivial(v8i* f0, v8i* f1, v8i* f2, v8i* f3, int len8,
                                  v8i v_iw0, v8i v_iw1, v8i v_iw2,
                                  v8i v_iw0_inv, v8i v_iw1_inv, v8i v_iw2_inv) {
    for (int p = 0; p < len8; ++p) {
        v8i a0 = f0[p];
        v8i a1 = f1[p];
        v8i a2 = f2[p];
        v8i a3 = f3[p];
        
        v8i s1 = _mm256_sub_mod(a0, a1);
        v8i s2 = _mm256_sub_mod(a2, a3);
        
        v8i t0 = _mm256_add_mod(a0, a1);
        v8i t2 = _mm256_add_mod(a2, a3);

        v8i t1 = s1;
        v8i t3 = _mm256_mont_mul_fixed(s2, v_iw2, v_iw2_inv);

        v8i p1 = _mm256_sub_mod(t0, t2);
        v8i p2 = _mm256_sub_mod(t1, t3);

        v8i r0 = _mm256_add_mod(t0, t2);
        v8i r1 = _mm256_add_mod(t1, t3);
        
        f2[p] = p1;
        f3[p] = p2;

        f0[p] = r0;       
        f1[p] = r1;           
    }
}

void dif_ntt(v8i *f, const int &n, const uint32_t* rt) {    
    const int n8 = n >> 3; 
    
    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3; 
    int i; 
    
    if (num_stages & 1) {
        int h = n >> 1;
        int h8 = h >> 3;
        for (int j = 0, k = 0; j < n8; j += h8 << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
            const v8i v_rt_inv = _mm256_mul_epu32(v_rt, v_m);
            butterfly_dif_radix2(f + j, f + j + h8, h8, v_rt, v_rt_inv);
        }
        i = n >> 3;
    } else {
        i = n >> 2;
    }
    
    for (; i >= 8; i >>= 2) {
        int i8 = i >> 3; 
        int inc = i8 << 2;
        v8i* f0 = f;
        v8i* f1 = f + i8;
        v8i* f2 = f + i8 * 2;
        v8i* f3 = f + i8 * 3;
        for (int j = 0, k = 0; j < n8; j += i8 << 2, ++k) {
            auto x = rt[k];
            auto y = rt[(k << 1)];
            auto z = rt[(k << 1) + 1];
            v8i v_w0 = _mm256_set1_epi32(x);
            v8i v_w1 = _mm256_set1_epi32(y);
            v8i v_w2 = _mm256_set1_epi32(z);
            auto xinv = x * M_INV;
            auto yinv = y * M_INV;
            auto zinv = z * M_INV;
            v8i v_w0_inv = _mm256_set1_epi32(xinv);
            v8i v_w1_inv = _mm256_set1_epi32(yinv);
            v8i v_w2_inv = _mm256_set1_epi32(zinv);
            
            if(k==0) butterfly_dif_radix4_trivial(f0, f1, f2, f3, i8, v_w0, v_w1, v_w2, v_w0_inv, v_w1_inv, v_w2_inv); else butterfly_dif_radix4(f0, f1, f2, f3, i8, v_w0, v_w1, v_w2, v_w0_inv, v_w1_inv, v_w2_inv);
            
            f0 += inc;
            f1 += inc;
            f2 += inc;
            f3 += inc;
        }
    }
    

}

// ============================================================================
// DIT NTT (using butterfly functions)
// ============================================================================
void dit_ntt(v8i *f, const int &n, const uint32_t* irt) {
    const int n8 = n >> 3; 
    


    int log_n = 31 - __builtin_clz(n);
    int num_outer_stages = log_n - 3; 
    
    int i = 8;
    for (; i << 2 <= n; i <<= 2) {
        int i8 = i >> 3; 
        int inc = i8 << 2;
        v8i* f0 = f;
        v8i* f1 = f + i8;
        v8i* f2 = f + i8 * 2;
        v8i* f3 = f + i8 * 3;
        for (int j = 0, k = 0; j < n8; j += i8 << 2, ++k) {
            auto x = irt[k];
            auto y = irt[(k << 1)];
            auto z = irt[(k << 1) + 1];
            v8i v_iw0 = _mm256_set1_epi32(x);
            v8i v_iw1 = _mm256_set1_epi32(y);
            v8i v_iw2 = _mm256_set1_epi32(z);
            auto xinv = x * M_INV;
            auto yinv = y * M_INV;
            auto zinv = z * M_INV;
            v8i v_iw0_inv = _mm256_set1_epi32(xinv);
            v8i v_iw1_inv = _mm256_set1_epi32(yinv);
            v8i v_iw2_inv = _mm256_set1_epi32(zinv);
            
            if(k==0) butterfly_dit_radix4_trivial(f0, f1, f2, f3, i8, v_iw0, v_iw1, v_iw2, v_iw0_inv, v_iw1_inv, v_iw2_inv); else butterfly_dit_radix4(f0, f1, f2, f3, i8, v_iw0, v_iw1, v_iw2, v_iw0_inv, v_iw1_inv, v_iw2_inv);
            
            f0 += inc;
            f1 += inc;
            f2 += inc;
            f3 += inc;
        }
    }
    
    if ((num_outer_stages & 1) && i <= (n >> 1)) {
        int i8 = i >> 3;
        for (int j = 0, k = 0; j < n8; j += i8 << 1, ++k) {
            const v8i v_irt = _mm256_set1_epi32(irt[k]);
            const v8i v_irt_inv = _mm256_mul_epu32(v_irt, v_m);
            butterfly_dit_radix2(f + j, f + j + i8, i8, v_irt, v_irt_inv);
        }
    }
    
    uint32_t inv_n = to_mont(to_mont(inv_mod(n)));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    v8i v_inv_n_inv = _mm256_set1_epi32(inv_n * M_INV);
    for (int i = 0; i < n8; ++i) {
        f[i] = _mm256_mod(_mm256_mont_mul_fixed(f[i], v_inv_n, v_inv_n_inv));
    }
}

void run_simd_convolution(int L, v8i* A, v8i* B, uint32_t* roots, uint32_t* inv_roots, int& root_size) {
    int L8 = L >> 3;
    get_root_mont(roots, inv_roots, root_size, L / 2);
    dif_ntt(A, L, roots);
    dif_ntt(B, L, roots);

    for (int i = 0; i < L8; ++i) {
        A[i] = dit8(_mm256_mont_mul_pointwise(dif8(A[i], i, roots), dif8(B[i], i, roots)), i, inv_roots);
    }
    __asm__ __volatile__("" : : "r,m"(A[0]) : "memory");

    dit_ntt(A, L, inv_roots);
}

// ============================================================================
// KACTL NTT for correctness testing and benchmarking
// ============================================================================
// Inspired by the partial-transform strategy already present in study/fast_ntt_v2.cpp.
// After the large stages, leaf j represents a product modulo x^8 - rt[j]^2.
// Canonicalize before accumulating: eight products plus the Montgomery correction
// are <= 8*(P-1)^2 + (2^32-1)*P < 2^64 for P=998244353.
// The reduced sum is <3P; a subtraction of 2P restores the outer butterfly range.
template<int Batch>
inline void direct8(v8i* a, v8i* b, int first, const u32* roots) {
    alignas(32) u32 window[Batch][16];
    alignas(32) u32 coeff[Batch][8];
    v8i even[Batch], odd[Batch];
    for(int t=0;t<Batch;++t) {
        u32 w=mont_mul(roots[first+t],roots[first+t]);
        v8i x=_mm256_mod(a[t]);
        v8i wrapped=_mm256_mod(_mm256_mont_mul_fixed(x,_mm256_set1_epi32(w),_mm256_set1_epi32(w*M_INV)));
        _mm256_store_si256((v8i*)window[t],wrapped);
        _mm256_store_si256((v8i*)(window[t]+8),x);
        _mm256_store_si256((v8i*)coeff[t],_mm256_mod(b[t]));
        even[t]=odd[t]=_mm256_setzero_si256();
    }
    for(int i=0;i<8;++i) {
        for(int t=0;t<Batch;++t) {
            v8i x=_mm256_loadu_si256((const v8i*)(window[t]+8-i));
            v8i y=_mm256_set1_epi32(coeff[t][i]);
            even[t]=_mm256_add_epi64(even[t],_mm256_mul_epu32(x,y));
            odd[t]=_mm256_add_epi64(odd[t],_mm256_mul_epu32(lmove(x),y));
        }
    }
    for(int t=0;t<Batch;++t) {
        v8i x=reduce(even[t],odd[t]);
        a[t]=_mm256_min_epu32(x,_mm256_sub_epi32(x,v_wmod));
    }
}
// Cache-local paired traversal of the existing radix-4 butterflies.
// k is the global block number at this level, so the original root layout applies.
void visit(v8i* a, v8i* b, int nv, int k, const u32* rt, const u32* irt) {
    if (nv == 1) {
        direct8<1>(a,b,k,rt);
        return;
    }
    if (__builtin_ctz(nv) & 1) {
        // This branch only occurs at the root; subsequent levels are radix 4.
        int h=nv/2;
        v8i w=_mm256_set1_epi32(rt[k]), wi=_mm256_set1_epi32(rt[k]*M_INV);
        for(int p=0;p<h;++p) { v8i u=a[p],v=a[p+h]; a[p]=_mm256_add_mod(u,v); a[p+h]=_mm256_sub_mod(u,v); }
        for(int p=0;p<h;++p) { v8i u=b[p],v=b[p+h]; b[p]=_mm256_add_mod(u,v); b[p+h]=_mm256_sub_mod(u,v); }
        visit(a,b,h,2*k,rt,irt); visit(a+h,b+h,h,2*k+1,rt,irt);
        w=_mm256_set1_epi32(irt[k]); wi=_mm256_set1_epi32(irt[k]*M_INV);
        for(int p=0;p<h;++p) { v8i u=a[p],v=a[p+h]; a[p]=_mm256_add_mod(u,v); a[p+h]=_mm256_sub_mod(u,v); }
        return;
    }
    int h=nv/4;
    v8i x=_mm256_set1_epi32(rt[k]),y=_mm256_set1_epi32(rt[2*k]),z=_mm256_set1_epi32(rt[2*k+1]);
    v8i xi=_mm256_set1_epi32(rt[k]*M_INV),yi=_mm256_set1_epi32(rt[2*k]*M_INV),zi=_mm256_set1_epi32(rt[2*k+1]*M_INV);
    if(k==0) butterfly_dif_radix4_trivial(a,a+h,a+2*h,a+3*h,h,x,y,z,xi,yi,zi); else butterfly_dif_radix4(a,a+h,a+2*h,a+3*h,h,x,y,z,xi,yi,zi);
    if(k==0) butterfly_dif_radix4_trivial(b,b+h,b+2*h,b+3*h,h,x,y,z,xi,yi,zi); else butterfly_dif_radix4(b,b+h,b+2*h,b+3*h,h,x,y,z,xi,yi,zi);
    if(h==1) direct8<4>(a,b,4*k,rt); else for(int t=0;t<4;++t) visit(a+t*h,b+t*h,h,4*k+t,rt,irt);
    x=_mm256_set1_epi32(irt[k]); y=_mm256_set1_epi32(irt[2*k]); z=_mm256_set1_epi32(irt[2*k+1]);
    xi=_mm256_set1_epi32(irt[k]*M_INV); yi=_mm256_set1_epi32(irt[2*k]*M_INV); zi=_mm256_set1_epi32(irt[2*k+1]*M_INV);
    if(k==0) butterfly_dit_radix4_trivial(a,a+h,a+2*h,a+3*h,h,x,y,z,xi,yi,zi); else butterfly_dit_radix4(a,a+h,a+2*h,a+3*h,h,x,y,z,xi,yi,zi);
}
void run_recursive(int n,v8i*a,v8i*b,u32*rt,u32*irt,int&rs) {
    get_root_mont(rt,irt,rs,n/8);
    visit(a,b,n/8,0,rt,irt);
    u32 scale=to_mont(to_mont(inv_mod(n/8)));
    v8i w=_mm256_set1_epi32(scale),wi=_mm256_set1_epi32(scale*M_INV);
    for(int j=0;j<n/8;++j) a[j]=_mm256_mod(_mm256_mont_mul_fixed(a[j],w,wi));
}


void invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& rs, bool fresh) { if(fresh || rs==0) reset_roots(r,ir,rs); run_recursive(n,(v8i*)a,(v8i*)b,r,ir,rs); }
}
