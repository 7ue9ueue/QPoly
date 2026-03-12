#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2")
#include <immintrin.h>
#include <cstdint>
#include <cstring>
#include <iostream>
#include <chrono>
#include <iomanip>
#include <random>

using u32 = uint32_t;
using u64 = uint64_t;
typedef __m256i v8i;

// ============================================================================
// Constants
// ============================================================================
constexpr uint32_t MOD = 998244353;
constexpr uint32_t WMOD = 1996488706;
constexpr uint32_t M_INV = 998244351;
constexpr uint32_t PRIM_ROOT = 3;
constexpr uint32_t R2_MOD = 932051910;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_m = _mm256_set1_epi32(M_INV);

constexpr int N = 1 << 20;
constexpr int N8 = N >> 3;

// ============================================================================
// Helper Functions
// ============================================================================
uint32_t pow_mod(uint32_t base, uint32_t exp) {
    uint32_t result = 1;
    while (exp > 0) {
        if (exp & 1) result = (uint64_t)result * base % MOD;
        base = (uint64_t)base * base % MOD;
        exp >>= 1;
    }
    return result;
}

inline uint32_t mont_mul(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint64_t m = (uint64_t)((uint32_t)t * M_INV) * MOD;
    uint32_t r = (t + m) >> 32;
    return r >= MOD ? r - MOD : r;
}

inline uint32_t to_mont(uint32_t x) { return mont_mul(x, R2_MOD); }

inline v8i lmove(v8i x) { return _mm256_bsrli_epi128(x, 4); }

// Montgomery multiplication
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

// port 0 latency: 30
inline v8i _mm256_mont_mul(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b);
    v8i x0246_ninv = _mm256_mul_epu32(x0246, v_m);
    v8i x1357_ninv = _mm256_mul_epu32(x1357, v_m);
    v8i x0246_res = _mm256_add_epi64(x0246, _mm256_mul_epu32(x0246_ninv, v_mod));
    v8i x1357_res = _mm256_add_epi64(x1357, _mm256_mul_epu32(x1357_ninv, v_mod));
    return _mm256_or_si256(_mm256_bsrli_epi128(x0246_res, 4), x1357_res);
}

// Shoup's multiplication helper
// port 0 latency: 10
inline v8i _mm256_mulhi_epi32(v8i a, v8i b) {
    v8i a_odd = _mm256_bsrli_epi128(a, 4);
    v8i b_odd = _mm256_bsrli_epi128(b, 4);
    v8i even = _mm256_mul_epu32(a, b);
    v8i odd = _mm256_mul_epu32(a_odd, b_odd);
    v8i even_high = _mm256_bsrli_epi128(even, 4);
    return _mm256_blend_epi32(even_high, odd, 0xAA);
}

// Shoup's multiplication
// port 0 latency: 30
inline v8i _mm256_shoup_mul(v8i a, v8i b, v8i bp) {
    v8i p = _mm256_mullo_epi32(a, b);
    v8i t = _mm256_mulhi_epi32(a, bp);
    v8i q = _mm256_mullo_epi32(t, v_mod);
    return _mm256_sub_epi32(p, q);
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
// Root Generation
// ============================================================================
void generate_roots(uint32_t* roots, int n) {
    roots[0] = to_mont(1);
    int root_size = 1;
    
    for (int i = 1; i < n; i <<= 1) {
        uint32_t pm = pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2));
        uint32_t w = to_mont(pm);
        
        if (i >= 8) {
            v8i v_w = _mm256_set1_epi32(w);
            v8i v_w_rt = _mm256_set1_epi32(w * M_INV);
            for (int j = 0; j < i; j += 8) {
                v8i v_root = _mm256_loadu_si256((v8i*)(roots + j));
                v8i new_root = _mm256_mont_mul_fixed(v_root, v_w, v_w_rt);
                _mm256_storeu_si256((v8i*)(roots + i + j), new_root);
            }
        } else {
            for (int j = 0; j < i; ++j) {
                roots[i + j] = mont_mul(roots[j], w);
            }
        }
    }
}

// Precompute bp values for Shoup multiplication
void precompute_bp(const uint32_t* roots, uint32_t* bp, int n) {
    for (int i = 0; i < n; ++i) {
        // bp[i] = floor(2^32 * roots[i] / MOD)
        bp[i] = ((uint64_t)roots[i] << 32) / MOD;
    }
}

