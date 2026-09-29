// Step 1: high-level algorithms in portable C++ (exploration 013). No intrinsics; GCC may
// auto-vectorize (O3 pragma, as a submission would use). Canonical residues throughout.
//
// Reduction facts used below (P = 998244353 < 2^30, (P-1)^2 < 2^59.8):
//  * fold(x) = (x >> 32) * (2^32 mod P) + (x mod 2^32) is congruent to x and < 1.2972e18
//    for every 64-bit x (2^32 mod P = 301989884).
//  * fold(x) + 16 (P-1)^2 < 1.2972e18 + 1.5944e19 < 2^64, so 16 products may be added to a
//    folded (or zero) accumulator before the next fold.
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3")
#endif
#include "../common.hpp"
#include "../strassen.hpp"

#include <algorithm>
#include <cstring>

using namespace mp;

namespace {
constexpr u64 C32 = (u64(1) << 32) % P;  // 301989884
static_assert(C32 == 301989884);
inline u64 fold(u64 x) { return (x >> 32) * C32 + (x & 0xffffffffu); }

// s00: textbook triple loop, one remainder per product.
void s00_naive(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < k; ++j) {
            u64 s = 0;
            for (int t = 0; t < m; ++t) s = (s + u64(a[i * m + t]) * b[t * k + j]) % P;
            c[i * k + j] = u32(s);
        }
}

// s01: same loop order, lazy reduction (fold every 16 products).
void s01_ijk_lazy(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < k; ++j) {
            u64 s = 0;
            for (int t = 0; t < m; ++t) {
                s += u64(a[i * m + t]) * b[t * k + j];
                if ((t & 15) == 15) s = fold(s);
            }
            c[i * k + j] = u32(s % P);
        }
}

// s02: i-k-j order (unit-stride B rows), 64-bit row accumulator, fold every 16.
void s02_ikj_lazy(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    u64* acc = static_cast<u64*>(scratch(std::size_t(k) * 8, 0));
    for (int i = 0; i < n; ++i) {
        std::fill(acc, acc + k, 0);
        for (int t = 0; t < m; ++t) {
            const u64 x = a[i * m + t];
            const u32* br = b + std::size_t(t) * k;
            for (int j = 0; j < k; ++j) acc[j] += x * br[j];
            if ((t & 15) == 15)
                for (int j = 0; j < k; ++j) acc[j] = fold(acc[j]);
        }
        for (int j = 0; j < k; ++j) c[i * k + j] = u32(acc[j] % P);
    }
}

// s03: s02 plus cache blocking: a JB-column slab of the 64-bit accumulators for all rows,
// B processed in TB x JB blocks (TB = 16 so each block ends exactly at a fold).
template <int JB, int TB>
void s03_blocked(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    static_assert(TB == 16);
    u64* acc = static_cast<u64*>(scratch(std::size_t(n) * JB * 8, 0));
    for (int j0 = 0; j0 < k; j0 += JB) {
        const int jw = std::min(JB, k - j0);
        std::fill(acc, acc + std::size_t(n) * JB, 0);
        for (int t0 = 0; t0 < m; t0 += TB) {
            const int tw = std::min(TB, m - t0);
            for (int i = 0; i < n; ++i) {
                u64* ar = acc + std::size_t(i) * JB;
                for (int t = t0; t < t0 + tw; ++t) {
                    const u64 x = a[i * m + t];
                    const u32* br = b + std::size_t(t) * k + j0;
                    for (int j = 0; j < jw; ++j) ar[j] += x * br[j];
                }
                for (int j = 0; j < jw; ++j) ar[j] = fold(ar[j]);
            }
        }
        for (int i = 0; i < n; ++i)
            for (int j = 0; j < jw; ++j) c[i * k + j0 + j] = u32(acc[std::size_t(i) * JB + j] % P);
    }
}

// s04: register-blocked micro-tile in plain C++: 4 rows x 8 columns of 64-bit accumulators
// (local array the compiler can keep in registers), fold every 16 products. Edges fall
// back to a scalar loop. B rows are read in place (unit stride), A by 4 strided rows.
template <int MR, int NR>
inline void tile(int m, const u32* a, int lda, const u32* b, int ldb, u32* c, int ldc) {
    u64 acc[MR][NR] = {};
    for (int t0 = 0; t0 < m; t0 += 16) {
        const int te = std::min(m, t0 + 16);
        for (int t = t0; t < te; ++t) {
            const u32* br = b + std::size_t(t) * ldb;
            for (int r = 0; r < MR; ++r) {
                const u64 x = a[r * lda + t];
                for (int j = 0; j < NR; ++j) acc[r][j] += x * br[j];
            }
        }
        for (int r = 0; r < MR; ++r)
            for (int j = 0; j < NR; ++j) acc[r][j] = fold(acc[r][j]);
    }
    for (int r = 0; r < MR; ++r)
        for (int j = 0; j < NR; ++j) c[r * ldc + j] = u32(acc[r][j] % P);
}
void scalar_block(int n0, int n1, int j0, int j1, int m, const u32* a, int lda, const u32* b, int ldb, u32* c, int ldc) {
    for (int i = n0; i < n1; ++i)
        for (int j = j0; j < j1; ++j) {
            u64 s = 0;
            for (int t = 0; t < m; ++t) {
                s += u64(a[i * lda + t]) * b[std::size_t(t) * ldb + j];
                if ((t & 15) == 15) s = fold(s);
            }
            c[i * ldc + j] = u32(s % P);
        }
}
template <int MR, int NR>
void tiled(int n, int m, int k, const u32* a, int lda, const u32* b, int ldb, u32* c, int ldc) {
    const int nt = n / MR * MR, kt = k / NR * NR;
    for (int i = 0; i < nt; i += MR)
        for (int j = 0; j < kt; j += NR) tile<MR, NR>(m, a + i * lda, lda, b + j, ldb, c + i * ldc + j, ldc);
    scalar_block(0, nt, kt, k, m, a, lda, b, ldb, c, ldc);
    scalar_block(nt, n, 0, k, m, a, lda, b, ldb, c, ldc);
}
void s04_tile4x8(int n, int m, int k, const u32* a, const u32* b, u32* c) { tiled<4, 8>(n, m, k, a, m, b, k, c, k); }

