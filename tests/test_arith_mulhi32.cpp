#include <immintrin.h>
#include <cstdint>
#include <random>
#include <cassert>
#include <iostream>

using v8i = __m256i;

// NOTE: Your posted signature takes pointers but uses them like values.
// This is the intended signature (or change uses to *a / *b).
inline v8i mm256_mulhi_epu32(v8i a, v8i b) {
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i even  = _mm256_mul_epu32(a, b);
    v8i odd   = _mm256_mul_epu32(a_odd, b_odd);
    return _mm256_blend_epi32(_mm256_srli_epi64(even, 32), odd, 0xAA);
}

static inline uint32_t ref_mulhi_u32(uint32_t x, uint32_t y) {
    return static_cast<uint32_t>((static_cast<uint64_t>(x) * y) >> 32);
}

void test_mm256_mulhi_epu32() {
    auto run_case = [](const uint32_t a[8], const uint32_t b[8]) {
        v8i va = _mm256_loadu_si256(reinterpret_cast<const v8i*>(a));
        v8i vb = _mm256_loadu_si256(reinterpret_cast<const v8i*>(b));
        v8i vr = mm256_mulhi_epu32(va, vb);

        alignas(32) uint32_t got[8];
        _mm256_storeu_si256(reinterpret_cast<v8i*>(got), vr);

        for (int i = 0; i < 8; ++i) {
            uint32_t expect = ref_mulhi_u32(a[i], b[i]);
            if (got[i] != expect) {
                std::cerr << "Mismatch lane " << i
                          << "  a=" << a[i]
                          << "  b=" << b[i]
                          << "  got=" << got[i]
                          << "  expect=" << expect << "\n";
                assert(false);
            }
        }
    };

    // Some directed edge cases
    {
        uint32_t a[8] = {0,0,0,0,0,0,0,0};
        uint32_t b[8] = {0,1,2,3,4,5,6,7};
        run_case(a,b);
    }
    {
        uint32_t a[8] = {1,1,1,1,1,1,1,1};
        uint32_t b[8] = {0u,1u,2u,3u,0xFFFFFFFFu,0x80000000u,0x7FFFFFFFu,123456789u};
        run_case(a,b);
    }
    {
        uint32_t a[8] = {0xFFFFFFFFu,0xFFFFFFFFu,0xFFFFFFFFu,0xFFFFFFFFu,0xFFFFFFFFu,0xFFFFFFFFu,0xFFFFFFFFu,0xFFFFFFFFu};
        uint32_t b[8] = {0xFFFFFFFFu,0x80000000u,0x7FFFFFFFu,2u,3u,4u,5u,6u};
        run_case(a,b);
    }
    {
        uint32_t a[8] = {0u,0xFFFFFFFFu,0u,0xFFFFFFFFu,0u,0xFFFFFFFFu,0u,0xFFFFFFFFu};
        uint32_t b[8] = {0xFFFFFFFFu,0u,123u,456u,0x80000000u,0x80000000u,0x7FFFFFFFu,0x7FFFFFFFu};
        run_case(a,b);
    }

    // Random stress
    std::mt19937_64 rng(1234567);
    std::uniform_int_distribution<uint32_t> dist(0u, 0xFFFFFFFFu);

    for (int it = 0; it < 20000; ++it) {
        alignas(32) uint32_t a[8], b[8];
        for (int i = 0; i < 8; ++i) {
            a[i] = dist(rng);
            b[i] = dist(rng);
        }
        run_case(a, b);
    }

    std::cout << "mm256_mulhi_epu32: all tests passed.\n";
}

/*
Build e.g.:
  g++ -O2 -mavx2 -std=c++20 test.cpp && ./a.out
*/
