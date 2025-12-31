// #pragma GCC optimize("O3,unroll-loops")
// #pragma GCC target("avx2,bmi,bmi2,lzcnt,popcnt")
#include <bits/stdc++.h>
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

template<class T> bool cmax(T &a, const T &b) {
    return a < b ? a = b, 1 : 0;
}

template<class T> bool cmin(T &a, const T &b) {
    return b < a ? a = b, 1 : 0;
}

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
const uint32_t R2_MOD = 932051910;
const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_m = _mm256_set1_epi32(M_INV);

v8i _mm256_multiply_mod(const v8i& a, const v8i& b) {    
    // Step 1: Multiply a * b to get 64-bit result (t1:t0)
    // Handle even lanes (0,2,4,6)
    v8i t_even = _mm256_mul_epu32(a, b);  // lanes 0,2,4,6 -> 64-bit results
    
    // Handle odd lanes (1,3,5,7) by shifting into even positions
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
    
    // Step 2: Compute u = (t0 * m) mod 2^32 (just keep low 32 bits)
    v8i u_even = _mm256_mullo_epi32(t_even, v_m);
    v8i u_odd = _mm256_mullo_epi32(t_odd, v_m);
    
    // Step 3: Compute (t + u*p) >> 32
    v8i up_even = _mm256_mul_epu32(u_even, v_mod);
    v8i up_odd = _mm256_mul_epu32(u_odd, v_mod);
    
    v8i sum_even = _mm256_add_epi64(t_even, up_even);
    v8i sum_odd = _mm256_add_epi64(t_odd, up_odd);
    
    // Extract high 32 bits (the result after division by 2^32)
    v8i res_even = _mm256_srli_epi64(sum_even, 32);
    v8i res_odd = _mm256_srli_epi64(sum_odd, 32);
    
    // Merge even and odd lanes back together
    // res_even: [r0, 0, r2, 0, r4, 0, r6, 0] (32-bit view)
    // res_odd:  [r1, 0, r3, 0, r5, 0, r7, 0] (32-bit view)
    v8i result = _mm256_blend_epi32(res_even, _mm256_slli_epi64(res_odd, 32), 0xAA); // 0xAA = 10101010
    
    // Step 4: Conditional subtraction if result >= mod
    // Compare unsigned: result >= mod means result - mod doesn't underflow
    v8i adjusted = _mm256_sub_epi32(result, v_mod);
    v8i needs_sub = _mm256_cmpgt_epi32(result, _mm256_sub_epi32(v_mod, _mm256_set1_epi32(1)));
    result = _mm256_blendv_epi8(result, adjusted, needs_sub);
    
    return result;
}

v8i _mm256_add_mod(const v8i& a, const v8i& b) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), v_mod);
    v8i mask = _mm256_srai_epi32(adjusted, 31);
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, v_mod));
}

v8i _mm256_add_mod(const v8i& a, const v8i& b) {
    static const v8i N1 = _mm256_set1_epi32(-1);
    v8i sum = _mm256_add_epi32(a, b);
    v8i adjusted = _mm256_sub_epi32(sum, v_mod);
    v8i mask = _mm256_cmpgt_epi32(adjusted, N1);
    return _mm256_blendv_epi8(sum, adjusted, mask);
}

const v8i v_r2 = _mm256_set1_epi32(R2_MOD);
const v8i v_one = _mm256_set1_epi32(1);

// n must be power of 2 and n >= 32. 
// load 32 bits and only use 64 bits in calculation.
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

    // (A, B) -> (A + wB, A - wB) SIMB butterfly. O(n log n).
    // Convert to Montgomery: MontMul(a, R^2) = a * R mod N
    int n_batched = n / 8; // must be divisible. 
    int* a_ptr = a.data();

    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
        v = _mm256_multiply_mod(v, v_r2);
        _mm256_storeu_si256((v8i*)(a_ptr + i), v);
    }

    // k = 1 
    {
        for (int i = 0; i < n; i += 8) {
            v8i v_I = _mm256_loadu_si256((v8i*)(a_ptr + i)); // [A0, B0, A1, B1, ...]

            v8i v_A = _mm256_shuffle_epi32(v_I, _MM_SHUFFLE(2, 2, 0, 0)); // [A0, A0, A1, A1, ...]
            v8i v_B = _mm256_shuffle_epi32(v_I, _MM_SHUFFLE(3, 3, 1, 1)); // [B0, B0, B1, B1, ...]

            v8i v_W = _mm256_set1_epi32(rt_mont[1]); // [W, W, ...]
            v8i v_WB = _mm256_multiply_mod(v_W, v_B);  // [W*B0, W*B0, W*B1, W*B1, ...]
            
            v8i v_neg_WB = _mm256_sub_epi32(v_mod, v_WB); // [MOD-W*B0, MOD-W*B0, MOD-W*B1, MOD-W*B1,...]
            
            v8i v_WB_interleaved = _mm256_blend_epi32(v_WB, v_neg_WB, 0xAA); // Interleave: [WB, MOD-WB, WB, MOD-WB, ...]
            
            v8i result = _mm256_add_mod(v_A, v_WB_interleaved);
            _mm256_storeu_si256((v8i*)(a_ptr + i), result);
        }
    }
    // k = 2
    {
        
    }
    // k = 4
    {

    }
    // k > 4
    {

    }
    // Convert from Montgomery: MontMul(a_mont, 1) = a mod N
    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(a_ptr + i));
        v = _mm256_multiply_mod(v, v_one);
        _mm256_storeu_si256((v8i*)(a_ptr + i), v);
    }
}

vll conv(const vll &a, const vll &b) {
    if (a.empty() || b.empty()) return {};
    int s = sz(a) + sz(b) - 1;
    int B = 32 - __builtin_clz(s);
    int n = 1 << B;
    ll inv = modpow(n, mod - 2, mod);
    vll L(a), R(b), out(n);
    L.resize(n);
    R.resize(n);
    ntt(L);
    ntt(R);
    rep(i, 0, n) out[-i & (n - 1)] = (ll)L[i] * R[i] % mod * inv % mod;
    ntt(out);
    return {out.begin(), out.begin() + s};
}

int main() {
    cin.tie(0)->sync_with_stdio(0);
    cin.exceptions(cin.failbit);
}