// io from https://judge.yosupo.jp/submission/199421
// NTT Logic replaced with Code 2 implementation

#pragma GCC target("avx2")
#pragma GCC target("sse,sse2,sse3,ssse3,sse4,popcnt,abm,mmx,avx,tune=native")
#include <immintrin.h>
#include "bits/stdc++.h"
#include <sys/mman.h>
#include <sys/stat.h>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstring>
#include <iostream>

using u32 = uint32_t;
using u64 = uint64_t;

typedef __m256i v8i;

const uint32_t MOD = 998244353;
const uint32_t WMOD = 1996488706;
const uint32_t R2_MOD = 932051910;
const uint32_t M_INV = 998244351;
const uint32_t PRIM_ROOT = 3;

const v8i v_mod = _mm256_set1_epi32(MOD);
const v8i v_wmod = _mm256_set1_epi32(WMOD);
const v8i v_m = _mm256_set1_epi32(M_INV);
const v8i v_r2 = _mm256_set1_epi32(R2_MOD);
const v8i v_one = _mm256_set1_epi32(1);
const v8i v_zero = _mm256_setzero_si256();

namespace io {
    using u8 = unsigned char;
    using u16 = uint16_t;
    using idt = std::size_t;

    constexpr std::size_t buf_def_size = 262144;
    constexpr std::size_t buf_flush_threshold = 32;
    constexpr std::size_t string_copy_threshold = 512;
    constexpr u64 E16 = 1e16, E12 = 1e12, E8 = 1e8, E4 = 1e4;
    struct _io_t {
        u8 t_i[1 << 15];
        int t_o[10000];
        constexpr _io_t() {
            std::fill(t_i, t_i + (1 << 15), u8(-1));
            for (int i = 0; i < 10; ++i) {
                for (int j = 0; j < 10; ++j) {
                    t_i[0x3030 + 256 * j + i] = j + 10 * i;
                }
            }
            for (int e0 = (48 << 0), j = 0; e0 < (58 << 0); e0 += (1 << 0)) {
                for (int e1 = (48 << 8); e1 < (58 << 8); e1 += (1 << 8)) {
                    for (int e2 = (48 << 16); e2 < (58 << 16); e2 += (1 << 16)) {
                        for (int e3 = (48 << 24); e3 < (58 << 24); e3 += (1 << 24)) {
                            t_o[j++] = e0 ^ e1 ^ e2 ^ e3;
                        }
                    }
                }
            }
        }
        void get(char* s, u32 p) const {
            *((int*)s) = t_o[p];
        }
    };
    constexpr _io_t _iot = {};
    struct Qinf {
        explicit Qinf(FILE* fi) : f(fi) {
            auto fd = fileno(f);
            fstat(fd, &Fl);
            bg = (char*)mmap(0, Fl.st_size + 4, PROT_READ, MAP_PRIVATE, fd, 0);
            p = bg, ed = bg + Fl.st_size;
            madvise(bg, Fl.st_size + 4, MADV_SEQUENTIAL);
        }
        ~Qinf() {
            munmap(bg, Fl.st_size + 1);
        }
        template <std::unsigned_integral T>
        Qinf& operator>>(T& x) {
            skip_space();
            x = *p++ - '0';
            for (;;) {
                T y = _iot.t_i[*reinterpret_cast<u16*>(p)];
                if (y > 99) {
                    break;
                }
                x = x * 100 + y, p += 2;
            }
            if (*p > ' ') {
                x = x * 10 + (*p++ & 15);
            }
            return *this;
        }

       private:
        void skip_space() {
            while (*p <= ' ') {
                ++p;
            }
        }
        FILE* f;
        char *bg, *ed, *p;
        struct stat Fl;
    } qin(stdin);
    struct Qoutf {
        explicit Qoutf(FILE* fi, std::size_t sz = buf_def_size) : f(fi), bg(new char[sz]), ed(bg + sz - buf_flush_threshold), p(bg) {}
        ~Qoutf() {
            flush();
            delete[] bg;
        }
        void flush() {
            fwrite_unlocked(bg, 1, p - bg, f), p = bg;
        }
        Qoutf& operator<<(u32 x) {
            if (x >= E8) {
                put2(x / E8), x %= E8, putb(x / E4), putb(x % E4);
            } else if (x >= E4) {
                put4(x / E4), putb(x % E4);
            } else {
                put4(x);
            }
            chk();
            return *this;
        }
        Qoutf& operator<<(u64 x) {
            if (x >= E8) {
                u64 q0 = x / E8, r0 = x % E8;
                if (x >= E16) {
                    u64 q1 = q0 / E8, r1 = q0 % E8;
                    put4(q1), putb(r1 / E4), putb(r1 % E4);
                } else if (x >= E12) {
                    put4(q0 / E4), putb(q0 % E4);
                } else {
                    put4(q0);
                }
                putb(r0 / E4), putb(r0 % E4);
            } else {
                if (x >= E4) {
                    put4(x / E4), putb(x % E4);
                } else {
                    put4(x);
                }
            }
            chk();
            return *this;
        }
        Qoutf& operator<<(char ch) {
            *p++ = ch;
            return *this;
        }

