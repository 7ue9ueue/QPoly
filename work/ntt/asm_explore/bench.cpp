// Correctness and timing driver for the asm exploration (exploration 009); a copy of
// uop_explore/bench.cpp (SHA256 bfebf19b...) with its own entries.inc.
// Every entry computes a cyclic convolution modulo 998244353:
//   invoke(n, a, b, r, ir, root_state, fresh)
// n is a power of two in [64, 2^22]; a,b are canonical, 64-byte aligned, disjoint.
// a receives the canonical result, b is destroyed; r/ir are caller-owned root
// scratch of n uint32 each. Entries that do not need root scratch ignore it.
//
// Usage:
//   bench check [max_log2]                       correctness (fails with exit 1)
//   bench time max_log2 reps mode [min_log2]      timing CSV (mode 0 fresh,1 reuse,2 both)
// Env ONLY=a,b,c restricts entries (the first listed entry is the speedup baseline).
#include <immintrin.h>
#include <algorithm>
#include <array>
#include <cassert>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <random>
#include <sstream>
#include <string>
#include <vector>
#include <cpuid.h>

// Optimization pragma variants (the judge's command line is fixed, so these are
// what a submission can control): default O3+unroll-loops as in all submissions.
#if defined(__GNUC__) && !defined(__clang__)
#if defined(QPOLY_OPT_SCHED)
#pragma GCC optimize("O3,unroll-loops,schedule-insns,sched-pressure")
#elif defined(QPOLY_OPT_SCHED_ONLY)
#pragma GCC optimize("O3,unroll-loops,schedule-insns")
#elif defined(QPOLY_OPT_O3)
#pragma GCC optimize("O3")
#elif defined(QPOLY_OPT_NONE)
#else
#pragma GCC optimize("O3,unroll-loops")
#endif
#endif
#pragma GCC target("avx2,bmi")

#include "entries.inc"

