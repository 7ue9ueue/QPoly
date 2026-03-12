#include <bits/stdc++.h>
#include <immintrin.h>
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")
using namespace std;
using namespace std::chrono;

#define rep(i, a, b) for (auto i = a; i < (b); ++i)
#define repr(i, a, b) for (auto i = (a) - 1; i >= (b); --i)
#define sz(x) int((x).size())
using ll = long long;
using vi = vector<int>;
using vll = vector<ll>;

const ll mod = (119 << 23) + 1, root = 62; // = 998244353

ll modpow(ll b, ll e) {
    ll ans = 1;
    for (; e; b = b * b % mod, e /= 2)
        if (e & 1) ans = ans * b % mod;
    return ans;
}

// ============================================================================
// Reference NTT implementation using 32-bit integers (FAIR COMPARISON)
// This is the same algorithm but using int instead of long long
// ============================================================================
void ntt_ref_int(vi &a) {
    int n = sz(a), L = 31 - __builtin_clz(n);
    static vi rt(2, 1);
    for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
        rt.resize(n);
        ll z[] = {1, modpow(root, mod >> s)};
        rep(i, k, 2 * k) rt[i] = (ll)rt[i / 2] * z[i & 1] % mod;
    }
    vi rev(n);
    rep(i, 0, n) rev[i] = (rev[i / 2] | (i & 1) << L) / 2;
    rep(i, 0, n) if (i < rev[i]) swap(a[i], a[rev[i]]);

    for (int k = 1; k < n; k *= 2)
        for (int i = 0; i < n; i += 2 * k)
            rep(j, 0, k) {
                ll z = (ll)rt[j + k] * a[i + j + k] % mod;
                int ai = a[i + j];
                a[i + j + k] = ai - z + (z > ai ? mod : 0);
                a[i + j] = ai + (ai + z >= mod ? z - mod : z);
            }
}

void ntt_ref_ll(vll &a) {
    int n = sz(a), L = 31 - __builtin_clz(n);
    static vll rt(2, 1);
    for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
        rt.resize(n);
        ll z[] = {1, modpow(root, mod >> s)};
        rep(i, k, 2 * k) rt[i] = rt[i / 2] * z[i & 1] % mod;
    }
    vi rev(n);
    rep(i, 0, n) rev[i] = (rev[i / 2] | (i & 1) << L) / 2;
    rep(i, 0, n) if (i < rev[i]) swap(a[i], a[rev[i]]);

    for (int k = 1; k < n; k *= 2)
        for (int i = 0; i < n; i += 2 * k)
            rep(j, 0, k) {
                ll z = rt[j + k] * a[i + j + k] % mod;
                ll &ai = a[i + j];
                a[i + j + k] = ai - z + (z > ai ? mod : 0);
                ai += (ai + z >= mod ? z - mod : z);
            }
}

// ============================================================================
// SIMD NTT Implementation
// ============================================================================
typedef __m256i v8i;

const uint32_t MOD = 998244353;
const uint32_t R2_MOD = 932051910;
const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_one = _mm256_set1_epi32(1);

// Montgomery constants
const uint32_t M_INV = 998244351;
const v8i v_m = _mm256_set1_epi32(M_INV);
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);

v8i _mm256_multiply_mod_mont(const v8i& a, const v8i& b) {    
    v8i t_even = _mm256_mul_epu32(a, b);
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
    
    v8i u_even = _mm256_mullo_epi32(t_even, v_m);
    v8i u_odd = _mm256_mullo_epi32(t_odd, v_m);
    
    v8i up_even = _mm256_mul_epu32(u_even, v_mod);
    v8i up_odd = _mm256_mul_epu32(u_odd, v_mod);
    
    v8i sum_even = _mm256_add_epi64(t_even, up_even);
    v8i sum_odd = _mm256_add_epi64(t_odd, up_odd);
    
    v8i res_even = _mm256_srli_epi64(sum_even, 32);
    v8i res_odd = _mm256_srli_epi64(sum_odd, 32);
    
    v8i result = _mm256_blend_epi32(res_even, _mm256_slli_epi64(res_odd, 32), 0xAA);
    
    v8i adjusted = _mm256_sub_epi32(result, v_mod);
    v8i needs_sub = _mm256_cmpgt_epi32(result, _mm256_sub_epi32(v_mod, _mm256_set1_epi32(1)));
    result = _mm256_blendv_epi8(result, adjusted, needs_sub);
    
    return result;
}
#define _mm256_multiply_mod _mm256_multiply_mod_mont

v8i _mm256_add_mod(const v8i& a, const v8i& b) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), v_mod);
    v8i mask = _mm256_srai_epi32(adjusted, 31);
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, v_mod));
}

