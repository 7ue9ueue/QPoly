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
    return reduce(x0246, x1357);
}


/*
find bp.

uint64_t mul_brt_prep(const uint64_t b, const uint64_t p){
  return ((unsigned __int128)b << 64U) / p;
}

inline uint64_t mul_brt_fixed(const uint64_t a, const uint64_t b, const uint64_t bp, const uint64_t p){
  uint128_t t;
  uint64_t r;
  t = mul128(a, bp);
  r = a * b - t.d64[1] * p;
  return r;
}
*/
inline v8i _mm256_mulhi_epi32(v8i a, v8i b) {
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i even = _mm256_mul_epu32(a, b);
    v8i odd = _mm256_mul_epu32(a_odd, b_odd);
    v8i even_high = _mm256_srli_epi64(even, 32);
    return _mm256_blend_epi32(even_high, odd, 0xAA);
}
inline v8i _mm258_shoup_mul(v8i a, v8i b, v8i bp) {
    v8i t = _mm256_mulhi_epi32(a, bp);
    v8i p = _mm256_mullo_epi32(a, b);
    v8i q = _mm256_mullo_epi32(t, v_mod);
    return _mm256_sub_epi32(p, q);
}

inline v8i _mm256_mont_mul_pointwise(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i b_sh = _mm256_bsrli_epi128(b, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b_sh);
    return reduce(x0246, x1357);
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
    auto start = std::chrono::high_resolution_clock::now();

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
                for (int j = 0; j < i; j += 8) {
                    v8i v_root = _mm256_loadu_si256((v8i*)(root_ptr + j));
                    v8i v_inv_root = _mm256_loadu_si256((v8i*)(inv_root_ptr + j));
                    
                    v8i new_root = _mm256_mont_mul(v_root, v_w);
                    v8i new_inv_root = _mm256_mont_mul(v_inv_root, v_iw);
                    
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

    auto end = std::chrono::high_resolution_clock::now();
    g_timing.root_precomp_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
}

// ============================================================================
// DIF NTT (Modified to accept roots pointer)
// ============================================================================
void dif_ntt(v8i *f, const int &n, const uint32_t* rt) {
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
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + h8;
            for (int p = 0; p < h8; ++p) {
                v8i v_q = f1[p];
                v8i v_u = f0[p];
                v8i v_v = _mm256_mont_mul(v_q, v_rt);
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
            const v8i v_w1 = _mm256_set1_epi32(rt[(k << 1)]);
            const v8i v_w2 = _mm256_set1_epi32(rt[(k << 1) + 1]);
            
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            v8i* __restrict f2 = f + j + i8 * 2;
            v8i* __restrict f3 = f + j + i8 * 3;
            
            for (int p = 0; p < i8; ++p) {
                v8i a3 = f3[p];
                v8i a2 = f2[p];
                v8i a1 = f1[p];
                v8i a0 = f0[p];

                v8i w0_a3 = _mm256_mont_mul(a3, v_w0);
                v8i w0_a2 = _mm256_mont_mul(a2, v_w0);
                
                v8i t1 = _mm256_add_mod(a1, w0_a3);
                v8i t3 = _mm256_sub_mod(a1, w0_a3);
                
                v8i t0 = _mm256_add_mod(a0, w0_a2);
                v8i t2 = _mm256_sub_mod(a0, w0_a2);

                v8i w1_t1 = _mm256_mont_mul(t1, v_w1);
                v8i w2_t3 = _mm256_mont_mul(t3, v_w2);

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
    
    auto end_small = std::chrono::high_resolution_clock::now();
    g_timing.dif_small_loops_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_small - start_small).count();
}

// ============================================================================
// DIT NTT (Modified to accept inv_roots pointer)
// ============================================================================
void dit_ntt(v8i *f, const int &n, const uint32_t* irt) {
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3; 
    
    // --- Start Small Loop Timing ---
    auto start_small = std::chrono::high_resolution_clock::now();

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
            const v8i v_iw1 = _mm256_set1_epi32(irt[k << 1]);
            const v8i v_iw2 = _mm256_set1_epi32(irt[(k << 1) + 1]);
            
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

                v8i t1 = _mm256_mont_mul(s1, v_iw1);
                v8i t3 = _mm256_mont_mul(s2, v_iw2);
                
                v8i t0 = _mm256_add_mod(a0, a1);
                v8i t2 = _mm256_add_mod(a2, a3);
                
                v8i p1 = _mm256_sub_mod(t0, t2);
                v8i p2 = _mm256_sub_mod(t1, t3);

                v8i r0 = _mm256_add_mod(t0, t2);
                v8i r1 = _mm256_add_mod(t1, t3);
                
                f2[p] = _mm256_mont_mul(p1, v_iw0);
                f3[p] = _mm256_mont_mul(p2, v_iw0);
                f0[p] = r0;       
                f1[p] = r1;           

            }
        }
    }
    
    if ((num_outer_stages & 1) && i <= (n >> 1)) {
        int i8 = i >> 3;
        for (int j = 0, k = 0; j < n8; j += i8 << 1, ++k) {
            const v8i v_irt = _mm256_set1_epi32(irt[k]);
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            for (int p = 0; p < i8; ++p) {
                v8i v_u = f0[p];
                v8i v_v = f1[p];
                f0[p] = _mm256_add_mod(v_u, v_v);
                f1[p] = _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt);
            }
        }
    }
    
    uint32_t inv_n = to_mont(to_mont(inv_mod(n)));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    for (int i = 0; i < n8; ++i) {
        f[i] = _mm256_mod(_mm256_mont_mul(f[i], v_inv_n));
    }

    auto end_nested = std::chrono::high_resolution_clock::now();
    g_timing.dit_nested_loop_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_nested - start_nested).count();
}