namespace harness {
using U = uint32_t;
using A = std::vector<U>;
constexpr U P = 998244353;

std::vector<Entry> selected() {
    std::vector<Entry> all(std::begin(ENTRIES), std::end(ENTRIES)), out;
    const char* env = std::getenv("ONLY");
    if (!env || !*env) return all;
    std::stringstream ss(env);
    std::string name;
    while (std::getline(ss, name, ',')) {
        auto it = std::find_if(all.begin(), all.end(), [&](const Entry& e) { return name == e.name; });
        if (it == all.end()) { std::cerr << "unknown entry " << name << '\n'; std::exit(2); }
        out.push_back(*it);
    }
    return out;
}

struct Aligned {
    U* p; int n;
    explicit Aligned(int size) : p((U*)_mm_malloc(size_t(size + 16) * 4, 64)), n(size) {
        if (!p) throw std::bad_alloc();
        std::fill(p, p + n, 0);
        std::fill(p + n, p + n + 16, 0xdeadbeef);
    }
    ~Aligned() { _mm_free(p); }
    Aligned(const Aligned&) = delete;
    bool intact() const { return std::all_of(p + n, p + n + 16, [](U x) { return x == 0xdeadbeef; }); }
};

U power(U a, U e) { U r = 1; for (; e; e >>= 1, a = uint64_t(a) * a % P) if (e & 1) r = uint64_t(r) * a % P; return r; }
// Independent scalar radix-2 oracle with explicit bit reversal and ordinary %.
void transform(A& a, bool inverse) {
    int n = int(a.size());
    for (int i = 1, j = 0; i < n; ++i) { int b = n / 2; for (; j & b; b >>= 1) j ^= b; j ^= b; if (i < j) std::swap(a[i], a[j]); }
    for (int len = 2; len <= n; len *= 2) {
        U step = power(3, (P - 1) / len); if (inverse) step = power(step, P - 2);
        for (int i = 0; i < n; i += len) { U w = 1; for (int j = 0; j < len / 2; ++j) {
            U x = a[i + j], y = uint64_t(a[i + j + len / 2]) * w % P;
            a[i + j] = (x + y) % P; a[i + j + len / 2] = (x + P - y) % P; w = uint64_t(w) * step % P; } }
    }
    if (inverse) { U w = power(n, P - 2); for (U& x : a) x = uint64_t(x) * w % P; }
}
A reference(A a, A b) { transform(a, false); transform(b, false); for (size_t i = 0; i < a.size(); ++i) a[i] = uint64_t(a[i]) * b[i] % P; transform(a, true); return a; }
A brute(const A& a, const A& b) {
    A c(a.size());
    for (size_t i = 0; i < a.size(); ++i) for (size_t j = 0; j < b.size(); ++j)
        c[(i + j) % a.size()] = (c[(i + j) % a.size()] + uint64_t(a[i]) * b[j]) % P;
    return c;
}
[[noreturn]] void fail(const char* name, int n, int i, U got, U want) {
    std::cout << "FAIL " << name << " n=" << n << " index=" << i << " got=" << got << " expected=" << want << std::endl;
    std::exit(1);
}
void check_one(const Entry& e, const A& x, const A& y, const A& want, Aligned& a, Aligned& b, Aligned& r, Aligned& ir, int& rs, bool fresh) {
    int n = int(x.size());
    std::copy(x.begin(), x.end(), a.p); std::copy(y.begin(), y.end(), b.p);
    e.fn(n, a.p, b.p, r.p, ir.p, rs, fresh);
    for (int i = 0; i < n; ++i) if (a.p[i] != want[i]) fail(e.name, n, i, a.p[i], want[i]);
    if (!a.intact() || !b.intact() || !r.intact() || !ir.intact()) fail(e.name, n, n, 0, 1);
}
void correctness(int max_log) {
    auto entries = selected();
    std::mt19937 rng(20260927);
    for (int lg = 6; lg <= max_log; ++lg) {
        int n = 1 << lg; Aligned a(n), b(n), r(n), ir(n);
        // Pattern 7 (sizes <= 2^10) and the extra case below (larger sizes) have zero
        // upper halves, which exercises the ordinary-convolution shortcut.
        for (int pattern = 0; pattern < (lg <= 10 ? 8 : 2); ++pattern) {
            A x(n), y(n);
            for (int i = 0; i < n; ++i) {
                x[i] = rng() % P; y[i] = rng() % P;
                if (pattern == 1) x[i] = y[i] = P - 1;
                if (pattern == 2) x[i] = 0;
                if (pattern == 3) x[i] = (i == n - 1 ? P - 1 : 0), y[i] = (i == 1);
                if (pattern == 4) x[i] = i & 1 ? P - 1 : 0, y[i] = i & 1 ? 1 : P - 1;
                if (pattern == 5) x[i] = y[i] = 1;
                if (pattern == 6) x[i] = P - 1 - (rng() & 7), y[i] = P - 1 - (rng() & 7);
                if (pattern == 7 && i >= n / 2) x[i] = y[i] = 0;   // ordinary-convolution padding
            }
            A want = reference(x, y);
            if (n <= 256 && want != brute(x, y)) fail("oracle-vs-brute", n, 0, 0, 1);
            if (pattern == 1 && lg > 10) {   // extra zero-upper-half case at large sizes
                A x2 = x, y2 = y; for (int i = 0; i < n; ++i) { x2[i] = rng() % P; y2[i] = rng() % P; if (i >= n / 2) x2[i] = y2[i] = 0; }
                A want2 = reference(x2, y2);
                for (const Entry& e : entries) { int rs = 0; check_one(e, x2, y2, want2, a, b, r, ir, rs, true); }
            }
            for (const Entry& e : entries) { int rs = 0; check_one(e, x, y, want, a, b, r, ir, rs, true); check_one(e, x, y, want, a, b, r, ir, rs, false); }
        }
        std::cout << "PASS 2^" << lg << '\n';
    }
    {   // all P-1 has a known answer; a single shifted P-1 checks wraparound.
        int n = 1 << max_log; Aligned a(n), b(n), r(n), ir(n);
        A x(n, P - 1), y(n, P - 1), want(n, U(n % P));
        for (const Entry& e : entries) { int rs = 0; check_one(e, x, y, want, a, b, r, ir, rs, true); }
        std::fill(x.begin(), x.end(), 0); x[n - 1] = P - 1;
        for (U& v : y) v = rng() % P;
        for (int i = 0; i < n; ++i) want[i] = (P - y[(i + 1) % n]) % P;
        for (const Entry& e : entries) { int rs = 0; check_one(e, x, y, want, a, b, r, ir, rs, true); }
    }
    for (const Entry& e : entries) {   // growing/shrinking sizes with reused root state
        Aligned a(4096), b(4096), r(4096), ir(4096); int rs = 0;
        for (int n : {64, 256, 128, 4096, 1024, 512, 64, 2048}) {
            A x(n), y(n); for (U& v : x) v = rng() % P; for (U& v : y) v = rng() % P;
            check_one(e, x, y, reference(x, y), a, b, r, ir, rs, false);
        }
    }
    std::cout << "PASS boundary, wraparound and changing sizes\n";
}

volatile uint64_t sink = 0;
void benchmark(int max_log, int reps, int mode, int min_log) {
    auto entries = selected();
    const int count = int(entries.size());
    std::mt19937 rng(42);
    std::cout << "mode,log2,implementation,median_ms,min_ms,max_ms,speedup_vs_first,samples\n";
    for (int lg = min_log; lg <= max_log; ++lg) {
        int n = 1 << lg; Aligned a(n), b(n), r(n), ir(n);
        A x(n), y(n); for (U& v : x) v = rng() % P; for (U& v : y) v = rng() % P;
        for (int reuse = 0; reuse <= 1; ++reuse) {
            if (mode != 2 && reuse != mode) continue;
            std::vector<std::vector<double>> samples(count);
            uint64_t expected = 0; bool have = false;
            for (int rep = -2; rep < reps; ++rep) for (int pos = 0; pos < count; ++pos) {
                int j = (pos + rep + 2) % count; if (rep & 1) j = count - 1 - j;
                const Entry& e = entries[j]; int rs = 0;
                if (reuse) { std::copy(x.begin(), x.end(), a.p); std::copy(y.begin(), y.end(), b.p); e.fn(n, a.p, b.p, r.p, ir.p, rs, true); }
                std::copy(x.begin(), x.end(), a.p); std::copy(y.begin(), y.end(), b.p);
                auto t0 = std::chrono::steady_clock::now();
                e.fn(n, a.p, b.p, r.p, ir.p, rs, !reuse);
                auto t1 = std::chrono::steady_clock::now();
                uint64_t h = 0; for (int i = 0; i < n; ++i) h = h * 31 + a.p[i]; sink = h;
                if (have && h != expected) fail(e.name, n, -1, U(h), U(expected));
                expected = h; have = true;
                if (rep >= 0) samples[j].push_back(std::chrono::duration<double, std::milli>(t1 - t0).count());
            }
            std::vector<double> med(count);
            for (int j = 0; j < count; ++j) {
                auto s = samples[j]; std::sort(s.begin(), s.end());
                med[j] = (s[(s.size() - 1) / 2] + s[s.size() / 2]) / 2;
            }
            for (int j = 0; j < count; ++j) {
                auto s = samples[j]; std::sort(s.begin(), s.end());
                std::cout << (reuse ? "reuse" : "fresh") << ',' << lg << ',' << entries[j].name << ','
                          << med[j] << ',' << s.front() << ',' << s.back() << ',' << med[0] / med[j] << ',';
                for (size_t k = 0; k < samples[j].size(); ++k) std::cout << (k ? ";" : "") << samples[j][k];
                std::cout << '\n';
            }
        }
    }
}
}  // namespace harness

