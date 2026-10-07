// Exploration 014: unit tests and in-memory timings for convolution_mod_large I/O variants.
//   bench_opt unit              every parser on generated token streams (random, 9-digit, single
//                               digit, uniform length, edges, short streams; single spaces and mixed
//                               whitespace; whole and resumed calls; fixed-width round trip);
//                               exit 1 on any mismatch
//   bench_opt time [reps]       parsers on 2^25 tokens (random / nine_digit / single_digit), variants
//                               interleaved in rotating order, median ms and ns/token per variant
//   bench_opt one NAME KIND N   run one parser N times (for perf stat)
// Baseline: qp_parse_ms2 with 128 KiB chunks (the exploration-011 deliverable's parser).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi,bmi2")
#include "../conv_large/io007.hpp"
#include "../io_large/parse_ms2.inc"
#include "../io_large/fmt_bcd.inc"
#include "parse_ms2s.inc"
#include <algorithm>
#include <chrono>
#include <cpuid.h>
#include <random>
#include <string>
#include <vector>

namespace {
constexpr uint32_t P = 998244353;
double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
[[noreturn]] void fail(const std::string& s) { std::printf("FAIL %s\n", s.c_str()); std::exit(1); }

struct Text {   // 4 KiB of zero bytes before and after the text
    std::vector<char> mem; size_t off = 4096, len = 0;
    char* begin() { return mem.data() + off; }
};
Text make_text(const std::vector<uint32_t>& v, int style) {   // 0: "a b c\n" lines of 1000, 1: mixed whitespace
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
std::vector<uint32_t> values(size_t n, int kind, uint32_t seed) {
    std::mt19937 rng(seed); std::vector<uint32_t> v(n);
    for (auto& x : v) {
        if (kind == 0) x = rng() % P;                                       // max_random
        else if (kind == 1) x = 100000000 + rng() % (P - 100000000);        // all 9 digits (fft_killer-like)
        else if (kind == 2) x = 1;                                          // all_same_00 input
        else if (kind == 3) { static const uint32_t pw[] = {1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, P};
                              int d = int(rng() % 9); x = pw[d] == 1 ? rng() % 10 : pw[d] + rng() % (pw[d + 1] - pw[d]); }
        else x = uint32_t(rng() % (1u << 24));
    }
    return v;
}

using ParseFn = char* (*)(char*, uint32_t*, size_t);
struct NamedParser { const char* name; ParseFn fn; };
constexpr auto TAIL = qp_parse_flat::parse_tokens;
const NamedParser PARSERS[] = {
    {"m2", qp_parse_ms2::parse_tokens<131072, TAIL>},              // deliverable (exploration 011)
    {"s0", qp_parse_ms2s::parse_tokens<32768, 0, 0, TAIL>},        // control: same spacing as m2
    {"s7", qp_parse_ms2s::parse_tokens<32768, 448, 0, TAIL>},      // streams 7 lines apart mod 4 KiB
    {"s17", qp_parse_ms2s::parse_tokens<32768, 1088, 0, TAIL>},    // 17 lines
    {"s33", qp_parse_ms2s::parse_tokens<32768, 2112, 0, TAIL>},    // 33 lines
    {"s17q", qp_parse_ms2s::parse_tokens<16384, 1088, 0, TAIL>},   // 64 KiB chunks
    {"s17h", qp_parse_ms2s::parse_tokens<65536, 1088, 0, TAIL>},   // 256 KiB chunks
    {"p0", qp_parse_ms2s::parse_tokens<32768, 0, 384, TAIL>},      // prefetch only
    {"s17p", qp_parse_ms2s::parse_tokens<32768, 1088, 384, TAIL>}, // skew + prefetch
};
const NamedParser* find_parser(const std::string& name) {
    for (const auto& p : PARSERS) if (name == p.name) return &p;
    fail("unknown parser " + name);
}

void unit_parse() {
    std::vector<std::vector<uint32_t>> sets;
    for (int kind = 0; kind <= 4; ++kind) sets.push_back(values(200000 + kind, kind, 11 + kind));
    sets.push_back(values(123457, 3, 99));
    sets.push_back(values(700001, 0, 5));   // several 128-270 KiB chunks
    std::vector<uint32_t> edge = {0, 1, 9, 10, 99, 100, 999, 1000, 9999, 10000, 99999, 100000, 999999, 1000000,
                                  9999999, 10000000, 99999999, 100000000, P - 1, 5, 0, 0};
    sets.push_back(edge);
    for (int n = 1; n <= 40; ++n) sets.push_back(values(size_t(n), 3, 100 + n));
    std::vector<uint32_t> out(800000 + 64);
    int runs = 0;
    for (const auto& vset : sets) for (int style = 0; style < 2; ++style) {
        Text t = make_text(vset, style);
        for (const auto& ps : PARSERS) {
            for (int split = 0; split < 2; ++split) {
                std::fill(out.begin(), out.end(), 0xdeadbeef);
                char* p = t.begin(); size_t done = 0; std::mt19937 rng(split);
                while (done < vset.size()) {
                    size_t take = split ? std::min<size_t>(vset.size() - done, 1 + rng() % 70001) : vset.size() - done;
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
    for (int kind = 0; kind <= 4; ++kind) {   // round trip through the deliverable's fixed-width formatter
        auto vset = values(300000, kind, 77 + kind);
        Text t; t.mem.assign(vset.size() * 10 + 16384, 0);
        char* q = t.begin();
        size_t i = 0;
        for (; i + 8 <= vset.size(); i += 8, q += 80) qp_fixed::blocks3<1>(vset.data() + i, q);
        for (; i < vset.size(); ++i, q += 10) qp_fixed::one(vset[i], q);
        q[-1] = '\n'; std::memset(q, 0, 64);
        for (const auto& ps : PARSERS) {
            std::fill(out.begin(), out.end(), 0);
            ps.fn(t.begin(), out.data(), vset.size());
            for (size_t k = 0; k < vset.size(); ++k) if (out[k] != vset[k]) fail(std::string("round trip ") + ps.name);
            ++runs;
        }
    }
    std::printf("PASS parsers: %d runs\n", runs);
}

double median(std::vector<double> s) { std::sort(s.begin(), s.end()); return s[s.size() / 2]; }

void time_parsers(int reps) {
    const size_t n = size_t(1) << 25;
    std::vector<uint32_t> out(n + 64);
    const char* kind_name[] = {"random", "nine_digit", "single_digit"};
    const size_t np = sizeof PARSERS / sizeof PARSERS[0];
    for (int kind = 0; kind <= 2; ++kind) {
        auto v = values(n, kind, 5);
        Text t = make_text(v, 0);
        std::vector<std::vector<double>> s(np);
        for (int r = 0; r < reps + 1; ++r) {   // round 0 is a warmup
            for (size_t k = 0; k < np; ++k) {
                const size_t i = (k + size_t(r)) % np;
                const double t0 = now_ms();
                PARSERS[i].fn(t.begin(), out.data(), n);
                const double t1 = now_ms();
                if (r) s[i].push_back(t1 - t0);
                for (size_t j = 0; j < n; j += 4099) if (out[j] != v[j]) fail(std::string("timing parse check ") + PARSERS[i].name);
            }
        }
        for (size_t i = 0; i < np; ++i) {
            std::printf("parse,%s,%s,%.2f,%.3f ns/token,min %.2f,max %.2f\n", PARSERS[i].name, kind_name[kind], median(s[i]),
                        median(s[i]) * 1e6 / double(n), *std::min_element(s[i].begin(), s[i].end()), *std::max_element(s[i].begin(), s[i].end()));
        }
    }
}

void run_one(const std::string& name, int kind, int count) {
    const size_t n = size_t(1) << 25;
    std::vector<uint32_t> out(n + 64);
    auto v = values(n, kind, 5);
    Text t = make_text(v, 0);
    const NamedParser* ps = find_parser(name);
    const double t0 = now_ms();
    for (int r = 0; r < count; ++r) ps->fn(t.begin(), out.data(), n);
    const double t1 = now_ms();
    for (size_t j = 0; j < n; ++j) if (out[j] != v[j]) fail("one: mismatch");
    std::printf("one,%s,%d,%.2f ms/run\n", name.c_str(), kind, (t1 - t0) / count);
}
}  // namespace

int main(int argc, char** argv) {
    unsigned r[4]; char brand[49]{};
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    std::printf("# CPU: %s\n# compiler: %s\n", brand, __VERSION__);
    const std::string cmd = argc > 1 ? argv[1] : "unit";
    if (cmd == "unit") { unit_parse(); std::printf("ALL OPT UNIT CHECKS PASSED\n"); }
    else if (cmd == "time") time_parsers(argc > 2 ? std::atoi(argv[2]) : 5);
    else if (cmd == "one" && argc > 4) run_one(argv[2], std::atoi(argv[3]), std::atoi(argv[4]));
    else fail("usage");
    return 0;
}
