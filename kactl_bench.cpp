//refractor butterfly function
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2")
#include <immintrin.h>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstring>
#include <iostream>
#include <vector>
#include <random>
#include <iomanip>
#include <algorithm>
#include <string>
#include <memory>

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
            
            butterfly_dif_radix4(f0, f1, f2, f3, i8, v_w0, v_w1, v_w2, v_w0_inv, v_w1_inv, v_w2_inv);
            
            f0 += inc;
            f1 += inc;
            f2 += inc;
            f3 += inc;
        }
    }
    
    butterfly_dif_size4(f, n8, rt);
    butterfly_dif_size2(f, n8, rt);
    butterfly_dif_size1(f, n8, rt);
}

// ============================================================================
// DIT NTT (using butterfly functions)
// ============================================================================
void dit_ntt(v8i *f, const int &n, const uint32_t* irt) {
    const int n8 = n >> 3; 
    
    butterfly_dit_size1(f, n8, irt);
    butterfly_dit_size2(f, n8, irt);
    butterfly_dit_size4(f, n8, irt);

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
            
            butterfly_dit_radix4(f0, f1, f2, f3, i8, v_iw0, v_iw1, v_iw2, v_iw0_inv, v_iw1_inv, v_iw2_inv);
            
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
    get_root_mont(roots, inv_roots, root_size, L);
    dif_ntt(A, L, roots);
    dif_ntt(B, L, roots);

    for (int i = 0; i < L8; ++i) {
        A[i] = _mm256_mont_mul_pointwise(A[i], B[i]);
    }
    __asm__ __volatile__("" : : "r,m"(A[0]) : "memory");

    dit_ntt(A, L, inv_roots);
}

// ============================================================================
// KACTL NTT for correctness testing and benchmarking
// ============================================================================
namespace KACTL {
    typedef long long ll;
    typedef std::vector<ll> vll;
    typedef std::vector<int> vi;
    
    const ll mod = 998244353;
    const ll root = 62; 
    
    ll modpow(ll base, ll exp, ll m = mod) {
        ll result = 1;
        base %= m;
        while (exp > 0) {
            if (exp & 1) result = (result * base) % m;
            base = (base * base) % m;
            exp >>= 1;
        }
        return result;
    }
    
    void ntt(vi &a) {
        int n = a.size(), L = 31 - __builtin_clz(n);
        static vi rt(2, 1);
        for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
            rt.resize(n);
            ll z = modpow(root, mod >> s);
            for (int i = k; i < 2*k; ++i) 
                rt[i] = (ll)rt[i/2] * ((i&1) ? z : 1) % mod;
        }
        vi rev(n);
        for (int i = 0; i < n; ++i) 
            rev[i] = (rev[i/2] | ((i&1) << L)) / 2;
        for (int i = 0; i < n; ++i) 
            if (i < rev[i]) std::swap(a[i], a[rev[i]]);
        for (int k = 1; k < n; k *= 2)
            for (int i = 0; i < n; i += 2*k) {
                for (int j = 0; j < k; ++j) {
                    ll z = (ll)rt[j+k] * a[i+j+k] % mod;
                    int &ai = a[i+j];
                    a[i+j+k] = ai - z + (z > ai ? mod : 0);
                    ai += (ai + z >= mod ? z - mod : z);
                }
            }
    }
    
    vi cyclic_conv(vi a, vi b, int L) {
        a.resize(L); b.resize(L);
        ntt(a); ntt(b);
        for (int i = 0; i < L; ++i)
            a[i] = (ll)a[i] * b[i] % mod;
        std::reverse(a.begin() + 1, a.end());
        ntt(a);
        ll inv = modpow(L, mod - 2);
        for (int i = 0; i < L; ++i)
            a[i] = (ll)a[i] * inv % mod;
        return a;
    }
}

// Helper to access v8i array as uint32_t
inline uint32_t get_elem(const v8i* arr, int idx) {
    alignas(32) uint32_t tmp[8];
    _mm256_store_si256((v8i*)tmp, arr[idx >> 3]);
    return tmp[idx & 7];
}

// ============================================================================
// Aligned Memory Allocation Helper
// ============================================================================
template<typename T>
T* aligned_alloc_array(size_t count, size_t alignment = 32) {
    void* ptr = std::aligned_alloc(alignment, count * sizeof(T));
    if (!ptr) {
        throw std::bad_alloc();
    }
    return static_cast<T*>(ptr);
}

struct AlignedArrayDeleter {
    void operator()(void* ptr) const {
        std::free(ptr);
    }
};

template<typename T>
using aligned_ptr = std::unique_ptr<T[], AlignedArrayDeleter>;

