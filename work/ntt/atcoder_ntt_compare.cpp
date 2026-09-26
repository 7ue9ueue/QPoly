// Paste this entire file into an AtCoder C++17-or-later Custom Test.
// Empty input runs through 2^20 with five repetitions, fresh roots.
// Optional input: 20 9 2  (max log2, repetitions, mode: 0 fresh / 1 reuse / 2 both).
// Requires x86-64 AVX2/BMI. No external files. Heap-owned aligned storage.
// Independently written candidate kernels; no fast-reference source embedded.
// Baseline source: cp/ntt_ver0.91.cpp, historical commit 31ba0a6 (profiling removed).
// Previous candidate: exploration 002, native-tested commit 7722004.
#include <immintrin.h>
#include <algorithm>
#include <array>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <memory>
#include <numeric>
#include <random>
#include <string>
#include <vector>
using Fn = void(*)(int,uint32_t*,uint32_t*,uint32_t*,uint32_t*,int&,bool);
struct Entry { const char* name; Fn fn; };

#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi")
#endif
namespace v91 {

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

const v8i v_mod = {int64_t(uint64_t(MOD)*0x100000001ULL), int64_t(uint64_t(MOD)*0x100000001ULL), int64_t(uint64_t(MOD)*0x100000001ULL), int64_t(uint64_t(MOD)*0x100000001ULL)};
const v8i v_wmod = {int64_t(uint64_t(WMOD)*0x100000001ULL), int64_t(uint64_t(WMOD)*0x100000001ULL), int64_t(uint64_t(WMOD)*0x100000001ULL), int64_t(uint64_t(WMOD)*0x100000001ULL)};
const v8i v_m = {int64_t(uint64_t(M_INV)*0x100000001ULL), int64_t(uint64_t(M_INV)*0x100000001ULL), int64_t(uint64_t(M_INV)*0x100000001ULL), int64_t(uint64_t(M_INV)*0x100000001ULL)};
const v8i v_r2 = {int64_t(uint64_t(R2_MOD)*0x100000001ULL), int64_t(uint64_t(R2_MOD)*0x100000001ULL), int64_t(uint64_t(R2_MOD)*0x100000001ULL), int64_t(uint64_t(R2_MOD)*0x100000001ULL)};
const v8i v_one = {int64_t(uint64_t(1)*0x100000001ULL), int64_t(uint64_t(1)*0x100000001ULL), int64_t(uint64_t(1)*0x100000001ULL), int64_t(uint64_t(1)*0x100000001ULL)};
const v8i v_zero = {0,0,0,0};

constexpr int maxn = 1 << 22; 
constexpr int maxn8 = maxn >> 3;

// ============================================================================
// Timing Infrastructure
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

// Vector helpers
inline v8i reduce(v8i x0246, v8i x1357) {
    v8i x0246_ninv = _mm256_mul_epu32(x0246, v_m);
    v8i x1357_ninv = _mm256_mul_epu32(x1357, v_m);
    v8i x0246_res = _mm256_add_epi64(x0246, _mm256_mul_epu32(x0246_ninv, v_mod));
    v8i x1357_res = _mm256_add_epi64(x1357, _mm256_mul_epu32(x1357_ninv, v_mod));
    v8i res = _mm256_or_si256(_mm256_bsrli_epi128(x0246_res, 4), x1357_res);
    return res;
}

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

inline v8i lmove(v8i x) {
    return _mm256_bsrli_epi128(x, 4);
}

// bninv = b * v_m
inline v8i _mm256_mont_mul_fixed(v8i a, v8i b, v8i bninv) {
    v8i aa = lmove(a);
    v8i cc = _mm256_mul_epu32(a, bninv);
    v8i dd = _mm256_mul_epu32(aa, bninv);
    v8i c = _mm256_mul_epu32(a, b);
    v8i d = _mm256_mul_epu32(aa, b);
    cc = _mm256_mul_epu32(cc, v_mod);
    dd = _mm256_mul_epu32(dd, v_mod);
    return _mm256_or_si256(lmove(_mm256_add_epi64(c, cc)), _mm256_add_epi64(d, dd));
}

inline v8i _mm256_mont_mul_pointwise(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i b_sh = _mm256_bsrli_epi128(b, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b_sh);
    return reduce(x0246, x1357);
}

inline v8i _mm256_mulhi_epi32(v8i a, v8i b) {
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i even = _mm256_mul_epu32(a, b);
    v8i odd = _mm256_mul_epu32(a_odd, b_odd);
    v8i even_high = _mm256_srli_epi64(even, 32);
    return _mm256_blend_epi32(even_high, odd, 0xAA);
}

// Shoup's SIMD multiplication: a * b mod p using precomputed bp
inline v8i _mm256_shoup_mul(v8i a, v8i b, v8i bp) {
    v8i t = _mm256_mulhi_epi32(a, bp);
    v8i p = _mm256_mullo_epi32(a, b);
    v8i q = _mm256_mullo_epi32(t, v_mod);
    return _mm256_sub_epi32(p, q);
}

inline v8i _mm256_mod(v8i a) {
    return _mm256_min_epu32(a, _mm256_sub_epi32(a, v_mod));
}

inline v8i _mm256_add_mod(v8i a, v8i b) {
    v8i sum = _mm256_add_epi32(a, b);
    return _mm256_min_epu32(sum, _mm256_sub_epi32(sum, v_wmod));
}

inline v8i _mm256_sub_mod(v8i a, v8i b) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i diff_m = _mm256_add_epi32(diff, v_wmod);
   return _mm256_min_epu32(diff, diff_m);
}

