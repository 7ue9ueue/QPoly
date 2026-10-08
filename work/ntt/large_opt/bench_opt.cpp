// Exploration 014: unit tests and in-memory timings for convolution_mod_large I/O variants.
//   bench_opt unit              every parser on generated token streams (random, 9-digit, single
//                               digit, uniform length, edges, short streams; single spaces and mixed
//                               whitespace; whole and resumed calls; fixed-width round trip);
//                               exit 1 on any mismatch
//   bench_opt time [reps]       parsers on 2^25 tokens (random / nine_digit / single_digit), variants
//                               interleaved in rotating order, median ms and ns/token per variant
//   bench_opt one NAME KIND N   run one parser N times (for perf stat)
//   bench_opt cache [reps]      parsers on a cache-resident text (2^18 random tokens, ~2.6 MB, parsed
//                               128 times per sample) vs 2^25 tokens from DRAM: ns/token
//   bench_opt fmtunit [limit]   asm formatter (fmt_asm.inc) vs blocks3 for every value < limit (default 10^9),
//                               random blocks for G = 2, 4 and edge values; exit 1 on any mismatch
//   bench_opt fmtablate [reps]  formatter ablations: full / compute without stores / stores only / half the stores
//   bench_opt fmttime [reps]    formatters on 2^25 values into a 160 KiB buffer (random, small < 2^24)
//   bench_opt ablate [reps]     ms2 step-loop ablations (parse_ablate.inc modes 0-5), DRAM and cached text
//   bench_opt ovl [reps]        overlap experiment: parse 2^24 random tokens with independent NTT
//                               work interleaved (one unit per 8-token step) vs each alone
// Baseline: qp_parse_ms2 with 128 KiB chunks (the exploration-011 deliverable's parser).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi,bmi2,prfchw")
#include "../conv_large/io007.hpp"
#include "../io_large/parse_ms2.inc"
#include "../io_large/fmt_bcd.inc"
#include "parse_ms2s.inc"
#include "parse_ms4.inc"
#include "parse_ms4p.inc"
#include "fmt_asm.inc"
#include "core_tw.hpp"
#include "parse_ablate.inc"
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
    {"q4", qp_parse_ms4::parse_tokens<32768, 0, TAIL>},            // four tokens per stream step
    {"q4s", qp_parse_ms4::parse_tokens<32768, 1088, TAIL>},
    {"q4h", qp_parse_ms4::parse_tokens<65536, 1088, TAIL>},
    {"q4p", qp_parse_ms4p::parse_tokens<32768, 0, TAIL>},           // pipelined: scan k+1 while converting k
    {"q4ph", qp_parse_ms4p::parse_tokens<65536, 1088, TAIL>},
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