// ============================================================================
// Test Functions
// ============================================================================
void run_correctness_tests(v8i* A, v8i* B, uint32_t* roots, uint32_t* inv_roots, int& root_size) {
    std::cout << "Running Correctness Tests (KACTL NTT Reference)...\n";
    std::cout << "--------------------------------------------------------\n";
    
    std::mt19937 rng(12345);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    
    for (int k = 4; k <= 20; ++k) {
        int L = 1 << k;
        
        std::vector<uint32_t> poly_a(L), poly_b(L);
        for (int i = 0; i < L; ++i) {
            poly_a[i] = dist(rng); 
            poly_b[i] = dist(rng);
        }
        
        std::vector<int> a_int(poly_a.begin(), poly_a.end());
        std::vector<int> b_int(poly_b.begin(), poly_b.end());
        std::vector<int> expected = KACTL::cyclic_conv(a_int, b_int, L);
        
        std::memset(A, 0, maxn8 * sizeof(v8i));
        std::memset(B, 0, maxn8 * sizeof(v8i));
        std::memcpy(A, poly_a.data(), L * sizeof(uint32_t));
        std::memcpy(B, poly_b.data(), L * sizeof(uint32_t));
        
        reset_roots(roots, inv_roots, root_size);
        run_simd_convolution(L, A, B, roots, inv_roots, root_size);
        
        bool passed = true;
        for (int i = 0; i < L; ++i) {
            uint32_t got = get_elem(A, i);
            if (got != (uint32_t)expected[i]) {
                passed = false;
                std::cout << "FAIL at size 2^" << k << ", index " << i 
                          << ": expected " << expected[i] 
                          << ", got " << got << "\n";
                break;
            }
        }
        
        if (passed) {
            std::cout << "PASS: size 2^" << std::setw(2) << k << " (" << std::setw(7) << L << ")\n";
        } else {
            break; 
        }
    }
    std::cout << "--------------------------------------------------------\n\n";
}

void run_comparison_benchmark(v8i* A, v8i* B, v8i* A_bak, v8i* B_bak, 
                               uint32_t* roots, uint32_t* inv_roots, int& root_size) {
    std::cout << "============================================================\n";
    std::cout << "       SIMD NTT vs KACTL NTT Benchmark Comparison\n";
    std::cout << "============================================================\n\n";
    
    std::mt19937 rng(42);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);

    const int warmup_iterations = 5;
    const int benchmark_iterations = 5;

    std::cout << "Configuration:\n";
    std::cout << "  - Warmup iterations:    " << warmup_iterations << "\n";
    std::cout << "  - Benchmark iterations: " << benchmark_iterations << "\n\n";

    // Header
    std::cout << "+----------+----------------+----------------+----------+\n";
    std::cout << "|   Size   |   SIMD (us)    |   KACTL (us)   |  Speedup |\n";
    std::cout << "+----------+----------------+----------------+----------+\n";

    for (int k = 12; k <= 22; ++k) {
        int L = 1 << k;
        int L8 = L >> 3;

        // Generate random test data
        std::vector<uint32_t> poly_a(L), poly_b(L);
        for (int i = 0; i < L; ++i) {
            poly_a[i] = dist(rng);
            poly_b[i] = dist(rng);
        }

        // Prepare backup data for SIMD
        alignas(32) uint32_t tmp_a[8], tmp_b[8];
        for(int i = 0; i < L8; ++i) {
            for(int j = 0; j < 8; ++j) {
                tmp_a[j] = poly_a[i * 8 + j];
                tmp_b[j] = poly_b[i * 8 + j];
            }
            A_bak[i] = _mm256_load_si256((v8i*)tmp_a);
            B_bak[i] = _mm256_load_si256((v8i*)tmp_b);
        }

        // =====================================================
        // Benchmark SIMD NTT
        // =====================================================
        
        // Warmup SIMD
        for (int w = 0; w < warmup_iterations; ++w) {
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));
            reset_roots(roots, inv_roots, root_size);
            run_simd_convolution(L, A, B, roots, inv_roots, root_size);
        }

        // Benchmark SIMD
        long long simd_total_ns = 0;
        for (int iter = 0; iter < benchmark_iterations; ++iter) {
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));
            reset_roots(roots, inv_roots, root_size);

            auto start = std::chrono::high_resolution_clock::now();
            run_simd_convolution(L, A, B, roots, inv_roots, root_size);
            auto end = std::chrono::high_resolution_clock::now();
            
            simd_total_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
        }
        double simd_avg_us = (double)simd_total_ns / benchmark_iterations / 1000.0;

        // =====================================================
        // Benchmark KACTL NTT
        // =====================================================
        
        // Warmup KACTL
        for (int w = 0; w < warmup_iterations; ++w) {
            std::vector<int> a_copy(poly_a.begin(), poly_a.end());
            std::vector<int> b_copy(poly_b.begin(), poly_b.end());
            KACTL::cyclic_conv(a_copy, b_copy, L);
        }

        // Benchmark KACTL
        long long kactl_total_ns = 0;
        for (int iter = 0; iter < benchmark_iterations; ++iter) {
            std::vector<int> a_copy(poly_a.begin(), poly_a.end());
            std::vector<int> b_copy(poly_b.begin(), poly_b.end());

            auto start = std::chrono::high_resolution_clock::now();
            auto result = KACTL::cyclic_conv(a_copy, b_copy, L);
            // Prevent optimization
            __asm__ __volatile__("" : : "r,m"(result[0]) : "memory");
            auto end = std::chrono::high_resolution_clock::now();
            
            kactl_total_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
        }
        double kactl_avg_us = (double)kactl_total_ns / benchmark_iterations / 1000.0;

        // Calculate speedup
        double speedup = kactl_avg_us / simd_avg_us;

        // Print row
        std::cout << "| 2^" << std::setw(5) << std::left << k 
                  << " | " << std::setw(14) << std::right << std::fixed << std::setprecision(1) << simd_avg_us
                  << " | " << std::setw(14) << std::fixed << std::setprecision(1) << kactl_avg_us
                  << " | " << std::setw(7) << std::fixed << std::setprecision(2) << speedup << "x |\n";
    }

    std::cout << "+----------+----------------+----------------+----------+\n\n";

    // Summary statistics
    std::cout << "Notes:\n";
    std::cout << "  - Times are in microseconds (us)\n";
    std::cout << "  - Speedup = KACTL time / SIMD time\n";
    std::cout << "  - SIMD uses AVX2 with Montgomery multiplication\n";
    std::cout << "  - KACTL is the reference implementation from kactl.github.io\n";
    std::cout << "============================================================\n";
}

