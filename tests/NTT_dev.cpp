#include <iostream>
#include <vector>
#include <random>
#include <chrono>
#include <iomanip>
#include <immintrin.h>
#include <cstring>

#pragma GCC target("avx2")

typedef __m256i v8i;

const uint32_t MOD = 998244353;
const uint32_t WMOD = 1996488706;
const uint32_t R2_MOD = 932051910;
const uint32_t M_INV = 998244351;
const uint32_t PRIM_ROOT = 3;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_one = _mm256_set1_epi32(1);
const v8i v_m = _mm256_set1_epi32(M_INV);
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);

// lazy Montgomery Multiplication， in [0, 2 * MOD)
inline v8i _mm256_mont_multiply_mod(const v8i& a, const v8i& b) {
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i t_even = _mm256_mul_epu32(a, b);             
    v8i u_even = _mm256_mul_epu32(t_even, v_m);      
    v8i up_even = _mm256_mul_epu32(u_even, v_mod);    
    v8i sum_even = _mm256_add_epi64(t_even, up_even); 
    v8i res_even = _mm256_srli_epi64(sum_even, 32);   
    v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
    v8i u_odd = _mm256_mul_epu32(t_odd, v_m);
    v8i up_odd = _mm256_mul_epu32(u_odd, v_mod);
    v8i sum_odd = _mm256_add_epi64(t_odd, up_odd);
    v8i result = _mm256_or_si256(res_even, sum_odd);
    v8i adjusted = _mm256_sub_epi32(result, v_mod);
    return _mm256_min_epu32(result, adjusted);
}
// a + b > m ? a + b - m : a + b
v8i _mm256_add_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), m);
    v8i mask = _mm256_srai_epi32(adjusted, 31);
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, m));
}

// a - b < 0 ? m + a - b : a - b
v8i _mm256_sub_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i mask = _mm256_cmpgt_epi32(b, a);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}

// a > m ? a - m : a
v8i _mm256_mod(const v8i& a, const v8i &m = v_mod) {
    v8i diff = _mm256_sub_epi32(a, m);
    v8i mask = _mm256_srai_epi32(diff, 31);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}

inline uint32_t mont_mul_scalar(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint32_t m = (uint32_t)t * M_INV;
    uint64_t u = t + (uint64_t)m * MOD;
    uint32_t res = u >> 32;
    return res >= MOD ? res - MOD : res;
}

inline uint32_t to_mont(uint32_t x) {
    return mont_mul_scalar(x, R2_MOD);
}

inline uint32_t from_mont(uint32_t x) {
    return mont_mul_scalar(x, 1);
}

uint32_t pow_mod(uint32_t base, uint32_t exp) {
    uint32_t result = to_mont(1);
    base = to_mont(base);
    while (exp > 0) {
        if (exp & 1) result = mont_mul_scalar(result, base);
        base = mont_mul_scalar(base, base);
        exp >>= 1;
    }
    return from_mont(result);
}

uint32_t inv_mod(uint32_t x) {
    return pow_mod(x, MOD - 2);
}

static std::pair<uint32_t*, uint32_t*> get_root(const int &n) {
    static std::vector<uint32_t> root{to_mont(1)};
    static std::vector<uint32_t> inv_root{to_mont(1)};
    
    if (static_cast<int>(root.size()) < n) {
        int i = root.size();
        root.resize(n);
        inv_root.resize(n);
        
        for (; i != n; i <<= 1) {
            uint32_t w = pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2));
            uint32_t iw = inv_mod(w);
            w = to_mont(w);
            iw = to_mont(iw);
            
            for (int j = 0; j != i; ++j) {
                root[i + j] = mont_mul_scalar(root[j], w);
                inv_root[i + j] = mont_mul_scalar(inv_root[j], iw);
            }
        }
    }
    
    return {root.data(), inv_root.data()};
}


void dif_ntt(uint32_t *f, const int &n) {
    const uint32_t* rt = get_root(n).first;
    
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    for (int i = n >> 1; i >= 8; i >>= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            v8i v_rt = _mm256_set1_epi32(rt[k]);
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));
                v8i v_q = _mm256_loadu_si256((v8i*)(f + p + i));
                v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                v8i v_np = _mm256_add_mod(v_u, v_v);
                v8i v_nq = _mm256_sub_mod(v_u, v_v);
                _mm256_storeu_si256((v8i*)(f + p), v_np);
                _mm256_storeu_si256((v8i*)(f + p + i), v_nq);
            }
        }
    }
    {
        for (int j = 0, k = 0; j != n; j += 8, ++k) {
            v8i v_rt = _mm256_set1_epi32(rt[k]);
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
            v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
            v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
            v8i v_np = _mm256_add_mod(v_u, v_v);
            v8i v_nq = _mm256_sub_mod(v_u, v_v);
            v8i v_result = _mm256_permute2x128_si256(v_np, v_nq, 0x20);
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
    {
        for (int j = 0; j != n; j += 8) {
            int k = j >> 2;
            v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + k)));
            v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i2);
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
            v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
            v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
            v8i v_np = _mm256_add_mod(v_u, v_v);
            v8i v_nq = _mm256_sub_mod(v_u, v_v);
            v8i v_result = _mm256_unpacklo_epi64(v_np, v_nq);
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
    {
        for (int j = 0; j != n; j += 8) {
            int k = j >> 1;
            v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + k)));
            v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i1);
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
            v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
            v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
            v8i v_np = _mm256_add_mod(v_u, v_v);
            v8i v_nq = _mm256_sub_mod(v_u, v_v);
            v8i v_result = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
}

