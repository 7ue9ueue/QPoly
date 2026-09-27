// Exploration 010 final program for Library Checker convolution_mod_large (N, M <= 2^24).
// I/O: exploration 007 (io007.hpp, verbatim): padded input mapping, two-stage AVX2 parser
// qp_parse_flat, table writer with a 64 KiB buffer, prefaulted THP-hinted arena().
// Transform: cyclic convolution of length 2^lg >= N+M-1 (lg >= 6) modulo 998244353.
//   lg <= 22: the exploration-009 kernel run() unchanged (as in the convolution_mod submission).
//   lg >= 23: qlarge::Core<Sel>::run (large_core.hpp): the same kernel's depth-first recursion
//             with a zero-upper first level and the final scale fused into the last inverse
//             level; its arrays come from a THP-hinted mapping faulted on first touch.
// Build: g++ -O2 -std=c++23 -march=native (the judge's command). -DQPOLY_PROBE prints one line
// (phase ms, THP mode, CPU) to stderr for probing the judge; the default build prints nothing.
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "io007.hpp"
#include "large_core.hpp"
#include <time.h>

#ifdef QPOLY_PROBE
#include <cpuid.h>
static long long qp_marks[5];
static inline long long qp_now() { timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec * 1000000000LL + t.tv_nsec; }
#define QP_MARK(i) (qp_marks[i] = qp_now())
static void qp_report() {
    char thp[128] = "?";
    if (FILE* f = std::fopen("/sys/kernel/mm/transparent_hugepage/enabled", "r")) {
        if (!std::fgets(thp, sizeof thp, f)) thp[0] = 0;
        std::fclose(f);
        for (char* q = thp; *q; ++q) if (*q == '\n') *q = 0;
    }
    unsigned r[4]; char brand[49]{};
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    const double ms = 1e-6;
    std::fprintf(stderr, "map %.1f parse %.1f ntt %.1f out %.1f ms (from main) | thp %s | %s\n",
                 (qp_marks[1] - qp_marks[0]) * ms, (qp_marks[2] - qp_marks[1]) * ms,
                 (qp_marks[3] - qp_marks[2]) * ms, (qp_marks[4] - qp_marks[3]) * ms, thp, brand);
}
#else
#define QP_MARK(i) ((void)0)
#endif

// The exploration-007 arena() mapping (2 MiB-aligned, MADV_HUGEPAGE) without the up-front
// MADV_POPULATE_WRITE: each huge page is zeroed at first touch, just before we write it,
// instead of long before (exploration 010 round 4/5: -8 to -14 ms per large case on EPYC 7763).
static uint32_t* lazy_arena(size_t words) {
    constexpr size_t huge = size_t(2) << 20;
    const size_t bytes = (words * 4 + huge - 1) & ~(huge - 1);
    char* raw = static_cast<char*>(mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    if (raw == MAP_FAILED) std::exit(1);
    char* p = reinterpret_cast<char*>((reinterpret_cast<uintptr_t>(raw) + huge - 1) & ~uintptr_t(huge - 1));
#ifdef MADV_HUGEPAGE
    madvise(p, bytes, MADV_HUGEPAGE);
#endif
    return reinterpret_cast<uint32_t*>(p);
}

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
    int lg = 6;  // exploration-009 kernel minimum length 64
    while ((1u << lg) < count) ++lg;
    const size_t len = size_t(1) << lg, arr = len + 16, tab = (qlarge::table_words(lg) + 15) & ~size_t(15);
    uint32_t* const a = lg >= 23 ? lazy_arena(2 * arr + 2 * tab) : arena(2 * arr + 2 * tab);
    uint32_t *const b = a + arr, *const roots = b + arr, *const iroots = roots + tab;
    input_cursor = qp_parse_flat::parse_tokens(input_cursor, a, n);
    input_cursor = qp_parse_flat::parse_tokens(input_cursor, b, m);
    QP_MARK(2);
    if (lg <= 22) {
        int root_size = 0;
        qasm::Kernel<qlarge::Sel>::run(int(len), a, b, roots, iroots, root_size, true, int(n), int(m));
    } else {
        qlarge::Tables T; T.r = roots; T.ir = iroots;
        qlarge::Core<qlarge::Sel>::run(lg, a, b, T, long(n), long(m));
    }
    QP_MARK(3);
    for (unsigned i = 0; i < count; ++i) write_mod998(out, output_cursor, output_end, a[i]);
    out.finish(output_cursor);
    QP_MARK(4);
#ifdef QPOLY_PROBE
    qp_report();
#endif
    return 0;
}