// ============================================================================
// DIF NTT with Montgomery Multiplication
// ============================================================================
void dif_ntt_mont(v8i *f, const uint32_t* rt) {    
    const int n = N;
    const int n8 = N8;
    
    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3;
    int i;
    
    if (num_stages & 1) {
        int h = n >> 1;
        int h8 = h >> 3;
        for (int j = 0, k = 0; j < n8; j += h8 << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
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
// DIF NTT with Shoup Multiplication
// ============================================================================
void dif_ntt_shoup(v8i *f, const uint32_t* rt, const uint32_t* bp) {    
    const int n = N;
    const int n8 = N8;
    
    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3;
    int i;
    
    if (num_stages & 1) {
        int h = n >> 1;
        int h8 = h >> 3;
        for (int j = 0, k = 0; j < n8; j += h8 << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
            const v8i v_bp = _mm256_set1_epi32(bp[k]);
            v8i* f0 = f + j;
            v8i* f1 = f + j + h8;
            for (int p = 0; p < h8; ++p) {
                v8i v_q = f1[p];
                v8i v_u = f0[p];
                v8i v_v = _mm256_shoup_mul(v_q, v_rt, v_bp);
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
            auto xp = bp[k];
            auto yp = bp[(k << 1)];
            auto zp = bp[(k << 1) + 1];
            
            v8i v_w0 = _mm256_set1_epi32(x);
            v8i v_w0p = _mm256_set1_epi32(xp);
            v8i v_w1 = _mm256_set1_epi32(y);
            v8i v_w1p = _mm256_set1_epi32(yp);
            v8i v_w2 = _mm256_set1_epi32(z);
            v8i v_w2p = _mm256_set1_epi32(zp);

            for (int p = 0; p < i8; ++p) {
                v8i a3 = f3[p];
                v8i a2 = f2[p];
                v8i a1 = f1[p];
                v8i a0 = f0[p];

                v8i w0_a3 = _mm256_shoup_mul(a3, v_w0, v_w0p);
                v8i w0_a2 = _mm256_shoup_mul(a2, v_w0, v_w0p);
                
                v8i t1 = _mm256_add_mod(a1, w0_a3);
                v8i t3 = _mm256_sub_mod(a1, w0_a3);
                v8i t0 = _mm256_add_mod(a0, w0_a2);
                v8i t2 = _mm256_sub_mod(a0, w0_a2);

                v8i w1_t1 = _mm256_shoup_mul(t1, v_w1, v_w1p);
                v8i w2_t3 = _mm256_shoup_mul(t3, v_w2, v_w2p);

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
    
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);

    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_set1_epi32(rt[k]);
        v8i v_bp = _mm256_set1_epi32(bp[k]);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_shoup_mul(v_q, v_rt, v_bp);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j << 1)))), perm_i2);
        v8i v_bp = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(bp + (j << 1)))), perm_i2);
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v_shoup = _mm256_shoup_mul(v_v, v_rt, v_bp);
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_shoup), _mm256_sub_mod(v_u, v_v_shoup));
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_f = f[j];
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + (j << 2)))), perm_i1);
        v8i v_bp = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(bp + (j << 2)))), perm_i1);
        v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shoup_mul(v_q, v_rt, v_bp);
        v8i v_nq = _mm256_sub_mod(v_u, v_v);
        v8i v_np = _mm256_add_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
}

