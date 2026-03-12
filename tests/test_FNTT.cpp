#include <iostream>
#include <vector>
#include <random>
#include <chrono>
#include <iomanip>
#include <immintrin.h>
#include <cstring>

#pragma GCC target("avx2")

typedef __m256i v8i;

const uint32_t MOD = 998244353;
const uint32_t WMOD = 1996488706;
const uint32_t R2_MOD = 932051910;
const uint32_t M_INV = 998244351;
const uint32_t PRIM_ROOT = 3;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_one = _mm256_set1_epi32(1);
const v8i v_m = _mm256_set1_epi32(M_INV);
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);

// lazy Montgomery Multiplication， in [0, 2 * MOD)
inline v8i _mm256_mont_multiply_mod(const v8i& a, const v8i& b) {
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i t_even = _mm256_mul_epu32(a, b);             
    v8i u_even = _mm256_mul_epu32(t_even, v_m);      
    v8i up_even = _mm256_mul_epu32(u_even, v_mod);    
    v8i sum_even = _mm256_add_epi64(t_even, up_even); 
    v8i res_even = _mm256_srli_epi64(sum_even, 32);   
    v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
    v8i u_odd = _mm256_mul_epu32(t_odd, v_m);
    v8i up_odd = _mm256_mul_epu32(u_odd, v_mod);
    v8i sum_odd = _mm256_add_epi64(t_odd, up_odd);
    v8i result = _mm256_or_si256(res_even, sum_odd);
    v8i adjusted = _mm256_sub_epi32(result, v_mod);
    return _mm256_min_epu32(result, adjusted);
}
// a + b > m ? a + b - m : a + b
v8i _mm256_add_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), m);
    v8i mask = _mm256_srai_epi32(adjusted, 31);
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, m));
}

// a - b < 0 ? m + a - b : a - b
v8i _mm256_sub_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i mask = _mm256_cmpgt_epi32(b, a);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}

// a > m ? a - m : a
v8i _mm256_mod(const v8i& a, const v8i &m = v_mod) {
    v8i diff = _mm256_sub_epi32(a, m);
    v8i mask = _mm256_srai_epi32(diff, 31);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}

inline uint32_t mont_mul_scalar(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint32_t m = (uint32_t)t * M_INV;
    uint64_t u = t + (uint64_t)m * MOD;
    uint32_t res = u >> 32;
    return res >= MOD ? res - MOD : res;
}

inline uint32_t to_mont(uint32_t x) {
    return mont_mul_scalar(x, R2_MOD);
}

inline uint32_t from_mont(uint32_t x) {
    return mont_mul_scalar(x, 1);
}

uint32_t pow_mod(uint32_t base, uint32_t exp) {
    uint32_t result = to_mont(1);
    base = to_mont(base);
    while (exp > 0) {
        if (exp & 1) result = mont_mul_scalar(result, base);
        base = mont_mul_scalar(base, base);
        exp >>= 1;
    }
    return from_mont(result);
}

uint32_t inv_mod(uint32_t x) {
    return pow_mod(x, MOD - 2);
}

static std::pair<uint32_t*, uint32_t*> get_root(const int &n) {
    static std::vector<uint32_t> root{to_mont(1)};
    static std::vector<uint32_t> inv_root{to_mont(1)};
    
    if (static_cast<int>(root.size()) < n) {
        int i = root.size();
        root.resize(n);
        inv_root.resize(n);
        
        for (; i != n; i <<= 1) {
            uint32_t w = pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2));
            uint32_t iw = inv_mod(from_mont(w));
            w = to_mont(w);
            iw = to_mont(iw);
            
            for (int j = 0; j != i; ++j) {
                root[i + j] = mont_mul_scalar(root[j], w);
                inv_root[i + j] = mont_mul_scalar(inv_root[j], iw);
            }
        }
    }
    
    return {root.data(), inv_root.data()};
}

