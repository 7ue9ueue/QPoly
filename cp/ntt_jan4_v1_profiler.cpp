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

const uint32_t MOD = 998244353;
const uint32_t WMOD = 1996488706;
const uint32_t R2_MOD = 932051910;
const uint32_t M_INV = 998244351;
const uint32_t PRIM_ROOT = 3;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_m = _mm256_set1_epi32(M_INV);
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);
const v8i v_one = _mm256_set1_epi32(1);
const v8i v_zero = _mm256_setzero_si256();

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
inline uint32_t mont_mul(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint64_t m = (uint64_t)((uint32_t)t * M_INV) * MOD;
    uint32_t r = (t + m) >> 32;
    return r >= MOD ? r - MOD : r;
}

inline uint32_t to_mont(uint32_t x) { return mont_mul(x, R2_MOD); }
inline uint32_t from_mont(uint32_t x) { return mont_mul(x, 1); }

uint32_t pow_mod(uint32_t base, uint32_t exp) {
    uint32_t result = to_mont(1);
    base = to_mont(base);
    while (exp > 0) {
        if (exp & 1) result = mont_mul(result, base);
        base = mont_mul(base, base);
        exp >>= 1;
    }
    return from_mont(result);
}

uint32_t inv_mod(uint32_t x) { return pow_mod(x, MOD - 2); }

v8i reduce(v8i x0246, v8i x1357) {
    v8i x0246_ninv = _mm256_mul_epu32(x0246, v_m);
    v8i x1357_ninv = _mm256_mul_epu32(x1357, v_m);
    v8i x0246_res = _mm256_add_epi64(x0246, _mm256_mul_epu32(x0246_ninv, v_mod));
    v8i x1357_res = _mm256_add_epi64(x1357, _mm256_mul_epu32(x1357_ninv, v_mod));
    v8i res = _mm256_or_si256(_mm256_srli_epi64(x0246_res, 32), x1357_res);
    return res;
}

v8i _mm256_mont_mul(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i b_sh = _mm256_bsrli_epi128(b, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b_sh);
    return reduce(x0246, x1357);
}

inline v8i _mm256_mod(v8i a, const v8i& m = v_mod) {
    return _mm256_min_epu32(a, _mm256_sub_epi32(a, m));
}

inline v8i _mm256_add_mod(v8i a, v8i b, const v8i& m = v_wmod) {
    v8i sum = _mm256_add_epi32(a, b);
    return _mm256_mod(sum, m);
}

inline v8i _mm256_sub_mod(v8i a, v8i b, const v8i& m = v_wmod) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i diff_m = _mm256_add_epi32(diff, m);
   return _mm256_min_epu32(diff, diff_m);
}

// ============================================================================
// Root Generation
// ============================================================================

std::vector<uint32_t> g_root;
std::vector<uint32_t> g_inv_root;

void reset_roots() {
    g_root = {to_mont(1)};
    g_inv_root = {to_mont(1)};
}

void get_root_mont(const int &n) {
    auto start = std::chrono::high_resolution_clock::now();

    if ((int)g_root.size() < n) {
        int i = g_root.size();
        g_root.resize(n); g_inv_root.resize(n);
        uint32_t* root_ptr = g_root.data();
        uint32_t* inv_root_ptr = g_inv_root.data();
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
                    g_root[i + j] = mont_mul(g_root[j], w);
                    g_inv_root[i + j] = mont_mul(g_inv_root[j], iw);
                }
            }
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    g_timing.root_precomp_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
}

