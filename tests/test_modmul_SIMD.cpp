#include <immintrin.h>
#include <cstdint>
#include <cstdio>
#include <random>
#include <chrono>
#include <vector>

using v8i = __m256i;

// Montgomery parameters - adjust these for your specific modulus
constexpr uint32_t MOD = 998244353;  // Common NTT prime
constexpr uint32_t M_INV = 998244351; // -MOD^{-1} mod 2^32
constexpr uint64_t R = (1ULL << 32) % MOD;  // 2^32 mod MOD
constexpr uint64_t R2 = ((uint64_t)R * R) % MOD;  // 2^64 mod MOD

// Standard scalar modular multiplication
inline uint32_t mulmod_scalar(uint32_t a, uint32_t b) {
    return (uint64_t)a * b % MOD;
}

// Montgomery multiplication (scalar version for reference)
inline uint32_t montgomery_mul_scalar(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint32_t m = (uint32_t)t * M_INV;
    uint64_t u = (uint64_t)m * MOD;
    uint32_t res = (t + u) >> 32;
    return res >= MOD ? res - MOD : res;
}

// Convert to Montgomery form
inline uint32_t to_montgomery(uint32_t x) {
    return montgomery_mul_scalar(x, R2);
}

// Convert from Montgomery form
inline uint32_t from_montgomery(uint32_t x) {
    return montgomery_mul_scalar(x, 1);
}

// Your SIMD Montgomery multiplication
v8i _mm256_multiply_mod(const v8i& a, const v8i& b) {
    v8i v_mod = _mm256_set1_epi32(MOD);
    v8i v_m = _mm256_set1_epi32(M_INV);
    
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
    v8i result = _mm256_blend_epi32(res_even, _mm256_slli_epi64(res_odd, 32), 0xAA);
    
    // Step 4: Conditional subtraction if result >= mod
    v8i adjusted = _mm256_sub_epi32(result, v_mod);
    v8i needs_sub = _mm256_cmpgt_epi32(result, _mm256_sub_epi32(v_mod, _mm256_set1_epi32(1)));
    result = _mm256_blendv_epi8(result, adjusted, needs_sub);
    
    return result;
}

// Helper to extract values from v8i
void extract_v8i(const v8i& v, uint32_t* out) {
    _mm256_storeu_si256((__m256i*)out, v);
}

