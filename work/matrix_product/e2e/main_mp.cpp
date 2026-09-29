// Library Checker matrix_product (https://judge.yosupo.jp/problem/matrix_product), QPoly
// exploration 013. C = A B mod 998244353, 1 <= N, M, K <= 1024.
// Pipeline: exploration-007 input (padded mmap + two-stage AVX2 parser) into row-major
// buffers; vectorized conversion into the recursive Strassen layout (A: Montgomery factor
// 2^32, centered; B: centered; 4-row / 8-column packed panels at the leaves); Strassen-Winograd
// to depth D over a generated inline-asm Winograd inner-product 4x8 micro-kernel (see
// work/matrix_product/README.md); row-major unpack; exploration-007 table writer with a
// 64 KiB buffer. Scratch memory: one 2 MiB-aligned anonymous arena with a THP hint,
// populated before use. Define MP_PHASES to print phase times (ms) to stderr.
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3")
#endif
#include "../e2e/io007.hpp"
#include "../common.hpp"
#include "../simd.hpp"
#include "../simd_kernel.hpp"
#include "../asm_kernels.hpp"
#include "../strassen.hpp"
#include "../sw_driver.hpp"

#include <chrono>

#ifndef MP_KERNEL
#define MP_KERNEL wipp_i2
#endif
#ifndef MP_DEPTH_MAX
#define MP_DEPTH_MAX 3
#endif

namespace mp {
// Grow-only small slot buffers (the Winograd corrections of one leaf live in slot 4).
void* scratch(std::size_t bytes, int slot) {
    struct Buf { void* p = nullptr; std::size_t n = 0; };
    static Buf buf[8];
    Buf& s = buf[slot & 7];
    if (s.n < bytes) {
        const std::size_t n = (bytes + 4095) & ~std::size_t(4095);
        void* p = mmap(nullptr, n, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (p == MAP_FAILED) std::abort();
        if (s.p) munmap(s.p, s.n);
        s.p = p, s.n = n;
    }
    return s.p;
}
}  // namespace mp

namespace {
using namespace mp;
using namespace mp::simd;
using namespace mp::sw;

#define MP_CAT2(a, b) a##b
#define MP_CAT(a, b) MP_CAT2(a, b)
struct Kern {
    static constexpr int period = MP_CAT(MP_CAT(asm_, MP_KERNEL), _period), unit = MP_CAT(MP_CAT(asm_, MP_KERNEL), _unit);
    static void main(const u32* pa, const u32* pb, long n, V (&acc)[8]) { MP_CAT(asm_, MP_KERNEL)(pa, pb, n, acc); }
    static void tail(const u32* pa, const u32* pb, long n, V (&acc)[8]) { MP_CAT(MP_CAT(asm_, MP_KERNEL), _tail)(pa, pb, n, acc); }
};

MP_AI void tile(const u32* pa, const u32* pb, std::size_t m, const i32* alpha, const i32* beta, u32* c) {
    V acc[8];
    const V be = _mm256_cvtepi32_epi64(_mm_setr_epi32(beta[0], beta[2], beta[4], beta[6]));
    const V bo = _mm256_cvtepi32_epi64(_mm_setr_epi32(beta[1], beta[3], beta[5], beta[7]));
    for (int r = 0; r < 4; ++r) {
        const V ar = _mm256_set1_epi64x(alpha[r]);
        acc[2 * r] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, be));
        acc[2 * r + 1] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, bo));
    }
    const std::size_t periods = m / Kern::period, rest = (m % Kern::period) / Kern::unit;
    if (periods) Kern::main(pa, pb, long(periods), acc);
    if (rest) Kern::tail(pa + periods * Kern::period * 4, pb + periods * Kern::period * 8, long(rest), acc);
    for (int r = 0; r < 4; ++r) _mm256_storeu_si256(reinterpret_cast<V*>(c + r * 8), finish_s(acc[2 * r], acc[2 * r + 1]));
}
struct Leaf {
    using E = u32;
    static constexpr int NR = 8;
    static void multiply(const u32* a, const u32* b, u32* c, std::size_t n, std::size_t m, std::size_t k) {
        const std::size_t np = n / 4, kp = k / 8;
        i32* alpha = static_cast<i32*>(scratch((n + k) * 4 + 64, 4));
        i32* beta = alpha + n;
        for (std::size_t ip = 0; ip < np; ++ip) wip_alpha4(a + ip * 4 * m, int(m), alpha + 4 * ip);
        for (std::size_t jp = 0; jp < kp; ++jp) wip_beta8(b + jp * 8 * m, int(m), beta + 8 * jp);
        for (std::size_t jp = 0; jp < kp; ++jp)
            for (std::size_t ip = 0; ip < np; ++ip)
                tile(a + ip * 4 * m, b + jp * 8 * m, m, alpha + 4 * ip, beta + 8 * jp, c + (ip * kp + jp) * 32);
    }
};
#ifdef MP_FUSED
using SW = StrassenWinogradFused<Leaf, FusedOps>;
#else
using SW = StrassenWinograd<Leaf, CenteredOps, CanonicalOps>;
#endif