// ============================================================================
// DIF NTT (Mixed Radix-2/4) - v8i array version
// ============================================================================
void dif_ntt(v8i *f, const int &n) {
    const uint32_t* rt = g_root.data();
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3;  // number of v8i elements
    
    // --- Start Nested Loop Timing ---
    auto start_nested = std::chrono::high_resolution_clock::now();

    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3;  // number of outer stages (half-block >= 8)
    int i;  // will be the radix-4 quarter-block size
    
    if (num_stages & 1) {
        // Odd number of stages: do one radix-2 pass first with half-block = n/2
        int h = n >> 1;
        int h8 = h >> 3;
        for (int j = 0, k = 0; j < n8; j += h8 << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + h8;
            for (int p = 0; p < h8; ++p) {
                v8i v_u = f0[p];
                v8i v_q = f1[p];
                v8i v_v = _mm256_mont_mul(v_q, v_rt);
                f0[p] = _mm256_add_mod(v_u, v_v);
                f1[p] = _mm256_sub_mod(v_u, v_v);
            }
        }
        i = n >> 3;
    } else {
        i = n >> 2;
    }
    
    // Radix-4 passes: i is the quarter-block size (in u32 elements)
    for (; i >= 8; i >>= 2) {
        int i8 = i >> 3;  // quarter-block size in v8i elements
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
    // --- End Nested Loop Timing ---

    // --- Start Small Loop Timing ---
    auto start_small = std::chrono::high_resolution_clock::now();

    // Inner loops for i = 4, 2, 1 (within each v8i)
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_rt = _mm256_set1_epi32(rt[k]);
        v8i v_f = f[j];
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j << 1)))), perm_i2);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_v_mont = _mm256_mont_mul(v_v, v_rt);
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_mont), _mm256_sub_mod(v_u, v_v_mont));
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + (j << 2)))), perm_i1);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        v8i v_np = _mm256_add_mod(v_u, v_v), v_nq = _mm256_sub_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
    
    auto end_small = std::chrono::high_resolution_clock::now();
    g_timing.dif_small_loops_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_small - start_small).count();
    // --- End Small Loop Timing ---
}

// ============================================================================
// DIT NTT (Mixed Radix-2/4) - v8i array version
// ============================================================================
void dit_ntt(v8i *f, const int &n) {
    const uint32_t* irt = g_inv_root.data();
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3;  // number of v8i elements
    
    // --- Start Small Loop Timing ---
    auto start_small = std::chrono::high_resolution_clock::now();

    // Inner loops for i = 1, 2, 4 (within each v8i)
    for (int j = 0; j < n8; ++j) {
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + (j << 2)))), perm_i1);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_sum = _mm256_add_mod(v_u, v_v), v_diff = _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt);
        f[j] = _mm256_blend_epi32(v_sum, _mm256_shuffle_epi32(v_diff, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + (j << 1)))), perm_i2);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt));
    }
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_irt = _mm256_set1_epi32(irt[k]);
        v8i v_f = f[j];
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt), 0x20);
    }
    
    auto end_small = std::chrono::high_resolution_clock::now();
    g_timing.dit_small_loops_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_small - start_small).count();
    // --- End Small Loop Timing ---

    // --- Start Nested Loop Timing ---
    auto start_nested = std::chrono::high_resolution_clock::now();

    // Radix-4 passes: i is the quarter-block size (in u32 elements), starts at 8
    int log_n = 31 - __builtin_clz(n);
    int num_outer_stages = log_n - 3;  // stages from half-block 8 to n/2
    
    // Radix-4 loop
    int i = 8;
    for (; i << 2 <= n; i <<= 2) {
        int i8 = i >> 3;  // quarter-block size in v8i elements
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
    
    // Final optional Radix-2 pass
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
    
    // Normalization
    uint32_t inv_n = to_mont(to_mont(inv_mod(n)));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    for (int i = 0; i < n8; ++i) {
        f[i] = _mm256_mod(_mm256_mont_mul(f[i], v_inv_n));
    }

    auto end_nested = std::chrono::high_resolution_clock::now();
    g_timing.dit_nested_loop_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_nested - start_nested).count();
    // --- End Nested Loop Timing ---
}

const int maxn = 1 << 22; 
const int maxn8 = maxn >> 3;
v8i A[maxn8], B[maxn8];
v8i A_bak[maxn8], B_bak[maxn8];

void run_test_logic(int L) {
    int L8 = L >> 3;
    get_root_mont(L);
    dif_ntt(A, L);
    dif_ntt(B, L);

    // --- Start Pointwise Timing ---
    auto start_pw = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < L8; ++i) {
        A[i] = _mm256_mont_mul(A[i], B[i]);
    }
    __asm__ __volatile__("" : : "r,m"(A[0]) : "memory");
    auto end_pw = std::chrono::high_resolution_clock::now();
    g_timing.pointwise_mult_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_pw - start_pw).count();
    // --- End Pointwise Timing ---

    dit_ntt(A, L);
}