       private:
        void putb(u32 x) {
            _iot.get(p, x), p += 4;
        }
        void put4(u32 x) {
            if (x > 99) {
                if (x > 999) {
                    putb(x);
                } else {
                    _iot.get(p, x * 10), p += 3;
                }
            } else {
                put2(x);
            }
        }
        void put2(u32 x) {
            if (x > 9) {
                _iot.get(p, x * 100), p += 2;
            } else {
                *p++ = x + '0';
            }
        }
        void chk() {
            if (p > ed) [[unlikely]] {
                flush();
            }
        }
        FILE* f;
        char *bg, *ed, *p;
    } qout(stdout);
};  // namespace io

// --- Scalar Montgomery Arithmetic (Same in both, included for completeness) ---

inline uint32_t mont_mul(uint32_t a, uint32_t b) {
    uint64_t t = (uint64_t)a * b;
    uint64_t m = (uint64_t)((uint32_t)t * M_INV) * MOD;
    uint32_t r = (t + m) >> 32;
    return r >= MOD ? r - MOD : r;
}

inline uint32_t to_mont(uint32_t x) { return mont_mul(x, R2_MOD); }
inline uint32_t from_mont(uint32_t x) { return mont_mul(x, 1); }

uint32_t pow_mod(uint32_t base, uint32_t exp) {
    uint32_t result = to_mont(1);
    base = to_mont(base);
    while (exp > 0) {
        if (exp & 1) result = mont_mul(result, base);
        base = mont_mul(base, base);
        exp >>= 1;
    }
    return from_mont(result);
}

uint32_t inv_mod(uint32_t x) { return pow_mod(x, MOD - 2); }

// --- AVX2 Helper Functions (From Code 2) ---

v8i reduce(v8i x0246, v8i x1357) {
    v8i x0246_ninv = _mm256_mul_epu32(x0246, v_m);
    v8i x1357_ninv = _mm256_mul_epu32(x1357, v_m);
    v8i x0246_res = _mm256_add_epi64(x0246, _mm256_mul_epu32(x0246_ninv, v_mod));
    v8i x1357_res = _mm256_add_epi64(x1357, _mm256_mul_epu32(x1357_ninv, v_mod));
    v8i res = _mm256_or_si256(_mm256_srli_epi64(x0246_res, 32), x1357_res);
    // v8i res = _mm256_or_si256(_mm256_bsrli_epi128(x0246_res, 4), x1357_res);
    return res;
}

v8i _mm256_mont_mul(v8i a, v8i b) {
    v8i a_sh = _mm256_bsrli_epi128(a, 4);
    v8i b_sh = _mm256_bsrli_epi128(b, 4);
    v8i x0246 = _mm256_mul_epu32(a, b);
    v8i x1357 = _mm256_mul_epu32(a_sh, b_sh);
    return reduce(x0246, x1357);
}

// this is correct. 
// inline v8i _mm256_mont_mul(v8i a, v8i b) {
//     v8i a_odd = _mm256_srli_epi64(a, 32);
//     v8i b_odd = _mm256_srli_epi64(b, 32);
//     v8i t_even = _mm256_mul_epu32(a, b);
//     v8i u_even = _mm256_mul_epu32(t_even, v_m);
//     v8i up_even = _mm256_mul_epu32(u_even, v_mod);
//     v8i sum_even = _mm256_add_epi64(t_even, up_even);
//     v8i res_even = _mm256_srli_epi64(sum_even, 32);
//     v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
//     v8i u_odd = _mm256_mul_epu32(t_odd, v_m);
//     v8i up_odd = _mm256_mul_epu32(u_odd, v_mod);
//     v8i sum_odd = _mm256_add_epi64(t_odd, up_odd);
//     v8i result = _mm256_or_si256(res_even, sum_odd);
//     v8i adjusted = _mm256_sub_epi32(result, v_mod);
//     return _mm256_min_epu32(result, adjusted);
// }

inline v8i _mm256_mod(const v8i& a, const v8i &m = v_mod) {
    return _mm256_min_epu32(a, _mm256_sub_epi32(a, m));
}

inline v8i _mm256_add_mod(v8i a, v8i b, const v8i m = v_wmod) {
    v8i sum = _mm256_add_epi32(a, b);
    return _mm256_mod(sum, m);
}

inline v8i _mm256_sub_mod(v8i a, v8i b, const v8i &m = v_wmod) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i diff_m = _mm256_add_epi32(diff, m);
   return _mm256_min_epu32(diff, diff_m);
}

