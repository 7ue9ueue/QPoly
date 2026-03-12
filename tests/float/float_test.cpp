#pragma GCC target("avx2")
#include <immintrin.h>
using namespace std;

constexpr int MOD = 998244353;

// float logic 
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

int main () {

}
