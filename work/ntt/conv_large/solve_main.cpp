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
    uint32_t* const a = arena(2 * arr + 2 * tab + panel);
    uint32_t *const b = a + arr, *const roots = b + arr, *const iroots = roots + tab;
    __m256i* const buf = reinterpret_cast<__m256i*>(iroots + tab);
    input_cursor = qp_parse_flat::parse_tokens(input_cursor, a, n);
    input_cursor = qp_parse_flat::parse_tokens(input_cursor, b, m);
    QP_MARK(2);
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
