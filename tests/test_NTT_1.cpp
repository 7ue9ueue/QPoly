#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")
#include <bits/stdc++.h>
#include <x86intrin.h>
using namespace std;

#define rep(i, a, b) for (auto i = a; i < (b); ++i)
#define repr(i, a, b) for (auto i = (a) - 1; i >= (b); --i)
#define pb push_back
#define eb emplace_back
#define all(x) begin(x), end(x)
#define sz(x) int((x).size())
using ll = long long;
using pii = pair<int, int>;
using vi = vector<int>;
using vll = vector<ll>;
using vii = vector<pii>;

// Modular exponentiation
ll modpow(ll base, ll exp, ll mod) {
    ll result = 1;
    base %= mod;
    while (exp > 0) {
        if (exp & 1) result = result * base % mod;
        base = base * base % mod;
        exp >>= 1;
    }
    return result;
}

const ll mod = (119 << 23) + 1, root = 62; // = 998244353

ll modpow(ll b, ll e) {
    ll ans = 1;
    for (; e; b = b * b % mod, e /= 2)
    if (e & 1) ans = ans * b % mod;
    return ans;
}

// n must be power of 2 and n >= 32. 
void ntt(vll &a) {
    int n = sz(a), L = 31 - __builtin_clz(n);
    static vll rt(2, 1);
    // O(n) 
    for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
        rt.resize(n);
        ll z[] = {1, modpow(root, mod >> s, mod)};
        rep(i, k, 2 * k) rt[i] = rt[i / 2] * z[i & 1] % mod;
    }
    vi rev(n);
    rep(i, 0, n) rev[i] = (rev[i / 2] | (i & 1) << L) / 2;
    rep(i, 0, n) if (i < rev[i]) swap(a[i], a[rev[i]]);

    // O(n log n)
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

// Precomputed constant: m = (-mod^{-1}) mod 2^32
// For mod = 998244353, m = 998244351
const uint32_t MOD = 998244353;
const uint32_t M_INV = 998244351; // Montgomery constant
const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_m = _mm256_set1_epi32(M_INV);

v8i _mm256_multiply_mod(const v8i& a, const v8i& b) {
    // Step 1: Multiply a * b
    // Even lanes (0, 2, 4, 6): get full 64-bit result
    v8i t_even = _mm256_mul_epu32(a, b);
    
    // Odd lanes (1, 3, 5, 7): Shift to low bits then multiply
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
    
    // Step 2: Compute u = (t * m) mod 2^32
    // We only need the low 32 bits of the product, so mullo works 
    // on the 64-bit t_even/t_odd directly (ignoring high garbage bits).
    v8i u_even = _mm256_mullo_epi32(t_even, v_m);
    v8i u_odd  = _mm256_mullo_epi32(t_odd,  v_m);
    
    // Step 3: Compute (t + u*p) / 2^32
    // Note: The low 32 bits of (t + u*p) are guaranteed to be zero.
    v8i up_even = _mm256_mul_epu32(u_even, v_mod);
    v8i up_odd  = _mm256_mul_epu32(u_odd,  v_mod);
    
    v8i sum_even = _mm256_add_epi64(t_even, up_even);
    v8i sum_odd  = _mm256_add_epi64(t_odd,  up_odd);
    
    // Step 4: Merge even and odd lanes
    // sum_even layout: [ Result_Even | 00...00 ] (64-bit lane)
    // sum_odd  layout: [ Result_Odd  | 00...00 ] (64-bit lane)
    
    // Shift sum_even right to move Result_Even to low 32 bits (idx 0,2,4,6)
    v8i res_even = _mm256_srli_epi64(sum_even, 32);

    // OPTIMIZATION 1: Zero-cost odd positioning
    // sum_odd already has Result_Odd in bits [63:32] (idx 1,3,5,7).
    // We can blend directly without shifting sum_odd down and back up.
    // 0xAA = 10101010 (Selects indices 1,3,5,7 from sum_odd)
    v8i result = _mm256_blend_epi32(res_even, sum_odd, 0xAA);
    
    // Step 5: Conditional subtraction if result >= mod
    // OPTIMIZATION 2: Branchless Min
    // Logic: If result < mod, (result - mod) underflows to HUGE_VAL. 
    //        min(result, HUGE) -> result.
    //        If result >= mod, (result - mod) is small.
    //        min(result, result-mod) -> result - mod.
    v8i diff = _mm256_sub_epi32(result, v_mod);
    result = _mm256_min_epu32(result, diff);
    
    return result;
}