// 2 MiB-aligned zero-initialized arena, populated before use (THP when available).
u32* arena(std::size_t words) {
    constexpr std::size_t huge = std::size_t(2) << 20;
    const std::size_t bytes = (words * 4 + huge - 1) & ~(huge - 1);
    char* raw = static_cast<char*>(mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    if (raw == MAP_FAILED) std::exit(1);
    char* p = reinterpret_cast<char*>((reinterpret_cast<uintptr_t>(raw) + huge - 1) & ~uintptr_t(huge - 1));
#ifdef MADV_HUGEPAGE
    madvise(p, bytes, MADV_HUGEPAGE);
#endif
    bool populated = false;
#ifdef MADV_POPULATE_WRITE
    populated = madvise(p, bytes, MADV_POPULATE_WRITE) == 0;
#endif
    if (!populated)
        for (std::size_t i = 0; i < bytes; i += 4096) static_cast<volatile char*>(p)[i] = 0;
    return reinterpret_cast<u32*>(p);
}

int depth_for(int n, int m, int k) {
    const int lo = std::min({n, m, k});
    int d = 0;
    while (d < MP_DEPTH_MAX && (lo >> d) >= 128) ++d;
    return d;
}

#ifdef MP_PHASES
double t_now() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
#define MP_MARK(name) do { const double t = t_now(); std::fprintf(stderr, "%s %.3f\n", name, t - t_last); t_last = t; } while (0)
#else
#define MP_MARK(name) do {} while (0)
#endif
}  // namespace

int main() {
#ifdef MP_PHASES
    double t_last = t_now();
#endif
    fastio_unsafe_impl::input in;
    static fastio_unsafe_impl::output out;
    char* p = in.cursor();
    const int n = int(read_sse_short(p)), m = int(read_sse_short(p)), k = int(read_sse_short(p));
    if (n < 1 || m < 1 || k < 1 || n > 1024 || m > 1024 || k > 1024) return 1;
    const int D = depth_for(n, m, k);
    const std::size_t N = round_up(n, std::size_t(4) << D), M = round_up(m, std::size_t(2) << D),
                      K = round_up(k, std::size_t(8) << D);
    const std::size_t s_in = round_up(std::max(std::size_t(n) * m, std::size_t(n) * k), 16),
                      s_b = round_up(std::size_t(m) * k, 16), s_pa = round_up(N * M, 16), s_pb = round_up(M * K, 16),
                      s_pc = round_up(N * K, 16), s_w = SW::workspace(N, M, K, D) + 16;
    u32* const a_rm = arena(s_in + s_b + s_pa + s_pb + s_pc + s_w);
    u32 *const b_rm = a_rm + s_in, *const pa = b_rm + s_b, *const pb = pa + s_pa, *const pc = pb + s_pb, *const work = pc + s_pc;
    MP_MARK("setup");
    p = qp_parse_flat::parse_tokens(p, a_rm, std::size_t(n) * m);
    p = qp_parse_flat::parse_tokens(p, b_rm, std::size_t(m) * k);
    MP_MARK("parse");
    for_each_leaf(pa, N, M, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        pack_a_leaf4(a_rm, n, m, blk, r0, c0, lr, lc);
    });
    for_each_leaf(pb, M, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        pack_b_leaf8(b_rm, m, k, blk, r0, c0, lr, lc);
    });
    MP_MARK("pack");
    SW::multiply(pa, pb, pc, N, M, K, D, work);
    MP_MARK("multiply");
    u32* const c_rm = a_rm;  // A's row-major buffer is dead after packing
    for_each_leaf(pc, N, K, D, [&](u32* blk, std::size_t r0, std::size_t c0, std::size_t lr, std::size_t lc) {
        unpack_c_leaf4x8(blk, n, k, c_rm, r0, c0, lr, lc);
    });
    MP_MARK("unpack");
    char* cur = out.begin();
    char* const end = out.end();
    for (int i = 0; i < n; ++i) {
        const u32* row = c_rm + std::size_t(i) * k;
        write_sep(out, cur, end, row[0], '\n');
        for (int j = 1; j < k; ++j) write_sep(out, cur, end, row[j], ' ');
    }
    out.finish(cur);
    MP_MARK("output");
    return 0;
}
