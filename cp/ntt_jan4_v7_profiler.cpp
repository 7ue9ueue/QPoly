#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2")
#include <immintrin.h>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstring>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <random>
#include <iomanip>
#include <algorithm>
#include <string>

using u32 = uint32_t;
using u64 = uint64_t;

typedef __m256i v8i;

// ============================================================================
// Constants
// ============================================================================
constexpr uint32_t MOD = 998244353;
constexpr uint32_t WMOD = 1996488706;
constexpr uint32_t PRIM_ROOT = 3;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_zero = _mm256_setzero_si256();

constexpr int maxn = 1 << 22; 
constexpr int maxn8 = maxn >> 3;

// ============================================================================
// Timing Infrastructure
// ============================================================================
struct TimingStats {
    long long root_precomp_ns = 0;
    long long dif_nested_loop_ns = 0;
    long long dif_small_loops_ns = 0;
    long long dit_small_loops_ns = 0;
    long long dit_nested_loop_ns = 0;
    long long pointwise_mult_ns = 0;
    
    void reset() {
        root_precomp_ns = 0;
        dif_nested_loop_ns = 0;
        dif_small_loops_ns = 0;
        dit_small_loops_ns = 0;
        dit_nested_loop_ns = 0;
        pointwise_mult_ns = 0;
    }
    
    void print(const std::string& label, int divisor = 1) const {
        if (divisor < 1) divisor = 1;
        std::cout << "\n=== Timing Breakdown: " << label << " (Average of " << divisor << " runs) ===\n";
        std::cout << "Root precomputation:    " << std::setw(10) << (root_precomp_ns / divisor) << " ns\n";
        std::cout << "DIF nested loops:       " << std::setw(10) << (dif_nested_loop_ns / divisor) << " ns\n";
        std::cout << "DIF small loops:        " << std::setw(10) << (dif_small_loops_ns / divisor) << " ns\n";
        std::cout << "Pointwise multiply:     " << std::setw(10) << (pointwise_mult_ns / divisor) << " ns\n";
        std::cout << "DIT small loops:        " << std::setw(10) << (dit_small_loops_ns / divisor) << " ns\n";
        std::cout << "DIT nested loops:       " << std::setw(10) << (dit_nested_loop_ns / divisor) << " ns\n";
        
        long long total = root_precomp_ns + dif_nested_loop_ns + dif_small_loops_ns + 
                          pointwise_mult_ns + dit_small_loops_ns + dit_nested_loop_ns;
                          
        std::cout << "----------------------------------------\n";
        std::cout << "Total (Breakdown Sum):  " << std::setw(10) << (total / divisor) << " ns\n";
        std::cout << "========================================\n\n";
    }
};

TimingStats g_timing;

// ============================================================================
// Modular Arithmetic Helpers
// ============================================================================
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

// Compute Shoup's precomputed value: bp = (b << 32) / p
inline uint32_t shoup_precomp(uint32_t b) {
    return ((uint64_t)b << 32) / MOD;
}

// Scalar Shoup multiplication: a * b mod p using precomputed bp
inline uint32_t shoup_mul(uint32_t a, uint32_t b, uint32_t bp) {
    uint32_t q = ((uint64_t)a * bp) >> 32;
    int64_t r = (int64_t)a * b - (int64_t)q * MOD;
    return r < 0 ? r + MOD : (r >= MOD ? r - MOD : r);
}

// Vector helpers
// inline v8i _mm256_mulhi_epi32(v8i a, v8i b) {
//     v8i a_odd = _mm256_srli_epi64(a, 32);
//     v8i b_odd = _mm256_srli_epi64(b, 32);
//     v8i even = _mm256_mul_epu32(a, b);
//     v8i odd = _mm256_mul_epu32(a_odd, b_odd);
//     v8i even_high = _mm256_srli_epi64(even, 32);
//     return _mm256_blend_epi32(even_high, odd, 0xAA);
// }

