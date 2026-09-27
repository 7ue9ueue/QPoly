// Exploration 010 correctness and timing driver for large cyclic convolutions.
//
//   bench_large check [max_lg]      correctness through 2^max_lg (default 25); exit 1 on failure
//   bench_large time lg reps [full]  timing CSV at n = 2^lg; inputs have N = M = n/2 random
//                                    canonical values (ordinary convolution, the judge's max case);
//                                    "full" uses full-length inputs (cyclic, general path)
//   bench_large phases lg reps       per-phase medians (top forward / rows / top inverse)
// Env ONLY=a,b,c restricts and orders entries (the first is the speedup baseline).
//
// Timing boundary: one call of the entry (root tables generated inside, as a
// submission does); input copies, zeroing of padding halves and checksums are outside.
// Arrays and tables are pre-faulted 2 MiB-aligned mappings (THP hint on Linux).
//
// Oracles: (1) independent textbook radix-2 NTT with bit reversal and % (lg <= 20),
// (2) brute force (lg <= 10), (3) for lg >= 21, entry "b0" (the unchanged exploration
// 009 arithmetic with its own recursion) is verified by evaluating a, b and the product
// at 8 random points of F_P (Schwartz-Zippel: a wrong product passes with probability
// <= (n/P)^8 < 2e-12), and every other entry must equal b0 exactly. Cyclic results at
// lg <= 25 are checked against the folded linear product at lg+1.
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "large.hpp"
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <iomanip>
#include <random>
#include <sstream>
#include <string>
#include <vector>
#include <cpuid.h>
#include <sys/mman.h>

