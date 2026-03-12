#pragma GCC target("avx2")
#include <immintrin.h>
#include <iostream>
#include <chrono>
#include <random>
#include <vector>

using v8i = __m256i;


void dif_ntt_memory_only(v8i *f, const int &n, const uint32_t* rt, const uint32_t* rt_p) {
    // This function mimics the memory access pattern of DIF but does ZERO math.
    // If this is slow, your bottleneck is Bandwidth/Latency, not Shoup Mul.
    
    const int n8 = n >> 3;
    int log_n = 31 - __builtin_clz(n);
    int num_stages = log_n - 3;
    int i;

    // Handle odd stages setup (omitted for brevity, usually fast)
    if (num_stages & 1) i = n >> 3;
    else i = n >> 2;

    auto start = std::chrono::high_resolution_clock::now();

    for (; i >= 8; i >>= 2) {
        int i8 = i >> 3;
        for (int j = 0; j < n8; j += i8 << 2) {
            v8i* __restrict f0 = f + j;
            v8i* __restrict f1 = f + j + i8;
            v8i* __restrict f2 = f + j + i8 * 2;
            v8i* __restrict f3 = f + j + i8 * 3;

            for (int p = 0; p < i8; ++p) {
                // LOAD
                v8i a0 = f0[p];
                v8i a1 = f1[p];
                v8i a2 = f2[p];
                v8i a3 = f3[p];

                // NO MATH (Just a dummy XOR to prevent optimization)
                v8i dummy1 = _mm256_xor_si256(a0, a1); 
                v8i dummy2 = _mm256_xor_si256(a2, a3); 
                
                // STORE
                f0[p] = dummy1; 
                f1[p] = dummy1;
                f2[p] = dummy2;
                f3[p] = dummy2;
            }
        }
    }
    auto end = std::chrono::high_resolution_clock::now();
    long long ns = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start).count();
    std::cout << "DIF MEMORY ONLY Time: " << ns << " ns\n";
}

int main () {

}
/*
Testing with n = 2^20 = 1048576 elements
Array size: 131072 v8i elements (4 MB)

DIF MEMORY ONLY Time: 1463846 ns

Running 5 benchmark iterations:
Run 1: DIF MEMORY ONLY Time: 1385180 ns
Run 2: DIF MEMORY ONLY Time: 1327320 ns
Run 3: DIF MEMORY ONLY Time: 1330549 ns
Run 4: DIF MEMORY ONLY Time: 1373476 ns
Run 5: DIF MEMORY ONLY Time: 1332738 ns

Approximate memory accessed per call: 8 MB

*/