// Needed for neg_n in inverse logic (From Code 1, as Code 2 didn't snippet it)
inline v8i _mm256_neg_mod(const v8i& a) {
    v8i neg = _mm256_sub_epi32(v_mod, a);
    v8i mask = _mm256_cmpeq_epi32(a, v_zero);
    return _mm256_andnot_si256(mask, neg);
}

// --- Roots and NTT Logic (From Code 2) ---

std::vector<uint32_t> g_root;
std::vector<uint32_t> g_inv_root;

void reset_roots() {
    g_root = {to_mont(1)};
    g_inv_root = {to_mont(1)};
}

void get_root_mont(const int &n) {
    if ((int)g_root.size() < n) {
        int i = g_root.size();
        g_root.resize(n); g_inv_root.resize(n);
        for (; i != n; i <<= 1) {
            u_int32_t pp = pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2));
            uint32_t w = to_mont(pp);
            uint32_t iw = to_mont(inv_mod(pp));
            for (int j = 0; j != i; ++j) {
                g_root[i + j] = mont_mul(g_root[j], w);
                g_inv_root[i + j] = mont_mul(g_inv_root[j], iw);
            }
        }
    }
}

void dif_ntt(uint32_t *f, const int &n) {
    const uint32_t* rt = g_root.data();
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    for (int i = n >> 1; i >= 8; i >>= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
            #pragma GCC unroll(4)
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));
                v8i v_q = _mm256_loadu_si256((v8i*)(f + p + i));
                v8i v_v = _mm256_mont_mul(v_q, v_rt);
                _mm256_storeu_si256((v8i*)(f + p), _mm256_add_mod(v_u, v_v));
                _mm256_storeu_si256((v8i*)(f + p + i), _mm256_sub_mod(v_u, v_v));
            }
        }
    }
    for (int j = 0, k = 0; j != n; j += 8, ++k) {
        v8i v_rt = _mm256_set1_epi32(rt[k]);
        v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        _mm256_storeu_si256((v8i*)(f + j), _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_sub_mod(v_u, v_v), 0x20));
    }
    for (int j = 0; j != n; j += 8) {
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + (j >> 2)))), perm_i2);
        v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        v8i v_v_mont = _mm256_mont_mul(v_v, v_rt);
        _mm256_storeu_si256((v8i*)(f + j), _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v_mont), _mm256_sub_mod(v_u, v_v_mont)));
    }
    for (int j = 0; j != n; j += 8) {
        v8i v_rt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + (j >> 1)))), perm_i1);
        v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_v = _mm256_mont_mul(v_q, v_rt);
        v8i v_np = _mm256_add_mod(v_u, v_v), v_nq = _mm256_sub_mod(v_u, v_v);
        _mm256_storeu_si256((v8i*)(f + j), _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA));
    }
}

void dit_ntt(uint32_t *f, const int &n) {
    const uint32_t* irt = g_inv_root.data();
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    for (int j = 0; j != n; j += 8) {
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(irt + (j >> 1)))), perm_i1);
        v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
        v8i v_sum = _mm256_add_mod(v_u, v_v), v_diff = _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt);
        _mm256_storeu_si256((v8i*)(f + j), _mm256_blend_epi32(v_sum, _mm256_shuffle_epi32(v_diff, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA));
    }
    for (int j = 0; j != n; j += 8) {
        v8i v_irt = _mm256_permutevar8x32_epi32(_mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(irt + (j >> 2)))), perm_i2);
        v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
        v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
        v8i v_v = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
        _mm256_storeu_si256((v8i*)(f + j), _mm256_unpacklo_epi64(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt)));
    }
    for (int j = 0, k = 0; j != n; j += 8, ++k) {
        v8i v_irt = _mm256_set1_epi32(irt[k]);
        v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
        v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
        v8i v_v = _mm256_permute2x128_si256(v_f, v_f, 0x11);
        _mm256_storeu_si256((v8i*)(f + j), _mm256_permute2x128_si256(_mm256_add_mod(v_u, v_v), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt), 0x20));
    }
    for (int i = 8; i < n; i <<= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            const v8i v_irt = _mm256_set1_epi32(irt[k]);
            #pragma GCC unroll(4)
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));
                v8i v_v = _mm256_loadu_si256((v8i*)(f + p + i));
                _mm256_storeu_si256((v8i*)(f + p), _mm256_add_mod(v_u, v_v));
                _mm256_storeu_si256((v8i*)(f + p + i), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt));
            }
        }
    }
    uint32_t inv_n = to_mont(to_mont(inv_mod(n)));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    for (int i = 0; i < n; i += 8) {
        v8i v_f = _mm256_loadu_si256((v8i*)(f + i));
        _mm256_storeu_si256((v8i*)(f + i), _mm256_mod(_mm256_mont_mul(v_f, v_inv_n)));
    }
}