uint32_t mont_mul_scalar(uint64_t a, uint64_t b) {
    uint64_t t = a * b;
    uint32_t u = (uint32_t)t * M_INV;
    uint64_t result = (t + (uint64_t)u * MOD) >> 32;
    if (result >= MOD) result -= MOD;
    return (uint32_t)result;
}

v8i _mm256_add_mod(const v8i& a, const v8i& b) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), v_mod);
    v8i mask = _mm256_srai_epi32(adjusted, 31);  // all 1s if negative, all 0s otherwise
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, v_mod));
}

// R^2 mod N for Montgomery conversion (R = 2^32)
const uint32_t R2_MOD = 932051910;
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);
const v8i v_one = _mm256_set1_epi32(1);

// n must be power of 2 and n >= 32. 
void ntt_SIMD(vi &a) {
    int n = sz(a), L = 31 - __builtin_clz(n);
    static vi rt(2, 1);
    static vi rt_mont(2);  // Twiddle factors in Montgomery form
    // O(n) 
    for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
        rt.resize(n);
        rt_mont.resize(n);
        ll z[] = {1, modpow(root, mod >> s, mod)};
        rep(i, k, 2 * k) {
            rt[i] = ((ll)rt[i / 2] * z[i & 1]) % mod;
            rt_mont[i] = mont_mul_scalar(rt[i], R2_MOD);
        }
    }
    rt_mont[1] = mont_mul_scalar(rt[1], R2_MOD);
    
    vi rev(n);
    rep(i, 0, n) rev[i] = (rev[i / 2] | (i & 1) << L) / 2;
    rep(i, 0, n) if (i < rev[i]) swap(a[i], a[rev[i]]);

    int* a_ptr = a.data();

    // Convert to Montgomery form
    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
        v = _mm256_multiply_mod(v, v_r2);
        _mm256_storeu_si256((v8i*)(a_ptr + i), v);
    }

    // k = 1 
v8i v_W = _mm256_set1_epi32(rt_mont[1]);