// // Shoup's SIMD multiplication: a * b mod p using precomputed bp
// inline v8i _mm256_shoup_mul(v8i a, v8i b, v8i bp) {
//     v8i t = _mm256_mulhi_epi32(a, bp);
//     v8i p = _mm256_mullo_epi32(a, b);
//     v8i q = _mm256_mullo_epi32(t, v_mod);
//     return _mm256_sub_epi32(p, q);
// }

inline v8i mullo_distributed(v8i a, v8i b) {
    v8i at =  _mm256_srli_epi64(a, 32);
    v8i bt = _mm256_srli_epi64(b, 32);
    v8i even = _mm256_mul_epu32(a, b);
    v8i odd  = _mm256_mul_epu32(at, bt);
    return _mm256_blend_epi32(even, _mm256_slli_epi64(odd, 32), 0xAA);
}

// Optimized Shoup Mul: Distributes load across Port 0 and Port 1
inline v8i _mm256_shoup_mul(v8i a, v8i b, v8i bp) {
    // ----------------------------------------------------------------
    // 1. SPLIT: Separate Even (0,2,4,6) and Odd (1,3,5,7) lanes
    // ----------------------------------------------------------------
    // Move Odd elements to the lower 32-bits of the 64-bit lanes
    v8i a_odd  = _mm256_srli_epi64(a, 32);
    v8i b_odd  = _mm256_srli_epi64(b, 32);
    v8i bp_odd = _mm256_srli_epi64(bp, 32);

    // ----------------------------------------------------------------
    // 2. PROCESS EVENS (Uses Port 0 & 1)
    // ----------------------------------------------------------------
    // Shoup Formula: p = a*b; q = (a*bp)>>32 * mod; res = p - q
    v8i p_ev    = _mm256_mul_epu32(a, b);            // a * b
    v8i t_ev    = _mm256_mul_epu32(a, bp);           // a * bp
    v8i q_term  = _mm256_srli_epi64(t_ev, 32);       // (a * bp) >> 32
    v8i q_ev    = _mm256_mul_epu32(q_term, v_mod);   // q * mod
    v8i res_ev  = _mm256_sub_epi64(p_ev, q_ev);      // Result in low 32-bits

    // ----------------------------------------------------------------
    // 3. PROCESS ODDS (Uses Port 0 & 1)
    // ----------------------------------------------------------------
    v8i p_od    = _mm256_mul_epu32(a_odd, b_odd);
    v8i t_od    = _mm256_mul_epu32(a_odd, bp_odd);
    v8i q_term_od = _mm256_srli_epi64(t_od, 32);
    v8i q_od    = _mm256_mul_epu32(q_term_od, v_mod);
    v8i res_od  = _mm256_sub_epi64(p_od, q_od);

    // ----------------------------------------------------------------
    // 4. MERGE
    // ----------------------------------------------------------------
    // Move odd results back to high 32-bits
    v8i res_od_hi = _mm256_slli_epi64(res_od, 32);
    
    // Combine: Evens take low 32, Odds take high 32
    // 0xAA = 10101010 (Select B for indices 1,3,5,7)
    return _mm256_blend_epi32(res_ev, res_od_hi, 0xAA);
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
// Root Generation with Shoup precomputation
// ============================================================================

void reset_roots(uint32_t* roots, uint32_t* roots_p, uint32_t* inv_roots, uint32_t* inv_roots_p, int& root_size) {
    roots[0] = 1;
    roots_p[0] = shoup_precomp(1);
    inv_roots[0] = 1;
    inv_roots_p[0] = shoup_precomp(1);
    root_size = 1;
}

void get_root(uint32_t* roots, uint32_t* roots_p, uint32_t* inv_roots, uint32_t* inv_roots_p, int& root_size, int n) {
    auto start = std::chrono::high_resolution_clock::now();

    if (root_size < n) {
        int i = root_size;
        
        for (; i != n; i <<= 1) {
            uint32_t w = pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2));
            uint32_t iw = inv_mod(w);
            uint32_t w_p = shoup_precomp(w);
            uint32_t iw_p = shoup_precomp(iw);
            
            for (int j = 0; j < i; ++j) {
                roots[i + j] = shoup_mul(roots[j], w, w_p);
                roots_p[i + j] = shoup_precomp(roots[i + j]);
                inv_roots[i + j] = shoup_mul(inv_roots[j], iw, iw_p);
                inv_roots_p[i + j] = shoup_precomp(inv_roots[i + j]);
            }
        }
        root_size = n;
    }

    auto end = std::chrono::high_resolution_clock::now();
    g_timing.root_precomp_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
}