// ============================================================================
// Main Test
// ============================================================================
int main() {
    std::cout << "DIF NTT Speed Test for n=2^20 (" << N << ")\n";
    std::cout << "===========================================\n\n";
    
    // Allocate aligned memory on heap
    v8i* A_mont = (v8i*)aligned_alloc(32, N8 * sizeof(v8i));
    v8i* A_shoup = (v8i*)aligned_alloc(32, N8 * sizeof(v8i));
    v8i* A_backup = (v8i*)aligned_alloc(32, N8 * sizeof(v8i));
    uint32_t* roots = (uint32_t*)aligned_alloc(32, N * sizeof(uint32_t));
    uint32_t* bp = (uint32_t*)aligned_alloc(32, N * sizeof(uint32_t));
    
    // Generate random input
    std::mt19937 rng(42);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    
    alignas(32) uint32_t tmp[8];
    for (int i = 0; i < N8; ++i) {
        for (int j = 0; j < 8; ++j) {
            tmp[j] = dist(rng);
        }
        A_backup[i] = _mm256_load_si256((v8i*)tmp);
    }
    
    // Generate roots and precompute bp
    std::cout << "Generating roots and precomputing Shoup parameters...\n";
    generate_roots(roots, N);
    precompute_bp(roots, bp, N);
    std::cout << "Done.\n\n";
    
    const int warmup_runs = 5;
    const int test_runs = 50;
    
    // ========== Test Montgomery Multiplication ==========
    std::cout << "Testing Montgomery Multiplication:\n";
    std::cout << "-------------------------------------------\n";
    
    // Warmup
    for (int i = 0; i < warmup_runs; ++i) {
        std::memcpy(A_mont, A_backup, N8 * sizeof(v8i));
        dif_ntt_mont(A_mont, roots);
        __asm__ __volatile__("" : : "r,m"(A_mont[0]) : "memory");
    }
    
    // Actual timing
    long long total_ns_mont = 0;
    for (int i = 0; i < test_runs; ++i) {
        std::memcpy(A_mont, A_backup, N8 * sizeof(v8i));
        
        auto start = std::chrono::high_resolution_clock::now();
        dif_ntt_mont(A_mont, roots);
        __asm__ __volatile__("" : : "r,m"(A_mont[0]) : "memory");
        auto end = std::chrono::high_resolution_clock::now();
        
        total_ns_mont += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    }
    
    double avg_us_mont = (double)total_ns_mont / test_runs / 1000.0;
    std::cout << "Average time over " << test_runs << " runs: " 
              << std::fixed << std::setprecision(2) << avg_us_mont << " us\n\n";
    
    // ========== Test Shoup Multiplication ==========
    std::cout << "Testing Shoup Multiplication:\n";
    std::cout << "-------------------------------------------\n";
    
    // Warmup
    for (int i = 0; i < warmup_runs; ++i) {
        std::memcpy(A_shoup, A_backup, N8 * sizeof(v8i));
        dif_ntt_shoup(A_shoup, roots, bp);
        __asm__ __volatile__("" : : "r,m"(A_shoup[0]) : "memory");
    }
    
    // Actual timing
    long long total_ns_shoup = 0;
    for (int i = 0; i < test_runs; ++i) {
        std::memcpy(A_shoup, A_backup, N8 * sizeof(v8i));
        
        auto start = std::chrono::high_resolution_clock::now();
        dif_ntt_shoup(A_shoup, roots, bp);
        __asm__ __volatile__("" : : "r,m"(A_shoup[0]) : "memory");
        auto end = std::chrono::high_resolution_clock::now();
        
        total_ns_shoup += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    }
    
    double avg_us_shoup = (double)total_ns_shoup / test_runs / 1000.0;
    std::cout << "Average time over " << test_runs << " runs: " 
              << std::fixed << std::setprecision(2) << avg_us_shoup << " us\n\n";
    
    // ========== Comparison ==========
    std::cout << "===========================================\n";
    std::cout << "Comparison:\n";
    std::cout << "-------------------------------------------\n";
    std::cout << "Montgomery: " << avg_us_mont << " us\n";
    std::cout << "Shoup:      " << avg_us_shoup << " us\n";
    std::cout << "Speedup:    " << std::setprecision(3) << (avg_us_mont / avg_us_shoup) << "x\n";
    std::cout << "===========================================\n";
    
    // Cleanup
    free(A_mont);
    free(A_shoup);
    free(A_backup);
    free(roots);
    free(bp);
    
    return 0;
}
/*
DIF NTT Speed Test for n=2^20 (1048576)
===========================================

Generating roots and precomputing Shoup parameters...
Done.

Testing Montgomery Multiplication:
-------------------------------------------
Average time over 50 runs: 3107.33 us

Testing Shoup Multiplication:
-------------------------------------------
Average time over 50 runs: 3312.16 us

===========================================
Comparison:
-------------------------------------------
Montgomery: 3107.33 us
Shoup:      3312.16 us
Speedup:    0.938x
===========================================

*/