// Main unrolled loop - processes 32 elements per iteration
int i = 0;
for (; i + 32 <= n; i += 32) {
    // Iteration 0
    v8i v_I0 = _mm256_loadu_si256((v8i*)(a_ptr + i));
    v8i v_A0 = _mm256_shuffle_epi32(v_I0, _MM_SHUFFLE(2, 2, 0, 0));
    v8i v_B0 = _mm256_shuffle_epi32(v_I0, _MM_SHUFFLE(3, 3, 1, 1));
    v8i v_WB0 = _mm256_multiply_mod(v_W, v_B0);
    v8i v_neg_WB0 = _mm256_sub_epi32(v_mod, v_WB0);
    v8i v_WB_interleaved0 = _mm256_blend_epi32(v_WB0, v_neg_WB0, 0xAA);
    v8i result0 = _mm256_add_mod(v_A0, v_WB_interleaved0);
    _mm256_storeu_si256((v8i*)(a_ptr + i), result0);
    
    // Iteration 1
    v8i v_I1 = _mm256_loadu_si256((v8i*)(a_ptr + i + 8));
    v8i v_A1 = _mm256_shuffle_epi32(v_I1, _MM_SHUFFLE(2, 2, 0, 0));
    v8i v_B1 = _mm256_shuffle_epi32(v_I1, _MM_SHUFFLE(3, 3, 1, 1));
    v8i v_WB1 = _mm256_multiply_mod(v_W, v_B1);
    v8i v_neg_WB1 = _mm256_sub_epi32(v_mod, v_WB1);
    v8i v_WB_interleaved1 = _mm256_blend_epi32(v_WB1, v_neg_WB1, 0xAA);
    v8i result1 = _mm256_add_mod(v_A1, v_WB_interleaved1);
    _mm256_storeu_si256((v8i*)(a_ptr + i + 8), result1);
    
    // Iteration 2
    v8i v_I2 = _mm256_loadu_si256((v8i*)(a_ptr + i + 16));
    v8i v_A2 = _mm256_shuffle_epi32(v_I2, _MM_SHUFFLE(2, 2, 0, 0));
    v8i v_B2 = _mm256_shuffle_epi32(v_I2, _MM_SHUFFLE(3, 3, 1, 1));
    v8i v_WB2 = _mm256_multiply_mod(v_W, v_B2);
    v8i v_neg_WB2 = _mm256_sub_epi32(v_mod, v_WB2);
    v8i v_WB_interleaved2 = _mm256_blend_epi32(v_WB2, v_neg_WB2, 0xAA);
    v8i result2 = _mm256_add_mod(v_A2, v_WB_interleaved2);
    _mm256_storeu_si256((v8i*)(a_ptr + i + 16), result2);
    
    // Iteration 3
    v8i v_I3 = _mm256_loadu_si256((v8i*)(a_ptr + i + 24));
    v8i v_A3 = _mm256_shuffle_epi32(v_I3, _MM_SHUFFLE(2, 2, 0, 0));
    v8i v_B3 = _mm256_shuffle_epi32(v_I3, _MM_SHUFFLE(3, 3, 1, 1));
    v8i v_WB3 = _mm256_multiply_mod(v_W, v_B3);
    v8i v_neg_WB3 = _mm256_sub_epi32(v_mod, v_WB3);
    v8i v_WB_interleaved3 = _mm256_blend_epi32(v_WB3, v_neg_WB3, 0xAA);
    v8i result3 = _mm256_add_mod(v_A3, v_WB_interleaved3);
    _mm256_storeu_si256((v8i*)(a_ptr + i + 24), result3);
}
    
    // k >= 2: TODO - currently incomplete
    for (int k = 2; k < n; k *= 2) {
        for (int i = 0; i < n; i += 2 * k) {
            rep(j, 0, k) {
                uint32_t w = rt_mont[j + k];
                uint32_t u = a[i + j];
                uint32_t v = mont_mul_scalar(w, a[i + j + k]);
                a[i + j] = (u + v >= MOD) ? (u + v - MOD) : (u + v);
                a[i + j + k] = (u >= v) ? (u - v) : (u - v + MOD);
            }
        }
    }
    
    // Convert from Montgomery form
    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
        v = _mm256_multiply_mod(v, v_one);
        _mm256_storeu_si256((v8i*)(a_ptr + i), v);
    }
}

// Reference NTT with Montgomery (for fair speed comparison)
void ntt_mont_ref(vi &a) {
    int n = sz(a), L = 31 - __builtin_clz(n);
    static vi rt(2, 1);
    static vi rt_mont(2);
    
    for (static int k = 2, s = 2; k < n; k *= 2, ++s) {
        rt.resize(n);
        rt_mont.resize(n);
        ll z[] = {1, modpow(root, mod >> s, mod)};
        rep(i, k, 2 * k) {
            rt[i] = ((ll)rt[i / 2] * z[i & 1]) % mod;
            rt_mont[i] = mont_mul_scalar(rt[i], R2_MOD);
        }
    }
    rt_mont[1] = mont_mul_scalar(rt[1], R2_MOD);
    
    vi rev(n);
    rep(i, 0, n) rev[i] = (rev[i / 2] | (i & 1) << L) / 2;
    rep(i, 0, n) if (i < rev[i]) swap(a[i], a[rev[i]]);

    // Convert to Montgomery
    rep(i, 0, n) a[i] = mont_mul_scalar(a[i], R2_MOD);
    
    // Butterfly with Montgomery multiplication
    for (int k = 1; k < n; k *= 2) {
        for (int i = 0; i < n; i += 2 * k) {
            rep(j, 0, k) {
                uint32_t w = rt_mont[j + k];
                uint32_t u = a[i + j];
                uint32_t v = mont_mul_scalar(w, a[i + j + k]);
                a[i + j] = (u + v >= MOD) ? (u + v - MOD) : (u + v);
                a[i + j + k] = (u >= v) ? (u - v) : (u - v + MOD);
            }
        }
    }
    
    // Convert from Montgomery
    rep(i, 0, n) a[i] = mont_mul_scalar(a[i], 1);
}

