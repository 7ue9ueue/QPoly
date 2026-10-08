// Library Checker convolution_mod_large, exploration-014 experiment program: the exploration-011
// deliverable (io_large/final_io_main.cpp: exploration-010 transform, ms2 parser, blocks3<4> output)
// with switches for the exploration-014 variants. All switches at their defaults reproduce the
// deliverable's code path.
//   QO_PARSE  0: qp_parse_ms2<128 KiB> (deliverable); 1: qp_parse_ms2s<QO_SUB, QO_SKEW, QO_PF>
//             (stream spacing QO_SUB + QO_SKEW bytes, optional prefetch; large_opt/parse_ms2s.inc);
//             2: qp_parse_ms4<QO_SUB, QO_SKEW> (four tokens per stream step; large_opt/parse_ms4.inc).
//   QO_FMT    0: qp_fixed::blocks3<4> (deliverable); 1, 2, 4: qp_fmt_asm::blocks<G> with G = QO_FMT
//             (fmt_asm.inc, inline asm, constants as memory operands), 32 values per loop step;
//             8 / 9: four 32-byte stores per 8 values (block8_s4 x4 / blocks2_s4 x2 per loop step).
//   QO_PFW    1: prefetchw of the output buffer lines of the next loop step (640 bytes ahead).
//   QO_TW     0: qlarge::Core (deliverable); 1: bottom twiddles generated on the fly (root tables of
//             n/64 instead of n/16 entries; large_opt/core_tw.hpp), lengths >= 2^23.
//   QO_OV     1: a's zero-upper first radix-4 group runs as a side job of b's parse (one butterfly per
//             parser step; the rest after the parse) and is skipped in the transform (qopt::CoreAh).
//             Needs QO_PARSE 1 or 2; lengths >= 2^23 with even log2(n/8) and N <= n/2.
//   QO_AH     0..2: per-group scalar inputs of the asm bottom stage (leaf weights, generated twiddles)
//             prepared QO_AH groups ahead (qopt::CoreAh); 0 with QO_TW = 0 is the deliverable's Core.
// -DQPOLY_PROBE prints one stderr line (phase ms, THP mode, CPU).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "../conv_large/io007.hpp"
#include "../conv_large/large_core.hpp"
#include "../io_large/parse_ms2.inc"
#include "../io_large/fmt_bcd.inc"
#include "parse_ms2s.inc"
#include "parse_ms4.inc"
#include "fmt_asm.inc"
#include "core_tw.hpp"
#include <time.h>

#ifndef QO_PARSE
#define QO_PARSE 0
#endif
#ifndef QO_SUB
#define QO_SUB 32768
#endif
#ifndef QO_SKEW
#define QO_SKEW 1088
#endif
#ifndef QO_PF
#define QO_PF 0
#endif
#ifndef QO_TW
#define QO_TW 0
#endif
#ifndef QO_FMT
#define QO_FMT 0
#endif
#ifndef QO_AH
#define QO_AH 0
#endif
#ifndef QO_OV
#define QO_OV 0
#endif
#ifndef QO_PFW
#define QO_PFW 0
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
    fastio_unsafe_impl::input in;
    char* input_cursor = in.cursor();
    const unsigned n = read_sse_short(input_cursor), m = read_sse_short(input_cursor);
    QP_MARK(1);
    if (n == 0 || m == 0 || n > (1u << 24) || m > (1u << 24)) return 1;
    const unsigned count = n + m - 1;
    int lg = 6;
    while ((1u << lg) < count) ++lg;
    const size_t len = size_t(1) << lg, arr = len + 16;
#if QO_TW
    const size_t tab = ((lg >= 23 ? qopt::table_words_tw(lg) : qlarge::table_words(lg)) + 15) & ~size_t(15);
#else
    const size_t tab = (qlarge::table_words(lg) + 15) & ~size_t(15);
#endif
    uint32_t* const a = lg >= 23 ? lazy_arena(2 * arr + 2 * tab) : arena(2 * arr + 2 * tab);
    uint32_t *const b = a + arr, *const roots = b + arr, *const iroots = roots + tab;
#if QO_PARSE == 1
    constexpr auto parse = qp_parse_ms2s::parse_tokens<QO_SUB, QO_SKEW, QO_PF, qp_parse_flat::parse_tokens>;
#elif QO_PARSE == 2
    constexpr auto parse = qp_parse_ms4::parse_tokens<QO_SUB, QO_SKEW, qp_parse_flat::parse_tokens>;