// ============================================================================
// DIF NTT using Shoup's algorithm
// ============================================================================
void dif_ntt(v8i *f, const int &n, const uint32_t* rt, const uint32_t* rt_p) {
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3; 
    
    // --- Start Nested Loop Timing ---
    auto start_nested = std::chrono::high_resolution_clock::now();

    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3; 
    int i; 
    
    if (num_stages & 1) {
        int h = n >> 1;
        int h8 = h >> 3;
        for (int j = 0, k = 0; j < n8; j += h8 << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
            const v8i v_rt_p = _mm256_set1_epi32(rt_p[k]);
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + h8;
            for (int p = 0; p < h8; ++p) {
                v8i v_q = f1[p];
                v8i v_u = f0[p];
                v8i v_v = _mm256_shoup_mul(v_q, v_rt, v_rt_p);
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
        for (int j = 0, k = 0; j < n8; j += i8 << 2, ++k) {
            const v8i v_w0 = _mm256_set1_epi32(rt[k]);
            const v8i v_w0_p = _mm256_set1_epi32(rt_p[k]);
            const v8i v_w1 = _mm256_set1_epi32(rt[(k << 1)]);
            const v8i v_w1_p = _mm256_set1_epi32(rt_p[(k << 1)]);
            const v8i v_w2 = _mm256_set1_epi32(rt[(k << 1) + 1]);
            const v8i v_w2_p = _mm256_set1_epi32(rt_p[(k << 1) + 1]);
            
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            v8i* __restrict f2 = f + j + i8 * 2;
            v8i* __restrict f3 = f + j + i8 * 3;
            
            for (int p = 0; p < i8; ++p) {
                if (i8 > 512) {
                   _mm_prefetch((const char*)(f0 + p + 32), _MM_HINT_T0);
                   _mm_prefetch((const char*)(f1 + p + 32), _MM_HINT_T0);
                   _mm_prefetch((const char*)(f2 + p + 32), _MM_HINT_T0);
                   _mm_prefetch((const char*)(f3 + p + 32), _MM_HINT_T0);
                }
                v8i a3 = f3[p];
                v8i a2 = f2[p];
                v8i a1 = f1[p];
                v8i a0 = f0[p];

                v8i w0_a3 = _mm256_shoup_mul(a3, v_w0, v_w0_p);
                v8i w0_a2 = _mm256_shoup_mul(a2, v_w0, v_w0_p);
                
                v8i t1 = _mm256_add_mod(a1, w0_a3);
                v8i t3 = _mm256_sub_mod(a1, w0_a3);
                
                v8i t0 = _mm256_add_mod(a0, w0_a2);
                v8i t2 = _mm256_sub_mod(a0, w0_a2);

                v8i w1_t1 = _mm256_shoup_mul(t1, v_w1, v_w1_p);
                v8i w2_t3 = _mm256_shoup_mul(t3, v_w2, v_w2_p);

                f0[p] = _mm256_add_mod(t0, w1_t1);
                f2[p] = _mm256_add_mod(t2, w2_t3);

                f1[p] = _mm256_sub_mod(t0, w1_t1);
                f3[p] = _mm256_sub_mod(t2, w2_t3);
            }
        }
    }
    auto end_nested = std::chrono::high_resolution_clock::now();
    g_timing.dif_nested_loop_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_nested - start_nested).count();
    
    // --- Start Small Loop Timing ---
    auto start_small = std::chrono::high_resolution_clock::now();

    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_set1_epi32(rt[k]);
        v8i v_rt_p = _mm256_set1_epi32(rt_p[k]);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_shoup_mul(v_q, v_rt, v_rt_p);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j << 1)))), perm_i2);
        v8i v_rt_p = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt_p + (j << 1)))), perm_i2);
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v_shoup = _mm256_shoup_mul(v_v, v_rt, v_rt_p);
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_shoup), _mm256_sub_mod(v_u, v_v_shoup));
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + (j << 2)))), perm_i1);
        v8i v_rt_p = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt_p + (j << 2)))), perm_i1);
        v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shoup_mul(v_q, v_rt, v_rt_p);
        v8i v_nq = _mm256_sub_mod(v_u, v_v);
        v8i v_np = _mm256_add_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
    
    auto end_small = std::chrono::high_resolution_clock::now();
    g_timing.dif_small_loops_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_small - start_small).count();
}