void dif_ntt(uint32_t *f, const int &n) {
    const uint32_t* rt = get_root(n).first;
        
    for (int i = n >> 1; i >= 8; i >>= 1) {
        // i >= 8
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]); // [rt[k], ...]
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));        // [f[p], ...]
                v8i v_q = _mm256_loadu_si256((v8i*)(f + p + i));    // [f[q], ...]
                v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);           // [f[q] * rt[k], ...]
                v8i v_np = _mm256_add_mod(v_u, v_v);                // [u + v, ...]
                v8i v_nq = _mm256_sub_mod(v_u, v_v);                // [u - v, ...]
                _mm256_storeu_si256((v8i*)(f + p), v_np);
                _mm256_storeu_si256((v8i*)(f + p + i), v_nq);
            }
        }
    }
    {
        // i <= 4
        static const int BLOCK = 1024;
        static const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
        static const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);

        for (int j_start = 0; j_start < n; j_start += BLOCK) {
            int j_end = std::min(j_start + BLOCK, n);
            int j = j_start;
            __builtin_prefetch(f + j_start + BLOCK);
            for (; j <= j_end - 32; j += 32) {
                v8i f0 = _mm256_loadu_si256((v8i*)(f + j));
                v8i f1 = _mm256_loadu_si256((v8i*)(f + j + 8));
                v8i f2 = _mm256_loadu_si256((v8i*)(f + j + 16));
                v8i f3 = _mm256_loadu_si256((v8i*)(f + j + 24));
                {
                    int k_4 = j >> 3;
                    v8i rts_all = _mm256_broadcastsi128_si256(_mm_loadu_si128((__m128i*)(rt + k_4)));
                    v8i rt0 = _mm256_shuffle_epi32(rts_all, 0x00); 
                    v8i rt1 = _mm256_shuffle_epi32(rts_all, 0x55); 
                    v8i rt2 = _mm256_shuffle_epi32(rts_all, 0xAA); 
                    v8i rt3 = _mm256_shuffle_epi32(rts_all, 0xFF);

                    auto layer4_op = [&](v8i &v, const v8i &w) {
                        v8i u = _mm256_permute2x128_si256(v, v, 0x00);
                        v8i q = _mm256_permute2x128_si256(v, v, 0x11);
                        v8i v_v = _mm256_mont_multiply_mod(q, w);
                        v8i np = _mm256_add_mod(u, v_v);
                        v8i nq = _mm256_sub_mod(u, v_v);
                        v = _mm256_permute2x128_si256(np, nq, 0x20);
                    };

                    layer4_op(f0, rt0);
                    layer4_op(f1, rt1);
                    layer4_op(f2, rt2);
                    layer4_op(f3, rt3);
                }
                {
                    int k_2 = j >> 2;
                    v8i all_rts = _mm256_loadu_si256((v8i*)(rt + k_2));

                    auto layer2_op = [&](v8i &v, const v8i &roots) {
                        v8i u = _mm256_shuffle_epi32(v, _MM_SHUFFLE(1, 0, 1, 0));
                        v8i q = _mm256_shuffle_epi32(v, _MM_SHUFFLE(3, 2, 3, 2));
                        v8i v_v = _mm256_mont_multiply_mod(q, roots);
                        v8i np = _mm256_add_mod(u, v_v);
                        v8i nq = _mm256_sub_mod(u, v_v);
                        v = _mm256_unpacklo_epi64(np, nq);
                    };
                    layer2_op(f0, _mm256_permutevar8x32_epi32(all_rts, perm_i2));
                    
                    v8i rts_23 = _mm256_shuffle_epi32(all_rts, _MM_SHUFFLE(3, 2, 3, 2));
                    layer2_op(f1, _mm256_permutevar8x32_epi32(rts_23, perm_i2));

                    v8i rts_hi = _mm256_permute2x128_si256(all_rts, all_rts, 0x11);
                    layer2_op(f2, _mm256_permutevar8x32_epi32(rts_hi, perm_i2));

                    v8i rts_67 = _mm256_shuffle_epi32(rts_hi, _MM_SHUFFLE(3, 2, 3, 2));
                    layer2_op(f3, _mm256_permutevar8x32_epi32(rts_67, perm_i2));
                }
                {
                    int k_1 = j >> 1;
                    v8i rts_lo = _mm256_loadu_si256((v8i*)(rt + k_1));
                    v8i rts_hi = _mm256_loadu_si256((v8i*)(rt + k_1 + 8));

                    auto layer1_op = [&](v8i &v, const v8i &roots) {
                        v8i u = _mm256_shuffle_epi32(v, _MM_SHUFFLE(2, 2, 0, 0));
                        v8i q = _mm256_shuffle_epi32(v, _MM_SHUFFLE(3, 3, 1, 1));
                        v8i v_v = _mm256_mont_multiply_mod(q, roots);
                        v8i np = _mm256_add_mod(u, v_v);
                        v8i nq = _mm256_sub_mod(u, v_v);
                        v = _mm256_blend_epi32(np, _mm256_shuffle_epi32(nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
                    };
                    layer1_op(f0, _mm256_permutevar8x32_epi32(rts_lo, perm_i1));
                    v8i rts_47 = _mm256_permute2x128_si256(rts_lo, rts_lo, 0x11);
                    layer1_op(f1, _mm256_permutevar8x32_epi32(rts_47, perm_i1));
                    layer1_op(f2, _mm256_permutevar8x32_epi32(rts_hi, perm_i1));
                    v8i rts_1215 = _mm256_permute2x128_si256(rts_hi, rts_hi, 0x11);
                    layer1_op(f3, _mm256_permutevar8x32_epi32(rts_1215, perm_i1));
                }
                _mm256_storeu_si256((v8i*)(f + j), _mm256_mod(f0));
                _mm256_storeu_si256((v8i*)(f + j + 8), _mm256_mod(f1));
                _mm256_storeu_si256((v8i*)(f + j + 16), _mm256_mod(f2));
                _mm256_storeu_si256((v8i*)(f + j + 24), _mm256_mod(f3));
            }
            for (; j != j_end; j += 8) { 
                v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
                {
                    int k_4 = j >> 3;
                    v8i v_rt = _mm256_set1_epi32(rt[k_4]);
                    v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
                    v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
                    v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                    v8i v_np = _mm256_add_mod(v_u, v_v);
                    v8i v_nq = _mm256_sub_mod(v_u, v_v);
                    v_f = _mm256_permute2x128_si256(v_np, v_nq, 0x20);
                }
                {
                    int k_2 = j >> 2;
                    v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + k_2)));
                    v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i2);
                    v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
                    v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
                    v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                    v8i v_np = _mm256_add_mod(v_u, v_v);
                    v8i v_nq = _mm256_sub_mod(v_u, v_v);
                    v_f = _mm256_unpacklo_epi64(v_np, v_nq);             
                }
                {
                    int k_1 = j >> 1;
                    v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + k_1)));
                    v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i1);
                    v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
                    v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
                    v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                    v8i v_np = _mm256_add_mod(v_u, v_v);
                    v8i v_nq = _mm256_sub_mod(v_u, v_v);
                    v_f = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
                }
                _mm256_storeu_si256((v8i*)(f + j), _mm256_mod(v_f));
            }
        }
    }
}