// s05: s04 with B panel reuse: column blocks of 64 so a 1024 x 64 B slab (256 KiB) stays in
// L2 while all row tiles sweep over it.
void s05_tile4x8_slab(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    constexpr int JB = 64;
    for (int j0 = 0; j0 < k; j0 += JB) {
        const int jw = std::min(JB, k - j0);
        tiled<4, 8>(n, m, jw, a, m, b + j0, k, c + j0, k);
    }
}

// s1x: Strassen-Winograd over the s04 tile, canonical residues, recursive layout with
// row-major leaves. Padding: n to 4*2^d, k to 8*2^d, m to 2^d (zeros).
struct CanonOps {
    static void add(const u32* x, const u32* y, u32* z, std::size_t len) {
        for (std::size_t i = 0; i < len; ++i) {
            const u32 s = x[i] + y[i];
            z[i] = s >= P ? s - P : s;
        }
    }
    static void sub(const u32* x, const u32* y, u32* z, std::size_t len) {
        for (std::size_t i = 0; i < len; ++i) {
            const u32 s = x[i] - y[i];
            z[i] = s > x[i] ? s + P : s;  // wrapped => x < y
        }
    }
};
struct TileLeaf {
    using E = u32;
    static void multiply(const u32* a, const u32* b, u32* c, std::size_t n, std::size_t m, std::size_t k) {
        tiled<4, 8>(int(n), int(m), int(k), a, int(m), b, int(k), c, int(k));
    }
};

std::size_t round_up(std::size_t x, std::size_t r) { return (x + r - 1) / r * r; }

template <int D>
void s1_strassen(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    using SW = StrassenWinograd<TileLeaf, CanonOps>;
    const std::size_t N = round_up(n, std::size_t(4) << D), M = round_up(m, std::size_t(1) << D),
                      K = round_up(k, std::size_t(8) << D);
    u32* base = static_cast<u32*>(scratch((N * M + M * K + N * K + SW::workspace(N, M, K, D)) * 4, 0));
    u32 *pa = base, *pb = pa + N * M, *pc = pb + M * K, *work = pc + N * K;
    auto pack = [](const u32* src, int rows, int cols, u32* dst, std::size_t R, std::size_t C) {
        for_each_leaf(dst, R, C, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
            for (std::size_t r = 0; r < lr; ++r)
                for (std::size_t q = 0; q < lc; ++q) {
                    const std::size_t gr = r0 + r, gc = c0 + q;
                    blk[r * lc + q] = gr < std::size_t(rows) && gc < std::size_t(cols) ? src[gr * cols + gc] : 0;
                }
        });
    };
    pack(a, n, m, pa, N, M);
    pack(b, m, k, pb, M, K);
    SW::multiply(pa, pb, pc, N, M, K, D, work);
    for_each_leaf(pc, N, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        for (std::size_t r = 0; r < lr && r0 + r < std::size_t(n); ++r)
            for (std::size_t q = 0; q < lc && c0 + q < std::size_t(k); ++q) c[(r0 + r) * k + c0 + q] = blk[r * lc + q];
    });
}
}  // namespace

MP_REGISTER(s00_naive, s00_naive, "i-j-k, % per product");
MP_REGISTER(s01_ijk_lazy, s01_ijk_lazy, "i-j-k, fold every 16 products");
MP_REGISTER(s02_ikj_lazy, s02_ikj_lazy, "i-k-j, 64-bit row accumulators, fold every 16");
MP_REGISTER(s03_blocked_256, (s03_blocked<256, 16>), "s02 + 256-column accumulator slabs, 16-row B blocks");
MP_REGISTER(s03_blocked_1024, (s03_blocked<1024, 16>), "s02 + 1024-column accumulator slabs, 16-row B blocks");
MP_REGISTER(s04_tile4x8, s04_tile4x8, "plain C++ 4x8 register tile, fold every 16");
MP_REGISTER(s05_tile4x8_slab, s05_tile4x8_slab, "s04 over 64-column B slabs (L2 reuse)");
MP_REGISTER(s11_sw1_tile, s1_strassen<1>, "Strassen-Winograd depth 1 over s04 tile");
MP_REGISTER(s12_sw2_tile, s1_strassen<2>, "Strassen-Winograd depth 2 over s04 tile");
MP_REGISTER(s13_sw3_tile, s1_strassen<3>, "Strassen-Winograd depth 3 over s04 tile");
MP_REGISTER(s14_sw4_tile, s1_strassen<4>, "Strassen-Winograd depth 4 over s04 tile");