// ============================================================================
// KACTL NTT for correctness testing (Unchanged)
// ============================================================================
namespace KACTL {
    typedef long long ll;
    typedef std::vector<ll> vll;
    
    const ll mod = 998244353;
    const ll root = 62; // This will be used as modpow(3, (mod-1)/N)
    
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
    
    // Cyclic convolution of exact size L (must be power of 2)
    vll cyclic_conv(const vll &a, const vll &b, int L) {
        vll A(a), B(b);
        A.resize(L); B.resize(L);
        ntt(A); ntt(B);
        for (int i = 0; i < L; ++i)
            A[i] = (ll)A[i] * B[i] % mod;
        // Inverse NTT: reverse + scale
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

inline void set_elem(v8i* arr, int idx, uint32_t val) {
    alignas(32) uint32_t tmp[8];
    int vec_idx = idx >> 3;
    _mm256_store_si256((v8i*)tmp, arr[vec_idx]);
    tmp[idx & 7] = val;
    arr[vec_idx] = _mm256_load_si256((v8i*)tmp);
}

void run_correctness_tests() {
    std::cout << "Running Correctness Tests (KACTL NTT Reference)...\n";
    std::cout << "--------------------------------------------------------\n";
    
    std::mt19937 rng(12345);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    
    // Test sizes from 2^4 to 2^20
    for (int k = 4; k <= 20; ++k) {
        int L = 1 << k;
        int L8 = L >> 3;
        
        std::vector<uint32_t> poly_a(L), poly_b(L);
        for (int i = 0; i < L; ++i) {
            poly_a[i] = dist(rng); 
            poly_b[i] = dist(rng);
        }
        
        // Compute expected using KACTL
        std::vector<long long> a_ll(poly_a.begin(), poly_a.end());
        std::vector<long long> b_ll(poly_b.begin(), poly_b.end());
        std::vector<long long> expected = KACTL::cyclic_conv(a_ll, b_ll, L);
        
        // Prepare A and B arrays
        std::memset(A, 0, sizeof(A));
        std::memset(B, 0, sizeof(B));
        std::memcpy(A, poly_a.data(), L * sizeof(uint32_t));
        std::memcpy(B, poly_b.data(), L * sizeof(uint32_t));
        
        reset_roots();
        g_timing.reset();
        run_test_logic(L);
        
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
            break; // Stop on first failure
        }
    }
    std::cout << "--------------------------------------------------------\n";
}

void run_benchmark() {
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

        // Generate random data once per size (directly into backup arrays)
        alignas(32) uint32_t tmp_a[8], tmp_b[8];
        for(int i = 0; i < L8; ++i) {
            for(int j = 0; j < 8; ++j) {
                tmp_a[j] = dist(rng);
                tmp_b[j] = dist(rng);
            }
            A_bak[i] = _mm256_load_si256((v8i*)tmp_a);
            B_bak[i] = _mm256_load_si256((v8i*)tmp_b);
        }

        // Warmup (2 runs)
        for (int w = 0; w < 2; ++w) {
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));
            reset_roots();
            g_timing.reset();
            run_test_logic(L);
        }

        // Averaging Loop
        long long total_us = 0;
        g_timing.reset();

        for (int iter = 0; iter < iterations; ++iter) {
            reset_roots();
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));

            auto start = std::chrono::high_resolution_clock::now();
            run_test_logic(L);
            auto end = std::chrono::high_resolution_clock::now();
            
            total_us += std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
        }

        double avg_us = (double)total_us / iterations;
        double avg_ms = avg_us / 1000.0;

        std::cout << "| 2^" << std::setw(9) << std::left << k 
                  << " | " << std::setw(20) << std::right << std::fixed << std::setprecision(0) << avg_us 
                  << " | " << std::setw(15) << std::fixed << std::setprecision(3) << avg_ms << " |\n";
        
        // Print detailed timing breakdown for the largest size
        if (k == 20) {
            g_timing.print("2^" + std::to_string(k), iterations);
        }
    }
    std::cout << "--------------------------------------------------------\n";
}