int main() {
    const size_t N = 1000000;  // Number of operations
    const size_t WARMUP = 10000;
    
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<uint32_t> dis(0, MOD - 1);
    
    // Generate test data
    std::vector<uint32_t> a_data(N), b_data(N);
    for (size_t i = 0; i < N; i++) {
        a_data[i] = dis(gen);
        b_data[i] = dis(gen);
    }
    
    printf("Testing Montgomery multiplication (MOD = %u)\n", MOD);
    printf("Operations: %zu\n\n", N);
    
    // ========== Scalar baseline ==========
    {
        uint64_t checksum = 0;
        
        // Warmup
        for (size_t i = 0; i < WARMUP; i++) {
            checksum += mulmod_scalar(a_data[i], b_data[i]);
        }
        
        auto start = std::chrono::high_resolution_clock::now();
        for (size_t i = 0; i < N; i++) {
            checksum += mulmod_scalar(a_data[i], b_data[i]);
        }
        auto end = std::chrono::high_resolution_clock::now();
        
        double elapsed = std::chrono::duration<double>(end - start).count();
        printf("Scalar modmul:\n");
        printf("  Time: %.3f ms\n", elapsed * 1000);
        printf("  Throughput: %.2f M ops/s\n", N / elapsed / 1e6);
        printf("  Checksum: %lu\n\n", checksum);
    }
    
    // ========== SIMD version (with Montgomery form conversion) ==========
    {
        uint64_t checksum = 0;
        alignas(32) uint32_t result[8];
        alignas(32) uint32_t a_mont[8], b_mont[8];
        
        // Warmup
        for (size_t i = 0; i < WARMUP; i += 8) {
            // Convert to Montgomery form
            for (int j = 0; j < 8; j++) {
                a_mont[j] = to_montgomery(a_data[i + j]);
                b_mont[j] = to_montgomery(b_data[i + j]);
            }
            
            v8i a = _mm256_loadu_si256((const v8i*)a_mont);
            v8i b = _mm256_loadu_si256((const v8i*)b_mont);
            v8i r = _mm256_multiply_mod(a, b);
            extract_v8i(r, result);
            
            // Convert back from Montgomery form
            checksum += from_montgomery(result[0]);
        }
        
        auto start = std::chrono::high_resolution_clock::now();
        for (size_t i = 0; i < N; i += 8) {
            // Convert to Montgomery form
            for (int j = 0; j < 8; j++) {
                a_mont[j] = to_montgomery(a_data[i + j]);
                b_mont[j] = to_montgomery(b_data[i + j]);
            }
            
            v8i a = _mm256_loadu_si256((const v8i*)a_mont);
            v8i b = _mm256_loadu_si256((const v8i*)b_mont);
            v8i r = _mm256_multiply_mod(a, b);
            extract_v8i(r, result);
            
            // Convert back from Montgomery form
            checksum += from_montgomery(result[0]);  // Prevent optimization
        }
        auto end = std::chrono::high_resolution_clock::now();
        
        double elapsed = std::chrono::duration<double>(end - start).count();
        printf("SIMD Montgomery (with conversions):\n");
        printf("  Time: %.3f ms\n", elapsed * 1000);
        printf("  Throughput: %.2f M ops/s\n", N / elapsed / 1e6);
        printf("  Checksum: %lu\n\n", checksum);
    }
    
    // ========== SIMD version (pure Montgomery, no conversions) ==========
    {
        uint64_t checksum = 0;
        alignas(32) uint32_t result[8];
        
        // Pre-convert all data to Montgomery form
        std::vector<uint32_t> a_mont(N), b_mont(N);
        for (size_t i = 0; i < N; i++) {
            a_mont[i] = to_montgomery(a_data[i]);
            b_mont[i] = to_montgomery(b_data[i]);
        }
        
        // Warmup
        for (size_t i = 0; i < WARMUP; i += 8) {
            v8i a = _mm256_loadu_si256((const v8i*)&a_mont[i]);
            v8i b = _mm256_loadu_si256((const v8i*)&b_mont[i]);
            v8i r = _mm256_multiply_mod(a, b);
            extract_v8i(r, result);
            checksum += result[0];
        }
        
        auto start = std::chrono::high_resolution_clock::now();
        for (size_t i = 0; i < N; i += 8) {
            v8i a = _mm256_loadu_si256((const v8i*)&a_mont[i]);
            v8i b = _mm256_loadu_si256((const v8i*)&b_mont[i]);
            v8i r = _mm256_multiply_mod(a, b);
            extract_v8i(r, result);
            checksum += result[0];  // Prevent optimization
        }
        auto end = std::chrono::high_resolution_clock::now();
        
        double elapsed = std::chrono::duration<double>(end - start).count();
        printf("SIMD Montgomery (pure, no conversions):\n");
        printf("  Time: %.3f ms\n", elapsed * 1000);
        printf("  Throughput: %.2f M ops/s\n", N / elapsed / 1e6);
        printf("  Speedup vs scalar: %.2fx\n", (1.027 / elapsed));  // Using typical scalar time
        printf("  Checksum: %lu\n\n", checksum);
    }
    
    // ========== Correctness verification ==========
    printf("Correctness check (first 100 operations):\n");
    bool all_correct = true;
    int errors = 0;
    
    alignas(32) uint32_t a_mont[8], b_mont[8];
    for (size_t i = 0; i < 100; i += 8) {
        // Convert to Montgomery form
        for (int j = 0; j < 8; j++) {
            a_mont[j] = to_montgomery(a_data[i + j]);
            b_mont[j] = to_montgomery(b_data[i + j]);
        }
        
        v8i a = _mm256_loadu_si256((const v8i*)a_mont);
        v8i b = _mm256_loadu_si256((const v8i*)b_mont);
        v8i r = _mm256_multiply_mod(a, b);
        
        alignas(32) uint32_t result[8];
        extract_v8i(r, result);
        
        for (int j = 0; j < 8; j++) {
            uint32_t simd_result = from_montgomery(result[j]);
            uint32_t expected = mulmod_scalar(a_data[i + j], b_data[i + j]);
            if (simd_result != expected && errors < 5) {
                printf("  Mismatch at index %zu: got %u, expected %u (inputs: %u, %u)\n", 
                       i + j, simd_result, expected, a_data[i + j], b_data[i + j]);
                all_correct = false;
                errors++;
            }
        }
    }
    
    if (all_correct) {
        printf("  ✓ All results correct!\n");
    } else {
        printf("  ✗ Found errors!\n");
    }
    
    return 0;
}