// ---- overlap experiment ---------------------------------------------------------------------
using V = __m256i;
template<class C>
__attribute__((always_inline)) inline void fwd4_one(V* f, long h, long j, const qasm::Twiddle& t) {   // qasm::fwd4<C, false> body
    using namespace qasm;
    constexpr int M = C::Mul; constexpr bool F = C::Flip, S = C::Shuf, O = C::Opq;
    V a = low(f[j]), b = low(f[j + h]), c = f[j + 2 * h], d = f[j + 3 * h];
    const U* fc = (const U*)(f + j + 2 * h);
    c = t.x.template mul2<M, F, O>(c, _mm256_loadu_si256((const V*)(fc + 1)));
    d = t.x.template mul2<M, F, O>(d, _mm256_loadu_si256((const V*)(fc + 8 * h + 1)));
    V ac = low(plus(a, c)), amc = low(diff(a, c));
    V bd = plus(b, d), bmd = diff(b, d);
    bd = t.y.template mul<M, F, S, O>(bd);
    bmd = t.z.template mul<M, F, S, O>(bmd);
    f[j] = plus(ac, bd); f[j + h] = diff(ac, bd); f[j + 2 * h] = plus(amc, bmd); f[j + 3 * h] = diff(amc, bmd);
}
qasm::Fixed fixed_of(uint32_t w) { return qasm::Fixed(qasm::splat(w), qasm::splat(qopt::quotient(w))); }
struct SideCount { size_t n = 0; __attribute__((always_inline)) void operator()() { ++n; } };
struct SideTop {   // zero-upper first radix-4 group (qlarge::top4_zero_body) over a 4H-vector array
    V* f; long H, j, end; qasm::Fixed z;
    __attribute__((always_inline)) void operator()() { if (j < end) { qlarge::top4_zero_body(f, H, j, z); ++j; } }
};
struct SideR4 {    // forward radix-4 butterflies (exploration-009 C++ body) cycling over [0, h)
    V* f; long h, j; size_t left; qasm::Twiddle t;
    __attribute__((always_inline)) void operator()() { if (left) { fwd4_one<qlarge::Sel>(f, h, j, t); if (++j == h) j = 0; --left; } }
};
constexpr auto TAILP = qp_parse_flat::parse_tokens;
template<class Side> double parse_with(Text& t, uint32_t* out, size_t n, Side& side) {
    const double t0 = now_ms();
    qp_parse_ms2s::parse_side<32768, 0, 0, TAILP>(t.begin(), out, n, side);
    return now_ms() - t0;
}
template<class Side> double side_alone(Side& side, size_t units) {
    const double t0 = now_ms();
    for (size_t i = 0; i < units; ++i) { side(); asm volatile("" ::: "memory"); }
    return now_ms() - t0;
}
void overlap(int reps) {
    const size_t n = size_t(1) << 24;
    std::vector<uint32_t> out(n + 64);
    auto v = values(n, 0, 5);
    Text t = make_text(v, 0);
    SideCount cnt; parse_with(t, out.data(), n, cnt);
    const size_t steps = cnt.n;
    std::mt19937 rng(9);
    const long H = 1L << 20;   // top group of a 2^25-word array
    std::vector<V> top(size_t(4 * H) + 2), r4d((size_t(4) << 18) + 2), r4c((size_t(4) << 11) + 2);   // +2: LdOdd reads past the end
    auto fill = [&](std::vector<V>& x, size_t len) { uint32_t* w = (uint32_t*)x.data(); for (size_t i = 0; i < len * 8; ++i) w[i] = rng() % P; };
    fill(top, size_t(2 * H)); fill(r4d, r4d.size() - 2); fill(r4c, r4c.size() - 2);
    const qasm::Twiddle tw{fixed_of(123456789), fixed_of(987654321), fixed_of(55555555)};
    struct Row { const char* name; std::vector<double> p, s, ps; };
    std::vector<Row> rows = {{"top"}, {"r4_dram"}, {"r4_l2"}};
    std::vector<double> base;
    for (int r = 0; r < reps + 1; ++r) {
        {
            qp_parse_ms2s::NoSide none;
            const double tp = parse_with(t, out.data(), n, none);
            if (r) base.push_back(tp);
        }
        for (size_t k = 0; k < rows.size(); ++k) {
            const size_t units = k == 0 ? std::min<size_t>(steps, size_t(H)) : steps;
            auto mk_top = [&]() { return SideTop{top.data(), H, 0, long(units), fixed_of(911660635)}; };
            auto mk_r4 = [&](std::vector<V>& x) { return SideR4{x.data(), long((x.size() - 2) / 4), 0, units, tw}; };
            double ts, tps;
            if (k == 0) { auto s1 = mk_top(); ts = side_alone(s1, units); auto s2 = mk_top(); tps = parse_with(t, out.data(), n, s2); }
            else { auto& x = k == 1 ? r4d : r4c; auto s1 = mk_r4(x); ts = side_alone(s1, units); auto s2 = mk_r4(x); tps = parse_with(t, out.data(), n, s2); }
            for (size_t j = 0; j < n; j += 4099) if (out[j] != v[j]) fail("overlap parse check");
            if (r) { rows[k].s.push_back(ts); rows[k].ps.push_back(tps); }
        }
    }
    const double tp = median(base);
    std::printf("ovl,parse_alone,%.2f,steps,%zu\n", tp, steps);
    for (auto& row : rows) {
        const double ts = median(row.s), tps = median(row.ps);
        std::printf("ovl,%s,side_alone,%.2f,parse_plus_side,%.2f,extra_vs_parse,%.2f,hidden_fraction,%.3f\n",
                    row.name, ts, tps, tps - tp, (tp + ts - tps) / ts);
    }
}

void cache_vs_dram(int reps) {
    const size_t small = size_t(1) << 18, big = size_t(1) << 25;   // small: ~2.6 MB text, L3-resident
    std::vector<uint32_t> out(big + 64);
    auto vs = values(small, 0, 5), vb = values(big, 0, 5);
    Text ts = make_text(vs, 0), tb = make_text(vb, 0);
    for (const char* name : {"m2", "q4h", "q4p", "q4ph"}) {
        const NamedParser* ps = find_parser(name);
        std::vector<double> c, d;
        for (int r = 0; r < reps + 1; ++r) {
            double t0 = now_ms();
            for (int k = 0; k < 128; ++k) ps->fn(ts.begin(), out.data(), small);
            double t1 = now_ms();
            ps->fn(tb.begin(), out.data(), big);
            double t2 = now_ms();
            if (r) { c.push_back((t1 - t0) * 1e6 / (128.0 * double(small))); d.push_back((t2 - t1) * 1e6 / double(big)); }
        }
        std::printf("cache,%s,cached_ns_per_token,%.3f,dram_ns_per_token,%.3f\n", name, median(c), median(d));
    }
}