// ============================================================================
// Root Generation (Refactored to take pointers)
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
                v8i v_w_rt = _mm256_set1_epi32(w * M_INV);
                v8i v_iw = _mm256_set1_epi32(iw);
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
    }

}

// ============================================================================
// DIF NTT (Modified to accept roots pointer)
// ============================================================================
void dif_ntt(v8i *f, const int &n, const uint32_t* rt) {    
    const int n8 = n >> 3; 
    
    // --- Start Nested Loop Timing ---

    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3; 
    int i; 
    
    if (num_stages & 1) {
        int h = n >> 1;
        int h8 = h >> 3;
        for (int j = 0, k = 0; j < n8; j += h8 << 1, ++k) {
            const v8i v_rt = {int64_t(uint64_t(rt[k])*0x100000001ULL), int64_t(uint64_t(rt[k])*0x100000001ULL), int64_t(uint64_t(rt[k])*0x100000001ULL), int64_t(uint64_t(rt[k])*0x100000001ULL)};
            v8i* f0 = f + j;
            v8i* f1 = f + j + h8;
            v8i v_rt_inv = _mm256_mul_epu32(v_rt, v_m);
            for (int p = 0; p < h8; ++p) {
                v8i v_q = f1[p];
                v8i v_u = f0[p];
                v8i v_v = _mm256_mont_mul_fixed(v_q, v_rt, v_rt_inv);
                f0[p] = _mm256_add_mod(v_u, v_v);
                f1[p] = _mm256_sub_mod(v_u, v_v);
            }
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
            v8i v_w0_inv = _mm256_set1_epi32(x * M_INV);
            v8i v_w1 = _mm256_set1_epi32(y);
            v8i v_w1_inv = _mm256_set1_epi32(y * M_INV);
            v8i v_w2 = _mm256_set1_epi32(z);
            v8i v_w2_inv = _mm256_set1_epi32(z * M_INV);

            for (int p = 0; p < i8; ++p) {
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
            f0 += inc;
            f1 += inc;
            f2 += inc;
            f3 += inc;
        }
    }
    
    // --- Start Small Loop Timing ---
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);

    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_set1_epi32(rt[k]);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j << 1)))), perm_i2);
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v_mont = _mm256_mont_mul(v_v, v_rt);
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_mont), _mm256_sub_mod(v_u, v_v_mont));
    }
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
// DIT NTT (Modified to accept inv_roots pointer)
// ============================================================================
void dit_ntt(v8i *f, const int &n, const uint32_t* irt) {
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3; 
    
    // --- Start Small Loop Timing ---

    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + (j << 2)))), perm_i1);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_diff = _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt);
        v8i v_sum = _mm256_add_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_sum, _mm256_shuffle_epi32(v_diff, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + (j << 1)))), perm_i2);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt));
    }
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_set1_epi32(irt[k]);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt), 0x20);
    }
    
    // --- End Small Loop Timing ---

    // --- Start Nested Loop Timing ---

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
            v8i v_iw0_inv = _mm256_set1_epi32(x * M_INV);
            v8i v_iw1 = _mm256_set1_epi32(y);
            v8i v_iw1_inv = _mm256_set1_epi32(y * M_INV);
            v8i v_iw2 = _mm256_set1_epi32(z);
            v8i v_iw2_inv = _mm256_set1_epi32(z * M_INV);
            
            for (int p = 0; p < i8; ++p) {
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
            f0 += inc;
            f1 += inc;
            f2 += inc;
            f3 += inc;
        }
    }
    
    if ((num_outer_stages & 1) && i <= (n >> 1)) {
        int i8 = i >> 3;
        for (int j = 0, k = 0; j < n8; j += i8 << 1, ++k) {
            const v8i v_irt = {int64_t(uint64_t(irt[k])*0x100000001ULL), int64_t(uint64_t(irt[k])*0x100000001ULL), int64_t(uint64_t(irt[k])*0x100000001ULL), int64_t(uint64_t(irt[k])*0x100000001ULL)};
            const v8i v_irt_inv = _mm256_mul_epu32(v_irt, v_m);
            v8i* f0 = f + j;
            v8i* f1 = f + j + i8;
            for (int p = 0; p < i8; ++p) {
                v8i v_u = f0[p];
                v8i v_v = f1[p];
                f0[p] = _mm256_add_mod(v_u, v_v);
                f1[p] = _mm256_mont_mul_fixed(_mm256_sub_mod(v_u, v_v), v_irt, v_irt_inv);
            }
        }
    }
    
    uint32_t inv_n = to_mont(to_mont(inv_mod(n)));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    v8i v_inv_n_inv = _mm256_set1_epi32(inv_n * M_INV);
    for (int i = 0; i < n8; ++i) {
        f[i] = _mm256_mod(_mm256_mont_mul_fixed(f[i], v_inv_n, v_inv_n_inv));
    }

}

