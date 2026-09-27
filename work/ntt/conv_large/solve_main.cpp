// Exploration 010 program for Library Checker convolution_mod_large (harness build).
// I/O: exploration 007 (io007.hpp, verbatim): padded input mapping, qp_parse_flat,
// table writer with a 64 KiB buffer, prefaulted THP-hinted arena. Kernel: qasm
// (exploration 009) for transform lengths <= 2^22; for 2^23..2^25 the driver chosen by
// QL_MODE (0: run_b0 with the zero-upper top, 1: run_top with QL_L/QL_W/QL_D/QL_NT,
// 2: run_b0 with the zero-upper top and the final scale fused into the last inverse level,
// 3: as 2 with non-temporal stores in the zero-upper top level).
// -DQPOLY_PHASES prints "QP main mapped parsed ntt written 0" (CLOCK_MONOTONIC ns) to stderr.
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "io007.hpp"
#include "large.hpp"
#include <time.h>

#ifndef QL_MODE
#define QL_MODE 1
#endif
#ifndef QL_L
#define QL_L 3
#endif
#ifndef QL_W
#define QL_W 2
#endif
#ifndef QL_D
#define QL_D 4
#endif
#ifndef QL_NT
#define QL_NT 1
#endif

#ifndef QL_FUSE
#define QL_FUSE 0
#endif
#ifndef QL_LAZY_ARENA
#define QL_LAZY_ARENA 0
#endif
#ifndef QL_CHUNK
#define QL_CHUNK 4096
#endif

#ifdef QPOLY_PHASES
static long long qp_marks[5];
static inline long long qp_now() { timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec * 1000000000LL + t.tv_nsec; }
#define QP_MARK(i) (qp_marks[i] = qp_now())
#else
#define QP_MARK(i) ((void)0)
#endif