// ============================================================================
// DIT NTT using Shoup's algorithm
// ============================================================================
void dit_ntt(v8i *f, const int &n, const uint32_t* irt, const uint32_t* irt_p) {
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3; 
    
    // --- Start Small Loop Timing ---
    auto start_small = std::chrono::high_resolution_clock::now();

    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + (j << 2)))), perm_i1);
        v8i v_irt_p = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt_p + (j << 2)))), perm_i1);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_diff = _mm256_shoup_mul(_mm256_sub_mod(v_u, v_v), v_irt, v_irt_p);
        v8i v_sum = _mm256_add_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_sum, _mm256_shuffle_epi32(v_diff, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + (j << 1)))), perm_i2);
        v8i v_irt_p = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt_p + (j << 1)))), perm_i2);
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v), _mm256_shoup_mul(_mm256_sub_mod(v_u, v_v), v_irt, v_irt_p));
    }
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_f = f[j];
        v8i v_irt = _mm256_set1_epi32(irt[k]);
        v8i v_irt_p = _mm256_set1_epi32(irt_p[k]);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_shoup_mul(_mm256_sub_mod(v_u, v_v), v_irt, v_irt_p), 0x20);
    }
    
    auto end_small = std::chrono::high_resolution_clock::now();
    g_timing.dit_small_loops_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_small - start_small).count();
    // --- End Small Loop Timing ---

    // --- Start Nested Loop Timing ---
    auto start_nested = std::chrono::high_resolution_clock::now();

    int log_n = 31 - __builtin_clz(n);
    int num_outer_stages = log_n - 3; 
    
    int i = 8;
    for (; i << 2 <= n; i <<= 2) {
        int i8 = i >> 3; 
        for (int j = 0, k = 0; j < n8; j += i8 << 2, ++k) {
            const v8i v_iw0 = _mm256_set1_epi32(irt[k]);
            const v8i v_iw0_p = _mm256_set1_epi32(irt_p[k]);
            const v8i v_iw1 = _mm256_set1_epi32(irt[k << 1]);
            const v8i v_iw1_p = _mm256_set1_epi32(irt_p[k << 1]);
            const v8i v_iw2 = _mm256_set1_epi32(irt[(k << 1) + 1]);
            const v8i v_iw2_p = _mm256_set1_epi32(irt_p[(k << 1) + 1]);
            
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            v8i* __restrict f2 = f + j + i8 * 2;
            v8i* __restrict f3 = f + j + i8 * 3;
            
            for (int p = 0; p < i8; ++p) {
                v8i a0 = f0[p];
                v8i a1 = f1[p];
                v8i a2 = f2[p];
                v8i a3 = f3[p];
                
                v8i s1 = _mm256_sub_mod(a0, a1);
                v8i s2 = _mm256_sub_mod(a2, a3);

                v8i t1 = _mm256_shoup_mul(s1, v_iw1, v_iw1_p);
                v8i t3 = _mm256_shoup_mul(s2, v_iw2, v_iw2_p);
                
                v8i t0 = _mm256_add_mod(a0, a1);
                v8i t2 = _mm256_add_mod(a2, a3);
                
                v8i p1 = _mm256_sub_mod(t0, t2);
                v8i p2 = _mm256_sub_mod(t1, t3);

                v8i r0 = _mm256_add_mod(t0, t2);
                v8i r1 = _mm256_add_mod(t1, t3);
                
                f2[p] = _mm256_shoup_mul(p1, v_iw0, v_iw0_p);
                f3[p] = _mm256_shoup_mul(p2, v_iw0, v_iw0_p);
                f0[p] = r0;       
                f1[p] = r1;           
            }
        }
    }
    
    if ((num_outer_stages & 1) && i <= (n >> 1)) {
        int i8 = i >> 3;
        for (int j = 0, k = 0; j < n8; j += i8 << 1, ++k) {
            const v8i v_irt = _mm256_set1_epi32(irt[k]);
            const v8i v_irt_p = _mm256_set1_epi32(irt_p[k]);
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            for (int p = 0; p < i8; ++p) {
                v8i v_u = f0[p];
                v8i v_v = f1[p];
                f0[p] = _mm256_add_mod(v_u, v_v);
                f1[p] = _mm256_shoup_mul(_mm256_sub_mod(v_u, v_v), v_irt, v_irt_p);
            }
        }
    }
    
    // Multiply by inv_n using Shoup's
    uint32_t inv_n = inv_mod(n);
    uint32_t inv_n_p = shoup_precomp(inv_n);
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    v8i v_inv_n_p = _mm256_set1_epi32(inv_n_p);
    for (int i = 0; i < n8; ++i) {
        f[i] = _mm256_mod(_mm256_shoup_mul(f[i], v_inv_n, v_inv_n_p));
    }

    auto end_nested = std::chrono::high_resolution_clock::now();
    g_timing.dit_nested_loop_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_nested - start_nested).count();
}