void run_test_logic(int L, v8i* A, v8i* B, uint32_t* roots, uint32_t* inv_roots, int& root_size) {
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
// KACTL NTT for correctness testing
// ============================================================================

void invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh){if(fresh||s==0)reset_roots(r,ir,s);run_test_logic(n,(v8i*)a,(v8i*)b,r,ir,s);}
}
// Frozen from generator at native-tested commit 7722004b7925454eaa7d4c3272d2d3804dabb4f5.
namespace direct8_identity {
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

const v8i v_mod = {int64_t(uint64_t(MOD)*0x100000001ULL), int64_t(uint64_t(MOD)*0x100000001ULL), int64_t(uint64_t(MOD)*0x100000001ULL), int64_t(uint64_t(MOD)*0x100000001ULL)};
const v8i v_wmod = {int64_t(uint64_t(WMOD)*0x100000001ULL), int64_t(uint64_t(WMOD)*0x100000001ULL), int64_t(uint64_t(WMOD)*0x100000001ULL), int64_t(uint64_t(WMOD)*0x100000001ULL)};
const v8i v_m = {int64_t(uint64_t(M_INV)*0x100000001ULL), int64_t(uint64_t(M_INV)*0x100000001ULL), int64_t(uint64_t(M_INV)*0x100000001ULL), int64_t(uint64_t(M_INV)*0x100000001ULL)};
const v8i v_r2 = {int64_t(uint64_t(R2_MOD)*0x100000001ULL), int64_t(uint64_t(R2_MOD)*0x100000001ULL), int64_t(uint64_t(R2_MOD)*0x100000001ULL), int64_t(uint64_t(R2_MOD)*0x100000001ULL)};
const v8i v_one = {int64_t(uint64_t(1)*0x100000001ULL), int64_t(uint64_t(1)*0x100000001ULL), int64_t(uint64_t(1)*0x100000001ULL), int64_t(uint64_t(1)*0x100000001ULL)};
const v8i v_zero = {0,0,0,0};

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
            const v8i v_rt = {int64_t(uint64_t(rt[k])*0x100000001ULL), int64_t(uint64_t(rt[k])*0x100000001ULL), int64_t(uint64_t(rt[k])*0x100000001ULL), int64_t(uint64_t(rt[k])*0x100000001ULL)};
            const v8i v_rt_inv = _mm256_mul_epu32(v_rt, v_m);
            for(int p=0;p<h8;++p) { v8i u=f[j+p], v=f[j+h8+p]; f[j+p]=_mm256_add_mod(u,v); f[j+h8+p]=_mm256_sub_mod(u,v); }
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
            const v8i v_irt = {int64_t(uint64_t(irt[k])*0x100000001ULL), int64_t(uint64_t(irt[k])*0x100000001ULL), int64_t(uint64_t(irt[k])*0x100000001ULL), int64_t(uint64_t(irt[k])*0x100000001ULL)};
            const v8i v_irt_inv = _mm256_mul_epu32(v_irt, v_m);
            for(int p=0;p<i8;++p) { v8i u=f[j+p], v=f[j+i8+p]; f[j+p]=_mm256_add_mod(u,v); f[j+i8+p]=_mm256_sub_mod(u,v); }
        }
    }
    
    uint32_t inv_n = to_mont(to_mont(inv_mod(n / 8)));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    v8i v_inv_n_inv = _mm256_set1_epi32(inv_n * M_INV);
    for (int i = 0; i < n8; ++i) {
        f[i] = _mm256_mod(_mm256_mont_mul_fixed(f[i], v_inv_n, v_inv_n_inv));
    }
}

void run_simd_convolution(int L, v8i* A, v8i* B, uint32_t* roots, uint32_t* inv_roots, int& root_size) {
    int L8 = L >> 3;
    get_root_mont(roots, inv_roots, root_size, L / 8);
    dif_ntt(A, L, roots);
    dif_ntt(B, L, roots);

    for(int i=0;i<L8;i+=4) direct8<4>(A+i,B+i,i,roots);
    __asm__ __volatile__("" : : "r,m"(A[0]) : "memory");

    dit_ntt(A, L, inv_roots);
}

// ============================================================================
// KACTL NTT for correctness testing and benchmarking
// ============================================================================


void invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& rs, bool fresh) { if(fresh || rs==0) reset_roots(r,ir,rs); run_simd_convolution(n,(v8i*)a,(v8i*)b,r,ir,rs); }
}