namespace bench {
using U = uint32_t;
using A = std::vector<U>;
constexpr U P = 998244353;
constexpr int MAX_LG = 26;

// ---- memory -------------------------------------------------------------------------
void* arena(size_t bytes) {
    constexpr size_t huge = size_t(2) << 20;
    bytes = (bytes + huge - 1) & ~(huge - 1);
    char* raw = (char*)mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (raw == MAP_FAILED) { std::perror("mmap"); std::exit(3); }
    char* p = (char*)(((uintptr_t)raw + huge - 1) & ~uintptr_t(huge - 1));
#ifdef MADV_HUGEPAGE
    madvise(p, bytes, MADV_HUGEPAGE);
#endif
    for (size_t i = 0; i < bytes; i += 4096) ((volatile char*)p)[i] = 0;
    return p;
}
struct Work {
    qlarge::Tables T;
    __m256i* buf;   // top-pass panels: 2 * R * w vectors (+ padding)
    Work() {
        T.r = (U*)arena(qlarge::table_words(MAX_LG) * 4);
        T.ir = (U*)arena(qlarge::table_words(MAX_LG) * 4);
        buf = (__m256i*)arena(size_t(1) << 22);
    }
};
Work& work() { static Work w; return w; }

// ---- entries --------------------------------------------------------------------------
using Fn = void (*)(int lg, U* a, U* b, long nza, long nzb);
struct Entry { const char* name; Fn fn; bool shortcut = true; };   // shortcut: never reads above nz <= n/2
using D = qlarge::Drivers<qlarge::Sel>;
template<bool Z, bool S = false, bool N = false> void e_b0(int lg, U* a, U* b, long nza, long nzb) { D::run_b0(lg, a, b, work().T, nza, nzb, Z, S, N); }
// Round 4: 1024-vector tiles; and b0zs with root tables kept from the previous call (tables
// are only rebuilt when the size grows), bounding what on-the-fly twiddles could save.
void e_b0zs_t1024(int lg, U* a, U* b, long nza, long nzb) { qlarge::Drivers<qlarge::Sel1024>::run_b0(lg, a, b, work().T, nza, nzb, true, true); }
void e_b0zs_keep(int lg, U* a, U* b, long nza, long nzb) {
    qlarge::fresh_tables = false; D::run_b0(lg, a, b, work().T, nza, nzb, true, true); qlarge::fresh_tables = true;
}
template<int L, int Wd, int Dist, bool Nt, bool Pair = true>
void e_top(int lg, U* a, U* b, long nza, long nzb) {
    const int nv = (1 << lg) / 8, lgv = __builtin_ctz(unsigned(nv)), odd = lgv & 1;
    int l = L; while (l > 1 && lgv - odd - 2 * l < 2) --l;   // rows must keep >= 4 vectors
    if (lgv - odd - 2 * l < 2 || lg < 9) { D::run_b0(lg, a, b, work().T, nza, nzb, true); return; }
    D::TopOpt o; o.w = Wd; o.dist = Dist; o.nt = Nt; o.pair = Pair;
    D::run_top(lg, a, b, work().T, nza, nzb, l, o, work().buf);
}
#define TOP(L, W, DI) {"t" #L "w" #W "d" #DI, e_top<L, W, DI, false>}
#define TOPNT(L, W, DI) {"t" #L "w" #W "d" #DI "nt", e_top<L, W, DI, true>}
#define TOPS(L, W, DI) {"t" #L "w" #W "d" #DI "s", e_top<L, W, DI, false, false>}
// Round 1 entries (kept for reference): TOP(2,2,4) TOPNT(2,2,4) TOP(3,2,4) TOPNT(3,2,4)
// TOP(4,2,4) TOPNT(4,2,4) TOPNT(5,2,4) TOPNT(3,4,2) TOPNT(4,4,2).
void e_final(int lg, U* a, U* b, long nza, long nzb) { qlarge::Core<qlarge::Sel>::run(lg, a, b, work().T, nza, nzb); }
// Exploration-009 runner-up assembly selections (its round-10 entries), rechecked at 2^25:
// forward loop F (h >= 16), h=4 forward F4, inverse I, fused bottom B, identity Id, scale Sc.
template<int F, int F4, int I, int B, int Id, int Sc>
void e_core(int lg, U* a, U* b, long nza, long nzb) {
    using C = qasm::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, F, I, 0, 4, B, 0, Id, Sc, F4>;
    qlarge::Core<C>::run(lg, a, b, work().T, nza, nzb);
}
#define CORE(F, F4, I, B, Id, Sc) {"c_f" #F "i" #I "b" #B "id" #Id, e_core<F, F4, I, B, Id, Sc>}
const Entry ENTRIES[] = {
    {"final", e_final}, {"b0zs", e_b0<true, true>},
    CORE(265, 104, 71, 23, 2, 2), CORE(11, 104, 282, 23, 2, 2), CORE(11, 104, 71, 67, 2, 2), CORE(11, 104, 71, 23, 4, 4), {"b0", e_b0<false>, false}, {"b0zs_t1024", e_b0zs_t1024}, {"b0zs_keep", e_b0zs_keep},
};
// Round 3 entries (run 36313058400): {"b0z", e_b0<true>}, {"b0zsn", e_b0<true, true, true>} (NT top,
// +14 ms), TOP(2, 8, 1), TOP(3, 32, 1), TOP(4, 16, 1).
// Round 2 entries (run 36312561197): TOP(2,32,1) TOP(2,64,1) TOP(3,8,1) TOP(3,16,1) TOP(4,4,1)
// TOP(4,8,1) TOPS(3,16,1) TOPS(4,16,1) TOPS(5,8,1) TOP(2,2,4) -- all slower than b0zs.

std::vector<Entry> selected() {
    std::vector<Entry> all(std::begin(ENTRIES), std::end(ENTRIES)), out;
    const char* env = std::getenv("ONLY");
    if (!env || !*env) return all;
    std::stringstream ss(env); std::string name;
    while (std::getline(ss, name, ',')) {
        auto it = std::find_if(all.begin(), all.end(), [&](const Entry& e) { return name == e.name; });
        if (it == all.end()) { std::cerr << "unknown entry " << name << '\n'; std::exit(2); }
        out.push_back(*it);
    }
    return out;
}

// ---- oracles --------------------------------------------------------------------------
U power(U a, U e) { U r = 1; for (; e; e >>= 1, a = uint64_t(a) * a % P) if (e & 1) r = uint64_t(r) * a % P; return r; }
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
// Horner evaluation at 8 points (independent chains for throughput).
void eval8(const U* f, size_t len, const U* r, U* out) {
    uint64_t acc[8] = {};
    for (size_t i = len; i-- > 0;) for (int k = 0; k < 8; ++k) acc[k] = (acc[k] * r[k] + f[i]) % P;
    for (int k = 0; k < 8; ++k) out[k] = U(acc[k]);
}
[[noreturn]] void fail(const std::string& what) { std::cout << "FAIL " << what << std::endl; std::exit(1); }

// ---- arrays ---------------------------------------------------------------------------
struct Arr {
    U* p; size_t n;
    explicit Arr(int lg) : p((U*)arena((size_t(1) << lg) * 4 + 256)), n(size_t(1) << lg) {}
    void guard() { for (int i = 0; i < 16; ++i) p[n + i] = 0xdeadbeef; }
    bool intact() const { for (int i = 0; i < 16; ++i) if (p[n + i] != 0xdeadbeef) return false; return true; }
};
Arr& arr(int which) { static Arr x(MAX_LG), y(MAX_LG); return which ? y : x; }

// Runs entry e on (x, y) padded to n = 2^lg; nz = number of leading inputs (rest zero).
const U* run(const Entry& e, int lg, const A& x, const A& y, bool garbage_upper) {
    Arr &a = arr(0), &b = arr(1);
    const size_t n = size_t(1) << lg;
    a.n = b.n = n;
    std::copy(x.begin(), x.end(), a.p); std::copy(y.begin(), y.end(), b.p);
    // [nz, n) is zero; when nz <= n/2 entries must not read [n/2, n): poison it to prove it.
    std::fill(a.p + x.size(), a.p + n, 0); std::fill(b.p + y.size(), b.p + n, 0);
    if (garbage_upper && x.size() <= n / 2) std::fill(a.p + n / 2, a.p + n, 0xfffffff0u);
    if (garbage_upper && y.size() <= n / 2) std::fill(b.p + n / 2, b.p + n, 0xfffffff0u);
    a.guard(); b.guard();
    e.fn(lg, a.p, b.p, long(x.size()), long(y.size()));
    if (!a.intact() || !b.intact()) fail(std::string(e.name) + " wrote past the end at lg=" + std::to_string(lg));
    return a.p;
}

void correctness(int max_lg) {
    auto entries = selected();
    std::mt19937 rng(20260927);
    auto rnd = [&](size_t len) { A v(len); for (U& t : v) t = rng() % P; return v; };
    for (int lg = 9; lg <= std::min(max_lg, 20); ++lg) {
        const size_t n = size_t(1) << lg;
        for (int pattern = 0; pattern < 6; ++pattern) {
            A x = rnd(n), y = rnd(n);
            if (pattern == 1) std::fill(x.begin(), x.end(), P - 1), std::fill(y.begin(), y.end(), P - 1);
            if (pattern == 2) { x.resize(n / 2); y.resize(n / 2); }               // ordinary convolution
            if (pattern == 3) { x.resize(n / 2); }                                 // one zero-upper input
            if (pattern == 4) { y.resize(n / 2 - 5); x.resize(n / 2); for (U& t : x) t = P - 1; }
            if (pattern == 5) { x.resize(3); }                                     // tiny factor
            A xf = x, yf = y; xf.resize(n); yf.resize(n);
            A want = reference(xf, yf);
            if (lg <= 10 && want != brute(xf, yf)) fail("oracle vs brute");
            for (const Entry& e : entries) {
                for (int garbage = 0; garbage < (e.shortcut ? 2 : 1); ++garbage) {
                    const U* got = run(e, lg, x, y, garbage);
                    for (size_t i = 0; i < n; ++i) if (got[i] != want[i])
                        fail(std::string(e.name) + " lg=" + std::to_string(lg) + " pattern=" + std::to_string(pattern) + " index=" + std::to_string(i));
                }
            }
        }
        std::cout << "PASS 2^" << lg << " (textbook oracle, 6 patterns, all entries)" << std::endl;
    }
    // Large sizes: b0 verified at random points, others equal to b0 exactly.
    for (int lg = 21; lg <= max_lg; ++lg) {
        const size_t n = size_t(1) << lg;
        for (int pattern = 0; pattern < 3; ++pattern) {
            A x = rnd(n / 2), y = rnd(n / 2);
            if (pattern == 1) { std::fill(x.begin(), x.end(), P - 1); std::fill(y.begin(), y.end(), P - 1); }
            if (pattern == 2) { y.resize(1000); }   // small_and_large shape
            const U* got = run(Entry{"b0", e_b0<false>, false}, lg, x, y, false);
            A want(got, got + n);
            U r[8], va[8], vb[8], vc[8];
            for (U& t : r) t = rng() % P;
            eval8(x.data(), x.size(), r, va); eval8(y.data(), y.size(), r, vb); eval8(want.data(), n, r, vc);
            for (int k = 0; k < 8; ++k) if (uint64_t(va[k]) * vb[k] % P != vc[k]) fail("b0 random-point check lg=" + std::to_string(lg));
            for (const Entry& e : entries) for (int garbage = 0; garbage < (e.shortcut ? 2 : 1); ++garbage) {
                const U* g2 = run(e, lg, x, y, garbage);
                for (size_t i = 0; i < n; ++i) if (g2[i] != want[i])
                    fail(std::string(e.name) + " vs b0 lg=" + std::to_string(lg) + " pattern=" + std::to_string(pattern) + " index=" + std::to_string(i));
            }
        }
        std::cout << "PASS 2^" << lg << " linear (b0 at 8 random points, all entries equal b0)" << std::endl;
        if (lg + 1 <= std::min(max_lg + 1, MAX_LG)) {   // cyclic with full-length inputs
            A x = rnd(n), y = rnd(n);
            const U* lin = run(Entry{"b0", e_b0<false>, false}, lg + 1, x, y, false);
            A linv(lin, lin + 2 * n);
            U r[8], va[8], vb[8], vc[8];
            for (U& t : r) t = rng() % P;
            eval8(x.data(), n, r, va); eval8(y.data(), n, r, vb); eval8(linv.data(), 2 * n, r, vc);
            for (int k = 0; k < 8; ++k) if (uint64_t(va[k]) * vb[k] % P != vc[k]) fail("b0 linear lg+1 random-point check lg=" + std::to_string(lg));
            A want(n); for (size_t i = 0; i < n; ++i) want[i] = U((linv[i] + linv[i + n]) % P);
            for (const Entry& e : entries) {
                const U* g2 = run(e, lg, x, y, false);
                for (size_t i = 0; i < n; ++i) if (g2[i] != want[i])
                    fail(std::string(e.name) + " cyclic lg=" + std::to_string(lg) + " index=" + std::to_string(i));
            }
            std::cout << "PASS 2^" << lg << " cyclic (full inputs vs folded verified linear product)" << std::endl;
        }
    }
}

// ---- timing ---------------------------------------------------------------------------
double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
double phase_t[8]; int phase_seen = 0;
void hook(int p) { phase_t[p] = now_ms(); phase_seen |= 1 << p; }
double median(std::vector<double> s) { std::sort(s.begin(), s.end()); return (s[(s.size() - 1) / 2] + s[s.size() / 2]) / 2; }

void timing(int lg, int reps, bool full, bool phases) {
    auto entries = selected();
    const int count = int(entries.size());
    const size_t n = size_t(1) << lg, len = full ? n : n / 2;
    std::mt19937 rng(42);
    A x(len), y(len); for (U& t : x) t = rng() % P; for (U& t : y) t = rng() % P;
    Arr &a = arr(0), &b = arr(1);
    std::vector<std::vector<double>> samples(count);
    std::vector<std::vector<std::array<double, 3>>> ph(count);
    uint64_t expected = 0; bool have = false;
    if (phases) { qlarge::phase_hook = hook; qlarge::depth_clock = now_ms; }
    std::vector<std::array<double, 16>> depth_sum(count);
    std::vector<int> depth_runs(count);
    for (int rep = -2; rep < reps; ++rep) for (int pos = 0; pos < count; ++pos) {
        int j = (pos + rep + 2) % count; if (rep & 1) j = count - 1 - j;
        const Entry& e = entries[j];
        std::copy(x.begin(), x.end(), a.p); std::copy(y.begin(), y.end(), b.p);
        std::fill(a.p + len, a.p + n, 0); std::fill(b.p + len, b.p + n, 0);
        phase_seen = 0;
        std::memset(qlarge::depth_ms, 0, sizeof qlarge::depth_ms);
        const double t0 = now_ms();
        e.fn(lg, a.p, b.p, long(len), long(len));
        const double t1 = now_ms();
        if (phases && rep >= 0) { for (int q = 0; q < 16; ++q) depth_sum[j][q] += qlarge::depth_ms[q / 8][q % 8]; ++depth_runs[j]; }
        uint64_t h = 0; for (size_t i = 0; i < n; ++i) h = h * 31 + a.p[i];
        if (have && h != expected) fail(std::string("checksum mismatch ") + e.name);
        expected = h; have = true;
        if (rep >= 0) {
            samples[j].push_back(t1 - t0);
            if (phases && phase_seen == 15) ph[j].push_back({phase_t[1] - phase_t[0], phase_t[2] - phase_t[1], phase_t[3] - phase_t[2]});
        }
    }
    qlarge::phase_hook = nullptr;
    const double base = median(samples[0]);
    for (int j = 0; j < count; ++j) {
        auto s = samples[j]; std::sort(s.begin(), s.end());
        std::cout << (full ? "full" : "half") << ',' << lg << ',' << entries[j].name << ',' << median(samples[j]) << ',' << s.front() << ',' << s.back()
                  << ',' << base / median(samples[j]) << ',';
        for (size_t k = 0; k < samples[j].size(); ++k) std::cout << (k ? ";" : "") << samples[j][k];
        if (phases && !ph[j].empty()) {
            for (int q = 0; q < 3; ++q) { std::vector<double> v; for (auto& t : ph[j]) v.push_back(t[q]); std::cout << ",phase" << q << '=' << median(v); }
            if (depth_runs[j]) for (int q = 0; q < 16; ++q) if (depth_sum[j][q] > 0)
                std::cout << (q < 8 ? ",fwd_d" : ",inv_d") << (q % 8) << '=' << depth_sum[j][q] / depth_runs[j];
        }
        std::cout << '\n';
    }
    std::cout << "# checksum " << expected << std::endl;
}
}  // namespace bench

void print_cpu() {
    unsigned r[4]; char brand[49]{};
    if (__get_cpuid_max(0x80000000, nullptr) >= 0x80000004) {
        for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
        std::cout << "# CPU: " << brand << '\n';
    }
    std::cout << "# compiler: " << __VERSION__ << '\n';
}

int main(int argc, char** argv) {
    std::cout << std::fixed << std::setprecision(4);
    std::string cmd = argc > 1 ? argv[1] : "check";
    print_cpu();
    if (cmd == "check") {
        bench::correctness(argc > 2 ? std::atoi(argv[2]) : 25);
        std::cout << "ALL CHECKS PASSED" << std::endl;
    } else if (cmd == "time" || cmd == "phases") {
        const int lg = argc > 2 ? std::atoi(argv[2]) : 25, reps = argc > 3 ? std::atoi(argv[3]) : 7;
        const bool full = argc > 4 && std::string(argv[4]) == "full";
        std::cout << "shape,lg,entry,median_ms,min_ms,max_ms,speedup_vs_first,samples\n";
        bench::timing(lg, reps, full, cmd == "phases");
    } else { std::cerr << "usage: bench_large check|time|phases ...\n"; return 2; }
}