// Helper to access v8i array as uint32_t
inline uint32_t get_elem(const v8i* arr, int idx) {
    alignas(32) uint32_t tmp[8];
    _mm256_store_si256((v8i*)tmp, arr[idx >> 3]);
    return tmp[idx & 7];
}

inline void set_elem(v8i* arr, int idx, uint32_t val) {
    alignas(32) uint32_t tmp[8];
    _mm256_store_si256((v8i*)tmp, arr[idx >> 3]);
    tmp[idx & 7] = val;
    arr[idx >> 3] = _mm256_load_si256((v8i*)tmp);
}

void run_test_logic(int L, v8i* A, v8i* B, uint32_t* roots, uint32_t* roots_p, 
                    uint32_t* inv_roots, uint32_t* inv_roots_p, int& root_size) {
    int L8 = L >> 3;
    get_root(roots, roots_p, inv_roots, inv_roots_p, root_size, L);
    dif_ntt(A, L, roots, roots_p);
    dif_ntt(B, L, roots, roots_p);

    auto start_pw = std::chrono::high_resolution_clock::now();
    // Scalar pointwise multiplication
    for (int i = 0; i < L; ++i) {
        uint32_t a_val = get_elem(A, i);
        uint32_t b_val = get_elem(B, i);
        uint32_t prod = (uint64_t)a_val * b_val % MOD;
        set_elem(A, i, prod);
    }
    __asm__ __volatile__("" : : "r,m"(A[0]) : "memory");
    auto end_pw = std::chrono::high_resolution_clock::now();
    g_timing.pointwise_mult_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_pw - start_pw).count();

    dit_ntt(A, L, inv_roots, inv_roots_p);
}

// ============================================================================
// KACTL NTT for correctness testing
// ============================================================================
namespace KACTL {
    typedef long long ll;
    typedef std::vector<ll> vll;
    
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
    