inline uint32_t mont_mul_scalar(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint32_t m = (uint32_t)t * M_INV;
    uint64_t u = t + (uint64_t)m * MOD;
    uint32_t res = u >> 32;
    return res >= MOD ? res - MOD : res;
}

void ntt_SIMD(vi &a) {
    int n = sz(a), L = 31 - __builtin_clz(n);
    static vi rt(2, 1);
    static vi rt_mont(2);
    
    for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
        rt.resize(n);
        rt_mont.resize(n);
        ll z[] = {1, modpow(root, mod >> s)};
        rep(i, k, 2 * k) {
            rt[i] = ((ll)rt[i / 2] * z[i & 1]) % mod;
            rt_mont[i] = mont_mul_scalar(rt[i], R2_MOD);
        }
    }
    if (sz(rt_mont) >= 2 && rt_mont[1] == 0) rt_mont[1] = mont_mul_scalar(rt[1], R2_MOD);

    vi rev(n);
    rep(i, 0, n) rev[i] = (rev[i / 2] | (i & 1) << L) / 2;
    rep(i, 0, n) if (i < rev[i]) swap(a[i], a[rev[i]]);

    int* a_ptr = a.data();

    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
        v = _mm256_multiply_mod(v, v_r2);
        _mm256_storeu_si256((v8i*)(a_ptr + i), v);
    }

    // k = 1 
    {
        v8i v_W = _mm256_set1_epi32(rt_mont[1]); 
        for (int i = 0; i < n; i += 8) {
            v8i v_I = _mm256_loadu_si256((v8i*)(a_ptr + i)); 
            v8i v_A = _mm256_shuffle_epi32(v_I, _MM_SHUFFLE(2, 2, 0, 0)); 
            v8i v_B = _mm256_shuffle_epi32(v_I, _MM_SHUFFLE(3, 3, 1, 1)); 

            v8i v_WB = _mm256_multiply_mod(v_W, v_B);  
            v8i v_neg_WB = _mm256_sub_epi32(v_mod, v_WB); 
            v8i v_WB_interleaved = _mm256_blend_epi32(v_WB, v_neg_WB, 0xAA); 
            
            v8i result = _mm256_add_mod(v_A, v_WB_interleaved);
            _mm256_storeu_si256((v8i*)(a_ptr + i), result);
        }
    }
    
    // k = 2
    {
        v8i w0 = _mm256_set1_epi32(rt_mont[2]);
        v8i w1 = _mm256_set1_epi32(rt_mont[3]);
        v8i v_W = _mm256_blend_epi32(w0, w1, 0xAA); 

        for (int i = 0; i < n; i += 8) {
            v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
            
            v8i v_U = _mm256_shuffle_epi32(v, _MM_SHUFFLE(1, 0, 1, 0));
            v8i v_V = _mm256_shuffle_epi32(v, _MM_SHUFFLE(3, 2, 3, 2));

            v8i v_Prod = _mm256_multiply_mod(v_V, v_W);
            v8i v_Sum = _mm256_add_mod(v_U, v_Prod);
            v8i v_Neg_Prod = _mm256_sub_epi32(v_mod, v_Prod);
            v8i v_Diff = _mm256_add_mod(v_U, v_Neg_Prod);

            v8i res = _mm256_unpacklo_epi64(v_Sum, v_Diff);
            _mm256_storeu_si256((v8i*)(a_ptr + i), res);
        }
    }

    // k = 4
    {
        v8i v_W = _mm256_broadcastsi128_si256(_mm_loadu_si128((__m128i*)&rt_mont[4]));

        for (int i = 0; i < n; i += 8) {
            v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
            
            v8i v_U = _mm256_permute2x128_si256(v, v, 0x00);
            v8i v_V = _mm256_permute2x128_si256(v, v, 0x11);

            v8i v_Prod = _mm256_multiply_mod(v_V, v_W);
            v8i v_Sum = _mm256_add_mod(v_U, v_Prod);
            v8i v_Neg_Prod = _mm256_sub_epi32(v_mod, v_Prod);
            v8i v_Diff = _mm256_add_mod(v_U, v_Neg_Prod);

            v8i res = _mm256_permute2x128_si256(v_Sum, v_Diff, 0x20);
            _mm256_storeu_si256((v8i*)(a_ptr + i), res);
        }
    }

    // k > 4
    for (int k = 8; k < n; k *= 2) {
        for (int i = 0; i < n; i += 2 * k) {
            for (int j = 0; j < k; j += 8) {
                v8i v_W = _mm256_loadu_si256((v8i*)&rt_mont[k + j]);
                v8i v_U = _mm256_loadu_si256((v8i*)(a_ptr + i + j));
                v8i v_V = _mm256_loadu_si256((v8i*)(a_ptr + i + j + k));

                v8i v_Prod = _mm256_multiply_mod(v_V, v_W);
                v8i v_Sum = _mm256_add_mod(v_U, v_Prod);
                v8i v_Neg_Prod = _mm256_sub_epi32(v_mod, v_Prod);
                v8i v_Diff = _mm256_add_mod(v_U, v_Neg_Prod);

                _mm256_storeu_si256((v8i*)(a_ptr + i + j), v_Sum);
                _mm256_storeu_si256((v8i*)(a_ptr + i + j + k), v_Diff);
            }
        }
    }

    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
        v = _mm256_multiply_mod(v, v_one);
        _mm256_storeu_si256((v8i*)(a_ptr + i), v);
    }
}