// Reference implementation (scalar)
void dif_ntt_reference(uint32_t *f, const int &n) {
    const uint32_t* rt = get_root(n).first;
    for (int i = n >> 1; i >= 1; i >>= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            for (int p = j, q = j + i; p != j + i; ++p, ++q) {
                const uint32_t u = f[p], v = mont_mul_scalar(f[q], rt[k]);
                f[p] = (u + v >= MOD) ? (u + v - MOD) : (u + v);
                f[q] = (u >= v) ? (u - v) : (u - v + MOD);
            }
        }
    }
}

// Test harness
bool test_correctness(int n) {
    std::vector<uint32_t> data1(n), data2(n);
    std::mt19937 rng(42);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    
    // Generate random data
    for (int i = 0; i < n; ++i) {
        data1[i] = data2[i] = to_mont(dist(rng));
    }
    
    // Run both implementations
    dif_ntt(data1.data(), n);
    dif_ntt_reference(data2.data(), n);
    
    // Compare results
    for (int i = 0; i < n; ++i) {
        if (data1[i] != data2[i]) {
            std::cout << "MISMATCH at index " << i << ": "
                      << data1[i] << " vs " << data2[i] << std::endl;
            return false;
        }
    }
    return true;
}

#define seed 42424
double benchmark(int n, int iterations) {
    // Pre-generate all test data
    std::mt19937 rng(seed);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    std::vector<std::vector<uint32_t>> test_data(iterations);
    for (int iter = 0; iter < iterations; ++iter) {
        test_data[iter].resize(n);
        for (int i = 0; i < n; ++i) {
            test_data[iter][i] = to_mont(dist(rng));
        }
    }
    
    // Pre-compute roots (not part of timing)
    get_root(n);
    
    std::vector<uint32_t> data(n);
    auto start = std::chrono::high_resolution_clock::now();
    for (int iter = 0; iter < iterations; ++iter) {
        std::memcpy(data.data(), test_data[iter].data(), n * sizeof(uint32_t));
        dif_ntt(data.data(), n);
        __asm__ __volatile__("" : : "r,m"(data[0]) : "memory");
    }
    auto end = std::chrono::high_resolution_clock::now();
    
    double elapsed = std::chrono::duration<double>(end - start).count();
    return elapsed / iterations;
}

