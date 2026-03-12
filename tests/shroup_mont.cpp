#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2")
#include <immintrin.h>
#include <cstdint>
#include <chrono>
#include <iostream>
#include <iomanip>

using u32 = uint32_t;
using u64 = uint64_t;
typedef __m256i v8i;

constexpr u32 MOD = 998244353;
constexpr u32 M_INV = 998244351;

static void escape(void* p) { asm volatile("" : : "g"(p) : "memory"); }

// ============================================================================
// Test pure instruction throughput (no dependencies)
// ============================================================================
void test_throughput() {
    std::cout << "=== Pure Instruction Throughput Test ===\n\n";
    
    alignas(32) u32 data[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    v8i a = _mm256_load_si256((v8i*)data);
    v8i b = _mm256_load_si256((v8i*)data);
    v8i c = _mm256_load_si256((v8i*)data);
    v8i d = _mm256_load_si256((v8i*)data);
    
    const long ITERS = 100000000L;
    
    // Test vpmuludq throughput (should be 2/cycle)
    auto start = std::chrono::high_resolution_clock::now();
    for (long i = 0; i < ITERS; ++i) {
        a = _mm256_mul_epu32(a, b);
        c = _mm256_mul_epu32(c, d);  // Independent
    }
    auto end = std::chrono::high_resolution_clock::now();
    escape(&a); escape(&c);
    double mul_epu32_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    
    a = _mm256_load_si256((v8i*)data);
    c = _mm256_load_si256((v8i*)data);
    
    // Test vpmulld throughput (should be 1/cycle or 0.5/cycle)
    start = std::chrono::high_resolution_clock::now();
    for (long i = 0; i < ITERS; ++i) {
        a = _mm256_mullo_epi32(a, b);
        c = _mm256_mullo_epi32(c, d);  // Independent
    }
    end = std::chrono::high_resolution_clock::now();
    escape(&a); escape(&c);
    double mullo_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    
    std::cout << "2x independent mul_epu32: " << std::fixed << std::setprecision(3) 
              << mul_epu32_ns / ITERS << " ns/iter\n";
    std::cout << "2x independent mullo_epi32: " << mullo_ns / ITERS << " ns/iter\n";
    std::cout << "Ratio mullo/mul_epu32: " << std::setprecision(2) 
              << mullo_ns / mul_epu32_ns << "x\n\n";
    
    // Test with 4 independent streams
    a = _mm256_load_si256((v8i*)data);
    c = _mm256_load_si256((v8i*)data);
    v8i e = _mm256_load_si256((v8i*)data);
    v8i f = _mm256_load_si256((v8i*)data);
    
    const long ITERS4 = ITERS / 2;
    
    start = std::chrono::high_resolution_clock::now();
    for (long i = 0; i < ITERS4; ++i) {
        a = _mm256_mul_epu32(a, b);
        c = _mm256_mul_epu32(c, d);
        e = _mm256_mul_epu32(e, b);
        f = _mm256_mul_epu32(f, d);
    }
    end = std::chrono::high_resolution_clock::now();
    escape(&a); escape(&c); escape(&e); escape(&f);
    double mul4_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    
    a = _mm256_load_si256((v8i*)data);
    c = _mm256_load_si256((v8i*)data);
    e = _mm256_load_si256((v8i*)data);
    f = _mm256_load_si256((v8i*)data);
    
    start = std::chrono::high_resolution_clock::now();
    for (long i = 0; i < ITERS4; ++i) {
        a = _mm256_mullo_epi32(a, b);
        c = _mm256_mullo_epi32(c, d);
        e = _mm256_mullo_epi32(e, b);
        f = _mm256_mullo_epi32(f, d);
    }
    end = std::chrono::high_resolution_clock::now();
    escape(&a); escape(&c); escape(&e); escape(&f);
    double mullo4_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    
    std::cout << "4x independent mul_epu32: " << std::setprecision(3) 
              << mul4_ns / ITERS4 << " ns/iter (4 muls)\n";
    std::cout << "4x independent mullo_epi32: " << mullo4_ns / ITERS4 << " ns/iter (4 muls)\n";
    std::cout << "Ratio mullo/mul_epu32: " << std::setprecision(2) 
              << mullo4_ns / mul4_ns << "x\n\n";
}

// ============================================================================
// Test latency (dependent chain)
// ============================================================================
void test_latency() {
    std::cout << "=== Instruction Latency Test (dependent chain) ===\n\n";
    
    alignas(32) u32 data[8] = {1, 2, 3, 4, 5, 6, 7, 8};
    v8i a = _mm256_load_si256((v8i*)data);
    v8i b = _mm256_load_si256((v8i*)data);
    
    const long ITERS = 50000000L;
    
    // Test mul_epu32 latency
    auto start = std::chrono::high_resolution_clock::now();
    for (long i = 0; i < ITERS; ++i) {
        a = _mm256_mul_epu32(a, b);  // Each depends on previous
    }
    auto end = std::chrono::high_resolution_clock::now();
    escape(&a);
    double mul_lat_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    
    a = _mm256_load_si256((v8i*)data);
    
    // Test mullo latency
    start = std::chrono::high_resolution_clock::now();
    for (long i = 0; i < ITERS; ++i) {
        a = _mm256_mullo_epi32(a, b);
    }
    end = std::chrono::high_resolution_clock::now();
    escape(&a);
    double mullo_lat_ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    
    std::cout << "mul_epu32 latency: " << std::fixed << std::setprecision(3) 
              << mul_lat_ns / ITERS << " ns/op\n";
    std::cout << "mullo_epi32 latency: " << mullo_lat_ns / ITERS << " ns/op\n";
    std::cout << "Ratio mullo/mul: " << std::setprecision(2) 
              << mullo_lat_ns / mul_lat_ns << "x\n\n";
}

// ============================================================================
// Simulate NTT inner loop patterns
// ============================================================================
void test_ntt_patterns() {
    std::cout << "=== NTT Inner Loop Pattern Test ===\n\n";
    
    const int N = 1 << 16;  // 64K for L1/L2 fit
    const int N8 = N >> 3;
    
    v8i* data = (v8i*)aligned_alloc(32, N8 * sizeof(v8i));
    
    alignas(32) u32 w_data[8] = {111111111, 222222222, 333333333, 444444444,
                                  555555555, 666666666, 777777777, 888888888};
    alignas(32) u32 wp_data[8];
    for (int i = 0; i < 8; ++i) {
        wp_data[i] = ((u64)w_data[i] << 32) / MOD;
    }
    
    v8i w = _mm256_load_si256((v8i*)w_data);
    v8i wp = _mm256_load_si256((v8i*)wp_data);
    v8i mod = _mm256_set1_epi32(MOD);
    v8i m_inv = _mm256_set1_epi32(M_INV);
    
    for (int i = 0; i < N8; ++i) {
        data[i] = _mm256_set1_epi32(i);
    }
    
    const int ITERS = 200;
    
    // Pattern 1: Shoup radix-2 butterfly (load-compute-store)
    auto start = std::chrono::high_resolution_clock::now();
    for (int iter = 0; iter < ITERS; ++iter) {
        for (int i = 0; i < N8; i += 2) {
            v8i u = data[i];
            v8i v = data[i + 1];
            
            // Shoup mul: mulhi + 2x mullo
            v8i a_odd = _mm256_srli_epi64(v, 32);
            v8i wp_odd = _mm256_srli_epi64(wp, 32);
            v8i ev = _mm256_mul_epu32(v, wp);
            v8i od = _mm256_mul_epu32(a_odd, wp_odd);
            v8i t = _mm256_blend_epi32(_mm256_srli_epi64(ev, 32), od, 0xAA);
            v8i p = _mm256_mullo_epi32(v, w);
            v8i q = _mm256_mullo_epi32(t, mod);
            v8i wv = _mm256_sub_epi32(p, q);
            
            data[i] = _mm256_add_epi32(u, wv);
            data[i + 1] = _mm256_sub_epi32(u, wv);
        }
    }
    auto end = std::chrono::high_resolution_clock::now();
    double shoup_us = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
    
    // Reset
    for (int i = 0; i < N8; ++i) {
        data[i] = _mm256_set1_epi32(i);
    }
    
    // Pattern 2: Montgomery radix-2 butterfly
    start = std::chrono::high_resolution_clock::now();
    for (int iter = 0; iter < ITERS; ++iter) {
        for (int i = 0; i < N8; i += 2) {
            v8i u = data[i];
            v8i v = data[i + 1];
            
            // Mont mul
            v8i v_sh = _mm256_bsrli_epi128(v, 4);
            v8i x0246 = _mm256_mul_epu32(v, w);
            v8i x1357 = _mm256_mul_epu32(v_sh, w);
            v8i n0 = _mm256_mul_epu32(x0246, m_inv);
            v8i n1 = _mm256_mul_epu32(x1357, m_inv);
            v8i r0 = _mm256_add_epi64(x0246, _mm256_mul_epu32(n0, mod));
            v8i r1 = _mm256_add_epi64(x1357, _mm256_mul_epu32(n1, mod));
            v8i wv = _mm256_or_si256(_mm256_bsrli_epi128(r0, 4), r1);
            
            data[i] = _mm256_add_epi32(u, wv);
            data[i + 1] = _mm256_sub_epi32(u, wv);
        }
    }
    end = std::chrono::high_resolution_clock::now();
    double mont_us = std::chrono::duration_cast<std::chrono::microseconds>(end - start).count();
    
    std::cout << "N = " << N << " (fits in cache), " << ITERS << " iterations\n";
    std::cout << "Shoup butterfly sweep: " << std::fixed << std::setprecision(1) 
              << shoup_us << " us (" << shoup_us / ITERS << " us/iter)\n";
    std::cout << "Mont butterfly sweep:  " << mont_us << " us (" << mont_us / ITERS << " us/iter)\n";
    std::cout << "Ratio Mont/Shoup: " << std::setprecision(2) << mont_us / shoup_us << "x\n\n";
    
    free(data);
}

int main() {
    test_latency();
    test_throughput();
    test_ntt_patterns();
    return 0;
}