template<int M> double ablate_once(Text& t, uint32_t* out, int times, uint64_t& sink) {
    const double t0 = now_ms();
    for (int k = 0; k < times; ++k) sink += qp_ablate::run<M>(t.begin(), t.len, out);
    return now_ms() - t0;
}
void ablate(int reps) {
    const size_t small = size_t(1) << 18, big = size_t(1) << 25;
    std::vector<uint32_t> out(big + 64);
    auto vs = values(small, 0, 5), vb = values(big, 0, 5);
    Text ts = make_text(vs, 0), tb = make_text(vb, 0);
    uint64_t sink = 0;
    using F = double (*)(Text&, uint32_t*, int, uint64_t&);
    const F fns[] = {ablate_once<0>, ablate_once<1>, ablate_once<2>, ablate_once<3>, ablate_once<4>, ablate_once<5>};
    const char* what[] = {"full_step", "no_stores", "two_only", "chain_only", "chain_win_row_shuf", "chain_win"};
    std::vector<double> dram[6], cached[6];
    for (int r = 0; r < reps + 1; ++r) for (int m = 0; m < 6; ++m) {
        const int i = (m + r) % 6;
        const double d = fns[i](tb, out.data(), 1, sink), c = fns[i](ts, out.data(), 128, sink);
        if (r) { dram[i].push_back(d * 1e6 / double(big)); cached[i].push_back(c * 1e6 / (128.0 * double(small))); }
    }
    for (int m = 0; m < 6; ++m)
        std::printf("ablate,%d,%s,dram_ns_per_token,%.3f,cached_ns_per_token,%.3f\n", m, what[m], median(dram[m]), median(cached[m]));
    {   // conversion only: token separators precomputed (outside the timer), 4 streams x 4 tokens per step
        std::vector<int32_t> sep(big + 1);
        sep[0] = -1;
        size_t k = 1;
        for (size_t i = 0; i < tb.len && k <= big; ++i) if (tb.begin()[i] <= ' ') sep[k++] = int32_t(i);
        if (k != big + 1) fail("conv_only: separator count");
        std::vector<double> c;
        for (int r = 0; r < reps + 1; ++r) {
            const double t0 = now_ms();
            sink += qp_ablate::conv_only(tb.begin(), sep.data() + 1, big, out.data());
            if (r) c.push_back((now_ms() - t0) * 1e6 / double(big));
        }
        for (size_t i = 0; i < big; i += 4097) if (out[i] != vb[i]) fail("conv_only mismatch");
        std::printf("ablate,6,conv_only_q4,dram_ns_per_token,%.3f\n", median(c));
    }
    std::printf("# sink %llu\n", (unsigned long long)(sink & 1));
}

