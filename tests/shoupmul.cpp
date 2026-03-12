#include <immintrin.h>
#include <cstdint>
#include <iostream>
#include <iomanip>

using v8i = __m256i;

// Global modulus (you can change this)
static uint32_t MOD = 998244353;
static v8i v_mod;

// The functions to test
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

// Helper functions
void print_v8i(const char* name, v8i v) {
    uint32_t arr[8];
    _mm256_storeu_si256((v8i*)arr, v);
    std::cout << name << ": ";
    for (int i = 0; i < 8; i++) {
        std::cout << std::setw(10) << arr[i] << " ";
    }
    std::cout << std::endl;
}

// Compute bp for Shoup reduction: bp = floor(2^32 * b / p)
uint32_t compute_bp(uint32_t b, uint32_t p) {
    return ((uint64_t)b << 32) / p;
}

// Reference modular multiplication
uint32_t mod_mul_ref(uint32_t a, uint32_t b, uint32_t p) {
    return ((uint64_t)a * b) % p;
}

// Reference high 32 bits of multiplication
uint32_t mulhi_ref(uint32_t a, uint32_t b) {
    return ((uint64_t)a * b) >> 32;
}

bool test_mulhi_epi32() {
    std::cout << "\n=== Testing _mm256_mulhi_epi32 ===" << std::endl;
    
    uint32_t a_vals[8] = {1234567890, 987654321, 0xFFFFFFFF, 0x80000000, 
                          123456, 0x12345678, 0xABCDEF01, 100000};
    uint32_t b_vals[8] = {987654321, 1234567890, 0xFFFFFFFF, 0xFFFFFFFF,
                          654321, 0x87654321, 0x0FEDCBA9, 200000};
    
    v8i a = _mm256_loadu_si256((v8i*)a_vals);
    v8i b = _mm256_loadu_si256((v8i*)b_vals);
    
    v8i result = _mm256_mulhi_epi32(a, b);
    
    uint32_t result_arr[8];
    _mm256_storeu_si256((v8i*)result_arr, result);
    
    bool pass = true;
    for (int i = 0; i < 8; i++) {
        uint32_t expected = mulhi_ref(a_vals[i], b_vals[i]);
        if (result_arr[i] != expected) {
            std::cout << "FAIL at index " << i << ": "
                      << a_vals[i] << " * " << b_vals[i] 
                      << " -> got " << result_arr[i] 
                      << ", expected " << expected << std::endl;
            pass = false;
        }
    }
    
    if (pass) {
        std::cout << "PASS: All mulhi_epi32 tests passed" << std::endl;
        print_v8i("Sample result", result);
    }
    
    return pass;
}

bool test_shoup_mul() {
    std::cout << "\n=== Testing _mm258_shoup_mul ===" << std::endl;
    std::cout << "Modulus: " << MOD << std::endl;
    
    // Initialize v_mod
    uint32_t mod_arr[8] = {MOD, MOD, MOD, MOD, MOD, MOD, MOD, MOD};
    v_mod = _mm256_loadu_si256((v8i*)mod_arr);
    
    // Test values
    uint32_t a_vals[8] = {123456789, 987654321, 100000000, 500000000,
                          1, MOD-1, 123, 999999999};
    uint32_t b_vals[8] = {987654321, 123456789, 200000000, 700000000,
                          MOD-1, MOD-1, 456, 888888888};
    
    // Compute bp values
    uint32_t bp_vals[8];
    for (int i = 0; i < 8; i++) {
        bp_vals[i] = compute_bp(b_vals[i], MOD);
    }
    
    v8i a = _mm256_loadu_si256((v8i*)a_vals);
    v8i b = _mm256_loadu_si256((v8i*)b_vals);
    v8i bp = _mm256_loadu_si256((v8i*)bp_vals);
    
    v8i result = _mm258_shoup_mul(a, b, bp);
    
    uint32_t result_arr[8];
    _mm256_storeu_si256((v8i*)result_arr, result);
    
    bool pass = true;
    for (int i = 0; i < 8; i++) {
        uint32_t expected = mod_mul_ref(a_vals[i], b_vals[i], MOD);
        
        // Shoup reduction may give result in [0, 2*p), so we need to handle that
        uint32_t normalized = result_arr[i];
        if (normalized >= MOD) normalized -= MOD;
        
        if (normalized != expected) {
            std::cout << "FAIL at index " << i << ": "
                      << a_vals[i] << " * " << b_vals[i] << " mod " << MOD
                      << " -> got " << result_arr[i] 
                      << " (normalized: " << normalized << ")"
                      << ", expected " << expected << std::endl;
            std::cout << "  bp[" << i << "] = " << bp_vals[i] << std::endl;
            pass = false;
        }
    }
    
    if (pass) {
        std::cout << "PASS: All shoup_mul tests passed" << std::endl;
        print_v8i("a       ", a);
        print_v8i("b       ", b);
        print_v8i("bp      ", bp);
        print_v8i("a*b % p ", result);
    }
    
    return pass;
}

int main() {
    std::cout << "SIMD Shoup Multiplication Test" << std::endl;
    std::cout << "===============================" << std::endl;
    
    bool test1 = test_mulhi_epi32();
    bool test2 = test_shoup_mul();
    
    std::cout << "\n=== Summary ===" << std::endl;
    std::cout << "mulhi_epi32: " << (test1 ? "PASS" : "FAIL") << std::endl;
    std::cout << "shoup_mul:   " << (test2 ? "PASS" : "FAIL") << std::endl;
    
    return (test1 && test2) ? 0 : 1;
}