    void ntt(vll &a) {
        int n = a.size(), L = 31 - __builtin_clz(n);
        static vll rt(2, 1);
        for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
            rt.resize(n);
            ll z = modpow(root, mod >> s);
            for (int i = k; i < 2*k; ++i) 
                rt[i] = rt[i/2] * ((i&1) ? z : 1) % mod;
        }
        vll rev(n);
        for (int i = 0; i < n; ++i) 
            rev[i] = (rev[i/2] | ((i&1) << L)) / 2;
        for (int i = 0; i < n; ++i) 
            if (i < rev[i]) std::swap(a[i], a[rev[i]]);
        for (int k = 1; k < n; k *= 2)
            for (int i = 0; i < n; i += 2*k) {
                for (int j = 0; j < k; ++j) {
                    ll z = rt[j+k] * a[i+j+k] % mod;
                    ll &ai = a[i+j];
                    a[i+j+k] = ai - z + (z > ai ? mod : 0);
                    ai += (ai + z >= mod ? z - mod : z);
                }
            }
    }
    
    vll cyclic_conv(const vll &a, const vll &b, int L) {
        vll A(a), B(b);
        A.resize(L); B.resize(L);
        ntt(A); ntt(B);
        for (int i = 0; i < L; ++i)
            A[i] = (ll)A[i] * B[i] % mod;
        std::reverse(A.begin() + 1, A.end());
        ntt(A);
        ll inv = modpow(L, mod - 2);
        for (int i = 0; i < L; ++i)
            A[i] = A[i] * inv % mod;
        return A;
    }
}

void run_correctness_tests(v8i* A, v8i* B, uint32_t* roots, uint32_t* roots_p,
                           uint32_t* inv_roots, uint32_t* inv_roots_p, int& root_size) {
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
        
        std::vector<long long> a_ll(poly_a.begin(), poly_a.end());
        std::vector<long long> b_ll(poly_b.begin(), poly_b.end());
        std::vector<long long> expected = KACTL::cyclic_conv(a_ll, b_ll, L);
        
        std::memset(A, 0, maxn8 * sizeof(v8i));
        std::memset(B, 0, maxn8 * sizeof(v8i));
        std::memcpy(A, poly_a.data(), L * sizeof(uint32_t));
        std::memcpy(B, poly_b.data(), L * sizeof(uint32_t));
        
        reset_roots(roots, roots_p, inv_roots, inv_roots_p, root_size);
        g_timing.reset();
        run_test_logic(L, A, B, roots, roots_p, inv_roots, inv_roots_p, root_size);
        
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
    std::cout << "--------------------------------------------------------\n";
}

