// Exploration 011 program for Library Checker convolution_mod_large: exploration-010 transform
// (conv_large/large_core.hpp, unchanged) with selectable I/O.
//   QI_INPUT  0: exploration-007 input mapping (fastio_unsafe_impl::input)
//             1: file mapped between two readable zero guard pages (parse_tail's look-behind)
//   QI_PARSE  0: qp_parse_flat (exploration 007)      1: qp_parse_tail (parse_tail.inc; needs QI_INPUT 1)
//             2: qp_parse_tail8 (8-token steps; needs QI_INPUT 1)
//             3: qp_parse_ms, 8 lockstep streams per 32 KiB chunk (parse_ms.inc)   4: 4 streams
//             5: qp_parse_ms2, 4 streams x 2 tokens per step, QI_CHUNK-byte chunks (parse_ms2.inc)
//             6: qp_parse_ms3 (parse_ms3.inc), QI_STREAMS (4 or 8) streams, QI_CHUNK-byte chunks
//   QI_FMT    0: exploration-007 table writer (variable width, 64 KiB buffer)
//             1: fixed-width AVX2 writer (fmt_fixed.inc eight(): 10 bytes per value, space padded)
//             2: fmt_fixed.inc blocks<1> (a from x directly)   3: blocks<2> (two blocks interleaved)
//             4: blocks<4> (four blocks interleaved)   5: blocks3<4> (SWAR BCD groups, fmt_fixed.inc)
//             6: blocks3<2>
//   QI_OBUF   output buffer bytes for the fixed writers (default 64000; a multiple of 80 * G)
// -DQPOLY_PROBE prints one stderr line (phase ms, THP mode, CPU).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "../conv_large/io007.hpp"
#include "../conv_large/large_core.hpp"
#include "parse_tail.inc"
#include "parse_ms.inc"
#include "parse_ms2.inc"
#include "parse_ms3.inc"
#include "fmt_fixed.inc"
#include <time.h>

#ifndef QI_INPUT
#define QI_INPUT 1
#endif
#ifndef QI_PARSE
#define QI_PARSE 1
#endif
#ifndef QI_FMT
#define QI_FMT 1
#endif
#ifndef QI_CHUNK
#define QI_CHUNK 65536
#endif
#ifndef QI_STREAMS
#define QI_STREAMS 4
#endif
#ifndef QI_OBUF
#define QI_OBUF 64000
#endif

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