void run_test_logic(int L, v8i* A, v8i* B, uint32_t* roots, uint32_t* inv_roots, int& root_size) {
    int L8 = L >> 3;
    get_root_mont(roots, inv_roots, root_size, L);
    dif_ntt(A, L, roots);
    dif_ntt(B, L, roots);

    auto start_pw = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < L8; ++i) {
        A[i] = _mm256_mont_mul_pointwise(A[i], B[i]);
    }
    __asm__ __volatile__("" : : "r,m"(A[0]) : "memory");
    auto end_pw = std::chrono::high_resolution_clock::now();
    g_timing.pointwise_mult_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_pw - start_pw).count();

    dit_ntt(A, L, inv_roots);
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

// Helper to access v8i array as uint32_t
inline uint32_t get_elem(const v8i* arr, int idx) {
    alignas(32) uint32_t tmp[8];
    _mm256_store_si256((v8i*)tmp, arr[idx >> 3]);
    return tmp[idx & 7];
}

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
        
        std::vector<long long> a_ll(poly_a.begin(), poly_a.end());
        std::vector<long long> b_ll(poly_b.begin(), poly_b.end());
        std::vector<long long> expected = KACTL::cyclic_conv(a_ll, b_ll, L);
        
        std::memset(A, 0, maxn8 * sizeof(v8i));
        std::memset(B, 0, maxn8 * sizeof(v8i));
        std::memcpy(A, poly_a.data(), L * sizeof(uint32_t));
        std::memcpy(B, poly_b.data(), L * sizeof(uint32_t));
        
        reset_roots(roots, inv_roots, root_size);
        g_timing.reset();
        run_test_logic(L, A, B, roots, inv_roots, root_size);
        
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

void run_benchmark(v8i* A, v8i* B, v8i* A_bak, v8i* B_bak, uint32_t* roots, uint32_t* inv_roots, int& root_size) {
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
            reset_roots(roots, inv_roots, root_size);
            g_timing.reset();
            run_test_logic(L, A, B, roots, inv_roots, root_size);
        }

        long long total_us = 0;
        g_timing.reset();

        for (int iter = 0; iter < iterations; ++iter) {
            reset_roots(roots, inv_roots, root_size);
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));

            auto start = std::chrono::high_resolution_clock::now();
            run_test_logic(L, A, B, roots, inv_roots, root_size);
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
    // STACK ALLOCATION
    // NOTE: This totals ~96MB. You MUST increase stack size (ulimit -s) or 
    // this will segfault.
    // ------------------------------------------------------------------------
    alignas(32) v8i A[maxn8];
    alignas(32) v8i B[maxn8];
    alignas(32) v8i A_bak[maxn8];
    alignas(32) v8i B_bak[maxn8];

    alignas(32) uint32_t roots[maxn];
    alignas(32) uint32_t inv_roots[maxn];
    int root_size = 0;

    reset_roots(roots, inv_roots, root_size);
    
    // Pass pointers to stack arrays down to functions
    run_correctness_tests(A, B, roots, inv_roots, root_size);
    run_benchmark(A, B, A_bak, B_bak, roots, inv_roots, root_size);
    
    return 0;
}