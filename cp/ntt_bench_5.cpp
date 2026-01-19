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
  static constexpr size_t kWordSize = 64UL;
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
    namespace prime59 {
      static constexpr size_t kPrimeBitSize = 59;
      static constexpr uint64_t p[1] = {576460752213245953UL};
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
// AVX2 Arithmetic Operations
// ============================================================================

namespace fntt {
  namespace core {

    inline __m256i _mm256_conditional_sub_epu64(const __m256i a, const __m256i p) {
      const __m256i z = _mm256_setzero_si256();
      __m256i t, m;
      t = _mm256_sub_epi64(a, p);
      m = _mm256_srli_epi64(t, 63);
      m = _mm256_sub_epi64(z, m);
      m = _mm256_and_si256(m, p);
      t = _mm256_add_epi64(t, m);
      return t;
    }

    inline __m256i _mm256_mulhi_epu64_b62(const __m256i a, const __m256i b) {
      const __m256i mask = _mm256_set1_epi64x(0xffffffffUL);
      __m256i a1, b1, s, s0, t, c0, c1;
      a1 = _mm256_shuffle_epi32(a, shuffle_imm(1, 1, 3, 3));
      b1 = _mm256_shuffle_epi32(b, shuffle_imm(1, 1, 3, 3));

      c0 = _mm256_mul_epu32(a, b);
      t = _mm256_mul_epu32(a1, b);
      s = _mm256_mul_epu32(b1, a);
      c1 = _mm256_mul_epu32(a1, b1);

      c0 = _mm256_srli_epi64(c0, 32);
      s0 = _mm256_and_si256(s, mask);
      s = _mm256_srli_epi64(s, 32);
      t = _mm256_add_epi64(t, c0);
      t = _mm256_add_epi64(t, s0);
      t = _mm256_srli_epi64(t, 32);

      c1 = _mm256_add_epi64(c1, s);
      c1 = _mm256_add_epi64(c1, t);
      return c1;
    }

    inline __m256i _mm256_mullo_epu64(const __m256i a, const __m256i b) {
      __m256i a1, b1, t, s, c0;
      a1 = _mm256_shuffle_epi32(a, shuffle_imm(1, 1, 3, 3));
      b1 = _mm256_shuffle_epi32(b, shuffle_imm(1, 1, 3, 3));

      c0 = _mm256_mul_epu32(a, b);
      t = _mm256_mul_epu32(a1, b);
      s = _mm256_mul_epu32(b1, a);
      t = _mm256_add_epi64(t, s);
      t = _mm256_slli_epi64(t, 32);
      c0 = _mm256_add_epi64(c0, t);
      return c0;
    }

    inline __m256i _mm256_mulhi_epu64_b32(const __m256i a, const __m256i b) {
      __m256i a1, c0, c1;
      a1 = _mm256_shuffle_epi32(a, shuffle_imm(1, 1, 3, 3));
      c0 = _mm256_mul_epu32(a, b);
      c1 = _mm256_mul_epu32(a1, b);
      c0 = _mm256_srli_epi64(c0, 32);
      c1 = _mm256_add_epi64(c1, c0);
      c1 = _mm256_srli_epi64(c1, 32);
      return c1;
    }

    inline __m256i _mm256_mullo_epu64_b32(const __m256i a, const __m256i b) {
      __m256i a1, c0, c1;
      a1 = _mm256_shuffle_epi32(a, shuffle_imm(1, 1, 3, 3));
      c1 = _mm256_mul_epu32(a1, b);
      c0 = _mm256_mul_epu32(a, b);
      c1 = _mm256_slli_epi64(c1, 32);
      c0 = _mm256_add_epi64(c0, c1);
      return c0;
    }

    inline __m256i _mm256_redc_barrett_lazy(const __m256i a, const __m256i r, const __m256i p) {
      __m256i t;
      t = _mm256_mulhi_epu64_b32(a, r);
      t = _mm256_mullo_epu64_b32(p, t);
      t = _mm256_sub_epi64(a, t);
      return t;
    }

    inline __m256i _mm256_mul_barrett_fixed_lazy(const __m256i a, const __m256i b, const __m256i bp,
                                                 const __m256i p) {
      __m256i t, c;
      t = _mm256_mulhi_epu64_b62(bp, a);
      c = _mm256_mullo_epu64(a, b);
      t = _mm256_mullo_epu64(t, p);
      c = _mm256_sub_epi64(c, t);
      return c;
    }

    inline __m256i _mm256_mul_barrett_fixed(const __m256i a, const __m256i b, const __m256i bp,
                                            const __m256i p) {
      __m256i t, c;
      t = _mm256_mulhi_epu64_b62(bp, a);
      c = _mm256_mullo_epu64(a, b);
      t = _mm256_mullo_epu64(t, p);
      c = _mm256_sub_epi64(c, t);
      c = _mm256_conditional_sub_epu64(c, p);
      return c;
    }

  } // namespace core
} // namespace fntt

// ============================================================================
// Scalar Arithmetic (for setup)
// ============================================================================

namespace fntt {
  namespace core {

    inline uint64_t mul_barrett_fixed_prep(const uint64_t b, const uint64_t p) {
      return ((unsigned __int128) b << 64U) / p;
    }

    template<enum ImplSelector Impl>
    inline uint64_t redc_barrett_lazy(uint64_t a, const uint64_t r, const uint64_t p) {
      uint64_t t0, t1;
      __asm__ volatile (
      "mulx %[r], %[t0], %[t1]\n\t"
      "imul %[p], %[t1]\n\t"
      "sub %[t1], %[a]\n\t"
      : [a] "+&d"(a), [t0] "=&r"(t0), [t1] "=&r"(t1)
      : [r] "r"(r), [p] "r"(p)
      : "cc");
      return a;
    }

    template<enum ImplSelector Impl>
    inline uint64_t mul_barrett_fixed_lazy(uint64_t a, const uint64_t b, const uint64_t bp, const uint64_t p) {
      uint64_t t0, t1;
      __asm__ volatile (
      "mulx %[bp], %[t0], %[t1]\n\t"
      "imul %[b], %[a]\n\t"
      "imul %[p], %[t1]\n\t"
      "sub %[t1], %[a]\n\t"
      : [a] "+&d"(a), [t0] "=&r"(t0), [t1] "=&r"(t1)
      : [b] "r"(b), [bp] "r"(bp), [p] "r"(p)
      : "cc");
      return a;
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
      inline void backward_butterfly_lazy(uint64_t *x, uint64_t *y,
                                          const uint64_t w, const uint64_t wp,
                                          const uint64_t Lp, const uint64_t p) {
        uint64_t u, v;
        u = *x;
        v = *y;
        *x = u + v;
        *y = mul_barrett_fixed_lazy<Impl>(u + Lp - v, w, wp, p);
      }

      template<enum ImplSelector Impl>
      inline void backward_butterfly_corr_lazy(uint64_t *x, uint64_t *y,
                                               const uint64_t w, const uint64_t wp,
                                               const uint64_t Lp, const uint64_t r,
                                               const uint64_t p) {
        uint64_t u, v;
        u = *x;
        v = *y;
        *x = redc_barrett_lazy<Impl>(u + v, r, p);
        *y = mul_barrett_fixed_lazy<Impl>(u + Lp - v, w, wp, p);
      }

      template<enum ImplSelector Impl>
      inline void forward_butterfly_lazy(uint64_t *x, uint64_t *y,
                                         const uint64_t w, const uint64_t wp, const uint64_t Lp, const uint64_t p) {
        uint64_t u, v;
        u = *x;
        v = mul_barrett_fixed_lazy<Impl>(*y, w, wp, p);
        *x = u + v;
        *y = u + Lp - v;
      }

      template<enum ImplSelector Impl>
      inline void forward_butterfly_montgomery_domain_lazy(uint64_t *x, uint64_t *y,
                                                           uint64_t w, uint64_t wp, const uint64_t Lp,
                                                           const uint64_t r, const uint64_t rp, const uint64_t p) {
        uint64_t u, v;
        u = mul_barrett_fixed_lazy<Impl>(*x, r, rp, p);
        v = mul_barrett_fixed_lazy<Impl>(*y, w, wp, p);
        *x = u + v;
        *y = u + Lp - v;
      }

      template<enum ImplSelector Impl>
      inline void backward_butterfly_montgomery_domain(uint64_t *x, uint64_t *y,
                                                       const uint64_t w, const uint64_t wp,
                                                       const uint64_t ni, const uint64_t nip,
                                                       const uint64_t Lp, const uint64_t p) {
        uint64_t u, v;
        u = *x;
        v = *y;
        *x = mul_barrett_fixed_lazy<Impl>(u + v, ni, nip, p);
        *y = mul_barrett_fixed_lazy<Impl>(u + Lp - v, w, wp, p);
      }

      // AVX2 butterfly operations
      inline void forward_butterfly4_lazy_avx2(uint64_t *x, uint64_t *y, const __m256i w, const __m256i wp,
                                               const __m256i Lp, const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        v = _mm256_mul_barrett_fixed_lazy(v, w, wp, p);
        x_ = _mm256_add_epi64(u, v);
        y_ = _mm256_add_epi64(u, Lp);
        y_ = _mm256_sub_epi64(y_, v);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      inline void backward_butterfly4_lazy(uint64_t *x, uint64_t *y, const __m256i w, const __m256i wp,
                                           const __m256i Lp, const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        x_ = _mm256_add_epi64(u, v);
        y_ = _mm256_add_epi64(u, Lp);
        y_ = _mm256_sub_epi64(y_, v);
        y_ = _mm256_mul_barrett_fixed_lazy(y_, w, wp, p);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      inline void backward_butterfly4_corr_lazy(uint64_t *x, uint64_t *y, const __m256i w, const __m256i wp,
                                                const __m256i Lp, const __m256i r, const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        x_ = _mm256_add_epi64(u, v);
        x_ = _mm256_redc_barrett_lazy(x_, r, p);
        y_ = _mm256_add_epi64(u, Lp);
        y_ = _mm256_sub_epi64(y_, v);
        y_ = _mm256_mul_barrett_fixed_lazy(y_, w, wp, p);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      inline void backward_butterfly4_montgomery_domain(uint64_t *x, uint64_t *y, const __m256i w, const __m256i wp,
                                                        const __m256i ni, const __m256i nip, const __m256i Lp,
                                                        const __m256i p) {
        __m256i u, v, x_, y_;
        u = _mm256_load_si256((__m256i *) x);
        v = _mm256_load_si256((__m256i *) y);
        x_ = _mm256_add_epi64(u, v);
        x_ = _mm256_mul_barrett_fixed(x_, ni, nip, p);
        y_ = _mm256_add_epi64(u, Lp);
        y_ = _mm256_sub_epi64(y_, v);
        y_ = _mm256_mul_barrett_fixed(y_, w, wp, p);
        _mm256_store_si256((__m256i *) x, x_);
        _mm256_store_si256((__m256i *) y, y_);
      }

      // Forward NTT (AVX2)
      template<size_t N>
      void ntt(uint64_t *x, const uint64_t *w, const uint64_t *wp,
               const uint64_t r, const uint64_t rp, const uint64_t p) {

        const uint64_t Lp = 2 * p;
        size_t t = N / 2;

        ++w, ++wp;

        const __m256i Lpm = _mm256_set1_epi64x(Lp), pm = _mm256_set1_epi64x(p);

        for(size_t m = 1; m < N / 4; m *= 2) {
          uint64_t *xp0 = x;
          uint64_t *xp1 = x + t;
          for(size_t i = 0; i < m; ++i) {
            const __m256i wm = _mm256_set1_epi64x(*w), wpm = _mm256_set1_epi64x(*wp);
            for(size_t j = 0; j < t; j += 4) {
              forward_butterfly4_lazy_avx2(xp0, xp1, wm, wpm, Lpm, pm);
              xp0 += 4, xp1 += 4;
            }
            xp0 += t, xp1 += t;
            ++w, ++wp;
          }
          t /= 2;
        }

        { // t = 2
          const size_t m = N / 4;
          uint64_t *xp0 = x;
          uint64_t *xp1 = x + 2;

          for(size_t i = 0; i < m; ++i) {
            forward_butterfly_lazy<fntt::x86_64>(xp0++, xp1++, *w, *wp, Lp, p);
            forward_butterfly_lazy<fntt::x86_64>(xp0, xp1, *w, *wp, Lp, p);

            xp0 += 2 + 1, xp1 += 2 + 1;
            ++w, ++wp;
          }
        }

        { // last loop, t = 1
          const size_t m = N / 2;
          uint64_t *xp0 = x;
          uint64_t *xp1 = x + 1;
          for(size_t i = 0; i < m; ++i) {
            forward_butterfly_montgomery_domain_lazy<fntt::x86_64>(xp0, xp1, *w, *wp, Lp, r, rp, p);

            xp0 += 2, xp1 += 2;
            ++w, ++wp;
          }
        }
      }

      // Inverse NTT (AVX2)
      template<size_t N>
      void intt(uint64_t *x, const uint64_t *w, const uint64_t *wp,
                const uint64_t ni, const uint64_t nip, const uint64_t r, const uint64_t p) {

        constexpr size_t s = fntt::kWordSize - prime59::kPrimeBitSize - 1;
        constexpr size_t L = 1UL << s;
        const uint64_t Lp = L * p;
        uint64_t *xp0, *xp1;

        ++w, ++wp;

        const __m256i Lpm = _mm256_set1_epi64x(Lp), pm = _mm256_set1_epi64x(p), rm = _mm256_set1_epi64x(r),
          nim = _mm256_set1_epi64x(ni), nipm = _mm256_set1_epi64x(nip);

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

        constexpr int logL = s;
        constexpr int logN = (int) utils::bitLength(N) - 2;
        constexpr int Q = logN / logL, R = logN - Q * logL;

        {
          size_t t = 4;
          size_t m = N / 8;

          for (int ll = 1; ll < logL - 1; ++ll) {
            xp0 = x, xp1 = x + t;
            for (size_t i = 0; i < m; ++i) {
              const __m256i wm = _mm256_set1_epi64x(*w), wpm = _mm256_set1_epi64x(*wp);
              for (size_t j = 0; j < t; j += 4) {
                backward_butterfly4_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 4, xp1 += 4;
              }
              xp0 += t, xp1 += t;
              ++w, ++wp;
            }
            t *= 2, m /= 2;
          }

          xp0 = x, xp1 = x + t;
          for (size_t i = 0; i < m; ++i) {
            const __m256i wm = _mm256_set1_epi64x(*w), wpm = _mm256_set1_epi64x(*wp);
            size_t j = 0;
            for (; j < 2 * t / L; j += 4) {
              backward_butterfly4_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
              xp0 += 4, xp1 += 4;
            }
            for (; j < t; j += 4) {
              backward_butterfly4_lazy(xp0, xp1, wm, wpm, Lpm, pm);
              xp0 += 4, xp1 += 4;
            }
            xp0 += t, xp1 += t;
            ++w, ++wp;
          }
          t *= 2, m /= 2;

          for (int qq = 1; qq < Q; ++qq) {
            for (int ll = 0; ll < logL - 1; ++ll) {
              xp0 = x, xp1 = x + t;
              for (size_t i = 0; i < m; ++i) {
                const __m256i wm = _mm256_set1_epi64x(*w), wpm = _mm256_set1_epi64x(*wp);
                size_t j = 0;
                for (; j < 1 * t / L; j += 4) {
                  backward_butterfly4_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                  xp0 += 4, xp1 += 4;
                }
                for (; j < 2 * t / L; j += 4) {
                  backward_butterfly4_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
                  xp0 += 4, xp1 += 4;
                }
                for (; j < t; j += 4) {
                  backward_butterfly4_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                  xp0 += 4, xp1 += 4;
                }
                xp0 += t, xp1 += t;
                ++w, ++wp;
              }
              t *= 2, m /= 2;
            }

            xp0 = x, xp1 = x + t;
            for (size_t i = 0; i < m; ++i) {
              const __m256i wm = _mm256_set1_epi64x(*w), wpm = _mm256_set1_epi64x(*wp);
              size_t j = 0;
              for (; j < 2 * t / L; j += 4) {
                backward_butterfly4_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
                xp0 += 4, xp1 += 4;
              }
              for (; j < t; j += 4) {
                backward_butterfly4_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 4, xp1 += 4;
              }
              xp0 += t, xp1 += t;
              ++w, ++wp;
            }
            t *= 2, m /= 2;
          }

          for (int rr = 0; rr < R; ++rr) {
            xp0 = x, xp1 = x + t;
            for (size_t i = 0; i < m; ++i) {
              const __m256i wm = _mm256_set1_epi64x(*w), wpm = _mm256_set1_epi64x(*wp);
              size_t j = 0;
              for (; j < 1 * t / L; j += 4) {
                backward_butterfly4_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 4, xp1 += 4;
              }
              for (; j < 2 * t / L; j += 4) {
                backward_butterfly4_corr_lazy(xp0, xp1, wm, wpm, Lpm, rm, pm);
                xp0 += 4, xp1 += 4;
              }
              for (; j < t; j += 4) {
                backward_butterfly4_lazy(xp0, xp1, wm, wpm, Lpm, pm);
                xp0 += 4, xp1 += 4;
              }
              xp0 += t, xp1 += t;
              ++w, ++wp;
            }
            t *= 2, m /= 2;
          }

          { // last loop t = n / 2
            constexpr size_t t = N / 2;
            xp0 = x, xp1 = x + t;
            const __m256i wm = _mm256_set1_epi64x(*w), wpm = _mm256_set1_epi64x(*wp);
            for (size_t j = 0; j < t; j += 4) {
              backward_butterfly4_montgomery_domain(xp0, xp1, wm, wpm, nim, nipm, Lpm, pm);
              xp0 += 4, xp1 += 4;
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

uint64_t mod_pow(uint64_t base, uint64_t exp, uint64_t mod) {
    uint64_t result = 1;
    base %= mod;
    while (exp > 0) {
        if (exp & 1) {
            result = (unsigned __int128)result * base % mod;
        }
        base = (unsigned __int128)base * base % mod;
        exp >>= 1;
    }
    return result;
}

uint64_t find_primitive_root(uint64_t p, size_t N) {
    for (uint64_t g = 2; g < p; g++) {
        uint64_t w = mod_pow(g, (p - 1) / N, p);
        if (w != 1 && mod_pow(w, N, p) == 1) {
            return w;
        }
    }
    return 0;
}

void setup_twiddle_factors(uint64_t* w, uint64_t* wp, size_t N, uint64_t p, uint64_t r, uint64_t rp) {
    uint64_t omega = find_primitive_root(p, N);
    uint64_t R_mod_p = (unsigned __int128)(1ULL << 63) % p * 2 % p;
    uint64_t omega_R = (unsigned __int128)omega * R_mod_p % p;
    
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
    const uint64_t p = prime59::p[0];
    
    uint64_t r = (unsigned __int128)(1ULL << 32) / p;
    uint64_t rp = mul_barrett_fixed_prep(r, p);
    
    uint64_t* x = (uint64_t*)aligned_alloc(32, N * sizeof(uint64_t));
    uint64_t* w = (uint64_t*)aligned_alloc(32, N * sizeof(uint64_t));
    uint64_t* wp = (uint64_t*)aligned_alloc(32, N * sizeof(uint64_t));
    
    setup_twiddle_factors(w, wp, N, p, r, rp);
    
    std::random_device rd;
    std::mt19937_64 gen(rd());
    std::uniform_int_distribution<uint64_t> dis(0, p - 1);
    
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
    std::cout << "Profiling Algorithm Speed (Average of 10 runs)" << std::endl;
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
/*
Profiling Algorithm Speed (Average of 10 runs)
--------------------------------------------------------
|     Size (n) |        Avg Time (us) |   Avg Time (ms) |
|--------------|----------------------|-----------------|
| 2^10        |                    5 |           0.005 |
| 2^12        |                   24 |           0.025 |
| 2^14        |                  114 |           0.114 |
| 2^16        |                  514 |           0.514 |
| 2^18        |                 2367 |           2.368 |
| 2^20        |                10628 |          10.628 |

*/