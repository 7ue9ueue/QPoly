// In-memory conversion microbenchmark; usage: bench_io OUT.csv CASE... (CASE = path
// prefix with .in/.out). Run with stdout redirected to /dev/null (the baseline
// writer flushes through write(1)). Parse: all tokens after the header, from a
// resident zero-padded copy into pre-touched arrays. Format: the model output's
// values into a 64 KiB buffer whose sink only counts bytes (baseline writer: its
// own 512 KiB buffer and write() to /dev/null). Two warmups, 11 timed repetitions,
// rotated order. Parsed arrays and new formatters' text are checked once, outside
// timing, against strtoul/model output; any mismatch exits non-zero.
#include <immintrin.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <algorithm>
#include <array>
#include <cerrno>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <functional>
#include <string>
#include <vector>
#include "baseline_io.inc"
#include "parse_quad.inc"
#include "parse_gen4.inc"
#include "format_avx2.inc"
#include "format_avx2x.inc"
#include "parse_flat.inc"

static std::string slurp(const std::string& path) {
    FILE* f = std::fopen(path.c_str(), "rb");
    if (!f) { std::perror(path.c_str()); std::exit(1); }
    std::string s;
    char buf[1 << 16];
    size_t got;
    while ((got = std::fread(buf, 1, sizeof buf, f)) > 0) s.append(buf, got);
    std::fclose(f);
    return s;
}
struct Discard {
    alignas(64) char buf[(1 << 16) + 64];
    size_t bytes = 0;
    char* flush(char* p) { bytes += size_t(p - buf); return buf; }
};
struct Capture {
    alignas(64) char buf[(1 << 16) + 64];
    std::string out;
    char* flush(char* p) { out.append(buf, p); return buf; }
};
using Clock = std::chrono::steady_clock;

int main(int argc, char** argv) {
    FILE* csv = std::fopen(argv[1], "w");
    std::fprintf(csv, "case,kind,variant,rep,ns,items\n");
    static uint32_t a[1 << 20], b[1 << 20], values[1 << 20];
    for (int c = 2; c < argc; ++c) {
        const std::string name = argv[c], text = slurp(name + ".in"), expected = slurp(name + ".out");
        std::vector<char> input(text.size() + 128, 0);
        std::memcpy(input.data(), text.data(), text.size());
        char* end;
        const unsigned n = unsigned(std::strtoul(input.data(), &end, 10));
        const unsigned m = unsigned(std::strtoul(end, &end, 10));
        char* body = end + 1;  // After the header's newline.
        std::vector<uint32_t> want;
        for (const char* q = body; want.size() < n + m;) want.push_back(uint32_t(std::strtoul(q, &end, 10))), q = end;
        size_t count = 0;
        for (const char* q = expected.data(); count < n + m - 1;) values[count++] = uint32_t(std::strtoul(q, &end, 10)), q = end;
        const std::string base_name = name.substr(name.find_last_of('/') + 1);

        auto parse_sse = [&] { char* p = body; for (unsigned i = 0; i < n; ++i) a[i] = read_sse_short(p);
                               for (unsigned i = 0; i < m; ++i) b[i] = read_sse_short(p); };
        auto parse_quad = [&] { qp_parse::parse_tokens(qp_parse::parse_tokens(body, a, n), b, m); };
        auto parse_gen4 = [&] { qp_parse4::parse_tokens(qp_parse4::parse_tokens(body, a, n), b, m); };
        auto parse_flat = [&] { qp_parse_flat::parse_tokens(qp_parse_flat::parse_tokens(body, a, n), b, m); };
        const std::vector<std::pair<const char*, std::function<void()>>> parsers = {
            {"sse_short", parse_sse}, {"quad", parse_quad}, {"gen4", parse_gen4}, {"flat", parse_flat}};
        static Discard discard;
        static fastio_unsafe_impl::output table_out;
        auto fmt_table = [&] { char* p = table_out.begin(); char* e = table_out.end();
                               for (size_t i = 0; i < count; ++i) write_mod998(table_out, p, e, values[i]);
                               table_out.flush(p); };
        auto fmt_avx = [&] { discard.flush(qp_format::format_values(discard, discard.buf, discard.buf + (1 << 16), values, count)); };
        auto fmt_avx2 = [&] { discard.flush(qp_format2::format_values(discard, discard.buf, discard.buf + (1 << 16), values, count)); };
        auto fmt_swar = [&] { discard.flush(qp_format2::format_scalar(discard, discard.buf, discard.buf + (1 << 16), values, count)); };
        const std::vector<std::pair<const char*, std::function<void()>>> formatters = {
            {"table", fmt_table}, {"avx", fmt_avx}, {"avx_extract", fmt_avx2}, {"swar", fmt_swar}};

        for (auto& [label, run] : parsers) {  // Correctness first.
            std::fill(a, a + (1 << 20), 0xFFFFFFFFu), std::fill(b, b + (1 << 20), 0xFFFFFFFFu);
            run();
            for (unsigned i = 0; i < n + m; ++i)
                if ((i < n ? a[i] : b[i - n]) != want[i]) { std::fprintf(stderr, "FAIL parse %s %s %u\n", label, name.c_str(), i); return 1; }
            if (a[n] != 0xFFFFFFFFu || b[m] != 0xFFFFFFFFu) { std::fprintf(stderr, "FAIL overrun %s\n", label); return 1; }
        }
        {
            static Capture capture;
            char* p = qp_format::format_values(capture, capture.buf, capture.buf + (1 << 16), values, count);
            capture.flush(p);
            std::string s1 = capture.out; capture.out.clear();
            capture.flush(qp_format2::format_values(capture, capture.buf, capture.buf + (1 << 16), values, count));
            std::string s2 = capture.out; capture.out.clear();
            capture.flush(qp_format2::format_scalar(capture, capture.buf, capture.buf + (1 << 16), values, count));
            const std::string want_text = " " + expected.substr(0, expected.size() - 1);
            if (s1 != want_text || s2 != want_text || capture.out != want_text) { std::fprintf(stderr, "FAIL format %s\n", name.c_str()); return 1; }
            capture.out.clear();
        }
        for (int kind = 0; kind < 2; ++kind) {
            const auto& list = kind ? formatters : parsers;
            for (int rep = -2; rep < 11; ++rep)
                for (size_t k = 0; k < list.size(); ++k) {
                    const size_t idx = (k + size_t(rep + 2)) % list.size();
                    const auto t0 = Clock::now();
                    list[idx].second();
                    const auto t1 = Clock::now();
                    if (rep >= 0)
                        std::fprintf(csv, "%s,%s,%s,%d,%lld,%zu\n", base_name.c_str(), kind ? "format" : "parse", list[idx].first, rep,
                                     (long long)std::chrono::duration_cast<std::chrono::nanoseconds>(t1 - t0).count(),
                                     kind ? count : size_t(n + m));
                }
        }
    }
    std::fclose(csv);
    std::fprintf(stderr, "PASS bench_io correctness (4 parsers, 3 new formatters)\n");
}