int main() {
    reset_roots();
    run_correctness_tests();
    run_benchmark();
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
| 2^16        |                  527 |           0.527 |
| 2^17        |                 1109 |           1.109 |
| 2^18        |                 2341 |           2.341 |
| 2^19        |                 5024 |           5.024 |
| 2^20        |                10701 |          10.701 |

=== Timing Breakdown: 2^20 (Average of 20 runs) ===
Root precomputation:        822821 ns
DIF nested loops:          4689850 ns
DIF small loops:           1762077 ns
Pointwise multiply:         253808 ns
DIT small loops:            874323 ns
DIT nested loops:          2297345 ns
----------------------------------------
Total (Breakdown Sum):    10700226 ns
========================================

| 2^21        |                22372 |          22.372 |
| 2^22        |                49407 |          49.407 |
--------------------------------------------------------

*/

/*
#pragma GCC optimize("O3")
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

const uint32_t MOD = 998244353;
const uint32_t WMOD = 1996488706;
const uint32_t R2_MOD = 932051910;
const uint32_t M_INV = 998244351;
const uint32_t PRIM_ROOT = 3;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_m = _mm256_set1_epi32(M_INV);
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);
const v8i v_one = _mm256_set1_epi32(1);
const v8i v_zero = _mm256_setzero_si256();

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
inline uint32_t mont_mul(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint64_t m = (uint64_t)((uint32_t)t * M_INV) * MOD;
    uint32_t r = (t + m) >> 32;
    return r >= MOD ? r - MOD : r;
}

inline uint32_t to_mont(uint32_t x) { return mont_mul(x, R2_MOD); }
inline uint32_t from_mont(uint32_t x) { return mont_mul(x, 1); }

uint32_t pow_mod(uint32_t base, uint32_t exp) {
    uint32_t result = to_mont(1);
    base = to_mont(base);
    while (exp > 0) {
        if (exp & 1) result = mont_mul(result, base);
        base = mont_mul(base, base);
        exp >>= 1;
    }
    return from_mont(result);
}

uint32_t inv_mod(uint32_t x) { return pow_mod(x, MOD - 2); }

v8i reduce(v8i x0246, v8i x1357) {
    v8i x0246_ninv = _mm256_mul_epu32(x0246, v_m);
    v8i x1357_ninv = _mm256_mul_epu32(x1357, v_m);
    v8i x0246_res = _mm256_add_epi64(x0246, _mm256_mul_epu32(x0246_ninv, v_mod));
    v8i x1357_res = _mm256_add_epi64(x1357, _mm256_mul_epu32(x1357_ninv, v_mod));
    v8i res = _mm256_or_si256(_mm256_srli_epi64(x0246_res, 32), x1357_res);
    return res;
}

v8i _mm256_mont_mul(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i b_sh = _mm256_bsrli_epi128(b, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b_sh);
    return reduce(x0246, x1357);
}

inline v8i _mm256_mod(v8i a, const v8i& m = v_mod) {
    return _mm256_min_epu32(a, _mm256_sub_epi32(a, m));
}

inline v8i _mm256_add_mod(v8i a, v8i b, const v8i& m = v_wmod) {
    v8i sum = _mm256_add_epi32(a, b);
    return _mm256_mod(sum, m);
}

inline v8i _mm256_sub_mod(v8i a, v8i b, const v8i& m = v_wmod) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i diff_m = _mm256_add_epi32(diff, m);
   return _mm256_min_epu32(diff, diff_m);
}

// ============================================================================
// Root Generation
// ============================================================================

std::vector<uint32_t> g_root;
std::vector<uint32_t> g_inv_root;

void reset_roots() {
    g_root = {to_mont(1)};
    g_inv_root = {to_mont(1)};
}

void get_root_mont(const int &n) {
    auto start = std::chrono::high_resolution_clock::now();

    if ((int)g_root.size() < n) {
        int i = g_root.size();
        g_root.resize(n); g_inv_root.resize(n);
        uint32_t* root_ptr = g_root.data();
        uint32_t* inv_root_ptr = g_inv_root.data();
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
                    g_root[i + j] = mont_mul(g_root[j], w);
                    g_inv_root[i + j] = mont_mul(g_inv_root[j], iw);
                }
            }
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    g_timing.root_precomp_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
}

// ============================================================================
// DIF NTT (Mixed Radix-2/4) - v8i array version
// ============================================================================
void dif_ntt(v8i *f, const int &n) {
    const uint32_t* rt = g_root.data();
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3;  // number of v8i elements
    
    // --- Start Nested Loop Timing ---
    auto start_nested = std::chrono::high_resolution_clock::now();

    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3;  // number of outer stages (half-block >= 8)
    int i;  // will be the radix-4 quarter-block size
    
    if (num_stages & 1) {
        // Odd number of stages: do one radix-2 pass first with half-block = n/2
        int h = n >> 1;
        int h8 = h >> 3;
        for (int j = 0, k = 0; j < n8; j += h8 << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + h8;
            for (int p = 0; p < h8; ++p) {
                v8i v_u = f0[p];
                v8i v_q = f1[p];
                v8i v_v = _mm256_mont_mul(v_q, v_rt);
                f0[p] = _mm256_add_mod(v_u, v_v);
                f1[p] = _mm256_sub_mod(v_u, v_v);
            }
        }
        i = n >> 3;
    } else {
        i = n >> 2;
    }
    
    // Radix-4 passes: i is the quarter-block size (in u32 elements)
    for (; i >= 8; i >>= 2) {
        int i8 = i >> 3;  // quarter-block size in v8i elements
        for (int j = 0, k = 0; j < n8; j += i8 << 2, ++k) {
            const v8i v_w0 = _mm256_set1_epi32(rt[k]);
            const v8i v_w1 = _mm256_set1_epi32(rt[2*k]);
            const v8i v_w2 = _mm256_set1_epi32(rt[2*k + 1]);
            
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            v8i* __restrict f2 = f + j + 2*i8;
            v8i* __restrict f3 = f + j + 3*i8;
            
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
    // --- End Nested Loop Timing ---

    // --- Start Small Loop Timing ---
    auto start_small = std::chrono::high_resolution_clock::now();

    // Inner loops for i = 4, 2, 1 (within each v8i)
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_rt = _mm256_set1_epi32(rt[k]);
        v8i v_f = f[j];
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j << 1)))), perm_i2);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_v_mont = _mm256_mont_mul(v_v, v_rt);
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_mont), _mm256_sub_mod(v_u, v_v_mont));
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + (j << 2)))), perm_i1);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        v8i v_np = _mm256_add_mod(v_u, v_v), v_nq = _mm256_sub_mod(v_u, v_v);
        f[j] = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
    
    auto end_small = std::chrono::high_resolution_clock::now();
    g_timing.dif_small_loops_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_small - start_small).count();
    // --- End Small Loop Timing ---
}

// ============================================================================
// DIT NTT (Mixed Radix-2/4) - v8i array version
// ============================================================================
void dit_ntt(v8i *f, const int &n) {
    const uint32_t* irt = g_inv_root.data();
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    const int n8 = n >> 3;  // number of v8i elements
    
    // --- Start Small Loop Timing ---
    auto start_small = std::chrono::high_resolution_clock::now();

    // Inner loops for i = 1, 2, 4 (within each v8i)
    for (int j = 0; j < n8; ++j) {
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + (j << 2)))), perm_i1);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_sum = _mm256_add_mod(v_u, v_v), v_diff = _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt);
        f[j] = _mm256_blend_epi32(v_sum, _mm256_shuffle_epi32(v_diff, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
    }
    for (int j = 0; j < n8; ++j) {
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + (j << 1)))), perm_i2);
        v8i v_f = f[j];
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        f[j] = _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt));
    }
    for (int j = 0, k = 0; j < n8; ++j, ++k) {
        v8i v_irt = _mm256_set1_epi32(irt[k]);
        v8i v_f = f[j];
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        f[j] = _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt), 0x20);
    }
    
    auto end_small = std::chrono::high_resolution_clock::now();
    g_timing.dit_small_loops_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_small - start_small).count();
    // --- End Small Loop Timing ---

    // --- Start Nested Loop Timing ---
    auto start_nested = std::chrono::high_resolution_clock::now();

    // Radix-4 passes: i is the quarter-block size (in u32 elements), starts at 8
    int log_n = 31 - __builtin_clz(n);
    int num_outer_stages = log_n - 3;  // stages from half-block 8 to n/2
    
    // Radix-4 loop
    int i = 8;
    for (; i << 2 <= n; i <<= 2) {
        int i8 = i >> 3;  // quarter-block size in v8i elements
        for (int j = 0, k = 0; j < n8; j += i8 << 2, ++k) {
            const v8i v_iw0 = _mm256_set1_epi32(irt[k]);
            const v8i v_iw1 = _mm256_set1_epi32(irt[2*k]);
            const v8i v_iw2 = _mm256_set1_epi32(irt[2*k + 1]);
            
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            v8i* __restrict f2 = f + j + 2*i8;
            v8i* __restrict f3 = f + j + 3*i8;
            
            for (int p = 0; p < i8; ++p) {
                v8i a0 = f0[p];
                v8i a1 = f1[p];
                v8i a2 = f2[p];
                v8i a3 = f3[p];
               
                v8i s1 = _mm256_sub_mod(a0, a1);
                v8i t0 = _mm256_add_mod(a0, a1);

                v8i s2 = _mm256_sub_mod(a2, a3);
                v8i t2 = _mm256_add_mod(a2, a3);

                v8i t1 = _mm256_mont_mul(s1, v_iw1);
                v8i t3 = _mm256_mont_mul(s2, v_iw2);
                
                v8i r0 = _mm256_add_mod(t0, t2);
                v8i p1 = _mm256_sub_mod(t0, t2);
                f0[p] = r0;

                v8i r1 = _mm256_add_mod(t1, t3);
                v8i p2 = _mm256_sub_mod(t1, t3);
                f1[p] = r1;
                
                f2[p] = _mm256_mont_mul(p1, v_iw0);
                f3[p] = _mm256_mont_mul(p2, v_iw0);
                
            }
        }
    }
    
    // Final optional Radix-2 pass
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
    
    // Normalization
    uint32_t inv_n = to_mont(to_mont(inv_mod(n)));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    for (int i = 0; i < n8; ++i) {
        f[i] = _mm256_mod(_mm256_mont_mul(f[i], v_inv_n));
    }

    auto end_nested = std::chrono::high_resolution_clock::now();
    g_timing.dit_nested_loop_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_nested - start_nested).count();
    // --- End Nested Loop Timing ---
}

const int maxn = 1 << 22; 
const int maxn8 = maxn >> 3;
v8i A[maxn8], B[maxn8];
v8i A_bak[maxn8], B_bak[maxn8];

void run_test_logic(int L) {
    int L8 = L >> 3;
    get_root_mont(L);
    dif_ntt(A, L);
    dif_ntt(B, L);

    // --- Start Pointwise Timing ---
    auto start_pw = std::chrono::high_resolution_clock::now();
    for (int i = 0; i < L8; ++i) {
        A[i] = _mm256_mont_mul(A[i], B[i]);
    }
    __asm__ __volatile__("" : : "r,m"(A[0]) : "memory");
    auto end_pw = std::chrono::high_resolution_clock::now();
    g_timing.pointwise_mult_ns += std::chrono::duration_cast<std::chrono::nanoseconds>(end_pw - start_pw).count();
    // --- End Pointwise Timing ---

    dit_ntt(A, L);
}

// ============================================================================
// KACTL NTT for correctness testing (Unchanged)
// ============================================================================
namespace KACTL {
    typedef long long ll;
    typedef std::vector<ll> vll;
    
    const ll mod = 998244353;
    const ll root = 62; // This will be used as modpow(3, (mod-1)/N)
    
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
    
    // Cyclic convolution of exact size L (must be power of 2)
    vll cyclic_conv(const vll &a, const vll &b, int L) {
        vll A(a), B(b);
        A.resize(L); B.resize(L);
        ntt(A); ntt(B);
        for (int i = 0; i < L; ++i)
            A[i] = (ll)A[i] * B[i] % mod;
        // Inverse NTT: reverse + scale
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

inline void set_elem(v8i* arr, int idx, uint32_t val) {
    alignas(32) uint32_t tmp[8];
    int vec_idx = idx >> 3;
    _mm256_store_si256((v8i*)tmp, arr[vec_idx]);
    tmp[idx & 7] = val;
    arr[vec_idx] = _mm256_load_si256((v8i*)tmp);
}

void run_correctness_tests() {
    std::cout << "Running Correctness Tests (KACTL NTT Reference)...\n";
    std::cout << "--------------------------------------------------------\n";
    
    std::mt19937 rng(12345);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    
    // Test sizes from 2^4 to 2^20
    for (int k = 4; k <= 20; ++k) {
        int L = 1 << k;
        int L8 = L >> 3;
        
        std::vector<uint32_t> poly_a(L), poly_b(L);
        for (int i = 0; i < L; ++i) {
            poly_a[i] = dist(rng); 
            poly_b[i] = dist(rng);
        }
        
        // Compute expected using KACTL
        std::vector<long long> a_ll(poly_a.begin(), poly_a.end());
        std::vector<long long> b_ll(poly_b.begin(), poly_b.end());
        std::vector<long long> expected = KACTL::cyclic_conv(a_ll, b_ll, L);
        
        // Prepare A and B arrays
        std::memset(A, 0, sizeof(A));
        std::memset(B, 0, sizeof(B));
        std::memcpy(A, poly_a.data(), L * sizeof(uint32_t));
        std::memcpy(B, poly_b.data(), L * sizeof(uint32_t));
        
        reset_roots();
        g_timing.reset();
        run_test_logic(L);
        
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
            break; // Stop on first failure
        }
    }
    std::cout << "--------------------------------------------------------\n";
}

void run_benchmark() {
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

        // Generate random data once per size (directly into backup arrays)
        alignas(32) uint32_t tmp_a[8], tmp_b[8];
        for(int i = 0; i < L8; ++i) {
            for(int j = 0; j < 8; ++j) {
                tmp_a[j] = dist(rng);
                tmp_b[j] = dist(rng);
            }
            A_bak[i] = _mm256_load_si256((v8i*)tmp_a);
            B_bak[i] = _mm256_load_si256((v8i*)tmp_b);
        }

        // Warmup (2 runs)
        for (int w = 0; w < 2; ++w) {
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));
            reset_roots();
            g_timing.reset();
            run_test_logic(L);
        }

        // Averaging Loop
        long long total_us = 0;
        g_timing.reset();

        for (int iter = 0; iter < iterations; ++iter) {
            reset_roots();
            std::memcpy(A, A_bak, L8 * sizeof(v8i));
            std::memcpy(B, B_bak, L8 * sizeof(v8i));

            auto start = std::chrono::high_resolution_clock::now();
            run_test_logic(L);
            auto end = std::chrono::high_resolution_clock::now();
            
            total_us += std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
        }

        double avg_us = (double)total_us / iterations;
        double avg_ms = avg_us / 1000.0;

        std::cout << "| 2^" << std::setw(9) << std::left << k 
                  << " | " << std::setw(20) << std::right << std::fixed << std::setprecision(0) << avg_us 
                  << " | " << std::setw(15) << std::fixed << std::setprecision(3) << avg_ms << " |\n";
        
        // Print detailed timing breakdown for the largest size
        if (k == 20) {
            g_timing.print("2^" + std::to_string(k), iterations);
        }
    }
    std::cout << "--------------------------------------------------------\n";
}

int main() {
    reset_roots();
    run_correctness_tests();
    run_benchmark();
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
| 2^16        |                  527 |           0.527 |
| 2^17        |                 1109 |           1.109 |
| 2^18        |                 2341 |           2.341 |
| 2^19        |                 5024 |           5.024 |
| 2^20        |                10701 |          10.701 |

=== Timing Breakdown: 2^20 (Average of 20 runs) ===
Root precomputation:        822821 ns
DIF nested loops:          4689850 ns
DIF small loops:           1762077 ns
Pointwise multiply:         253808 ns
DIT small loops:            874323 ns
DIT nested loops:          2297345 ns
----------------------------------------
Total (Breakdown Sum):    10700226 ns
========================================

| 2^21        |                22372 |          22.372 |
| 2^22        |                49407 |          49.407 |
--------------------------------------------------------

*/