int main() {
    aligned_ptr<v8i> A(aligned_alloc_array<v8i>(maxn8));
    aligned_ptr<v8i> B(aligned_alloc_array<v8i>(maxn8));
    aligned_ptr<v8i> A_bak(aligned_alloc_array<v8i>(maxn8));
    aligned_ptr<v8i> B_bak(aligned_alloc_array<v8i>(maxn8));

    aligned_ptr<uint32_t> roots(aligned_alloc_array<uint32_t>(maxn));
    aligned_ptr<uint32_t> inv_roots(aligned_alloc_array<uint32_t>(maxn));
    int root_size = 0;

    reset_roots(roots.get(), inv_roots.get(), root_size);
    
    // First verify correctness
    run_correctness_tests(A.get(), B.get(), roots.get(), inv_roots.get(), root_size);
    
    // Then run comparison benchmark
    run_comparison_benchmark(A.get(), B.get(), A_bak.get(), B_bak.get(), 
                             roots.get(), inv_roots.get(), root_size);
    
    return 0;
}
/*
Running Correctness Tests (KACTL NTT Reference)...
--------------------------------------------------------
PASS: size 2^ 4 (     16)
PASS: size 2^ 5 (     32)
PASS: size 2^ 6 (     64)
PASS: size 2^ 7 (    128)
PASS: size 2^ 8 (    256)
PASS: size 2^ 9 (    512)
PASS: size 2^10 (   1024)
PASS: size 2^11 (   2048)
PASS: size 2^12 (   4096)
PASS: size 2^13 (   8192)
PASS: size 2^14 (  16384)
PASS: size 2^15 (  32768)
PASS: size 2^16 (  65536)
PASS: size 2^17 ( 131072)
PASS: size 2^18 ( 262144)
PASS: size 2^19 ( 524288)
PASS: size 2^20 (1048576)
--------------------------------------------------------

============================================================
       SIMD NTT vs KACTL NTT Benchmark Comparison
============================================================

Configuration:
  - Warmup iterations:    5
  - Benchmark iterations: 5

+----------+----------------+----------------+----------+
|   Size   |   SIMD (us)    |   KACTL (us)   |  Speedup |
+----------+----------------+----------------+----------+
| 2^12    |           26.9 |          129.5 |    4.81x |
| 2^13    |           55.6 |          281.7 |    5.06x |
| 2^14    |          110.4 |          637.5 |    5.77x |
| 2^15    |          227.4 |         1466.6 |    6.45x |
| 2^16    |          478.7 |         3183.8 |    6.65x |
| 2^17    |         1092.6 |         6770.8 |    6.20x |
| 2^18    |         2161.1 |        14189.7 |    6.57x |
| 2^19    |         4673.0 |        31940.9 |    6.84x |
| 2^20    |        10072.2 |        69126.7 |    6.86x |
| 2^21    |        20873.8 |       164404.8 |    7.88x |
| 2^22    |        45394.0 |       416031.5 |    9.16x |
+----------+----------------+----------------+----------+

Notes:
  - Times are in microseconds (us)
  - Speedup = KACTL time / SIMD time
  - SIMD uses AVX2 with Montgomery multiplication
  - KACTL is the reference implementation from kactl.github.io
============================================================
*/