void print_cpu() {
    unsigned r[4]; char brand[49]{};
    if (__get_cpuid_max(0x80000000, nullptr) >= 0x80000004) {
        for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
        std::cout << "# CPU: " << brand << '\n';
    }
    if (__get_cpuid_max(0, nullptr) >= 7) {
        __cpuid_count(7, 0, r[0], r[1], r[2], r[3]);
        std::cout << "# avx2=" << ((r[1] >> 5) & 1) << " avx512f=" << ((r[1] >> 16) & 1) << " avx512ifma=" << ((r[1] >> 21) & 1) << '\n';
    }
    std::cout << "# compiler: " << __VERSION__ << '\n';
}

int main(int argc, char** argv) {
    std::cout << std::fixed << std::setprecision(4);
    std::string cmd = argc > 1 ? argv[1] : "check";
    print_cpu();
    if (cmd == "check") {
        harness::correctness(argc > 2 ? std::atoi(argv[2]) : 20);
        std::cout << "ALL CHECKS PASSED\n";
    } else if (cmd == "time") {
        int max_log = argc > 2 ? std::atoi(argv[2]) : 20, reps = argc > 3 ? std::atoi(argv[3]) : 9;
        int mode = argc > 4 ? std::atoi(argv[4]) : 0, min_log = argc > 5 ? std::atoi(argv[5]) : max_log;
        harness::benchmark(max_log, reps, mode, min_log);
        std::cout << "# checksum " << harness::sink << '\n';
    } else { std::cerr << "usage: bench check|time ...\n"; return 2; }
}