int main() {
    QP_MARK(0);
    fastio_unsafe_impl::input in;
    static fastio_unsafe_impl::output out;
    QP_MARK(1);
    char* input_cursor = in.cursor();
    char* output_cursor = out.begin();
    char* const output_end = out.end();
    const unsigned n = read_sse_short(input_cursor), m = read_sse_short(input_cursor);
    if (n == 0 || m == 0 || n > (1u << 24) || m > (1u << 24)) return 1;
    const unsigned count = n + m - 1;
    int lg = 6;  // qasm minimum length 64
    while ((1u << lg) < count) ++lg;
    using D = qlarge::Drivers<qlarge::Sel>;
    const size_t len = size_t(1) << lg, arr = len + 16, tab = (qlarge::table_words(lg) + 15) & ~size_t(15);
    // Top-pass geometry for this size (rows keep >= 4 vectors).
    const int lgv = lg - 3, odd = lgv & 1;
    int L = QL_L; while (L > 1 && lgv - odd - 2 * L < 2) --L;
    const size_t panel = (size_t(2) << (odd + 2 * L)) * QL_W * 8 + 64;
#if QL_LAZY_ARENA
    // Round 4 variant: the same 2 MiB-aligned THP-hinted mapping, faulted on first touch
    // instead of MADV_POPULATE_WRITE up front.
    uint32_t* const a = [](size_t words) {
        constexpr size_t huge = size_t(2) << 20;
        const size_t bytes = (words * 4 + huge - 1) & ~(huge - 1);
        char* raw = static_cast<char*>(mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
        if (raw == MAP_FAILED) std::exit(1);
        char* p = reinterpret_cast<char*>((reinterpret_cast<uintptr_t>(raw) + huge - 1) & ~uintptr_t(huge - 1));
#ifdef MADV_HUGEPAGE
        madvise(p, bytes, MADV_HUGEPAGE);
#endif
        return reinterpret_cast<uint32_t*>(p);
    }(2 * arr + 2 * tab + panel);
#else
    uint32_t* const a = arena(2 * arr + 2 * tab + panel);
#endif
    uint32_t *const b = a + arr, *const roots = b + arr, *const iroots = roots + tab;
    __m256i* const buf = reinterpret_cast<__m256i*>(iroots + tab);
    // QL_FUSE: for even log2(len/8) >= 20 with both inputs <= len/2, the depth-0 forward
    // radix-4 group (zero-upper form) runs while parsing the second input quarter, and the
    // depth-0 inverse group + scale runs while formatting the first output quarter. The
    // parser and writer are the exploration-007 routines, called unchanged.
    const bool fuse = QL_FUSE && lg >= 23 && ((lg - 3) & 1) == 0 && n <= len / 2 && m <= len / 2;
    if (fuse) {
        const qasm::Fixed z = D::root4(false);
        const size_t Q = len / 4, hv = Q / 8;
        alignas(64) static uint32_t chunk[QL_CHUNK + 64];
        auto parse_fused = [&](uint32_t* f, size_t count) {
            input_cursor = qp_parse_flat::parse_tokens(input_cursor, f, std::min(count, Q));
            size_t rest = count > Q ? count - Q : 0;
            __m256i* fv = reinterpret_cast<__m256i*>(f);
            for (size_t v0 = 0; v0 < hv; v0 += QL_CHUNK / 8) {
                const size_t take = std::min<size_t>(QL_CHUNK, rest);
                if (take) input_cursor = qp_parse_flat::parse_tokens(input_cursor, chunk, take);
                if (take < QL_CHUNK) std::memset(chunk + take, 0, (QL_CHUNK - take) * 4);
                rest -= take;
                const __m256i* cv = reinterpret_cast<const __m256i*>(chunk);
                for (size_t j = 0; j < QL_CHUNK / 8; ++j) {
                    const __m256i x = fv[v0 + j], y = cv[j];
                    const __m256i zy = z.mul<2, false, false, true>(y);
                    fv[v0 + j] = qasm::plus(x, y); fv[hv + v0 + j] = qasm::diff(x, y);
                    fv[2 * hv + v0 + j] = qasm::plus(x, zy); fv[3 * hv + v0 + j] = qasm::diff(x, zy);
                }
            }
        };
        parse_fused(a, n);
        parse_fused(b, m);
    } else {
        input_cursor = qp_parse_flat::parse_tokens(input_cursor, a, n);
        input_cursor = qp_parse_flat::parse_tokens(input_cursor, b, m);
    }
    QP_MARK(2);
    if (fuse) {
        qlarge::Tables T; T.r = roots; T.ir = iroots;
        D::middle(lg, a, b, T);
        QP_MARK(3);
        const qasm::Fixed iz = D::root4(true), scale = D::scale_factor(int(len / 8));
        const size_t hv = len / 32;
        __m256i* av = reinterpret_cast<__m256i*>(a);
        alignas(32) uint32_t lane[8];
        for (size_t j = 0; j < hv; ++j) {   // quarter 0 (all of it is below count)
            const __m256i p0 = av[j], p1 = av[hv + j], p2 = av[2 * hv + j], p3 = av[3 * hv + j];
            const __m256i ab = qasm::low(qasm::plus(p0, p1)), cd = qasm::low(qasm::plus(p2, p3));
            const __m256i amb = qasm::low(qasm::diff(p0, p1)), cmd = iz.mul<2, false, false, true>(qasm::diff(p2, p3));
            av[hv + j] = D::scale1(scale, qasm::plus(amb, cmd));
            av[2 * hv + j] = D::scale1(scale, qasm::diff(ab, cd));
            av[3 * hv + j] = D::scale1(scale, qasm::diff(amb, cmd));
            _mm256_store_si256(reinterpret_cast<__m256i*>(lane), D::scale1(scale, qasm::plus(ab, cd)));
            for (int t = 0; t < 8; ++t) write_mod998(out, output_cursor, output_end, lane[t]);
        }
        for (size_t i = len / 4; i < count; ++i) write_mod998(out, output_cursor, output_end, a[i]);
        out.finish(output_cursor);
        QP_MARK(4);
#ifdef QPOLY_PHASES
        dprintf(2, "QP %lld %lld %lld %lld %lld 0\n", qp_marks[0], qp_marks[1], qp_marks[2], qp_marks[3], qp_marks[4]);
#endif
        return 0;
    }
    if (lg <= 22) {
        int root_size = 0;
        qasm::Kernel<qlarge::Sel>::run(int(len), a, b, roots, iroots, root_size, true, int(n), int(m));
    } else {
        qlarge::Tables T; T.r = roots; T.ir = iroots;
#if QL_MODE == 0
        D::run_b0(lg, a, b, T, long(n), long(m), true);
#elif QL_MODE == 2
        D::run_b0(lg, a, b, T, long(n), long(m), true, true);
#elif QL_MODE == 3
        D::run_b0(lg, a, b, T, long(n), long(m), true, true, true);
#else
        D::TopOpt o; o.w = QL_W; o.dist = QL_D; o.nt = QL_NT;
        D::run_top(lg, a, b, T, long(n), long(m), L, o, buf);
#endif
    }
    QP_MARK(3);
    for (unsigned i = 0; i < count; ++i) write_mod998(out, output_cursor, output_end, a[i]);
    out.finish(output_cursor);
    QP_MARK(4);
#ifdef QPOLY_PHASES
    dprintf(2, "QP %lld %lld %lld %lld %lld 0\n", qp_marks[0], qp_marks[1], qp_marks[2], qp_marks[3], qp_marks[4]);
#endif
    return 0;
}
