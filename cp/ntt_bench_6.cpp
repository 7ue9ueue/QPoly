#include <iostream>
#include <iomanip>
#include <chrono>
#include <random>
#include <cstdint>
#include <cstdlib>
#include <immintrin.h>

// ============================================================================
// Constants and Utilities
// ============================================================================

namespace fntt {
  enum ImplSelector {
    Generic, x86_64, SSE, AVX2
  };
  static constexpr size_t kWordSize = 32UL;
}

namespace utils {
    constexpr size_t bitLength(size_t n) {
        size_t len = 0;
        while (n > 0) {
            n >>= 1;
            len++;
        }
        return len;
    }
}

namespace fntt {
  namespace core {
    namespace prime30 {
      static constexpr size_t kPrimeBitSize = 30;
      // 998244353 = 119 * 2^23 + 1 (NTT-friendly prime)
      static constexpr uint32_t p[1] = {998244353U};
    }
  }
}

// ============================================================================
// SIMD Utilities
// ============================================================================

inline int shuffle_imm(const unsigned i0, const unsigned i1, const unsigned i2, const unsigned i3){
  return (int)((i0 << 0U) | (i1 << 2U) | (i2 << 4U) | (i3 << 6U));
}

inline int blend32_imm(const unsigned i0, const unsigned i1, const unsigned i2, const unsigned i3,
                       const unsigned i4, const unsigned i5, const unsigned i6, const unsigned i7) {
  return (int)((i0 << 0U) | (i1 << 1U) | (i2 << 2U) | (i3 << 3U) | (i4 << 4U) | (i5 << 5U) | (i6 << 6U) | (i7 << 7U));
}

// ============================================================================
// AVX2 Arithmetic Operations (32-bit)
// ============================================================================

namespace fntt {
  namespace core {

    inline __m256i _mm256_conditional_sub_epu32(const __m256i a, const __m256i p) {
      const __m256i z = _mm256_setzero_si256();
      __m256i t, m;
      t = _mm256_sub_epi32(a, p);
      m = _mm256_srli_epi32(t, 31);
      m = _mm256_sub_epi32(z, m);
      m = _mm256_and_si256(m, p);
      t = _mm256_add_epi32(t, m);
      return t;
    }

    inline __m256i _mm256_mulhi_epu32(const __m256i a, const __m256i b) {
      __m256i a_low = _mm256_and_si256(a, _mm256_set1_epi64x(0xFFFFFFFF));
      __m256i b_low = _mm256_and_si256(b, _mm256_set1_epi64x(0xFFFFFFFF));
      __m256i a_high = _mm256_srli_epi64(a, 32);
      __m256i b_high = _mm256_srli_epi64(b, 32);
      
      __m256i prod_low = _mm256_mul_epu32(a_low, b_low);
      __m256i prod_high = _mm256_mul_epu32(a_high, b_high);
      
      prod_low = _mm256_srli_epi64(prod_low, 32);
      prod_high = _mm256_srli_epi64(prod_high, 32);
      
      return _mm256_blend_epi32(prod_low, _mm256_slli_epi64(prod_high, 32), 0xAA);
    }

    inline __m256i _mm256_mullo_epu32_full(const __m256i a, const __m256i b) {
      return _mm256_mullo_epi32(a, b);
    }

    inline __m256i _mm256_redc_barrett_lazy_32(const __m256i a, const __m256i r, const __m256i p) {
      __m256i t = _mm256_mulhi_epu32(a, r);
      t = _mm256_mullo_epu32_full(p, t);
      t = _mm256_sub_epi32(a, t);
      return t;
    }

    inline __m256i _mm256_mul_barrett_fixed_lazy_32(const __m256i a, const __m256i b, const __m256i bp,
                                                    const __m256i p) {
      __m256i t, c;
      t = _mm256_mulhi_epu32(bp, a);
      c = _mm256_mullo_epu32_full(a, b);
      t = _mm256_mullo_epu32_full(t, p);
      c = _mm256_sub_epi32(c, t);
      return c;
    }

