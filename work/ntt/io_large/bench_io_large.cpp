// Exploration 011: I/O unit tests and in-memory benchmarks at convolution_mod_large scale.
//   bench_io_large unit [limit]   formatters over every value < limit (default 10^9) and the
//                                 parsers on generated token streams; exit 1 on any mismatch
//   bench_io_large time [reps]    ns/token (parsers) and ns/value (formatters) on 2^25 items,
//                                 plus formatting with write() into a new file in /dev/shm
// Parsers: sse (exploration-007 per-token read_sse_short), flat (007 continuation parse_flat),
// tail (parse_tail.inc). Formatters: table (007 write_mod998, variable width), fixed_table and
// fixed_avx2 (fmt_fixed.inc, fixed 10-byte fields).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi,bmi2")
#include "../conv_large/io007.hpp"
#include "parse_tail.inc"
#include "fmt_fixed.inc"
#include <algorithm>
#include <chrono>
#include <cpuid.h>
#include <fcntl.h>
#include <random>
#include <string>
#include <vector>

namespace {
constexpr uint32_t P = 998244353;
double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
[[noreturn]] void fail(const std::string& s) { std::printf("FAIL %s\n", s.c_str()); std::exit(1); }

// Text buffer with 4 KiB of readable zero bytes before and after the text (guards for the
// parsers' 16-byte look-behind and 64-byte look-ahead).
struct Text {
    std::vector<char> mem; size_t off = 4096, len = 0;
    char* begin() { return mem.data() + off; }
};
Text make_text(const std::vector<uint32_t>& v, int style) {   // style 0: "a b c\n", 1: mixed whitespace
    Text t; t.mem.assign(v.size() * 12 + 16384, 0);
    char* p = t.begin();
    std::mt19937 rng(7);
    for (size_t i = 0; i < v.size(); ++i) {
        p += std::sprintf(p, "%u", v[i]);
        if (style == 0) *p++ = (i + 1 == v.size() || (i + 1) % 1000 == 0) ? '\n' : ' ';
        else { static const char* seps[] = {" ", "  ", "\n", "\r\n", "\t", " \n"}; const char* s = seps[rng() % 6]; while (*s) *p++ = *s++; }
    }
    t.len = size_t(p - t.begin());
    return t;
}

using ParseFn = char* (*)(char*, uint32_t*, size_t);
char* parse_sse(char* p, uint32_t* dst, size_t n) { for (size_t i = 0; i < n; ++i) dst[i] = read_sse_short(p); return p; }
struct NamedParser { const char* name; ParseFn fn; };
const NamedParser PARSERS[] = {{"sse", parse_sse}, {"flat", qp_parse_flat::parse_tokens}, {"tail", qp_parse_tail::parse_tokens},
                               {"tail8", qp_parse_tail8::parse_tokens}};

std::vector<uint32_t> values(size_t n, int kind, uint32_t seed) {
    std::mt19937 rng(seed); std::vector<uint32_t> v(n);
    for (auto& x : v) {
        if (kind == 0) x = rng() % P;                                       // max_random
        else if (kind == 1) x = 100000000 + rng() % (P - 100000000);        // all 9 digits
        else if (kind == 2) x = 1;                                          // all_same_00 input
        else if (kind == 3) { static const uint32_t pw[] = {1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, P};
                              int d = int(rng() % 9); x = pw[d] == 1 ? rng() % 10 : pw[d] + rng() % (pw[d + 1] - pw[d]); }  // uniform digit count
        else x = uint32_t(rng() % (1u << 24));                              // all_same_00-like outputs
    }
    return v;
}

// ---- unit tests -------------------------------------------------------------------------------
void unit_format(uint64_t limit) {
    alignas(32) uint32_t v[8];
    char a[128], b[128];
    uint64_t checked = 0;
    for (uint64_t x0 = 0; x0 < limit; x0 += 8) {
        for (int i = 0; i < 8; ++i) v[i] = uint32_t(std::min<uint64_t>(x0 + i, limit - 1));
        qp_fixed::eight(v, a);
        for (int i = 0; i < 8; ++i) {
            qp_fixed::one_table(v[i], b + 10 * i);
            if (std::memcmp(a + 10 * i, b + 10 * i, 10) != 0) fail("fixed_avx2 vs fixed_table at " + std::to_string(v[i]));
        }
        qp_fixed::blocks<1>(v, a);
        if (std::memcmp(a, b, 80) != 0) fail("blocks<1> vs fixed_table at " + std::to_string(v[0]));
        if (x0 % (1u << 12) == 0 || x0 < 20000000) {   // digit-loop reference on a dense prefix + sample
            for (int i = 0; i < 8; ++i) { qp_fixed::one(v[i], a); if (std::memcmp(a, b + 10 * i, 10) != 0) fail("fixed_table vs reference at " + std::to_string(v[i])); }
        }
        checked += 8;
    }
    {   // blocks<2> on random values and on a dense prefix
        std::mt19937 rng(3); alignas(32) uint32_t w[16]; char c2[256], d2[256];
        for (int t = 0; t < 4000000; ++t) {
            for (int i = 0; i < 16; ++i) w[i] = t < 2000000 ? uint32_t(t * 16 % 1000000000 + i) : rng() % 1000000000u;
            qp_fixed::blocks<2>(w, c2);
            for (int i = 0; i < 16; ++i) qp_fixed::one_table(w[i], d2 + 10 * i);
            if (std::memcmp(c2, d2, 160) != 0) fail("blocks<2> vs fixed_table");
        }
    }
    // Boundaries and P-1 against the reference.
    std::vector<uint32_t> edge = {0, 1, 9, 10, 11, 99, 100, 101, 998244352};
    for (uint32_t k = 10; k <= 100000000; k *= 10) for (int d = -2; d <= 2; ++d) edge.push_back(uint32_t(int64_t(k) + d));
    for (uint32_t x : edge) {
        for (int i = 0; i < 8; ++i) v[i] = x;
        qp_fixed::eight(v, a); qp_fixed::one(x, b);
        for (int i = 0; i < 8; ++i) if (std::memcmp(a + 10 * i, b, 10) != 0) fail("fixed_avx2 edge " + std::to_string(x));
        qp_fixed::one_table(x, a); if (std::memcmp(a, b, 10) != 0) fail("fixed_table edge " + std::to_string(x));
        // Token check: the field holds the canonical decimal string, right-aligned.
        char want[16]; const int n = std::snprintf(want, sizeof want, "%u", x);
        if (std::memcmp(b + 9 - n, want, size_t(n)) != 0 || b[9] != ' ') fail("reference layout " + std::to_string(x));
        for (int i = 0; i < 9 - n; ++i) if (b[i] != ' ') fail("reference padding " + std::to_string(x));
    }
    std::printf("PASS formatters: %llu values below %llu (avx2 == table everywhere, table == digit loop on [0, 2e7) and every 4096th), %zu edge values\n",
                (unsigned long long)checked, (unsigned long long)limit, edge.size());
}

void unit_parse() {
    std::vector<std::vector<uint32_t>> sets;
    for (int kind = 0; kind <= 4; ++kind) sets.push_back(values(200000 + kind, kind, 11 + kind));
    std::vector<uint32_t> edge = {0, 1, 9, 10, 99, 100, 999, 1000, 9999, 10000, 99999, 100000, 999999, 1000000,
                                  9999999, 10000000, 99999999, 100000000, P - 1, 5, 0, 0};
    sets.push_back(edge);
    for (int n = 1; n <= 40; ++n) sets.push_back(values(size_t(n), 3, 100 + n));   // short streams
    std::vector<uint32_t> out(300000 + 64);
    int runs = 0;
    for (const auto& vset : sets) for (int style = 0; style < 2; ++style) {
        Text t = make_text(vset, style);
        for (const auto& ps : PARSERS) {
            // Whole stream in one call, then split into uneven pieces (resumed calls).
            for (int split = 0; split < 2; ++split) {
                std::fill(out.begin(), out.end(), 0xdeadbeef);
                char* p = t.begin(); size_t done = 0; std::mt19937 rng(split);
                while (done < vset.size()) {
                    size_t take = split ? std::min<size_t>(vset.size() - done, 1 + rng() % 37) : vset.size() - done;
                    p = ps.fn(p, out.data() + done, take);
                    done += take;
                }
                for (size_t i = 0; i < vset.size(); ++i) if (out[i] != vset[i])
                    fail(std::string("parser ") + ps.name + " style " + std::to_string(style) + " index " + std::to_string(i) +
                         " got " + std::to_string(out[i]) + " want " + std::to_string(vset[i]));
                if (out[vset.size()] != 0xdeadbeef) fail(std::string("parser ") + ps.name + " wrote past count");
                ++runs;
            }
        }
    }
    // Round trip through the fixed-width formatter (runs of spaces between tokens).
    for (int kind = 0; kind <= 4; ++kind) {
        auto vset = values(100000, kind, 77 + kind);
        Text t; t.mem.assign(vset.size() * 10 + 16384, 0);
        char* q = t.begin();
        size_t i = 0;
        for (; i + 8 <= vset.size(); i += 8, q += 80) qp_fixed::eight(vset.data() + i, q);
        for (; i < vset.size(); ++i, q += 10) qp_fixed::one_table(vset[i], q);
        q[-1] = '\n'; std::memset(q, 0, 64);
        for (const auto& ps : PARSERS) {
            std::fill(out.begin(), out.end(), 0);
            ps.fn(t.begin(), out.data(), vset.size());
            for (size_t k = 0; k < vset.size(); ++k) if (out[k] != vset[k]) fail(std::string("round trip ") + ps.name);
            ++runs;
        }
    }
    std::printf("PASS parsers: %d runs (random, 9-digit, single-digit, uniform length, small, edges, 40 short streams; single spaces and mixed whitespace; resumed calls; fixed-width round trip)\n", runs);
}

// ---- timing -----------------------------------------------------------------------------------
double median(std::vector<double> s) { std::sort(s.begin(), s.end()); return s[s.size() / 2]; }

void time_all(int reps) {
    const size_t n = size_t(1) << 25;
    std::vector<uint32_t> out(n + 64);
    const char* kind_name[] = {"random", "nine_digit", "single_digit"};
    for (int kind = 0; kind <= 2; ++kind) {
        auto v = values(n, kind, 5);
        Text t = make_text(v, 0);
        for (const auto& ps : PARSERS) {
            std::vector<double> s;
            for (int r = 0; r < reps + 1; ++r) {
                const double t0 = now_ms();
                ps.fn(t.begin(), out.data(), n);
                const double t1 = now_ms();
                if (r) s.push_back(t1 - t0);
            }
            for (size_t i = 0; i < n; i += 4099) if (out[i] != v[i]) fail("timing parse check");
            std::printf("parse,%s,%s,%.2f,%.3f ns/token\n", ps.name, kind_name[kind], median(s), median(s) * 1e6 / double(n));
        }
    }
    static fastio_unsafe_impl::output ob;
    const char* fkind_name[] = {"random", "", "", "", "small"};
    for (int kind : {0, 4}) {
        auto v = values(n + 8, kind, 9);
        alignas(64) static char buf[(1 << 16) + 256];
        for (int f = 0; f < 5; ++f) {
            const char* name = f == 0 ? "table" : f == 1 ? "fixed_table" : f == 2 ? "fixed_avx2" : f == 3 ? "fixed_v2g1" : "fixed_v2g2";
            std::vector<double> s; uint64_t sink = 0;
            for (int r = 0; r < reps + 1; ++r) {
                const double t0 = now_ms();
                if (f == 0) {
                    char* c = ob.begin(); char* const e = ob.end();
                    for (size_t i = 0; i < n; ++i) {
                        if (__builtin_expect(e - c < 16, 0)) { sink += uint64_t(c - ob.begin()); c = ob.begin(); }
                        *c++ = ' ';
                        uint32_t value = v[i];
                        if (value >= 100000000U) {
                            const uint32_t high = value / 100000000U;
                            *c++ = char('0' + high); value -= high * 100000000U;
                            fastio_unsafe_impl::emit_padded(c, value / 10000U); fastio_unsafe_impl::emit_padded(c, value % 10000U);
                        } else fastio_unsafe_impl::emit_u32_unchecked(c, value);
                    }
                    sink += uint64_t(c - ob.begin());
                } else {
                    char* c = buf; char* const e = buf + (1 << 16);
                    if (f == 1) for (size_t i = 0; i < n; ++i) { if (__builtin_expect(c + 10 > e, 0)) { sink += uint64_t(c - buf); c = buf; } qp_fixed::one_table(v[i], c); c += 10; }
                    else if (f == 2) for (size_t i = 0; i < n; i += 8) { if (__builtin_expect(c + 86 > e, 0)) { sink += uint64_t(c - buf); c = buf; } qp_fixed::eight(v.data() + i, c); c += 80; }
                    else if (f == 3) for (size_t i = 0; i < n; i += 8) { if (__builtin_expect(c + 86 > e, 0)) { sink += uint64_t(c - buf); c = buf; } qp_fixed::blocks<1>(v.data() + i, c); c += 80; }
                    else for (size_t i = 0; i < n; i += 16) { if (__builtin_expect(c + 166 > e, 0)) { sink += uint64_t(c - buf); c = buf; } qp_fixed::blocks<2>(v.data() + i, c); c += 160; }
                    sink += uint64_t(c - buf) + uint8_t(buf[5]);
                }
                const double t1 = now_ms();
                if (r) s.push_back(t1 - t0);
            }
            std::printf("format,%s,%s,%.2f,%.3f ns/value (sink %llu)\n", name, fkind_name[kind], median(s), median(s) * 1e6 / double(n), (unsigned long long)(sink & 1));
        }
        // With write() into a fresh tmpfs file (the judge's output is a new tmpfs file).
        for (int f = 0; f < 4; ++f) {
            if (f == 1) continue;
            const char* name = f == 0 ? "table" : f == 2 ? "fixed_avx2" : "fixed_v2g2";
            std::vector<double> s; size_t bytes = 0;
            for (int r = 0; r < std::min(reps, 3) + 1; ++r) {
                unlink("/dev/shm/qpoly_io_out");
                const int fd = open("/dev/shm/qpoly_io_out", O_WRONLY | O_CREAT, 0600);
                const double t0 = now_ms();
                bytes = 0;
                auto put = [&](const char* d, size_t len) { bytes += len; while (len) { ssize_t k = write(fd, d, len); if (k <= 0) std::exit(3); d += k; len -= size_t(k); } };
                if (f == 0) {
                    char* c = ob.begin(); char* const e = ob.end();
                    for (size_t i = 0; i < n; ++i) {
                        if (__builtin_expect(e - c < 16, 0)) { put(ob.begin(), size_t(c - ob.begin())); c = ob.begin(); }
                        *c++ = ' ';
                        uint32_t value = v[i];
                        if (value >= 100000000U) {
                            const uint32_t high = value / 100000000U;
                            *c++ = char('0' + high); value -= high * 100000000U;
                            fastio_unsafe_impl::emit_padded(c, value / 10000U); fastio_unsafe_impl::emit_padded(c, value % 10000U);
                        } else fastio_unsafe_impl::emit_u32_unchecked(c, value);
                    }
                    put(ob.begin(), size_t(c - ob.begin()));
                } else if (f == 2) {
                    char* c = buf; char* const e = buf + 64000;
                    for (size_t i = 0; i < n; i += 8) { qp_fixed::eight(v.data() + i, c); c += 80; if (c >= e) { put(buf, size_t(c - buf)); c = buf; } }
                    put(buf, size_t(c - buf));
                } else {
                    char* c = buf; char* const e = buf + 64000;
                    for (size_t i = 0; i < n; i += 16) { qp_fixed::blocks<2>(v.data() + i, c); c += 160; if (c >= e) { put(buf, size_t(c - buf)); c = buf; } }
                    put(buf, size_t(c - buf));
                }
                const double t1 = now_ms();
                close(fd);
                if (r) s.push_back(t1 - t0);
            }
            unlink("/dev/shm/qpoly_io_out");
            std::printf("format_write,%s,%s,%.2f,%.3f ns/value (%zu bytes)\n", name, fkind_name[kind], median(s), median(s) * 1e6 / double(n), bytes);
        }
    }
}
}  // namespace

int main(int argc, char** argv) {
    unsigned r[4]; char brand[49]{};
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    std::printf("# CPU: %s\n# compiler: %s\n", brand, __VERSION__);
    const std::string cmd = argc > 1 ? argv[1] : "unit";
    if (cmd == "unit") {
        unit_parse();
        unit_format(argc > 2 ? std::strtoull(argv[2], nullptr, 10) : 1000000000ull);
        std::printf("ALL IO UNIT CHECKS PASSED\n");
    } else if (cmd == "time") time_all(argc > 2 ? std::atoi(argv[2]) : 5);
    return 0;
}