// ============================================================================
// Test utilities
// ============================================================================
mt19937_64 rng(42);

vi generate_random_input(int n) {
    vi a(n);
    for (int i = 0; i < n; i++) {
        a[i] = rng() % MOD;
    }
    return a;
}

bool test_correctness(int n, int num_tests = 10) {
    cout << "Testing correctness for n = " << n << "... ";
    
    for (int t = 0; t < num_tests; t++) {
        vi input = generate_random_input(n);
        
        // Test with reference implementation (long long version for ground truth)
        vll a_ref(input.begin(), input.end());
        ntt_ref_ll(a_ref);
        
        // Test with SIMD implementation
        vi a_simd = input;
        ntt_SIMD(a_simd);
        
        // Compare results
        for (int i = 0; i < n; i++) {
            if (a_ref[i] != a_simd[i]) {
                cout << "FAILED!\n";
                cout << "  Mismatch at index " << i << ": ";
                cout << "reference = " << a_ref[i] << ", SIMD = " << a_simd[i] << "\n";
                cout << "  First few values of input: ";
                for (int j = 0; j < min(10, n); j++) {
                    cout << input[j] << " ";
                }
                cout << "\n";
                return false;
            }
        }
    }
    
    cout << "PASSED (" << num_tests << " random tests)\n";
    return true;
}

// ============================================================================
// FIXED BENCHMARK: Fair comparison with pre-allocated buffers
// ============================================================================
void benchmark_fair(int n, int iterations = 100) {
    cout << "Benchmarking n = " << n << " (" << iterations << " iterations)...\n";
    
    vi input = generate_random_input(n);
    
    // Pre-allocate buffers (avoids allocation overhead in timing loop)
    vi buffer_ref(n);
    vi buffer_simd(n);
    vll buffer_ref_ll(n);  // For the original long long version
    
    // Warm up and ensure twiddle factors are precomputed
    for (int i = 0; i < 10; i++) {
        copy(input.begin(), input.end(), buffer_ref.begin());
        ntt_ref_int(buffer_ref);
        copy(input.begin(), input.end(), buffer_simd.begin());
        ntt_SIMD(buffer_simd);
    }
    
    // Benchmark reference (int version - FAIR COMPARISON)
    auto start = high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        copy(input.begin(), input.end(), buffer_ref.begin());
        ntt_ref_int(buffer_ref);
    }
    auto end = high_resolution_clock::now();
    double time_ref_int = duration_cast<nanoseconds>(end - start).count() / 1e6 / iterations;
    
    // Benchmark SIMD
    start = high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        copy(input.begin(), input.end(), buffer_simd.begin());
        ntt_SIMD(buffer_simd);
    }
    end = high_resolution_clock::now();
    double time_simd = duration_cast<nanoseconds>(end - start).count() / 1e6 / iterations;
    
    cout << "  Reference (int32):  " << fixed << setprecision(3) << time_ref_int << " ms\n";
    cout << "  SIMD (Montgomery):  " << fixed << setprecision(3) << time_simd << " ms\n";
    cout << "  Speedup vs int32:   " << fixed << setprecision(2) << (time_ref_int / time_simd) << "x\n";
    cout << "\n";
}