void fmt_unit(uint64_t limit) {
    alignas(32) uint32_t v[32];
    char a[400], b[400 + 64];
    uint64_t checked = 0;
    for (uint64_t x0 = 0; x0 < limit; x0 += 8) {
        for (int i = 0; i < 8; ++i) v[i] = uint32_t(std::min<uint64_t>(x0 + i, limit - 1));
        qp_fixed::blocks3<1>(v, a);
        qp_fmt_asm::block8(v, b);
        if (std::memcmp(a, b, 80) != 0) fail("asm block8 vs blocks3 at " + std::to_string(x0));
        qp_fmt_asm::block8_s4(v, b);
        if (std::memcmp(a, b, 80) != 0) fail("asm block8_s4 vs blocks3 at " + std::to_string(x0));
        checked += 8;
    }
    std::mt19937 rng(17);
    for (int t = 0; t < 2000000; ++t) {
        for (int i = 0; i < 32; ++i) v[i] = (t & 1) ? rng() % 1000000000u : rng() % P;
        qp_fixed::blocks3<4>(v, a);
        qp_fmt_asm::blocks<4>(v, b);
        if (std::memcmp(a, b, 320) != 0) fail("asm blocks<4> vs blocks3<4>");
        qp_fmt_asm::blocks<2>(v, b); qp_fmt_asm::blocks<2>(v + 16, b + 160);
        if (std::memcmp(a, b, 320) != 0) fail("asm blocks<2> vs blocks3<4>");
        qp_fmt_asm::blocks2_s4(v, b); qp_fmt_asm::blocks2_s4(v + 16, b + 160);
        if (std::memcmp(a, b, 320) != 0) fail("asm blocks2_s4 vs blocks3<4>");
        for (int k = 0; k < 4; ++k) qp_fmt_asm::block8_s4(v + 8 * k, b + 80 * k);
        if (std::memcmp(a, b, 320) != 0) fail("asm block8_s4 x4 vs blocks3<4>");
    }
    std::vector<uint32_t> edge = {0, 1, 9, 10, 11, 99, 100, 101, 998244352, 999999999};
    for (uint32_t k = 10; k <= 100000000; k *= 10) for (int d = -2; d <= 2; ++d) edge.push_back(uint32_t(int64_t(k) + d));
    for (uint32_t x : edge) {
        for (int i = 0; i < 8; ++i) v[i] = x;
        qp_fmt_asm::block8(v, b); qp_fixed::one(x, a);
        for (int i = 0; i < 8; ++i) if (std::memcmp(b + 10 * i, a, 10) != 0) fail("asm edge " + std::to_string(x));
        qp_fmt_asm::block8_s4(v, b);
        for (int i = 0; i < 8; ++i) if (std::memcmp(b + 10 * i, a, 10) != 0) fail("asm s4 edge " + std::to_string(x));
        char want[16]; const int n = std::snprintf(want, sizeof want, "%u", x);
        if (std::memcmp(a + 9 - n, want, size_t(n)) != 0 || a[9] != ' ') fail("reference layout " + std::to_string(x));
    }
    std::printf("PASS asm formatter: %llu values below %llu equal blocks3, 2M random 32-value groups (G = 4, 2), %zu edge values\n",
                (unsigned long long)checked, (unsigned long long)limit, edge.size());
}
// Formatter ablations (diagnostic): full block; compute without stores (f0..f3 folded into one
// 32-byte store); stores without compute (8 stores of loaded data at the usual offsets); compute with
// the four low-lane stores only.
__attribute__((always_inline)) inline void fa_nostore(const uint32_t* src, char* dst) {
    asm volatile(QFA_COMPUTE(0) "vpxor %%ymm5, %%ymm4, %%ymm4\n\tvpxor %%ymm7, %%ymm6, %%ymm6\n\tvpxor %%ymm6, %%ymm4, %%ymm4\n\tvmovdqu %%ymm4, (%[d])\n\t"
                 : : [s] "r"(src), [d] "r"(dst), [t] "r"(qp_fmt_asm::consts.v) : QFA_CLOBBERS);
}
__attribute__((always_inline)) inline void fa_storeonly(const uint32_t* src, char* dst) {
    asm volatile("vmovdqu (%[s]), %%ymm4\n\tvpaddd %%ymm4, %%ymm4, %%ymm5\n\tvpaddd %%ymm5, %%ymm4, %%ymm6\n\tvpaddd %%ymm6, %%ymm4, %%ymm7\n\t" QFA_STORE(0)
                 : : [s] "r"(src), [d] "r"(dst), [t] "r"(qp_fmt_asm::consts.v) : QFA_CLOBBERS);
}
__attribute__((always_inline)) inline void fa_halfstore(const uint32_t* src, char* dst) {
    asm volatile(QFA_COMPUTE(0) "vmovdqu %%xmm4, (%[d])\n\tvmovdqu %%xmm5, 10(%[d])\n\tvmovdqu %%xmm6, 20(%[d])\n\tvmovdqu %%xmm7, 30(%[d])\n\t"
                 : : [s] "r"(src), [d] "r"(dst), [t] "r"(qp_fmt_asm::consts.v) : QFA_CLOBBERS);
}
void fmt_ablate(int reps) {
    const size_t n = size_t(1) << 25;
    alignas(64) static char buf[163840 + 512];
    auto v = values(n + 32, 0, 9);
    using F = void (*)(const uint32_t*, char*);
    const F fns[] = {qp_fmt_asm::block8, fa_nostore, fa_storeonly, fa_halfstore};
    const char* names[] = {"full", "compute_no_stores", "stores_only", "compute_half_stores"};
    std::vector<double> s[4]; uint64_t sink = 0;
    for (int r = 0; r < reps + 1; ++r) for (int f0 = 0; f0 < 4; ++f0) {
        const int f = (f0 + r) % 4;
        char* c = buf; char* const e = buf + 163840;
        const double t0 = now_ms();
        for (size_t i = 0; i < n; i += 8) {
            if (c >= e) { sink += uint64_t(c - buf); c = buf; }
            fns[f](v.data() + i, c);
            c += 80;
        }
        const double t1 = now_ms();
        sink += uint64_t(c - buf) + uint8_t(buf[7]);
        if (r) s[f].push_back(t1 - t0);
    }
    for (int f = 0; f < 4; ++f) std::printf("fmtablate,%s,%.2f ms,%.3f ns/value\n", names[f], median(s[f]), median(s[f]) * 1e6 / double(n));
    std::printf("# sink %llu\n", (unsigned long long)(sink & 1));
}