// --- Polynomial Utilities (Adapted from Code 1) ---

// Pointwise multiplication (Montgomery form)
inline void dot_n(uint32_t* a, uint32_t* b, uint32_t* c, int n) {
    for (int i = 0; i < n; i += 8) {
        v8i va = _mm256_loadu_si256((v8i*)(a + i));
        v8i vb = _mm256_loadu_si256((v8i*)(b + i));
        _mm256_storeu_si256((v8i*)(c + i), _mm256_mont_mul(va, vb));
    }
}

// Negate array (Montgomery form): dst[i] = -src[i] mod p
inline void neg_n(uint32_t* src, uint32_t* dst, int n) {
    int i = 0;
    for (; i + 8 <= n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(src + i));
        _mm256_storeu_si256((v8i*)(dst + i), _mm256_neg_mod(v));
    }
    for (; i < n; i++) {
        dst[i] = src[i] == 0 ? 0 : MOD - src[i];
    }
}

// Convert array to Montgomery form
inline void to_mont_n(uint32_t* f, int n) {
    int i = 0;
    for (; i + 8 <= n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(f + i));
        _mm256_storeu_si256((v8i*)(f + i), _mm256_mont_mul(v, v_r2));
    }
    for (; i < n; i++) {
        f[i] = to_mont(f[i]);
    }
}

// Convert array from Montgomery form
inline void from_mont_n(uint32_t* f, int n) {
    int i = 0;
    for (; i + 8 <= n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(f + i));
        _mm256_storeu_si256((v8i*)(f + i), _mm256_mod(_mm256_mont_mul(v, v_one)));
    }
    for (; i < n; i++) {
        f[i] = from_mont(f[i]);
    }
}

// Zero array (handles any size correctly)
inline void zero_n(uint32_t* f, int n) {
    int i = 0;
    for (; i + 8 <= n; i += 8) {
        _mm256_storeu_si256((v8i*)(f + i), v_zero);
    }
    for (; i < n; i++) f[i] = 0;
}

const int MAXN = 1 << 18;
alignas(32) uint32_t A[MAXN], B[MAXN], F[MAXN], G[MAXN];

int main() {
    size_t n; 
    using io::qin;
    using io::qout;
    qin >> n;
    // Read input directly (no % MOD needed, input guaranteed < 10^9)
    for (int i = 0; i < n; i++) {
        qin >> A[i];
    }
    
    // Find smallest power of 2 >= n (minimum 8 for SIMD)
    int shrink_len = 8;
    while (shrink_len < n) shrink_len <<= 1;
    
    // Precompute roots and zero-pad A
    memset(A + n, 0, (shrink_len - n) * sizeof(uint32_t));
    
    // Convert A to Montgomery form once    
    // B[0] = A[0]^{-1} in Montgomery form
    B[0] = inv_mod(A[0]);
    
    // Newton iteration: B = 2B' - A * B'^2
    // Key insight: cyclic convolution is OK because we clear positions 0..N-1 anyway
    int N = 1, N2 = 2;
    reset_roots();
    while (N < shrink_len) {
        int newN = (N2 > shrink_len) ? shrink_len : N2;
        int ntt_size = N2;  // N2-point NTT is sufficient!
        if (ntt_size < 8) ntt_size = 8;
        
        // Copy A[0..newN-1] to F, zero-pad to ntt_size
        memcpy(F, A, newN * sizeof(uint32_t));
        memset(F + newN, 0, (ntt_size - newN) * sizeof(uint32_t));
        
        // Copy B'[0..N-1] to G, zero-pad to ntt_size
        memcpy(G, B, N * sizeof(uint32_t));
        memset(G + N, 0, (ntt_size - N) * sizeof(uint32_t));
        
        // NTT both (already in Montgomery form)
        get_root_mont(ntt_size);
        dif_ntt(F, ntt_size);
        dif_ntt(G, ntt_size);
        
        // F = F * G (frequency domain: A * B')
        dot_n(F, G, F, ntt_size);
        
        // INTT
        dit_ntt(F, ntt_size);
        
        // Clear positions 0..N-1 (should be [R, 0, 0, ...] but we don't care)
        memset(F, 0, N * sizeof(uint32_t));
        
        // NTT again
        dif_ntt(F, ntt_size);
        
        // F = F * G (frequency domain: (A*B' - 1) * B')
        dot_n(F, G, F, ntt_size);
        
        // INTT
        dit_ntt(F, ntt_size);
        
        // B[N..newN-1] = -F[N..newN-1]
        neg_n(F + N, B + N, newN - N);
        
        N = newN;
        N2 = N << 1;
    }    
    // Output
    for (int i = 0; i < n; i++) {
        qout << B[i] << ' ';
    }
    
    return 0;
}