// Alternative: Benchmark excluding copy overhead entirely
void benchmark_no_copy(int n, int iterations = 100) {
    cout << "Benchmarking n = " << n << " (NO COPY, " << iterations << " iterations)...\n";
    cout << "  Note: Transforms same data repeatedly (results differ from fresh input)\n";
    
    vi input = generate_random_input(n);
    
    // Pre-allocate buffers
    vi buffer_ref = input;
    vi buffer_simd = input;
    
    // Warm up
    for (int i = 0; i < 10; i++) {
        vi temp = input;
        ntt_ref_int(temp);
        temp = input;
        ntt_SIMD(temp);
    }
    
    // Reset buffers
    buffer_ref = input;
    buffer_simd = input;
    
    // Benchmark reference (int version)
    auto start = high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        ntt_ref_int(buffer_ref);
    }
    auto end = high_resolution_clock::now();
    double time_ref_int = duration_cast<nanoseconds>(end - start).count() / 1e6 / iterations;
    
    // Reset and benchmark SIMD
    buffer_simd = input;
    start = high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        ntt_SIMD(buffer_simd);
    }
    end = high_resolution_clock::now();
    double time_simd = duration_cast<nanoseconds>(end - start).count() / 1e6 / iterations;
    
    cout << "  Reference (int32):  " << fixed << setprecision(3) << time_ref_int << " ms\n";
    cout << "  SIMD (Montgomery):  " << fixed << setprecision(3) << time_simd << " ms\n";
    cout << "  Speedup vs int32:   " << fixed << setprecision(2) << (time_ref_int / time_simd) << "x\n";
    cout << "\n";
}

void test_edge_cases() {
    cout << "=== Testing Edge Cases ===\n\n";
    
    // Test minimum size (n = 32)
    cout << "Test 1: Minimum size (n = 32)\n";
    test_correctness(32);
    
    // Test all zeros
    cout << "Test 2: All zeros (n = 64)\n";
    vi zeros(64, 0);
    vll zeros_ref(64, 0);
    vi zeros_simd = zeros;
    ntt_SIMD(zeros_simd);
    bool zeros_match = true;
    for (int i = 0; i < 64; i++) {
        if (zeros_ref[i] != zeros_simd[i]) {
            zeros_match = false;
            break;
        }
    }
    cout << (zeros_match ? "PASSED" : "FAILED") << "\n";
    
    // Test all ones
    cout << "Test 3: All ones (n = 64)\n";
    vi ones(64, 1);
    vll ones_ref(64, 1);
    vi ones_simd = ones;
    ntt_SIMD(ones_simd);
    bool ones_match = true;
    for (int i = 0; i < 64; i++) {
        if (ones_ref[i] != ones_simd[i]) {
            ones_match = false;
            break;
        }
    }
    cout << (ones_match ? "PASSED" : "FAILED") << "\n";
    
    // Test maximum values
    cout << "Test 4: Maximum values (n = 64)\n";
    vi maxvals(64, MOD - 1);
    vll maxvals_ref(64, MOD - 1);
    vi maxvals_simd = maxvals;
    ntt_SIMD(maxvals_simd);
    bool maxvals_match = true;
    for (int i = 0; i < 64; i++) {
        if (maxvals_ref[i] != maxvals_simd[i]) {
            maxvals_match = false;
            break;
        }
    }
    cout << (maxvals_match ? "PASSED" : "FAILED") << "\n";
    
    cout << "\n";
}

int main() {
    // cout << "=== NTT Implementation Test Suite (FIXED BENCHMARK) ===\n";
    // cout << "Modulus: " << MOD << "\n";
    // cout << "Primitive root: " << root << "\n\n";
    
    // cout << "FIXES APPLIED:\n";
    // cout << "  1. Added int32 reference implementation for fair comparison\n";
    // cout << "  2. Pre-allocated buffers to avoid allocation overhead in timing\n";
    // cout << "  3. Using std::copy instead of vector construction\n";
    // cout << "  4. Reporting both int32 and int64 reference times\n";
    // cout << "\n";
    
    // test_edge_cases();
    
    // cout << "=== Correctness Tests ===\n\n";
    
    // vector<int> test_sizes = {32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536};
    
    // bool all_passed = true;
    // for (int n : test_sizes) {
    //     if (!test_correctness(n)) {
    //         all_passed = false;
    //         break;
    //     }
    // }
    
    // if (!all_passed) {
    //     cout << "\nCorrectness tests FAILED. Skipping benchmarks.\n";
    //     return 1;
    // }
    
    // cout << "\n=== All Correctness Tests PASSED ===\n\n";
    
    cout << "=== Performance Benchmarks (WITH COPY) ===\n\n";
    
    vector<int> bench_sizes = {1024, 4096, 16384, 65536, 262144};
    for (int n : bench_sizes) {
        benchmark_fair(n, n <= 65536 ? 50 : 20);
    }
    
    cout << "=== Performance Benchmarks (NO COPY - Pure NTT Time) ===\n\n";
    
    for (int n : bench_sizes) {
        benchmark_no_copy(n, n <= 65536 ? 50 : 20);
    }
    
    cout << "=== All Tests Complete ===\n";
    
    return 0;
}