// Standard input as one contiguous read-only buffer with at least 4 KiB of readable zero bytes
// before and after it: a regular file is mapped between two anonymous zero pages; anything else
// (pipes) is read into a heap buffer with the same padding.
struct GuardedInput {
    char* data = nullptr;
    GuardedInput() {
        struct stat st{};
        const size_t page = size_t(sysconf(_SC_PAGESIZE));
        if (fstat(0, &st) == 0 && S_ISREG(st.st_mode) && st.st_size > 0) {
            const off_t at = lseek(0, 0, SEEK_CUR);
            const size_t size = size_t(st.st_size), rounded = (size + page - 1) / page * page;
            char* region = static_cast<char*>(mmap(nullptr, rounded + 2 * page, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
            if (region != MAP_FAILED && mmap(region + page, rounded, PROT_READ, MAP_PRIVATE | MAP_FIXED, 0, 0) != MAP_FAILED) {
                data = region + page + (at > 0 ? std::min(size_t(at), size) : 0);
                return;
            }
        }
        size_t cap = size_t(1) << 20, len = 0;
        char* buf = static_cast<char*>(std::calloc(cap + 2 * page, 1));
        for (;;) {
            if (!buf) std::abort();
            if (len == cap) {
                char* grown = static_cast<char*>(std::realloc(buf, 2 * cap + 2 * page));
                if (!grown) std::abort();
                buf = grown; cap *= 2;
            }
            const ssize_t got = read(0, buf + page + len, cap - len);
            if (got < 0 && errno == EINTR) continue;
            if (got <= 0) break;
            len += size_t(got);
        }
        std::memset(buf, 0, page);
        std::memset(buf + page + len, 0, cap - len + page);
        data = buf + page;
    }
};
static inline uint32_t read_header_u32(char*& p) {   // one unsigned token; skips leading whitespace
    while (*p && *p <= ' ') ++p;
    uint32_t v = 0;
    while (*p > ' ') v = v * 10 + uint32_t(*p++ - '0');
    ++p;
    return v;
}
static void write_all(const char* d, size_t len) {
    while (len) {
        const ssize_t k = write(1, d, len);
        if (k > 0) d += k, len -= size_t(k);
        else if (k < 0 && errno == EINTR) continue;
        else std::abort();
    }
}

// Exploration-010 lazily faulted THP arena (see conv_large/final_main.cpp).
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
#if QI_INPUT
    GuardedInput in;
    char* input_cursor = in.data;
    const unsigned n = read_header_u32(input_cursor), m = read_header_u32(input_cursor);
#else
    fastio_unsafe_impl::input in;
    char* input_cursor = in.cursor();
    const unsigned n = read_sse_short(input_cursor), m = read_sse_short(input_cursor);
#endif
    QP_MARK(1);
    if (n == 0 || m == 0 || n > (1u << 24) || m > (1u << 24)) return 1;
    const unsigned count = n + m - 1;
    int lg = 6;
    while ((1u << lg) < count) ++lg;
    const size_t len = size_t(1) << lg, arr = len + 16, tab = (qlarge::table_words(lg) + 15) & ~size_t(15);
    uint32_t* const a = lg >= 23 ? lazy_arena(2 * arr + 2 * tab) : arena(2 * arr + 2 * tab);
    uint32_t *const b = a + arr, *const roots = b + arr, *const iroots = roots + tab;
#if QI_PARSE == 6
    constexpr auto parse = qp_parse_ms3::parse_tokens<QI_STREAMS, QI_CHUNK, qp_parse_flat::parse_tokens>;
    input_cursor = parse(input_cursor, a, n);
    input_cursor = parse(input_cursor, b, m);
#elif QI_PARSE == 5
    constexpr auto parse = qp_parse_ms2::parse_tokens<QI_CHUNK, qp_parse_flat::parse_tokens>;
    input_cursor = parse(input_cursor, a, n);
    input_cursor = parse(input_cursor, b, m);
#elif QI_PARSE == 3 || QI_PARSE == 4
    constexpr auto parse = qp_parse_ms::parse_tokens<QI_PARSE == 3 ? 8 : 4, 32768, qp_parse_flat::parse_tokens>;
    input_cursor = parse(input_cursor, a, n);
    input_cursor = parse(input_cursor, b, m);
#elif QI_PARSE == 2
    input_cursor = qp_parse_tail8::parse_tokens(input_cursor, a, n);
    input_cursor = qp_parse_tail8::parse_tokens(input_cursor, b, m);
#elif QI_PARSE == 1
    input_cursor = qp_parse_tail::parse_tokens(input_cursor, a, n);
    input_cursor = qp_parse_tail::parse_tokens(input_cursor, b, m);
#else
    input_cursor = qp_parse_flat::parse_tokens(input_cursor, a, n);
    input_cursor = qp_parse_flat::parse_tokens(input_cursor, b, m);
#endif
    QP_MARK(2);
    if (lg <= 22) {
        int root_size = 0;
        qasm::Kernel<qlarge::Sel>::run(int(len), a, b, roots, iroots, root_size, true, int(n), int(m));
    } else {
        qlarge::Tables T; T.r = roots; T.ir = iroots;
        qlarge::Core<qlarge::Sel>::run(lg, a, b, T, long(n), long(m));
    }
    QP_MARK(3);
#if QI_FMT
    alignas(4096) static char obuf[QI_OBUF + 512];
    char* c = obuf;
    unsigned i = 0;
#if QI_FMT == 4 || QI_FMT == 5
    for (; i + 32 <= count; i += 32) {   // a[] has 16 padding words: never reads past them
#if QI_FMT == 5
        qp_fixed::blocks3<4>(a + i, c);
#else
        qp_fixed::blocks<4>(a + i, c);
#endif
        c += 320;
        if (c >= obuf + QI_OBUF) { write_all(obuf, size_t(c - obuf)); c = obuf; }
    }
#elif QI_FMT == 3 || QI_FMT == 6
    for (; i + 16 <= count; i += 16) {
#if QI_FMT == 6
        qp_fixed::blocks3<2>(a + i, c);
#else
        qp_fixed::blocks<2>(a + i, c);
#endif
        c += 160;
        if (c >= obuf + QI_OBUF) { write_all(obuf, size_t(c - obuf)); c = obuf; }
    }
#endif
    for (; i + 8 <= count; i += 8) {   // a block reads 8 values
#if QI_FMT == 1
        qp_fixed::eight(a + i, c);
#elif QI_FMT >= 5
        qp_fixed::blocks3<1>(a + i, c);
#else
        qp_fixed::blocks<1>(a + i, c);
#endif
        c += 80;
        if (c >= obuf + QI_OBUF) { write_all(obuf, size_t(c - obuf)); c = obuf; }
    }
    for (; i < count; ++i, c += 10) qp_fixed::one_table(a[i], c);
    c[-1] = '\n';
    write_all(obuf, size_t(c - obuf));
#else
    static fastio_unsafe_impl::output out;
    char* output_cursor = out.begin();
    char* const output_end = out.end();
    for (unsigned i = 0; i < count; ++i) write_mod998(out, output_cursor, output_end, a[i]);
    out.finish(output_cursor);
#endif
    QP_MARK(4);
#ifdef QPOLY_PROBE
    qp_report();
#endif
    return 0;
}