void fmt_time(int reps) {
    const size_t n = size_t(1) << 25;
    alignas(64) static char buf[163840 + 512];
    const char* names[] = {"blocks3_4", "blocks3_2", "asm_1x4", "asm_2x2", "asm_4", "s4_1x4", "s4_2x2", "asm_2x2_pfw", "s4_2x2_pfw", "blocks3_4_pfw"};
    const char* kinds[] = {"random", "small"};
    for (int kind = 0; kind < 2; ++kind) {
        auto v = values(n + 32, kind == 0 ? 0 : 4, 9);
        constexpr int NF = 10;
        std::vector<double> s[NF]; uint64_t sink = 0;
        for (int r = 0; r < reps + 1; ++r) for (int f0 = 0; f0 < NF; ++f0) {
            const int f = (f0 + r) % NF;
            char* c = buf; char* const e = buf + 163840;
            const double t0 = now_ms();
            for (size_t i = 0; i < n; i += 32) {
                if (c >= e) { sink += uint64_t(c - buf); c = buf; }
                const uint32_t* src = v.data() + i;
                if (f == 0) qp_fixed::blocks3<4>(src, c);
                else if (f == 1) { qp_fixed::blocks3<2>(src, c); qp_fixed::blocks3<2>(src + 16, c + 160); }
                else if (f == 2) { qp_fmt_asm::block8(src, c); qp_fmt_asm::block8(src + 8, c + 80); qp_fmt_asm::block8(src + 16, c + 160); qp_fmt_asm::block8(src + 24, c + 240); }
                else if (f == 3) { qp_fmt_asm::blocks<2>(src, c); qp_fmt_asm::blocks<2>(src + 16, c + 160); }
                else if (f == 4) qp_fmt_asm::blocks<4>(src, c);
                else if (f == 5) { qp_fmt_asm::block8_s4(src, c); qp_fmt_asm::block8_s4(src + 8, c + 80); qp_fmt_asm::block8_s4(src + 16, c + 160); qp_fmt_asm::block8_s4(src + 24, c + 240); }
                else if (f == 6) { qp_fmt_asm::blocks2_s4(src, c); qp_fmt_asm::blocks2_s4(src + 16, c + 160); }
                else {   // write-intent prefetch of the next group's five lines (640 bytes ahead)
                    for (int l = 0; l < 320; l += 64) __builtin_prefetch(c + 640 + l, 1, 3);
                    if (f == 7) { qp_fmt_asm::blocks<2>(src, c); qp_fmt_asm::blocks<2>(src + 16, c + 160); }
                    else if (f == 8) { qp_fmt_asm::blocks2_s4(src, c); qp_fmt_asm::blocks2_s4(src + 16, c + 160); }
                    else qp_fixed::blocks3<4>(src, c);
                }
                c += 320;
            }
            const double t1 = now_ms();
            sink += uint64_t(c - buf) + uint8_t(buf[7]);
            if (r) s[f].push_back(t1 - t0);
        }
        for (int f = 0; f < NF; ++f)
            std::printf("format,%s,%s,%.2f,%.3f ns/value,min %.2f (sink %llu)\n", names[f], kinds[kind], median(s[f]), median(s[f]) * 1e6 / double(n),
                        *std::min_element(s[f].begin(), s[f].end()), (unsigned long long)(sink & 1));
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
    else if (cmd == "cache") cache_vs_dram(argc > 2 ? std::atoi(argv[2]) : 5);
    else if (cmd == "fmtunit") { fmt_unit(argc > 2 ? std::strtoull(argv[2], nullptr, 10) : 1000000000ull); std::printf("ALL FMT UNIT CHECKS PASSED\n"); }
    else if (cmd == "fmtablate") fmt_ablate(argc > 2 ? std::atoi(argv[2]) : 5);
    else if (cmd == "fmttime") fmt_time(argc > 2 ? std::atoi(argv[2]) : 5);
    else if (cmd == "ablate") ablate(argc > 2 ? std::atoi(argv[2]) : 5);
    else if (cmd == "ovl") overlap(argc > 2 ? std::atoi(argv[2]) : 5);
    else if (cmd == "one" && argc > 4) run_one(argv[2], std::atoi(argv[3]), std::atoi(argv[4]));
    else fail("usage");
    return 0;
}