double benchmark_reference(int n, int iterations) {
    // Pre-generate all test data (same seed = same data as optimized version)
    std::mt19937 rng(seed);
    std::uniform_int_distribution<uint32_t> dist(0, MOD - 1);
    std::vector<std::vector<uint32_t>> test_data(iterations);
    for (int iter = 0; iter < iterations; ++iter) {
        test_data[iter].resize(n);
        for (int i = 0; i < n; ++i) {
            test_data[iter][i] = to_mont(dist(rng));
        }
    }
    
    // Pre-compute roots (not part of timing)
    get_root(n);
    
    std::vector<uint32_t> data(n);
    auto start = std::chrono::high_resolution_clock::now();
    for (int iter = 0; iter < iterations; ++iter) {
        std::memcpy(data.data(), test_data[iter].data(), n * sizeof(uint32_t));
        dif_ntt_reference(data.data(), n);
        __asm__ __volatile__("" : : "r,m"(data[0]) : "memory");
    }
    auto end = std::chrono::high_resolution_clock::now();
    
    double elapsed = std::chrono::duration<double>(end - start).count();
    return elapsed / iterations;
}

int main() {
    std::cout << "=== DIF NTT Correctness Tests ===" << std::endl;
    std::vector<int> sizes = {8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384};
    
    for (int n : sizes) {
        bool passed = test_correctness(n);
        std::cout << "n = " << std::setw(6) << n << ": "
                  << (passed ? "PASS" : "FAIL") << std::endl;
        if (!passed) return 1;
    }
    
    std::cout << "\n=== Performance Benchmarks ===" << std::endl;
    std::cout << std::setw(8) << "n" 
              << std::setw(15) << "Optimized (ms)"
              << std::setw(15) << "Reference (ms)"
              << std::setw(12) << "Speedup" << std::endl;
    std::cout << std::string(50, '-') << std::endl;
    
    for (int n : {256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576}) {
        int iterations = std::max(5, 100000 / n);
        double time_opt = benchmark(n, iterations) * 1000.0;
        double time_ref = benchmark_reference(n, iterations) * 1000.0;
        double speedup = time_ref / time_opt;
        
        std::cout << std::setw(8) << n
                  << std::setw(15) << std::fixed << std::setprecision(4) << time_opt
                  << std::setw(15) << std::fixed << std::setprecision(4) << time_ref
                  << std::setw(11) << std::fixed << std::setprecision(2) << speedup << "x"
                  << std::endl;
    }
    
    return 0;
}