    inline __m256i _mm256_mul_barrett_fixed_32(const __m256i a, const __m256i b, const __m256i bp,
                                               const __m256i p) {
      __m256i t, c;
      t = _mm256_mulhi_epu32(bp, a);
      c = _mm256_mullo_epu32(a, b);
      t = _mm256_mullo_epu32(t, p);
      c = _mm256_sub_epi32(c, t);
      c = _mm256_conditional_sub_epu32(c, p);
      return c;
    }

  } // namespace core
} // namespace fntt

// ============================================================================
// Scalar Arithmetic (for setup)
// ============================================================================

namespace fntt {
  namespace core {

    inline uint32_t mul_barrett_fixed_prep(const uint32_t b, const uint32_t p) {
      return ((uint64_t) b << 32U) / p;
    }

    template<enum ImplSelector Impl>
    inline uint32_t redc_barrett_lazy(uint32_t a, const uint32_t r, const uint32_t p) {
      uint64_t t = (uint64_t)a * r;
      uint32_t q = t >> 32;
      uint32_t res = a - q * p;
      return res;
    }

    template<enum ImplSelector Impl>
    inline uint32_t mul_barrett_fixed_lazy(uint32_t a, const uint32_t b, const uint32_t bp, const uint32_t p) {
      uint64_t t = (uint64_t)a * bp;
      uint32_t q = t >> 32;
      uint32_t res = (uint32_t)((uint64_t)a * b) - q * p;
      return res;
    }

  } // namespace core
} // namespace fntt

// ============================================================================
// NTT Butterfly Operations
// ============================================================================

namespace fntt {
  namespace core {
    namespace FNTT {

      template<enum ImplSelector Impl>
      inline void backward_butterfly_lazy(uint32_t *x, uint32_t *y,
                                          const uint32_t w, const uint32_t wp,
                                          const uint32_t Lp, const uint32_t p) {
        uint32_t u, v;
        u = *x;
        v = *y;
        *x = u + v;
        *y = mul_barrett_fixed_lazy<Impl>(u + Lp - v, w, wp, p);
      }

      template<enum ImplSelector Impl>
      inline void backward_butterfly_corr_lazy(uint32_t *x, uint32_t *y,
                                               const uint32_t w, const uint32_t wp,
                                               const uint32_t Lp, const uint32_t r,
                                               const uint32_t p) {
        uint32_t u, v;
        u = *x;
        v = *y;
        *x = redc_barrett_lazy<Impl>(u + v, r, p);
        *y = mul_barrett_fixed_lazy<Impl>(u + Lp - v, w, wp, p);
      }

      template<enum ImplSelector Impl>
      inline void forward_butterfly_lazy(uint32_t *x, uint32_t *y,
                                         const uint32_t w, const uint32_t wp, const uint32_t Lp, const uint32_t p) {
        uint32_t u, v;
        u = *x;
        v = mul_barrett_fixed_lazy<Impl>(*y, w, wp, p);
        *x = u + v;
        *y = u + Lp - v;
      }

      template<enum ImplSelector Impl>
      inline void forward_butterfly_montgomery_domain_lazy(uint32_t *x, uint32_t *y,
                                                           uint32_t w, uint32_t wp, const uint32_t Lp,
                                                           const uint32_t r, const uint32_t rp, const uint32_t p) {
        uint32_t u, v;
        u = mul_barrett_fixed_lazy<Impl>(*x, r, rp, p);
        v = mul_barrett_fixed_lazy<Impl>(*y, w, wp, p);
        *x = u + v;
        *y = u + Lp - v;
      }