void test_correctness() {
    cout << "=== Testing Correctness ===" << endl;
    
    vector<int> sizes = {32, 64, 128, 256, 512, 1024, 2048, 4096, 8192};
    mt19937 rng(42);
    uniform_int_distribution<int> dist(0, MOD - 1);
    
    bool all_passed = true;
    
    for (int n : sizes) {
        vi a(n), b(n);
        vll a_ref(n);
        
        // Generate random input
        rep(i, 0, n) {
            a[i] = b[i] = a_ref[i] = dist(rng);
        }
        
        // Run both implementations
        ntt_SIMD(a);
        ntt(a_ref);
        
        // Compare results
        bool match = true;
        rep(i, 0, n) {
            if (a[i] != (int)a_ref[i]) {
                match = false;
                break;
            }
        }
        
        if (match) {
            cout << "n = " << setw(5) << n << ": PASSED" << endl;
        } else {
            cout << "n = " << setw(5) << n << ": FAILED" << endl;
            all_passed = false;
            
            // Show first few differences
            int diff_count = 0;
            rep(i, 0, min(n, 16)) {
                if (a[i] != (int)a_ref[i]) {
                    cout << "  a[" << i << "] = " << a[i] 
                         << ", expected = " << a_ref[i] << endl;
                    if (++diff_count >= 5) break;
                }
            }
        }
    }
    
    cout << "\nOverall: " << (all_passed ? "ALL TESTS PASSED" : "SOME TESTS FAILED") << endl;
    cout << endl;
}

void test_speed() {
    cout << "=== Testing Speed ===" << endl;
    
    vector<int> sizes = {1024, 2048, 4096, 8192, 16384, 32768, 65536};
    const int ITERATIONS = 100;
    mt19937 rng(12345);
    uniform_int_distribution<int> dist(0, MOD - 1);
    
    cout << fixed << setprecision(3);
    cout << setw(10) << "Size" 
         << setw(15) << "Reference (ms)" 
         << setw(15) << "SIMD (ms)" 
         << setw(12) << "Speedup" << endl;
    cout << string(52, '-') << endl;
    
    for (int n : sizes) {
        vi a(n), b(n);
        
        // Warmup and generate data
        rep(i, 0, n) a[i] = b[i] = dist(rng);
        
        // Benchmark reference implementation
        auto t1 = chrono::high_resolution_clock::now();
        for (int iter = 0; iter < ITERATIONS; iter++) {
            vi temp = a;
            ntt_mont_ref(temp);
            // Prevent optimization
            if (temp[0] == -1) cout << "";
        }
        auto t2 = chrono::high_resolution_clock::now();
        double time_ref = chrono::duration<double, milli>(t2 - t1).count() / ITERATIONS;
        
        // Benchmark SIMD implementation
        auto t3 = chrono::high_resolution_clock::now();
        for (int iter = 0; iter < ITERATIONS; iter++) {
            vi temp = b;
            ntt_SIMD(temp);
            // Prevent optimization
            if (temp[0] == -1) cout << "";
        }
        auto t4 = chrono::high_resolution_clock::now();
        double time_simd = chrono::duration<double, milli>(t4 - t3).count() / ITERATIONS;
        
        double speedup = time_ref / time_simd;
        
        cout << setw(10) << n
             << setw(15) << time_ref
             << setw(15) << time_simd
             << setw(11) << speedup << "x" << endl;
    }
    cout << endl;
}

int main() {
    cout << "NTT SIMD Implementation Test\n" << endl;
    cout << "Montgomery constant R^2 mod p = " << R2_MOD << endl;
    cout << "M_INV = " << M_INV << "\n" << endl;
    
    test_correctness();
    test_speed();
    
    return 0;
}
/*
NTT SIMD Implementation Test

Montgomery constant R^2 mod p = 932051910
M_INV = 998244351

=== Testing Correctness ===
n =    32: PASSED
n =    64: PASSED
n =   128: PASSED
n =   256: PASSED
n =   512: PASSED
n =  1024: PASSED
n =  2048: PASSED
n =  4096: PASSED
n =  8192: PASSED

Overall: ALL TESTS PASSED

=== Testing Speed ===
      Size Reference (ms)      SIMD (ms)     Speedup
----------------------------------------------------
      1024          0.013          0.011      1.250x
      2048          0.028          0.023      1.247x
      4096          0.059          0.047      1.252x
      8192          0.133          0.107      1.241x
     16384          0.291          0.233      1.248x
     32768          0.664          0.554      1.200x
     65536          1.514          1.173      1.291x
*/