// Independently written continuation of QPoly's Montgomery / partial-NTT work.
// Starting point: kactl_bench.cpp and simd_explore/direct8.inc, commit 1e5a80f.
// No study/reference implementation is included in or copied into this kernel.
namespace qpoly_lazy {
using U=uint32_t; using W=uint64_t; using V=__m256i;
constexpr U P=998244353, P2=2*P, NI=998244351, R2=932051910;
static_assert(W(4)*P < (W(1)<<32));
static_assert(W(8)*(P-1)*(P-1) < UINT64_MAX-W(UINT32_MAX)*P);
constexpr U muls(U a,U b) {
    W x=W(a)*b; U c=U(x)*NI; U z=(x+W(c)*P)>>32;
    return z>=P?z-P:z;
}
constexpr U power(U a,U e) { U r=1; for(;e;e>>=1,a=W(a)*a%P) if(e&1)r=W(r)*a%P;return r; }
constexpr U mont(U a) { return muls(a,R2); }
constexpr U ONE=mont(1);
inline V splat(U x) { return _mm256_set1_epi32(x); }
inline V plus(V x,V y) { return _mm256_add_epi32(x,y); }
inline V minus(V x,V y) { return _mm256_sub_epi32(x,y); }
inline V shrink(V x,U p) { return _mm256_min_epu32(x,minus(x,splat(p))); }
inline V low(V x) { return shrink(x,P2); }
inline V canonical(V x) { return shrink(low(x),P); }
inline V diff(V x,V y) { return minus(plus(x,splat(P2)),y); }
inline V odd(V x) { return _mm256_srli_epi64(x,32); }
// As in the user's Montgomery kernel, operate on even/odd lanes independently.
inline V reduce(V e,V o) {
    V m=splat(NI),p=splat(P);
    e=_mm256_add_epi64(e,_mm256_mul_epu32(_mm256_mul_epu32(e,m),p));
    o=_mm256_add_epi64(o,_mm256_mul_epu32(_mm256_mul_epu32(o,m),p));
    return _mm256_or_si256(odd(e),o);
}
struct Fixed {
    V w,wi;
    explicit Fixed(U x):w(splat(x)),wi(splat(x*NI)){}
    explicit Fixed(V x):w(x),wi(_mm256_mul_epu32(x,splat(NI))){}
    // x<4P, w<P => x*w + correction < 2^64 and result <2P.
    inline V operator()(V x) const {
        V e=_mm256_mul_epu32(x,w),o=_mm256_mul_epu32(odd(x),w);
        e=_mm256_add_epi64(e,_mm256_mul_epu32(_mm256_mul_epu32(x,wi),splat(P)));
        o=_mm256_add_epi64(o,_mm256_mul_epu32(_mm256_mul_epu32(odd(x),wi),splat(P)));
        return _mm256_or_si256(odd(e),o);
    }
};

// r[k] = product(q[b] for each set bit b of k), q[b]=3^((P-1)/2^(b+2)).
// Incrementing k clears t low bits and sets bit t; delta=q[t]/prod(q[0:t]).
// The radix-4 group uses x=r[k], y=r[2k], z=I*y (or x*y for twisted inputs).
struct Constants {
    U q[22]{},iq[22]{},step[22]{},istep[22]{},even_step[21]{},ieven_step[21]{};
    alignas(32) W rates[2][2][21][4]{};
    alignas(32) W fixed_rates[2][2][21][4]{};
    constexpr Constants() {
        q[21]=mont(power(3,(P-1)>>23)); iq[21]=mont(power(power(3,(P-1)>>23),P-2));
        for(int j=20;j>=0;--j) {q[j]=muls(q[j+1],q[j+1]);iq[j]=muls(iq[j+1],iq[j+1]);}
        U a=ONE,b=ONE,c=ONE,d=ONE;
        for(int j=0;j<22;++j) {
            step[j]=muls(q[j],a);istep[j]=muls(iq[j],b);
            a=muls(a,iq[j]);b=muls(b,q[j]);
            if(j<21) {
                even_step[j]=muls(q[j+1],c);ieven_step[j]=muls(iq[j+1],d);
                c=muls(c,iq[j+1]);d=muls(d,q[j+1]);
                for(int inverse=0;inverse<2;++inverse) for(int twist=0;twist<2;++twist) {
                    U x=inverse?istep[j]:step[j], y=inverse?ieven_step[j]:even_step[j];
                    rates[inverse][twist][j][0]=x; rates[inverse][twist][j][1]=y;
                    rates[inverse][twist][j][2]=twist?muls(x,y):y;rates[inverse][twist][j][3]=ONE;
                    for(int lane=0;lane<4;++lane) {
                        U value=U(rates[inverse][twist][j][lane]);
                        fixed_rates[inverse][twist][j][lane]=W(value)|(W(value*NI)<<32);
                    }
                }
            }
        }
    }
};
inline constexpr Constants constants{};
inline V packed_mul(V x,V y) {
    V t=_mm256_mul_epu32(x,y);
    V c=_mm256_mul_epu32(_mm256_mul_epu32(t,splat(NI)),splat(P));
    return shrink(_mm256_srli_epi64(_mm256_add_epi64(t,c),32),P);
}
inline V packed_mul_fixed(V x,V rate) {
    V product=_mm256_mul_epu32(x,rate);
    V correction=_mm256_mul_epu32(_mm256_mul_epu32(x,odd(rate)),splat(P));
    return shrink(_mm256_srli_epi64(_mm256_add_epi64(product,correction),32),P);
}
struct Twiddle { Fixed x,y,z; Twiddle(V a,V b,V c):x(a),y(b),z(c){} };

// Lazy=false is an ablation that keeps all butterfly values below 2P.
// Lazy=true: forward loads/stores <4P, inverse loads/stores <2P.
// Twist=true distributes w,w^2,w^3 onto inputs to expose independent multiplies.
template<bool Lazy,bool Twist,bool Identity,bool Inverse>
inline void radix4(V* f,int h,const Twiddle& t) {
    const Fixed imag(Inverse?constants.iq[0]:constants.q[0]);
    for(int j=0;j<h;++j) {
        V a=f[j],b=f[j+h],c=f[j+2*h],d=f[j+3*h];
        V o0,o1,o2,o3;
        if constexpr(!Inverse) {
            if constexpr(Lazy) a=low(a);
            if constexpr(Twist) {
                if constexpr(Identity) {if constexpr(Lazy) {b=low(b);c=low(c);d=low(d);}}
                else {b=t.y(b);c=t.x(c);d=t.z(d);}
                V ac=low(plus(a,c)), amc=low(diff(a,c));
                V bd=low(plus(b,d)), bmd=imag(Lazy?diff(b,d):low(diff(b,d)));
                o0=plus(ac,bd);o1=diff(ac,bd);o2=plus(amc,bmd);o3=diff(amc,bmd);
            } else {
                if constexpr(Lazy) b=low(b);
                if constexpr(Identity) {if constexpr(Lazy) {c=low(c);d=low(d);}}
                else {c=t.x(c);d=t.x(d);}
                V ac=low(plus(a,c)), amc=low(diff(a,c));
                V bd=plus(b,d), bmd=diff(b,d);
                if constexpr(!Lazy) {bd=low(bd);bmd=low(bmd);}
                if constexpr(Identity) bd=low(bd); else bd=t.y(bd);
                bmd=t.z(bmd);
                o0=plus(ac,bd);o1=diff(ac,bd);o2=plus(amc,bmd);o3=diff(amc,bmd);
            }
            if constexpr(!Lazy) {o0=low(o0);o1=low(o1);o2=low(o2);o3=low(o3);}
        } else {
            V ab=low(plus(a,b)),cd=low(plus(c,d));
            V amb=diff(a,b),cmd=diff(c,d);
            if constexpr(!Lazy) {amb=low(amb);cmd=low(cmd);}
            if constexpr(Twist) {
                amb=low(amb);cmd=imag(cmd);
                o0=low(plus(ab,cd));o1=plus(amb,cmd);o2=diff(ab,cd);o3=diff(amb,cmd);
                if constexpr(!Lazy) {o1=low(o1);o2=low(o2);o3=low(o3);}
                if constexpr(Identity) {o1=low(o1);o2=low(o2);o3=low(o3);}
                else {o1=t.y(o1);o2=t.x(o2);o3=t.z(o3);}
            } else {
                if constexpr(Identity) amb=low(amb);else amb=t.y(amb);
                cmd=t.z(cmd);
                o0=low(plus(ab,cd));o1=low(plus(amb,cmd));o2=diff(ab,cd);o3=diff(amb,cmd);
                if constexpr(!Lazy) {o2=low(o2);o3=low(o3);}
                if constexpr(Identity) {o2=low(o2);o3=low(o3);}else {o2=t.x(o2);o3=t.x(o3);}
            }
        }
        f[j]=o0;f[j+h]=o1;f[j+2*h]=o2;f[j+3*h]=o3;
    }
}

// Own direct8 method from exploration 002, with explicit incoming [0,4P) handling.
// Sum bound: 8*(P-1)^2+(2^32-1)*P <2^64. Reduce output <3P to <2P.
template<int Batch,int Schedule=0>
inline void leaf(V* a,V* b,const U* weights) {
    alignas(32) U window[Batch][16],coeff[Batch][8];
    V e[Batch],o[Batch];
    for(int t=0;t<Batch;++t) {
        V x=canonical(a[t]); Fixed w(weights[t]);
        _mm256_store_si256((V*)window[t],shrink(w(x),P));
        _mm256_store_si256((V*)(window[t]+8),x);
        _mm256_store_si256((V*)coeff[t],canonical(b[t]));
        e[t]=o[t]=_mm256_setzero_si256();
    }
    auto step = [&](int i) __attribute__((always_inline)) {
        for(int t=0;t<Batch;++t) {
            V x=_mm256_loadu_si256((V*)(window[t]+8-i)),y=splat(coeff[t][i]);
            e[t]=_mm256_add_epi64(e[t],_mm256_mul_epu32(x,y));
            o[t]=_mm256_add_epi64(o[t],_mm256_mul_epu32(odd(x),y));
        }
    };
    if constexpr(Schedule==1) {
        // The fully expanded leaf spilled many products in GCC 13 assembly.
        #pragma GCC unroll 1
        for(int i=0;i<8;++i)step(i);
    } else if constexpr(Schedule==2) {
        #pragma GCC unroll 2
        for(int i=0;i<8;++i)step(i);
    } else for(int i=0;i<8;++i)step(i);
    for(int t=0;t<Batch;++t)a[t]=low(reduce(e[t],o[t]));
}

// RootMode=0: O(N) root tables. RootMode=1: packed incremental per-stage cursors,
// and a scalar cursor for batches of four leaf factors. Tile is in AVX2 vectors.
template<bool Lazy,bool Twist,int RootMode,int Tile,int LeafBatch=4,int LeafSchedule=0,bool FuseTop=false>
struct Kernel {
    U *rt,*irt;
    V forward[12],inverse[12]; U leaf_cursor=ONE;
    Kernel(U* r,U* ir):rt(r),irt(ir) {
        for(int i=0;i<12;++i) {
            forward[i]=_mm256_setr_epi64x(ONE,ONE,Twist?ONE:constants.q[0],ONE);
            inverse[i]=_mm256_setr_epi64x(ONE,ONE,Twist?ONE:constants.iq[0],ONE);
        }
    }
    static void tables(int count,U* r,U* ir,int& size,bool fresh) {
        if(fresh||size==0) {r[0]=ir[0]=ONE;size=1;}
        for(int h=size;h<count;h*=2) {
            int s=__builtin_ctz(unsigned(h)); Fixed a(constants.q[s]),b(constants.iq[s]);
            if(h>=8) for(int j=0;j<h;j+=8) {
                _mm256_store_si256((V*)(r+h+j),shrink(a(_mm256_load_si256((V*)(r+j))),P));
                _mm256_store_si256((V*)(ir+h+j),shrink(b(_mm256_load_si256((V*)(ir+j))),P));
            } else for(int j=0;j<h;++j) {r[h+j]=muls(r[j],constants.q[s]);ir[h+j]=muls(ir[j],constants.iq[s]);}
        }
        size=std::max(size,count);
    }
    template<bool Inv>
    inline Twiddle twiddle(int h,int k) {
        if constexpr(RootMode==0 || RootMode==2) {
            const U* r=Inv?irt:rt;U x=r[k],y=r[2*k],z=Twist?muls(x,y):r[2*k+1];
            return Twiddle(splat(x),splat(y),splat(z));
        } else {
            int level=__builtin_ctz(unsigned(h))/2;
            V& cursor=Inv?inverse[level]:forward[level]; V current=cursor;
            int carry=__builtin_ctz(~unsigned(k));
            if constexpr(RootMode==3) {
                V step=_mm256_load_si256((const V*)constants.fixed_rates[Inv][Twist][carry]);
                cursor=packed_mul_fixed(current,step);
            } else {
                V step=_mm256_load_si256((const V*)constants.rates[Inv][Twist][carry]);
                cursor=packed_mul(current,step);
            }
            return Twiddle(_mm256_permute4x64_epi64(current,0x00),_mm256_permute4x64_epi64(current,0x55),_mm256_permute4x64_epi64(current,0xaa));
        }
    }
    template<bool Inv>
    inline void group(V* a,V* b,int h,int k) {
        Twiddle t=twiddle<Inv>(h,k);
        if(k==0) {
            radix4<Lazy,Twist,true,Inv>(a,h,t);
            if constexpr(!Inv)radix4<Lazy,Twist,true,false>(b,h,t);
        } else {
            radix4<Lazy,Twist,false,Inv>(a,h,t);
            if constexpr(!Inv)radix4<Lazy,Twist,false,false>(b,h,t);
        }
    }
    inline void leaves(V* a,V* b,int nv,int first) {
        for(int j=0;j<nv;j+=4) {
            U w[4];
            if constexpr(RootMode==0)for(int t=0;t<4;++t)w[t]=muls(rt[first+j+t],rt[first+j+t]);
            else {
                w[0]=leaf_cursor;w[1]=P-w[0];w[2]=muls(w[0],constants.q[0]);w[3]=P-w[2];
                int carry=__builtin_ctz(~unsigned((first+j)/4));
                leaf_cursor=muls(leaf_cursor,constants.even_step[carry]);
            }
            if constexpr(LeafBatch==2) {leaf<2,LeafSchedule>(a+j,b+j,w);leaf<2,LeafSchedule>(a+j+2,b+j+2,w+2);}
            else leaf<4,LeafSchedule>(a+j,b+j,w);
        }
    }
    void visit(V* a,V* b,int nv,int k) {
        if(nv<=Tile) {
            for(int h=nv/4;h;h/=4)for(int j=0;j<nv;j+=4*h)group<false>(a+j,b+j,h,k*(nv/(4*h))+j/(4*h));
            leaves(a,b,nv,k*nv);
            for(int h=1;h<nv;h*=4)for(int j=0;j<nv;j+=4*h)group<true>(a+j,nullptr,h,k*(nv/(4*h))+j/(4*h));
        } else {
            int h=nv/4;group<false>(a,b,h,k);
            for(int t=0;t<4;++t)visit(a+t*h,b+t*h,h,4*k+t);
            group<true>(a,nullptr,h,k);
        }
    }
    static void run(int n,U* aa,U* bb,U* r,U* ir,int& size,bool fresh) {
        assert(n>=64 && n<=(1<<22) && (n&(n-1))==0);
        if constexpr(RootMode==0 || RootMode==2)tables(n/(RootMode==2?16:8),r,ir,size,fresh);
        Kernel job(r,ir);V* a=(V*)aa;V* b=(V*)bb;int nv=n/8;
        if(__builtin_ctz(unsigned(nv))&1) {
            int h=nv/2;
            for(int i=0;i<h;++i) {
                V x=a[i],y=a[i+h];a[i]=low(plus(x,y));a[i+h]=low(diff(x,y));
                x=b[i];y=b[i+h];b[i]=low(plus(x,y));b[i+h]=low(diff(x,y));
            }
            job.visit(a,b,h,0);job.visit(a+h,b+h,h,1);
            if constexpr(FuseTop) {
                // The final sums/differences are <4P, acceptable to canonical scale.
                // This also removes both reduce2 operations and the normalization pass.
                Fixed scale(mont(mont(power(nv,P-2))));
                for(int i=0;i<h;++i) {V x=a[i],y=a[i+h];a[i]=shrink(scale(plus(x,y)),P);a[i+h]=shrink(scale(diff(x,y)),P);}
                return;
            } else for(int i=0;i<h;++i) {V x=a[i],y=a[i+h];a[i]=low(plus(x,y));a[i+h]=low(diff(x,y));}
        } else job.visit(a,b,nv,0);
        Fixed scale(mont(mont(power(nv,P-2))));
        for(int i=0;i<nv;++i)a[i]=shrink(scale(a[i]),P);
    }
};
}

