// io from https://judge.yosupo.jp/submission/199421
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

inline v8i _mm256_mont_mul(const v8i& a, const v8i& b) {
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

inline v8i _mm256_add_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), m);
    v8i mask = _mm256_srai_epi32(adjusted, 31);
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, m));
}

inline v8i _mm256_sub_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i mask = _mm256_cmpgt_epi32(b, a);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}

inline v8i _mm256_mod(const v8i& a, const v8i &m = v_mod) {
    v8i diff = _mm256_sub_epi32(a, m);
    v8i mask = _mm256_srai_epi32(diff, 31);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}

static std::pair<uint32_t*, uint32_t*> get_root_mont(const int &n) {
    static std::vector<uint32_t> root{to_mont(1)};
    static std::vector<uint32_t> inv_root{to_mont(1)};
    if ((int)root.size() < n) {
        int i = root.size();
        root.resize(n); inv_root.resize(n);
        for (; i != n; i <<= 1) {
            uint32_t w = to_mont(pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2)));
            uint32_t iw = to_mont(inv_mod(pow_mod(PRIM_ROOT, (MOD - 1) / (i << 2))));
            for (int j = 0; j != i; ++j) {
                root[i + j] = mont_mul(root[j], w);
                inv_root[i + j] = mont_mul(inv_root[j], iw);
            }
        }
    }
    return {root.data(), inv_root.data()};
}

void dif_ntt(uint32_t *f, const int &n) {
    const uint32_t* rt = get_root_mont(n).first;
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    for (int i = n >> 1; i >= 8; i >>= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            v8i v_rt = _mm256_set1_epi32(rt[k]);
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
    const uint32_t* irt = get_root_mont(n).second;
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
            v8i v_irt = _mm256_set1_epi32(irt[k]);
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));
                v8i v_v = _mm256_loadu_si256((v8i*)(f + p + i));
                _mm256_storeu_si256((v8i*)(f + p), _mm256_add_mod(v_u, v_v));
                _mm256_storeu_si256((v8i*)(f + p + i), _mm256_mont_mul(_mm256_sub_mod(v_u, v_v), v_irt));
            }
        }
    }
    uint32_t inv_n = to_mont(inv_mod(n));
    v8i v_inv_n = _mm256_set1_epi32(inv_n);
    for (int i = 0; i < n; i += 8) {
        v8i v_f = _mm256_loadu_si256((v8i*)(f + i));
        _mm256_storeu_si256((v8i*)(f + i), _mm256_mod(_mm256_mont_mul(v_f, v_inv_n)));
    }
}

inline void to_mont_n(uint32_t* f, int n) {
    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(f + i));
        _mm256_storeu_si256((v8i*)(f + i), _mm256_mont_mul(v, v_r2));
    }
}

inline void from_mont_n(uint32_t* f, int n) {
    for (int i = 0; i < n; i += 8) {
        v8i v = _mm256_loadu_si256((v8i*)(f + i));
        _mm256_storeu_si256((v8i*)(f + i), _mm256_mod(_mm256_mont_mul(v, v_one)));
    }
}

const int maxn = 1 << 25;
alignas(32) uint32_t A[maxn], B[maxn];

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


int main() {
    size_t n, m;
    using io::qin;
    using io::qout;
    qin >> n >> m;
    
    for (int i = 0; i < n; i++) qin >> A[i];
    for (int i = 0; i < m; i++) qin >> B[i];
    
    int L = 8;
    while (L < n + m - 1) L <<= 1;
    
    get_root_mont(L);
    
    to_mont_n(A, L);
    to_mont_n(B, L);
    
    dif_ntt(A, L);
    dif_ntt(B, L);
    
    for (int i = 0; i < L; i += 8) {
        v8i va = _mm256_loadu_si256((v8i*)(A + i));
        v8i vb = _mm256_loadu_si256((v8i*)(B + i));
        _mm256_storeu_si256((v8i*)(A + i), _mm256_mont_mul(va, vb));
    }
    
    dit_ntt(A, L);
    from_mont_n(A, L);
    
    for (int i = 0; i < n + m - 1; i++) {
        qout << A[i] << ' ';
    }
    
    return 0;
}
