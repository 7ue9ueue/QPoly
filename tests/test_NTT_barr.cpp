// #pragma GCC optimize("O3,unroll-loops")
// #pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")
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

// Reference NTT implementation (assumed correct)
void ntt(vll &a) {
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

typedef __m256i v8i;

// ============================================================
// NFLlib-style Barrett Reduction
// ============================================================
const uint32_t MOD = 998244353;
const uint32_t BARRETT_MU = 2309898375;  // floor(2^61 / MOD) - CORRECTED

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_mu = _mm256_set1_epi32(BARRETT_MU);

/**
 * NFLlib Barrett reduction: computes (a * b) mod p
 * 
 * Algorithm:
 *   x = a * b                      (64-bit product)
 *   q = ((x >> 29) * μ) >> 32      (approximate quotient)
 *   r = x - q * p                  (remainder, may need correction)
 */
v8i _mm256_multiply_mod(const v8i& a, const v8i& b) {
    // Step 1: Compute x = a * b (64-bit results)
    v8i x_even = _mm256_mul_epu32(a, b);
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i x_odd = _mm256_mul_epu32(a_odd, b_odd);
    
    // Step 2: q = ((x >> 29) * μ) >> 32
    v8i x_shr29_even = _mm256_srli_epi64(x_even, 29);
    v8i x_shr29_odd = _mm256_srli_epi64(x_odd, 29);
    
    v8i qmu_even = _mm256_mul_epu32(x_shr29_even, v_mu);
    v8i qmu_odd = _mm256_mul_epu32(x_shr29_odd, v_mu);
    
    v8i q_even = _mm256_srli_epi64(qmu_even, 32);
    v8i q_odd = _mm256_srli_epi64(qmu_odd, 32);
    
    // Step 3: r = x - q * p
    v8i qp_even = _mm256_mul_epu32(q_even, v_mod);
    v8i qp_odd = _mm256_mul_epu32(q_odd, v_mod);
    
    v8i r_even = _mm256_sub_epi64(x_even, qp_even);
    v8i r_odd = _mm256_sub_epi64(x_odd, qp_odd);
    
    // Step 4: Merge even/odd results
    v8i result = _mm256_blend_epi32(r_even, _mm256_slli_epi64(r_odd, 32), 0xAA);
    
    // Step 5: Conditional subtractions (r may be in [0, ~3p))
    // First subtraction
    v8i r1 = _mm256_sub_epi32(result, v_mod);
    v8i mask1 = _mm256_srai_epi32(r1, 31);
    result = _mm256_add_epi32(r1, _mm256_and_si256(mask1, v_mod));
    
    // Second subtraction
    v8i r2 = _mm256_sub_epi32(result, v_mod);
    v8i mask2 = _mm256_srai_epi32(r2, 31);
    result = _mm256_add_epi32(r2, _mm256_and_si256(mask2, v_mod));
    
    return result;
}

v8i _mm256_add_mod(const v8i& a, const v8i& b) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), v_mod);
    v8i mask = _mm256_srai_epi32(adjusted, 31);
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, v_mod));
}

// SIMD NTT implementation with NFLlib Barrett reduction
void ntt_SIMD(vi &a) {
    int n = sz(a), L = 31 - __builtin_clz(n);
    
    // Twiddle factors in NORMAL domain (not Montgomery)
    static vi rt(2, 1);
    for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
        rt.resize(n);
        ll z[] = {1, modpow(root, mod >> s)};
        rep(i, k, 2 * k) {
            rt[i] = ((ll)rt[i / 2] * z[i & 1]) % mod;
        }
    }

    vi rev(n);
    rep(i, 0, n) rev[i] = (rev[i / 2] | (i & 1) << L) / 2;
    rep(i, 0, n) if (i < rev[i]) swap(a[i], a[rev[i]]);

    int* a_ptr = a.data();

    // NO Montgomery conversion needed - Barrett works in normal domain

    // k = 1 
    {
        v8i v_W = _mm256_set1_epi32(rt[1]); 
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
        v8i w0 = _mm256_set1_epi32(rt[2]);
        v8i w1 = _mm256_set1_epi32(rt[3]);
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
        v8i v_W = _mm256_broadcastsi128_si256(_mm_loadu_si128((__m128i*)&rt[4]));

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
                v8i v_W = _mm256_loadu_si256((v8i*)&rt[k + j]);
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

    // NO conversion back needed - already in normal domain
}

// Test utilities
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
        
        // Test with reference implementation
        vll a_ref(input.begin(), input.end());
        ntt(a_ref);
        
        // Test with SIMD implementation
        vi a_simd = input;
        ntt_SIMD(a_simd);
        
        // Compare results
        bool match = true;
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

void benchmark(int n, int iterations = 100) {
    cout << "Benchmarking n = " << n << " (" << iterations << " iterations)...\n";
    
    vi input = generate_random_input(n);
    
    // Warm up
    for (int i = 0; i < 10; i++) {
        vll a_ref(input.begin(), input.end());
        ntt(a_ref);
        vi a_simd = input;
        ntt_SIMD(a_simd);
    }
    
    // Benchmark reference
    auto start = high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        vll a(input.begin(), input.end());
        ntt(a);
    }
    auto end = high_resolution_clock::now();
    double time_ref = duration_cast<nanoseconds>(end - start).count() / 1e6 / iterations;
    
    // Benchmark SIMD
    start = high_resolution_clock::now();
    for (int i = 0; i < iterations; i++) {
        vi a = input;
        ntt_SIMD(a);
    }
    end = high_resolution_clock::now();
    double time_simd = duration_cast<nanoseconds>(end - start).count() / 1e6 / iterations;
    
    cout << "  Reference: " << fixed << setprecision(3) << time_ref << " ms\n";
    cout << "  SIMD:      " << fixed << setprecision(3) << time_simd << " ms\n";
    cout << "  Speedup:   " << fixed << setprecision(2) << (time_ref / time_simd) << "x\n";
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
    ntt(zeros_ref);
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
    ntt(ones_ref);
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
    ntt(maxvals_ref);
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
    cout << "=== NTT Implementation Test Suite (NFLlib Barrett) ===\n";
    cout << "Modulus: " << MOD << "\n";
    cout << "Primitive root: " << root << "\n";
    cout << "Barrett μ: " << BARRETT_MU << " = floor(2^61 / MOD)\n\n";
    
    test_edge_cases();
    
    cout << "=== Correctness Tests ===\n\n";
    
    // Test various sizes
    vector<int> test_sizes = {32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536};
    
    bool all_passed = true;
    for (int n : test_sizes) {
        if (!test_correctness(n)) {
            all_passed = false;
            break;
        }
    }
    
    if (!all_passed) {
        cout << "\nCorrectness tests FAILED. Skipping benchmarks.\n";
        return 1;
    }
    
    cout << "\n=== All Correctness Tests PASSED ===\n\n";
    
    cout << "=== Performance Benchmarks ===\n\n";
    
    // Benchmark different sizes
    const int SMALL = 100;
    const int BIG = 20;
    vector<int> bench_sizes = {1024, 4096, 16384, 65536, 262144};
    for (int n : bench_sizes) {
        benchmark(n, n <= 65536 ? SMALL : BIG);
    }
    
    cout << "=== All Tests Complete ===\n";
    
    return 0;
}