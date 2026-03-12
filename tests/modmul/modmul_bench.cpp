#pragma GCC target("avx2")
#include <immintrin.h>
#include <chrono>
#include <iostream>
#include <random>
#include <vector>
using namespace std;

constexpr uint32_t MOD = 998244353;
constexpr uint64_t M_INV = 998244351ULL;

// ============ Double/Float Logic ============

using v4d = __m256d;
const v4d db_mod = _mm256_set1_pd(MOD);
const v4d db_recip = _mm256_set1_pd(1.0 / MOD);

inline v4d reduce(v4d x) {
    v4d q = _mm256_mul_pd(x, db_recip);
    q = _mm256_round_pd(q, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
}
inline v4d mul_mod_f64_avx2(v4d a, v4d b) {
    v4d x = _mm256_mul_pd(a, b);
    v4d q = _mm256_mul_pd(x, db_recip);
    q = _mm256_round_pd(q, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
    v4d y = _mm256_fmsub_pd(a, b, x);
    v4d z = _mm256_fnmadd_pd(q, db_mod, x);
    v4d d = _mm256_add_pd(z, y);
    return d;
}

// ============ Int Logic ============

typedef __m256i v8i;

inline v8i lmove(v8i x) {
    return _mm256_bsrli_epi128(x, 4);
}

const v8i v_mod = _mm256_set1_epi32(MOD);

// Montgomery with v_mod parameter
inline v8i _mm256_mont_mul(v8i a, v8i b, v8i bninv, v8i v_mod) {
    v8i aa = lmove(a);
    v8i cc = _mm256_mul_epu32(a, bninv);
    v8i dd = _mm256_mul_epu32(aa, bninv);
    v8i c = _mm256_mul_epu32(a, b);
    v8i d = _mm256_mul_epu32(aa, b);
    cc = _mm256_mul_epu32(cc, v_mod);
    dd = _mm256_mul_epu32(dd, v_mod);
    return _mm256_or_si256(lmove(_mm256_add_epi64(c, cc)), _mm256_add_epi64(d, dd));
}

// Shoup's multiplication
inline v8i _mm256_mulhi_epi32(v8i a, v8i b) {
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i even = _mm256_mul_epu32(a, b);
    v8i odd = _mm256_mul_epu32(a_odd, b_odd);
    v8i even_high = _mm256_srli_epi64(even, 32);
    return _mm256_blend_epi32(even_high, odd, 0xAA);
}

inline v8i _mm256_shoup_mul(v8i a, v8i b, v8i bp, v8i v_mod) {
    v8i t = _mm256_mulhi_epi32(a, bp);
    v8i p = _mm256_mullo_epi32(a, b);
    v8i q = _mm256_mullo_epi32(t, v_mod);
    return _mm256_sub_epi32(p, q);
}

int main() {
    const int NUM_VECTORS = 1000;
    const int ITERATIONS = 10000;
    
    mt19937 gen(42);
    uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    
    // Prepare data
    vector<v8i> data_a(NUM_VECTORS);
    vector<v8i> data_b(NUM_VECTORS);
    vector<v8i> data_bp(NUM_VECTORS);
    vector<v4d> data_da(NUM_VECTORS * 2);
    vector<v4d> data_db(NUM_VECTORS * 2);
    
    for (int i = 0; i < NUM_VECTORS; i++) {
        alignas(32) uint32_t vals_a[8], vals_b[8], vals_bp[8];
        alignas(32) double dvals_a[4], dvals_b[4];
        
        for (int j = 0; j < 8; j++) {
            vals_a[j] = dist(gen);
            vals_b[j] = dist(gen);
            vals_bp[j] = (uint32_t)(((uint64_t)vals_b[j] << 32) / MOD);
            
            if (j < 4) {
                dvals_a[j] = vals_a[j];
                dvals_b[j] = vals_b[j];
            }
        }
        
        data_a[i] = _mm256_load_si256((v8i*)vals_a);
        data_b[i] = _mm256_load_si256((v8i*)vals_b);
        data_bp[i] = _mm256_load_si256((v8i*)vals_bp);
        
        if (i * 2 < NUM_VECTORS * 2) {
            data_da[i * 2] = _mm256_load_pd(dvals_a);
            data_db[i * 2] = _mm256_load_pd(dvals_b);
            
            for (int j = 0; j < 4; j++) {
                dvals_a[j] = vals_a[j + 4];
                dvals_b[j] = vals_b[j + 4];
            }
            data_da[i * 2 + 1] = _mm256_load_pd(dvals_a);
            data_db[i * 2 + 1] = _mm256_load_pd(dvals_b);
        }
    }
    
    v8i v_mod_param = _mm256_set1_epi32(MOD);
    v8i acc = _mm256_setzero_si256();
    v4d dacc = _mm256_setzero_pd();
    
    cout << "Running benchmarks (" << ITERATIONS << " iterations, " << NUM_VECTORS << " vectors)...\n\n";

    // Double version
    {
        auto start = chrono::high_resolution_clock::now();
        for (int iter = 0; iter < ITERATIONS; iter++) {
            for (int i = 0; i < NUM_VECTORS * 2; i++) {
                dacc = _mm256_xor_pd(dacc, mul_mod_f64_avx2(data_da[i], data_db[i]));
            }
        }
        auto end = chrono::high_resolution_clock::now();
        chrono::duration<double> diff = end - start;
        cout << "mul_mod_f64_avx2 (double):      " << diff.count() << "s\n";
        
        alignas(32) double tmp[4];
        _mm256_store_pd(tmp, dacc);
        cout << "  Checksum: " << tmp[0] + tmp[1] + tmp[2] + tmp[3] << "\n\n";
    }
    // Montgomery
    {
        acc = _mm256_setzero_si256();
        auto start = chrono::high_resolution_clock::now();
        for (int iter = 0; iter < ITERATIONS; iter++) {
            for (int i = 0; i < NUM_VECTORS; i++) {
                acc = _mm256_xor_si256(acc, _mm256_mont_mul(data_a[i], data_b[i], data_bp[i], v_mod_param));
            }
        }
        auto end = chrono::high_resolution_clock::now();
        chrono::duration<double> diff = end - start;
        cout << "_mm256_mont_mul (int):          " << diff.count() << "s\n";
        
        alignas(32) uint32_t tmp[8];
        _mm256_store_si256((v8i*)tmp, acc);
        uint64_t sum = 0;
        for (int i = 0; i < 8; i++) sum += tmp[i];
        cout << "  Checksum: " << sum << "\n\n";
    }

    // Shoup
    {
        acc = _mm256_setzero_si256();
        auto start = chrono::high_resolution_clock::now();
        for (int iter = 0; iter < ITERATIONS; iter++) {
            for (int i = 0; i < NUM_VECTORS; i++) {
                acc = _mm256_xor_si256(acc, _mm256_shoup_mul(data_a[i], data_b[i], data_bp[i], v_mod_param));
            }
        }
        auto end = chrono::high_resolution_clock::now();
        chrono::duration<double> diff = end - start;
        cout << "_mm256_shoup_mul (int):         " << diff.count() << "s\n";
        
        alignas(32) uint32_t tmp[8];
        _mm256_store_si256((v8i*)tmp, acc);
        uint64_t sum = 0;
        for (int i = 0; i < 8; i++) sum += tmp[i];
        cout << "  Checksum: " << sum << "\n\n";
    }

    return 0;
}
/*
Running benchmarks (10000 iterations, 1000 vectors)...

mul_mod_f64_avx2 (double):      0.0180423s
  Checksum: 0

_mm256_mont_mul (int):          0.0110911s
  Checksum: 0

_mm256_shoup_mul (int):         0.0135459s
  Checksum: 0


*/