void dit_ntt(uint32_t *f, const int &n) {
    const uint32_t* irt = get_root(n).second;
    
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    // i = 1: pairs of adjacent elements
    // Input:  [a0, a1, a2, a3, a4, a5, a6, a7]
    // Output: [a0+a1, (a0-a1)*w0, a2+a3, (a2-a3)*w1, a4+a5, (a4-a5)*w2, a6+a7, (a6-a7)*w3]
    {
        for (int j = 0; j != n; j += 8) {
            int k = j >> 1;
            v8i v_irt_raw = _mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + k)));
            v8i v_irt = _mm256_permutevar8x32_epi32(v_irt_raw, perm_i1);
            // v_irt = [w0, w0, w1, w1, w2, w2, w3, w3]
            
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));  // [a0,a0,a2,a2,a4,a4,a6,a6]
            v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));  // [a1,a1,a3,a3,a5,a5,a7,a7]
            
            v8i v_sum = _mm256_add_mod(v_u, v_v);
            v8i v_diff = _mm256_sub_mod(v_u, v_v);
            v8i v_diff_mult = _mm256_mont_multiply_mod(v_diff, v_irt);
            
            // Interleave: [sum[0], diff_mult[1], sum[2], diff_mult[3], ...]
            v8i v_diff_shuffled = _mm256_shuffle_epi32(v_diff_mult, _MM_SHUFFLE(2, 3, 0, 1));
            v8i v_result = _mm256_blend_epi32(v_sum, v_diff_shuffled, 0xAA);
            
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
    
    // i = 2: pairs of 2 elements
    // Input:  [a0, a1, a2, a3, a4, a5, a6, a7]
    // Output: [a0+a2, a1+a3, (a0-a2)*w0, (a1-a3)*w0, a4+a6, a5+a7, (a4-a6)*w1, (a5-a7)*w1]
    {
        for (int j = 0; j != n; j += 8) {
            int k = j >> 2;
            v8i v_irt_raw = _mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + k)));
            v8i v_irt = _mm256_permutevar8x32_epi32(v_irt_raw, perm_i2);
            // v_irt = [w0, w0, w0, w0, w1, w1, w1, w1]
            
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));  // [a0,a1,a0,a1,a4,a5,a4,a5]
            v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));  // [a2,a3,a2,a3,a6,a7,a6,a7]
            
            v8i v_sum = _mm256_add_mod(v_u, v_v);
            v8i v_diff = _mm256_sub_mod(v_u, v_v);
            v8i v_diff_mult = _mm256_mont_multiply_mod(v_diff, v_irt);
            
            // Interleave 64-bit chunks: [sum[0:1], diff_mult[2:3], sum[4:5], diff_mult[6:7]]
            v8i v_result = _mm256_unpacklo_epi64(v_sum, v_diff_mult);
            
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
    
    // i = 4: pairs of 4 elements (128-bit lanes)
    // Input:  [a0, a1, a2, a3 | a4, a5, a6, a7]
    // Output: [a0+a4, a1+a5, a2+a6, a3+a7 | (a0-a4)*w, (a1-a5)*w, (a2-a6)*w, (a3-a7)*w]
    {
        for (int j = 0, k = 0; j != n; j += 8, ++k) {
            v8i v_irt = _mm256_set1_epi32(irt[k]);
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            
            v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);  // low 128 bits duplicated
            v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);  // high 128 bits duplicated
            
            v8i v_sum = _mm256_add_mod(v_u, v_v);
            v8i v_diff = _mm256_sub_mod(v_u, v_v);
            v8i v_diff_mult = _mm256_mont_multiply_mod(v_diff, v_irt);
            
            // Combine: [sum (low 128) | diff_mult (low 128)]
            v8i v_result = _mm256_permute2x128_si256(v_sum, v_diff_mult, 0x20);
            
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
    
    // i >= 8: standard vectorized approach with contiguous memory access
    for (int i = 8; i < n; i <<= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            v8i v_irt = _mm256_set1_epi32(irt[k]);
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));
                v8i v_v = _mm256_loadu_si256((v8i*)(f + p + i));
                
                v8i v_sum = _mm256_add_mod(v_u, v_v);
                v8i v_diff = _mm256_sub_mod(v_u, v_v);
                v8i v_diff_mult = _mm256_mont_multiply_mod(v_diff, v_irt);
                
                _mm256_storeu_si256((v8i*)(f + p), v_sum);
                _mm256_storeu_si256((v8i*)(f + p + i), v_diff_mult);
            }
        }
    }
    uint32_t inv_n = to_mont(inv_mod(n));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    for (int i = 0; i < n; i += 8) {
        v8i v_f = _mm256_loadu_si256((v8i*)(f + i));
        v8i v_result = _mm256_mont_multiply_mod(v_f, v_inv_n);
        v_result = _mm256_mod(v_result);
        _mm256_storeu_si256((v8i*)(f + i), v_result);
    }
}
/*
static void dif_n(Z *f, const int &n) {
		const Z* rt = get_root(n).first;
		for (int i = n; i >>= 1; ) {
			for (int j = 0, k = 0; j != n; j += i << 1, ++ k) {
				for (int p = j, q = j + i; p != j + i; ++ p, ++ q) {
					const Z u = f[p], v = f[q] * rt[k];
					f[p] = u + v, f[q] = u - v;
				}
			}
		}
	}
static void dit_n(Z *f, const int &n) {
    const Z* irt = get_root(n).second;
    for (int i = 1; i != n; i <<= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++ k) {
            for (int p = j, q = j + i; p != j + i; ++ p, ++ q) {
                const Z u = f[p], v = f[q];
                f[p] = u + v, f[q] = (u - v) * irt[k];
            }
        }
    }
    Z is mod int class, but removed. 
    const Z inv = Z::from_raw(Mod - Mod / n);
    for (int i = 0; i < n; i ++) {
        f[i] *= inv;
    }
}
*/