#include <immintrin.h>
#include <cstdint>
#include <cstdio>
#include <cassert>

// Your function
inline __m256i _mm256_mulhi_epu32(const __m256i a, const __m256i b) {
    __m256i even = _mm256_mul_epu32(a, b);
    __m256i a_odd = _mm256_srli_epi64(a, 32);
    __m256i b_odd = _mm256_srli_epi64(b, 32);
    __m256i odd = _mm256_mul_epu32(a_odd, b_odd);
    __m256i even_high = _mm256_srli_epi64(even, 32);
    return _mm256_blend_epi32(even_high, odd, 0xAA);
}

// Reference scalar implementation
uint32_t mulhi_epu32_scalar(uint32_t a, uint32_t b) {
    return (uint32_t)(((uint64_t)a * (uint64_t)b) >> 32);
}

void test_mulhi() {
    // Test data: 8 pairs of 32-bit unsigned integers
    alignas(32) uint32_t a_data[8] = {
        0x00000000, 0xFFFFFFFF, 0x80000000, 0x12345678,
        0xABCDEF00, 0x00000001, 0x7FFFFFFF, 0xDEADBEEF
    };
    
    alignas(32) uint32_t b_data[8] = {
        0xFFFFFFFF, 0xFFFFFFFF, 0x80000000, 0x87654321,
        0x11111111, 0x00000001, 0x00000002, 0xCAFEBABE
    };
    
    // Load into SIMD registers
    __m256i a = _mm256_load_si256((__m256i*)a_data);
    __m256i b = _mm256_load_si256((__m256i*)b_data);
    
    // Compute using SIMD function
    __m256i result = _mm256_mulhi_epu32(a, b);
    
    // Extract results
    alignas(32) uint32_t result_data[8];
    _mm256_store_si256((__m256i*)result_data, result);
    
    // Verify against scalar reference
    printf("Testing _mm256_mulhi_epu32:\n");
    bool all_passed = true;
    
    for (int i = 0; i < 8; i++) {
        uint32_t expected = mulhi_epu32_scalar(a_data[i], b_data[i]);
        uint32_t actual = result_data[i];
        
        bool passed = (expected == actual);
        all_passed &= passed;
        
        printf("  [%d] 0x%08X * 0x%08X >> 32 = 0x%08X (expected 0x%08X) %s\n",
               i, a_data[i], b_data[i], actual, expected,
               passed ? "✓" : "✗ FAILED");
        
        assert(passed && "Mismatch detected!");
    }
    
    if (all_passed) {
        printf("\n✓ All tests passed!\n");
    }
}

int main() {
    test_mulhi();
    return 0;
}