void run_benchmark(v8i* A, v8i* B, v8i* A_bak, v8i* B_bak, 
                   uint32_t* roots, uint32_t* roots_p,
                   uint32_t* inv_roots, uint32_t* inv_roots_p, int& root_size) {
    std::cout << "Profiling Algorithm Speed (Average of 20 runs)\n";
    std::cout << "--------------------------------------------------------\n";
    std::cout << "| " << std::setw(12) << "Size (n)" 
              << " | " << std::setw(20) << "Avg Time (us)" 
              << " | " << std::setw(15) << "Avg Time (ms)" << " |\n";
    std::cout << "|--------------|----------------------|-----------------|\n";

    std::mt19937 rng(42);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);

    const int iterations = 20;

    for (int k = 16; k <= 22; ++k) {
        int L = 1 << k;
        int L8 = L >> 3;

        alignas(32) uint32_t tmp_a[8], tmp_b[8];
        for(int i = 0; i < L8; ++i) {
            for(int j = 0; j < 8; ++j) {
                tmp_a[j] = dist(rng);
                tmp_b[j] = dist(rng);
            }
            A_bak[i] = _mm256_load_si256((v8i*)tmp_a);
            B_bak[i] = _mm256_load_si256((v8i*)tmp_b);
        }

        // Warmup 
        for (int w = 0; w < 2; ++w) {
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));
            reset_roots(roots, roots_p, inv_roots, inv_roots_p, root_size);
            g_timing.reset();
            run_test_logic(L, A, B, roots, roots_p, inv_roots, inv_roots_p, root_size);
        }

        long long total_us = 0;
        g_timing.reset();

        for (int iter = 0; iter < iterations; ++iter) {
            reset_roots(roots, roots_p, inv_roots, inv_roots_p, root_size);
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));

            auto start = std::chrono::high_resolution_clock::now();
            run_test_logic(L, A, B, roots, roots_p, inv_roots, inv_roots_p, root_size);
            auto end = std::chrono::high_resolution_clock::now();
            
            total_us += std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
        }

        double avg_us = (double)total_us / iterations;
        double avg_ms = avg_us / 1000.0;

        std::cout << "| 2^" << std::setw(9) << std::left << k 
                  << " | " << std::setw(20) << std::right << std::fixed << std::setprecision(0) << avg_us 
                  << " | " << std::setw(15) << std::fixed << std::setprecision(3) << avg_ms << " |\n";
        
        if (k == 20) {
            g_timing.print("2^" + std::to_string(k), iterations);
        }
    }
    std::cout << "--------------------------------------------------------\n";
}

int main() {
    // ------------------------------------------------------------------------
    // HEAP ALLOCATION
    // ------------------------------------------------------------------------
    v8i* A = (v8i*)aligned_alloc(32, maxn8 * sizeof(v8i));
    v8i* B = (v8i*)aligned_alloc(32, maxn8 * sizeof(v8i));
    v8i* A_bak = (v8i*)aligned_alloc(32, maxn8 * sizeof(v8i));
    v8i* B_bak = (v8i*)aligned_alloc(32, maxn8 * sizeof(v8i));

    uint32_t* roots = (uint32_t*)aligned_alloc(32, maxn * sizeof(uint32_t));
    uint32_t* roots_p = (uint32_t*)aligned_alloc(32, maxn * sizeof(uint32_t));
    uint32_t* inv_roots = (uint32_t*)aligned_alloc(32, maxn * sizeof(uint32_t));
    uint32_t* inv_roots_p = (uint32_t*)aligned_alloc(32, maxn * sizeof(uint32_t));
    int root_size = 0;

    reset_roots(roots, roots_p, inv_roots, inv_roots_p, root_size);
    
    // Pass pointers to heap arrays down to functions
    run_correctness_tests(A, B, roots, roots_p, inv_roots, inv_roots_p, root_size);
    run_benchmark(A, B, A_bak, B_bak, roots, roots_p, inv_roots, inv_roots_p, root_size);
    
    free(A); free(B); free(A_bak); free(B_bak);
    free(roots); free(roots_p); free(inv_roots); free(inv_roots_p);
    
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
Profiling Algorithm Speed (Average of 20 runs)
--------------------------------------------------------
|     Size (n) |        Avg Time (us) |   Avg Time (ms) |
|--------------|----------------------|-----------------|
| 2^16        |                 1573 |           1.573 |
| 2^17        |                 3194 |           3.194 |
| 2^18        |                 6501 |           6.501 |
| 2^19        |                13229 |          13.229 |
| 2^20        |                26795 |          26.795 |

=== Timing Breakdown: 2^20 (Average of 20 runs) ===
Root precomputation:       2723214 ns
DIF nested loops:          5129198 ns
DIF small loops:           2138693 ns
Pointwise multiply:       13242708 ns
DIT small loops:           1025410 ns
DIT nested loops:          2535521 ns
----------------------------------------
Total (Breakdown Sum):    26794745 ns
========================================

| 2^21        |                55120 |          55.120 |
| 2^22        |               115788 |         115.788 |
--------------------------------------------------------

diagnose: Shorup 2 times faster, but only on port 0. 
*/