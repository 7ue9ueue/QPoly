#include <immintrin.h>
#include <iostream>
#include <vector>
#include <chrono>
#include <random>
#include <iomanip>

#pragma GCC target("avx2")

using namespace std;
using vi = vector<int>;

void vector_add_baseline(const int* a, const int* b, int* result, int n) {
    for (int i = 0; i < n; i++) {
        result[i] = a[i] + b[i];
    }
}

typedef __m256i v8i;
void vector_add_SIMD(const int* a, const int* b, int* result, int n) {
    for (int i = 0; i < n; i += 8) {
        v8i va = _mm256_loadu_si256((const v8i*)(a + i));
        v8i vb = _mm256_loadu_si256((const v8i*)(b + i));
        v8i vsum = _mm256_add_epi32(va, vb);
        _mm256_storeu_si256((v8i*)(result + i), vsum);
    }
}