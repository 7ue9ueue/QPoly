#pragma GCC target("avx2")
#include <immintrin.h>
#include <iostream>
#include <chrono>
#include <random>
#include <vector>

using v8i = __m256i;

// Global constants
constexpr uint32_t MOD = 998244353;
constexpr uint64_t M_INV = 998244351ULL; 

// ============ Montgomery Multiplication ============
inline v8i lmove(v8i x) {
    return _mm256_bsrli_epi128(x, 4);
}
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


// ============ Shoup's Multiplication ============

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

// ============ Main ============

int main() {
    // Initialize constants inside main
    v8i v_mod = _mm256_set1_epi32(MOD);
    v8i v_m = _mm256_set1_epi64x(M_INV);

    const int NUM_VECTORS = 1000;
    const int ITERATIONS = 10000; // Reduced for testing
    
    std::mt19937 gen(42);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    
    std::vector<v8i> data_a(NUM_VECTORS);
    std::vector<v8i> data_b(NUM_VECTORS);
    std::vector<v8i> data_bp(NUM_VECTORS); 
    
    for (int i = 0; i < NUM_VECTORS; i++) {
        alignas(32) uint32_t vals_a[8], vals_b[8], vals_bp[8];
        for (int j = 0; j < 8; j++) {
            vals_a[j] = dist(gen);
            vals_b[j] = dist(gen);
            vals_bp[j] = (uint32_t)(((uint64_t)vals_b[j] << 32) / MOD);
        }
        data_a[i] = _mm256_load_si256((v8i*)vals_a);
        data_b[i] = _mm256_load_si256((v8i*)vals_b);
        data_bp[i] = _mm256_load_si256((v8i*)vals_bp);
    }
    
    v8i acc = _mm256_setzero_si256();
    std::cout << "Benchmarking...\n";

    // Montgomery
    auto start = std::chrono::high_resolution_clock::now();
    for (int iter = 0; iter < ITERATIONS; iter++) {
        v8i acc0 = _mm256_setzero_si256();
        v8i acc1 = _mm256_setzero_si256();
        for (int i = 0; i < NUM_VECTORS; i += 2) {
            acc0 = _mm256_xor_si256(acc0, _mm256_mont_mul(data_a[i], data_b[i], data_bp[i], v_mod));
            acc1 = _mm256_xor_si256(acc1, _mm256_mont_mul(data_a[i + 1], data_b[i + 1], data_bp[i + 1], v_mod));
        }
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> diff = end - start;
    std::cout << "Montgomery Time: " << diff.count() << "s\n";

    // Shoup
    start = std::chrono::high_resolution_clock::now();
    for (int iter = 0; iter < ITERATIONS; iter++) {
        for (int i = 0; i < NUM_VECTORS; i++) {
            acc = _mm256_xor_si256(acc, _mm256_shoup_mul(data_a[i], data_b[i], data_bp[i], v_mod));
        }
    }
    end = std::chrono::high_resolution_clock::now();
    diff = end - start;
    std::cout << "Shoup Time: " << diff.count() << "s\n";

    return 0;
}