namespace lazy_inc_counted { void invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh) {qpoly_lazy::Kernel<true,false,1,256,4,1>::run(n,a,b,r,ir,s,fresh);} }

namespace lazy_inc_fused { void invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh) {qpoly_lazy::Kernel<true,false,1,256,4,1,true>::run(n,a,b,r,ir,s,fresh);} }

namespace lazy_hybrid_fused { void invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh) {qpoly_lazy::Kernel<true,false,2,256,4,2,true>::run(n,a,b,r,ir,s,fresh);} }

const Entry entries[] = {
{"v91",v91::invoke},
{"direct8_identity",direct8_identity::invoke},
{"lazy_inc_counted",lazy_inc_counted::invoke},
{"lazy_inc_fused",lazy_inc_fused::invoke},
{"lazy_hybrid_fused",lazy_hybrid_fused::invoke},
};
// Self-contained comparison driver. No problem input/output is required.
// Empty stdin: max_log2=20, repetitions=5, mode=0 (fresh).
// Optional stdin: "20 9 2". Mode 0=fresh, 1=reuse, 2=both. max_log2 <=22.
namespace comparison {
using U=uint32_t; using A=std::vector<U>;
constexpr U P=998244353;
struct Aligned {
    U* p;int n;
    explicit Aligned(int size):p((U*)_mm_malloc(size_t(size+16)*4,64)),n(size) {
        if(!p)throw std::bad_alloc();std::fill(p,p+n,0);std::fill(p+n,p+n+16,0xdeadbeef);
    }
    ~Aligned(){_mm_free(p);}
    Aligned(const Aligned&)=delete;
    bool intact()const{return std::all_of(p+n,p+n+16,[](U x){return x==0xdeadbeef;});}
};
U power(U a,U e) {U r=1;for(;e;e>>=1,a=uint64_t(a)*a%P)if(e&1)r=uint64_t(r)*a%P;return r;}
// Independent scalar radix-2 oracle; explicit bit reversal and ordinary %.
void transform(A& a,bool inverse) {
    int n=int(a.size());
    for(int i=1,j=0;i<n;++i){int b=n/2;for(;j&b;b>>=1)j^=b;j^=b;if(i<j)std::swap(a[i],a[j]);}
    for(int len=2;len<=n;len*=2){
        U step=power(3,(P-1)/len);if(inverse)step=power(step,P-2);
        for(int i=0;i<n;i+=len){U w=1;for(int j=0;j<len/2;++j){
            U x=a[i+j],y=uint64_t(a[i+j+len/2])*w%P;
            a[i+j]=(x+y)%P;a[i+j+len/2]=(x+P-y)%P;w=uint64_t(w)*step%P;
        }}
    }
    if(inverse){U w=power(n,P-2);for(U& x:a)x=uint64_t(x)*w%P;}
}
A reference(A a,A b){transform(a,false);transform(b,false);for(size_t i=0;i<a.size();++i)a[i]=uint64_t(a[i])*b[i]%P;transform(a,true);return a;}
A brute(const A&a,const A&b){A c(a.size());for(size_t i=0;i<a.size();++i)for(size_t j=0;j<b.size();++j)c[(i+j)%a.size()]=(c[(i+j)%a.size()]+uint64_t(a[i])*b[j])%P;return c;}
[[noreturn]] void fail(const char*name,int n,int i,U got,U want){
    std::cerr<<"FAIL "<<name<<" n="<<n<<" index="<<i<<" got="<<got<<" expected="<<want<<'\n';std::exit(1);
}
void check(const Entry&e,const A&x,const A&y,const A&want,Aligned&a,Aligned&b,Aligned&r,Aligned&ir,int&rs,bool fresh){
    int n=int(x.size());std::copy(x.begin(),x.end(),a.p);std::copy(y.begin(),y.end(),b.p);
    e.fn(n,a.p,b.p,r.p,ir.p,rs,fresh);
    // Require canonical outputs, not just equivalence modulo P.
    for(int i=0;i<n;++i)if(a.p[i]!=want[i])fail(e.name,n,i,a.p[i],want[i]);
    if(!a.intact()||!b.intact()||!r.intact()||!ir.intact())fail(e.name,n,n,0,1);
}
volatile uint64_t sink=0;
void correctness(int max_log){
    std::mt19937 rng(20260926);
    for(int lg=6;lg<=max_log;++lg){
        int n=1<<lg;Aligned a(n),b(n),r(n),ir(n);
        for(int pattern=0;pattern<(lg<=8?6:1);++pattern){
            A x(n),y(n);for(int i=0;i<n;++i){
                x[i]=rng()%P;y[i]=rng()%P;
                if(pattern==1)x[i]=y[i]=P-1;
                if(pattern==2)x[i]=0;
                if(pattern==3)x[i]=(i==n-1?P-1:0),y[i]=(i==1);
                if(pattern==4)x[i]=i&1?P-1:0,y[i]=i&1?1:P-1;
                if(pattern==5)x[i]=y[i]=1;
            }
            A want=reference(x,y);if(n<=256&&want!=brute(x,y))fail("oracle-vs-brute",n,0,0,1);
            for(const Entry&e:entries){int rs=0;check(e,x,y,want,a,b,r,ir,rs,true);check(e,x,y,want,a,b,r,ir,rs,false);}
        }
        std::cout<<"PASS 2^"<<lg<<" all implementations\n";
    }
    {int n=1<<max_log;Aligned a(n),b(n),r(n),ir(n);A x(n,P-1),y(n,P-1),want(n,n);
     for(const Entry&e:entries){int rs=0;check(e,x,y,want,a,b,r,ir,rs,true);}
     std::fill(x.begin(),x.end(),0);x[n-1]=P-1;
     for(U&v:y)v=rng()%P;for(int i=0;i<n;++i)want[i]=(P-y[(i+1)%n])%P;
     for(const Entry&e:entries){int rs=0;check(e,x,y,want,a,b,r,ir,rs,true);}}
    for(const Entry&e:entries){Aligned a(1024),b(1024),r(1024),ir(1024);int rs=0;
        for(int n:{64,256,128,1024,512,64}){A x(n),y(n);for(U&v:x)v=rng()%P;for(U&v:y)v=rng()%P;check(e,x,y,reference(x,y),a,b,r,ir,rs,false);}}
    std::cout<<"PASS maximum coefficients, wraparound, and changing sizes\n";
}
void benchmark(int max_log,int reps,int mode){
    std::mt19937 rng(42);constexpr int count=sizeof(entries)/sizeof(entries[0]);
    std::cout<<"mode,log2,implementation,median_ms,min_ms,max_ms,speedup_vs_v91\n";
    for(int lg=std::min(12,max_log);lg<=max_log;++lg){
        int n=1<<lg;Aligned a(n),b(n),r(n),ir(n);A x(n),y(n);for(U&v:x)v=rng()%P;for(U&v:y)v=rng()%P;
        for(int reuse=0;reuse<=1;++reuse){if(mode!=2&&reuse!=mode)continue;
            std::vector<double> samples[count];uint64_t expected_hash=0;bool hash_set=false;
            for(int rep=-2;rep<reps;++rep)for(int pos=0;pos<count;++pos){
                int j=(pos+rep+2)%count;if(rep&1)j=count-1-j;const Entry&e=entries[j];int rs=0;
                if(reuse){std::copy(x.begin(),x.end(),a.p);std::copy(y.begin(),y.end(),b.p);e.fn(n,a.p,b.p,r.p,ir.p,rs,true);}
                std::copy(x.begin(),x.end(),a.p);std::copy(y.begin(),y.end(),b.p);
                auto start=std::chrono::steady_clock::now();e.fn(n,a.p,b.p,r.p,ir.p,rs,!reuse);auto end=std::chrono::steady_clock::now();
                uint64_t hash=0;for(int i=0;i<n;++i)hash=hash*31+a.p[i];sink=hash;
                if(hash_set&&hash!=expected_hash)fail(e.name,n,-1,U(hash),U(expected_hash));expected_hash=hash;hash_set=true;
                if(rep>=0)samples[j].push_back(std::chrono::duration<double,std::milli>(end-start).count());
            }
            for(auto&s:samples)std::sort(s.begin(),s.end());
            auto median=[](const std::vector<double>&s){return (s[(s.size()-1)/2]+s[s.size()/2])/2;};
            double baseline=median(samples[0]);
            for(int j=0;j<count;++j){const auto&s=samples[j];std::cout<<(reuse?"reuse":"fresh")<<','<<lg<<','<<entries[j].name<<','<<median(s)<<','<<s.front()<<','<<s.back()<<','<<baseline/median(s)<<'\n';}
        }
    }
}
}
int main(){
    std::ios::sync_with_stdio(false);std::cin.tie(nullptr);std::cout<<std::unitbuf<<std::fixed<<std::setprecision(4);
    int max_log=20,reps=5,mode=0;
    if(std::cin>>max_log){if(!(std::cin>>reps>>mode)){std::cerr<<"Expected: max_log2 repetitions mode\n";return 2;}}
    if(max_log<6||max_log>22||reps<1||reps>25||mode<0||mode>2){std::cerr<<"Require 6<=max_log2<=22, 1<=repetitions<=25, mode in {0,1,2}\n";return 2;}
    std::cout<<"QPoly NTT comparison / modulus 998244353 / cyclic convolution\n"
             <<"Compiler: "<<__VERSION__<<"\nmax_log2="<<max_log<<" repetitions="<<reps<<" mode="<<mode<<'\n'
             <<"Heap allocation and input copies excluded. Full convolution timed.\n"
             <<"fresh regenerates size-dependent roots; reuse primes each implementation. Fixed constexpr metadata is never timed.\n";
    comparison::correctness(max_log);comparison::benchmark(max_log,reps,mode);
    std::cout<<"ALL CHECKS PASSED checksum="<<comparison::sink<<'\n';
}