#else
    constexpr auto parse = qp_parse_ms2::parse_tokens<131072, qp_parse_flat::parse_tokens>;
#endif
    input_cursor = parse(input_cursor, a, n);
#if QO_OV
    const bool ov = lg >= 23 && qopt::top_zero_applies(lg, long(n));
    qopt::TopZeroSide side{reinterpret_cast<__m256i*>(a), long(len / 32), 0, qopt::top_zero_twiddle()};
    if (!ov) side.j = side.h;   // nothing to do
#if QO_PARSE == 1
    input_cursor = qp_parse_ms2s::parse_side<QO_SUB, QO_SKEW, QO_PF, qp_parse_flat::parse_tokens>(input_cursor, b, m, side);
#elif QO_PARSE == 2
    input_cursor = qp_parse_ms4::parse_side<QO_SUB, QO_SKEW, qp_parse_flat::parse_tokens>(input_cursor, b, m, side);
#else
#error "QO_OV needs QO_PARSE 1 or 2"
#endif
    side.finish();
#else
    input_cursor = parse(input_cursor, b, m);
#endif
    QP_MARK(2);
    if (lg <= 22) {
        int root_size = 0;
        qasm::Kernel<qlarge::Sel>::run(int(len), a, b, roots, iroots, root_size, true, int(n), int(m));
    } else {
        qlarge::Tables T; T.r = roots; T.ir = iroots;
#if QO_TW || QO_AH || QO_OV
#if QO_OV
        qopt::CoreAh<qlarge::Sel, bool(QO_TW), QO_AH>::run(lg, a, b, T, long(n), long(m), ov);
#else
        qopt::CoreAh<qlarge::Sel, bool(QO_TW), QO_AH>::run(lg, a, b, T, long(n), long(m));
#endif
#else
        qlarge::Core<qlarge::Sel>::run(lg, a, b, T, long(n), long(m));
#endif
    }
    QP_MARK(3);
    // 160 KiB = 512 * 320-byte groups; a group writes 326 bytes (6 overwritten by the next one).
    // The buffer is flushed before a group, never after the last one, so the final field (whose
    // trailing space becomes the newline) is always still in the buffer; the tail (<= 3 blocks and
    // <= 7 single values, <= 320 bytes) fits in the 512-byte slack.
    constexpr size_t obuf_size = 163840;
    alignas(4096) static char obuf[obuf_size + 512];
    char* c = obuf;
    unsigned i = 0;
    for (; i + 32 <= count; i += 32) {   // reads a[i .. i + 31] < count
        if (c >= obuf + obuf_size) { write_all(obuf, size_t(c - obuf)); c = obuf; }
#if QO_PFW
        for (int l = 0; l < 320; l += 64) __builtin_prefetch(c + 640 + l, 1, 3);
#endif
#if QO_FMT == 1
        qp_fmt_asm::blocks<1>(a + i, c); qp_fmt_asm::blocks<1>(a + i + 8, c + 80);
        qp_fmt_asm::blocks<1>(a + i + 16, c + 160); qp_fmt_asm::blocks<1>(a + i + 24, c + 240);
#elif QO_FMT == 2
        qp_fmt_asm::blocks<2>(a + i, c); qp_fmt_asm::blocks<2>(a + i + 16, c + 160);
#elif QO_FMT == 4
        qp_fmt_asm::blocks<4>(a + i, c);
#elif QO_FMT == 8
        qp_fmt_asm::block8_s4(a + i, c); qp_fmt_asm::block8_s4(a + i + 8, c + 80);
        qp_fmt_asm::block8_s4(a + i + 16, c + 160); qp_fmt_asm::block8_s4(a + i + 24, c + 240);
#elif QO_FMT == 9
        qp_fmt_asm::blocks2_s4(a + i, c); qp_fmt_asm::blocks2_s4(a + i + 16, c + 160);
#else
        qp_fixed::blocks3<4>(a + i, c);
#endif
        c += 320;
    }
    for (; i + 8 <= count; i += 8, c += 80) qp_fixed::blocks3<1>(a + i, c);
    for (; i < count; ++i, c += 10) qp_fixed::one(a[i], c);
    c[-1] = '\n';   // count >= 1, so c > obuf
    write_all(obuf, size_t(c - obuf));
    QP_MARK(4);
#ifdef QPOLY_PROBE
    qp_report();
#endif
    return 0;
}