      template<enum ImplSelector Impl>
      inline void backward_butterfly_montgomery_domain(uint32_t *x, uint32_t *y,
                                                       const uint32_t w, const uint32_t wp,
                                                       const uint32_t ni, const uint32_t nip,
                                                       const uint32_t Lp, const uint32_t p) {
        uint32_t u, v;
        u = *x;
        v = *y;
        *x = mul_barrett_fixed_lazy<Impl>(u + v, ni, nip, p);
        *y = mul_barrett_fixed_lazy<Impl>(u + Lp - v, w, wp, p);
      }

      // AVX2 butterfly operations (8x 32-bit lanes)
      inline void forward_butterfly8_lazy_avx2(uint32_t *x, uint32_t *y, const __m256i w, const __m256i wp,
                                               const __m256i Lp, const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        v = _mm256_mul_barrett_fixed_lazy_32(v, w, wp, p);
        x_ = _mm256_add_epi32(u, v);
        y_ = _mm256_add_epi32(u, Lp);
        y_ = _mm256_sub_epi32(y_, v);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      inline void backward_butterfly8_lazy(uint32_t *x, uint32_t *y, const __m256i w, const __m256i wp,
                                           const __m256i Lp, const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        x_ = _mm256_add_epi32(u, v);
        y_ = _mm256_add_epi32(u, Lp);
        y_ = _mm256_sub_epi32(y_, v);
        y_ = _mm256_mul_barrett_fixed_lazy_32(y_, w, wp, p);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      inline void backward_butterfly8_corr_lazy(uint32_t *x, uint32_t *y, const __m256i w, const __m256i wp,
                                                const __m256i Lp, const __m256i r, const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        x_ = _mm256_add_epi32(u, v);
        x_ = _mm256_redc_barrett_lazy_32(x_, r, p);
        y_ = _mm256_add_epi32(u, Lp);
        y_ = _mm256_sub_epi32(y_, v);
        y_ = _mm256_mul_barrett_fixed_lazy_32(y_, w, wp, p);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      inline void backward_butterfly8_montgomery_domain(uint32_t *x, uint32_t *y, const __m256i w, const __m256i wp,
                                                        const __m256i ni, const __m256i nip, const __m256i Lp,
                                                        const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        x_ = _mm256_add_epi32(u, v);
        x_ = _mm256_mul_barrett_fixed_32(x_, ni, nip, p);
        y_ = _mm256_add_epi32(u, Lp);
        y_ = _mm256_sub_epi32(y_, v);
        y_ = _mm256_mul_barrett_fixed_32(y_, w, wp, p);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      // Forward NTT (AVX2)
      template<size_t N>
      void ntt(uint32_t *x, const uint32_t *w, const uint32_t *wp,
               const uint32_t r, const uint32_t rp, const uint32_t p) {

        const uint32_t Lp = 2 * p;
        size_t t = N / 2;

        ++w, ++wp;

        const __m256i Lpm = _mm256_set1_epi32(Lp), pm = _mm256_set1_epi32(p);

        for(size_t m = 1; m < N / 8; m *= 2) {
          uint32_t *xp0 = x;
          uint32_t *xp1 = x + t;
          for(size_t i = 0; i < m; ++i) {
            const __m256i wm = _mm256_set1_epi32(*w), wpm = _mm256_set1_epi32(*wp);
            for(size_t j = 0; j < t; j += 8) {
              forward_butterfly8_lazy_avx2(xp0, xp1, wm, wpm, Lpm, pm);
              xp0 += 8, xp1 += 8;
            }
            xp0 += t, xp1 += t;
            ++w, ++wp;
          }
          t /= 2;
        }

        { // t = 4
          const size_t m = N / 8;
          uint32_t *xp0 = x;
          uint32_t *xp1 = x + 4;

          for(size_t i = 0; i < m; ++i) {
            for(size_t j = 0; j < 4; ++j) {
              forward_butterfly_lazy<fntt::x86_64>(xp0 + j, xp1 + j, *w, *wp, Lp, p);
            }
            xp0 += 8, xp1 += 8;
            ++w, ++wp;
          }
        }

        { // t = 2
          const size_t m = N / 4;
          uint32_t *xp0 = x;
          uint32_t *xp1 = x + 2;

          for(size_t i = 0; i < m; ++i) {
            forward_butterfly_lazy<fntt::x86_64>(xp0++, xp1++, *w, *wp, Lp, p);
            forward_butterfly_lazy<fntt::x86_64>(xp0, xp1, *w, *wp, Lp, p);

            xp0 += 2 + 1, xp1 += 2 + 1;
            ++w, ++wp;
          }
        }

        { // last loop, t = 1
          const size_t m = N / 2;
          uint32_t *xp0 = x;
          uint32_t *xp1 = x + 1;
          for(size_t i = 0; i < m; ++i) {
            forward_butterfly_montgomery_domain_lazy<fntt::x86_64>(xp0, xp1, *w, *wp, Lp, r, rp, p);

            xp0 += 2, xp1 += 2;
            ++w, ++wp;
          }
        }
      }

      // Inverse NTT (AVX2)
      template<size_t N>
      void intt(uint32_t *x, const uint32_t *w, const uint32_t *wp,
                const uint32_t ni, const uint32_t nip, const uint32_t r, const uint32_t p) {

        constexpr size_t s = fntt::kWordSize - prime30::kPrimeBitSize - 1;
        constexpr size_t L = 1UL << s;
        const uint32_t Lp = L * p;
        uint32_t *xp0, *xp1;

        ++w, ++wp;

        const __m256i Lpm = _mm256_set1_epi32(Lp), pm = _mm256_set1_epi32(p), rm = _mm256_set1_epi32(r),
          nim = _mm256_set1_epi32(ni), nipm = _mm256_set1_epi32(nip);

        { // first loop, t = 1
          constexpr size_t m = N / 2;
          xp0 = x, xp1 = x + 1;
          for (size_t i = 0; i < m; ++i) {
            backward_butterfly_corr_lazy<fntt::x86_64>(xp0, xp1, *w, *wp, Lp, r, p);
            xp0 += 2, xp1 += 2;
            ++w, ++wp;
          }
        }

        { // second loop, t = 2
          constexpr size_t m = N / 4;
          xp0 = x, xp1 = x + 2;
          for (size_t i = 0; i < m; ++i) {
            backward_butterfly_lazy<fntt::x86_64>(xp0++, xp1++, *w, *wp, Lp, p);
            backward_butterfly_lazy<fntt::x86_64>(xp0, xp1, *w, *wp, Lp, p);
            xp0 += 2 + 1, xp1 += 2 + 1;
            ++w, ++wp;
          }
        }

        { // third loop, t = 4
          constexpr size_t m = N / 8;
          xp0 = x, xp1 = x + 4;
          for (size_t i = 0; i < m; ++i) {
            for(size_t j = 0; j < 4; ++j) {
              backward_butterfly_lazy<fntt::x86_64>(xp0 + j, xp1 + j, *w, *wp, Lp, p);
            }
            xp0 += 8, xp1 += 8;
            ++w, ++wp;
          }
        }

        constexpr int logL = s;
        constexpr int logN = (int) utils::bitLength(N) - 2;
        constexpr int Q = logN / logL, R = logN - Q * logL;

        {
          size_t t = 8;
          size_t m = N / 16;

          for (int ll = 1; ll < logL - 1; ++ll) {
            xp0 = x, xp1 = x + t;
            for (size_t i = 0; i < m; ++i) {
              const __m256i wm = _mm256_set1_epi32(*w), wpm = _mm256_set1_epi32(*wp);
              for (size_t j = 0; j < t; j += 8) {
                backward_butterfly8_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 8, xp1 += 8;
              }
              xp0 += t, xp1 += t;
              ++w, ++wp;
            }
            t *= 2, m /= 2;
          }

          if (m > 0) {
            xp0 = x, xp1 = x + t;
            for (size_t i = 0; i < m; ++i) {
              const __m256i wm = _mm256_set1_epi32(*w), wpm = _mm256_set1_epi32(*wp);
              size_t j = 0;
              for (; j < 2 * t / L; j += 8) {
                backward_butterfly8_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
                xp0 += 8, xp1 += 8;
              }
              for (; j < t; j += 8) {
                backward_butterfly8_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 8, xp1 += 8;
              }
              xp0 += t, xp1 += t;
              ++w, ++wp;
            }
            t *= 2, m /= 2;
          }

          for (int qq = 1; qq < Q; ++qq) {
            for (int ll = 0; ll < logL - 1; ++ll) {
              xp0 = x, xp1 = x + t;
              for (size_t i = 0; i < m; ++i) {
                const __m256i wm = _mm256_set1_epi32(*w), wpm = _mm256_set1_epi32(*wp);
                size_t j = 0;
                for (; j < 1 * t / L; j += 8) {
                  backward_butterfly8_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                  xp0 += 8, xp1 += 8;
                }
                for (; j < 2 * t / L; j += 8) {
                  backward_butterfly8_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
                  xp0 += 8, xp1 += 8;
                }
                for (; j < t; j += 8) {
                  backward_butterfly8_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                  xp0 += 8, xp1 += 8;
                }
                xp0 += t, xp1 += t;
                ++w, ++wp;
              }
              t *= 2, m /= 2;
            }

            xp0 = x, xp1 = x + t;
            for (size_t i = 0; i < m; ++i) {
              const __m256i wm = _mm256_set1_epi32(*w), wpm = _mm256_set1_epi32(*wp);
              size_t j = 0;
              for (; j < 2 * t / L; j += 8) {
                backward_butterfly8_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
                xp0 += 8, xp1 += 8;
              }
              for (; j < t; j += 8) {
                backward_butterfly8_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 8, xp1 += 8;
              }
              xp0 += t, xp1 += t;
              ++w, ++wp;
            }
            t *= 2, m /= 2;
          }

          for (int rr = 0; rr < R; ++rr) {
            xp0 = x, xp1 = x + t;
            for (size_t i = 0; i < m; ++i) {
              const __m256i wm = _mm256_set1_epi32(*w), wpm = _mm256_set1_epi32(*wp);
              size_t j = 0;
              for (; j < 1 * t / L; j += 8) {
                backward_butterfly8_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 8, xp1 += 8;
              }
              for (; j < 2 * t / L; j += 8) {
                backward_butterfly8_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
                xp0 += 8, xp1 += 8;
              }
              for (; j < t; j += 8) {
                backward_butterfly8_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 8, xp1 += 8;
              }
              xp0 += t, xp1 += t;
              ++w, ++wp;
            }
            t *= 2, m /= 2;
          }

          { // last loop t = n / 2
            constexpr size_t t = N / 2;
            xp0 = x, xp1 = x + t;
            const __m256i wm = _mm256_set1_epi32(*w), wpm = _mm256_set1_epi32(*wp);
            for (size_t j = 0; j < t; j += 8) {
              backward_butterfly8_montgomery_domain(xp0, xp1, wm, wpm, nim, nipm, Lpm, pm);
              xp0 += 8, xp1 += 8;
            }
          }
        }
      }

    } // namespace FNTT
  } // namespace core
} // namespace fntt

// ============================================================================
// Benchmark Setup and Main
// ============================================================================

using namespace fntt;
using namespace fntt::core;

uint32_t mod_pow(uint32_t base, uint32_t exp, uint32_t mod) {
    uint32_t result = 1;
    base %= mod;
    while (exp > 0) {
        if (exp & 1) {
            result = (uint64_t)result * base % mod;
        }
        base = (uint64_t)base * base % mod;
        exp >>= 1;
    }
    return result;
}

uint32_t find_primitive_root(uint32_t p, size_t N) {
    for (uint32_t g = 2; g < p; g++) {
        uint32_t w = mod_pow(g, (p - 1) / N, p);
        if (w != 1 && mod_pow(w, N, p) == 1) {
            return w;
        }
    }
    return 0;
}

void setup_twiddle_factors(uint32_t* w, uint32_t* wp, size_t N, uint32_t p, uint32_t r, uint32_t rp) {
    uint32_t omega = find_primitive_root(p, N);
    uint32_t R_mod_p = (uint64_t)(1ULL << 31) % p * 2 % p;
    uint32_t omega_R = (uint64_t)omega * R_mod_p % p;
    
    w[0] = 1;
    wp[0] = mul_barrett_fixed_prep(w[0], p);
    
    for (size_t i = 1; i < N; i++) {
        size_t k = 0;
        size_t tmp = i;
        for (size_t j = 0; j < __builtin_ctzll(N); j++) {
            k = (k << 1) | (tmp & 1);
            tmp >>= 1;
        }
        
        w[i] = mod_pow(omega_R, k, p);
        wp[i] = mul_barrett_fixed_prep(w[i], p);
    }
}

template<size_t N>
void benchmark_ntt() {
    const uint32_t p = prime30::p[0];
    
    uint32_t r = (uint64_t)(1ULL << 16) / p;
    uint32_t rp = mul_barrett_fixed_prep(r, p);
    
    uint32_t* x = (uint32_t*)aligned_alloc(32, N * sizeof(uint32_t));
    uint32_t* w = (uint32_t*)aligned_alloc(32, N * sizeof(uint32_t));
    uint32_t* wp = (uint32_t*)aligned_alloc(32, N * sizeof(uint32_t));
    
    setup_twiddle_factors(w, wp, N, p, r, rp);
    
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<uint32_t> dis(0, p - 1);
    
    for (size_t i = 0; i < N; i++) {
        x[i] = dis(gen);
    }
    
    for (int i = 0; i < 3; i++) {
        FNTT::ntt<N>(x, w, wp, r, rp, p);
    }
    
    const int num_runs = 10;
    uint64_t total_time_us = 0;
    
    for (int run = 0; run < num_runs; run++) {
        for (size_t i = 0; i < N; i++) {
            x[i] = dis(gen);
        }
        
        auto start = std::chrono::high_resolution_clock::now();
        FNTT::ntt<N>(x, w, wp, r, rp, p);
        auto end = std::chrono::high_resolution_clock::now();
        
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
        total_time_us += duration.count();
    }
    
    double avg_time_us = total_time_us / (double)num_runs;
    double avg_time_ms = avg_time_us / 1000.0;
    
    int log2n = __builtin_ctzll(N);
    std::cout << "| 2^" << std::setw(2) << log2n << "        | "
              << std::setw(20) << (uint64_t)avg_time_us << " | "
              << std::setw(15) << std::fixed << std::setprecision(3) << avg_time_ms << " |" 
              << std::endl;
    
    free(x);
    free(w);
    free(wp);
}

int main() {
    std::cout << "Profiling Algorithm Speed (32-bit, Average of 10 runs)" << std::endl;
    std::cout << "Prime: " << prime30::p[0] << " (998244353 = 119 * 2^23 + 1)" << std::endl;
    std::cout << "--------------------------------------------------------" << std::endl;
    std::cout << "|     Size (n) |        Avg Time (us) |   Avg Time (ms) |" << std::endl;
    std::cout << "|--------------|----------------------|-----------------|" << std::endl;
    
    benchmark_ntt<(1 << 10)>();
    benchmark_ntt<(1 << 12)>();
    benchmark_ntt<(1 << 14)>();
    benchmark_ntt<(1 << 16)>();
    benchmark_ntt<(1 << 18)>();
    benchmark_ntt<(1 << 20)>();
    
    return 0;
}