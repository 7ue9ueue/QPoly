// matrix_product kernel benchmark (QPoly exploration 013).
// Usage: bench [--variants=a,b|all] [--check=full|quick|none] [--sizes=NxMxK,...]
//              [--reps=R] [--warmup=W] [--budget=SECONDS] [--list]
// Correctness: every variant is compared exactly against an independent reference
// (transposed B, unsigned __int128 dot products, one final % P) on small exhaustive
// shapes, random medium shapes, boundary shapes and adversarial value patterns.
// Timing: per size, one verified warm-up call per variant, then R rounds that call
// every variant once in rotated order. Timed: exactly one fn() call (all packing,
// conversion and scratch use inside; scratch memory is already faulted after the
// warm-up). Not timed: input generation, reference, verification.
// Any mismatch makes the process exit with status 1.
#include "common.hpp"

#include <algorithm>
#include <array>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <string>
#include <sys/mman.h>
#include <vector>

namespace mp {
std::vector<Variant>& registry() {
    static std::vector<Variant> r;
    return r;
}
void* scratch(std::size_t bytes, int slot) {
    struct Buf { void* p = nullptr; std::size_t n = 0; };
    static Buf buf[16];
    constexpr std::size_t huge = std::size_t(2) << 20;
    if (slot < 0 || slot >= 16) std::abort();
    Buf& s = buf[slot];
    if (s.n < bytes) {
        if (s.p) munmap(s.p, s.n);
        const std::size_t n = (bytes + huge - 1) & ~(huge - 1);
        char* raw = static_cast<char*>(mmap(nullptr, n + huge, PROT_READ | PROT_WRITE,
                                            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
        if (raw == MAP_FAILED) std::abort();
        char* p = reinterpret_cast<char*>((reinterpret_cast<uintptr_t>(raw) + huge - 1) & ~uintptr_t(huge - 1));
#ifdef MADV_HUGEPAGE
        madvise(p, n, MADV_HUGEPAGE);
#endif
        std::memset(p, 0, n);  // Fault the pages now; timing must not see first touch.
        s.p = p, s.n = n;      // (The raw mapping prefix is leaked; allocation is rare.)
    }
    return s.p;
}
}  // namespace mp

using namespace mp;

namespace {
struct Rng {
    u64 s;
    u64 next() {
        u64 z = (s += 0x9e3779b97f4a7c15ULL);
        z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
        z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
        return z ^ (z >> 31);
    }
    u32 below(u32 n) { return u32((next() >> 32) * n >> 32); }
};

struct AlignedBuf {
    u32* p = nullptr;
    std::size_t n = 0;
    explicit AlignedBuf(std::size_t count) : n(count) {
        p = static_cast<u32*>(std::aligned_alloc(64, ((count * 4 + 63) / 64) * 64 + 64));
        if (!p) std::abort();
    }
    ~AlignedBuf() { std::free(p); }
    AlignedBuf(const AlignedBuf&) = delete;
    AlignedBuf& operator=(const AlignedBuf&) = delete;
};

// Independent reference: transposed B and 128-bit exact dot products.
void reference(int n, int m, int k, const u32* a, const u32* b, u32* c) {
    std::vector<u32> bt(std::size_t(m) * k);
    for (int t = 0; t < m; ++t)
        for (int j = 0; j < k; ++j) bt[std::size_t(j) * m + t] = b[std::size_t(t) * k + j];
    for (int i = 0; i < n; ++i) {
        const u32* ar = a + std::size_t(i) * m;
        for (int j = 0; j < k; ++j) {
            const u32* br = bt.data() + std::size_t(j) * m;
            unsigned __int128 s = 0;
            for (int t = 0; t < m; ++t) s += u64(ar[t]) * br[t];
            c[std::size_t(i) * k + j] = u32(s % P);
        }
    }
}

enum class Pattern { Random, AllMax, AllHalfLow, AllHalfHigh, SignedOverflow, UnsignedOverflow, Zero, Extremes, Small };
const char* pattern_name(Pattern p) {
    switch (p) {
        case Pattern::Random: return "random";
        case Pattern::AllMax: return "all_P-1";
        case Pattern::AllHalfLow: return "all_(P-1)/2";
        case Pattern::AllHalfHigh: return "all_(P+1)/2";
        case Pattern::SignedOverflow: return "all_P/2-1";
        case Pattern::UnsignedOverflow: return "all_P-2";
        case Pattern::Zero: return "zero";
        case Pattern::Extremes: return "extremes";
        case Pattern::Small: return "small_values";
    }
    return "?";
}
void fill(u32* x, std::size_t count, Pattern pat, Rng& rng) {
    static const u32 ext[] = {0, 1, 2, P / 2 - 1, (P - 1) / 2, (P + 1) / 2, P - 2, P - 1};
    for (std::size_t i = 0; i < count; ++i) {
        switch (pat) {
            case Pattern::Random: x[i] = rng.below(P); break;
            case Pattern::AllMax: x[i] = P - 1; break;
            case Pattern::AllHalfLow: x[i] = (P - 1) / 2; break;
            case Pattern::AllHalfHigh: x[i] = (P + 1) / 2; break;
            case Pattern::SignedOverflow: x[i] = P / 2 - 1; break;
            case Pattern::UnsignedOverflow: x[i] = P - 2; break;
            case Pattern::Zero: x[i] = 0; break;
            case Pattern::Extremes: x[i] = ext[rng.below(8)]; break;
            case Pattern::Small: x[i] = rng.below(3); break;
        }
    }
}

struct Options {
    std::vector<std::string> variants;  // empty = all
    std::string check = "full";
    std::vector<std::array<int, 3>> sizes;
    int reps = 11, warmup = 1;
    double budget = 30.0;
    bool list = false;
};

std::vector<std::string> split(const std::string& s, char sep) {
    std::vector<std::string> out;
    std::size_t start = 0;
    while (start <= s.size()) {
        std::size_t e = s.find(sep, start);
        if (e == std::string::npos) e = s.size();
        if (e > start) out.push_back(s.substr(start, e - start));
        start = e + 1;
    }
    return out;
}

double now_ms() {
    return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count();
}

int failures = 0;
long long checked_cases = 0;

bool run_case(const Variant& v, int n, int m, int k, Pattern pa, Pattern pb, u64 seed,
              const u32* a, const u32* b, const u32* ref, u32* c) {
    std::memset(c, 0xA5, std::size_t(n) * k * 4);
    v.fn(n, m, k, a, b, c);
    if (!v.checked) return true;  // diagnostic variant: timing only
    ++checked_cases;
    for (std::size_t i = 0; i < std::size_t(n) * k; ++i) {
        if (c[i] != ref[i]) {
            ++failures;
            std::printf("FAIL %s n=%d m=%d k=%d a=%s b=%s seed=%llu at (%zu,%zu): got %u want %u\n", v.name, n, m, k,
                        pattern_name(pa), pattern_name(pb), (unsigned long long)seed, i / k, i % k, c[i], ref[i]);
            return false;
        }
    }
    return true;
}

void check_shape(const std::vector<const Variant*>& vs, int n, int m, int k, Pattern pa, Pattern pb, u64 seed) {
    Rng rng{seed};
    AlignedBuf a(std::size_t(n) * m), b(std::size_t(m) * k), ref(std::size_t(n) * k), c(std::size_t(n) * k);
    fill(a.p, a.n, pa, rng);
    fill(b.p, b.n, pb, rng);
    reference(n, m, k, a.p, b.p, ref.p);
    for (const Variant* v : vs) run_case(*v, n, m, k, pa, pb, seed, a.p, b.p, ref.p, c.p);
}

void run_checks(const std::vector<const Variant*>& vs, const std::string& mode) {
    const double t0 = now_ms();
    std::vector<int> dims = mode == "full"
        ? std::vector<int>{1, 2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31, 32, 33, 63, 64, 65}
        : std::vector<int>{1, 2, 3, 8, 9, 17, 64, 65};
    u64 seed = 1;
    for (int n : dims)
        for (int m : dims)
            for (int k : dims) check_shape(vs, n, m, k, Pattern::Random, Pattern::Random, seed++);
    Rng shapes{12345};
    const int medium = mode == "full" ? 60 : 12;
    for (int t = 0; t < medium; ++t) {
        int n = 1 + int(shapes.below(300)), m = 1 + int(shapes.below(300)), k = 1 + int(shapes.below(300));
        check_shape(vs, n, m, k, Pattern::Random, Pattern::Random, seed++);
    }
    std::vector<std::array<int, 3>> boundary = {
        {127, 128, 129}, {128, 128, 128}, {129, 127, 128}, {255, 256, 257}, {256, 256, 256},
        {192, 320, 448}, {96, 160, 224}, {1024, 1, 1024}, {1, 1024, 1}, {1, 1024, 1024}, {1024, 1024, 1},
        {600, 900, 570}, {513, 511, 515}};
    if (mode == "full") {
        for (auto s : std::vector<std::array<int, 3>>{{512, 512, 512}, {1024, 1024, 1024}, {1000, 1000, 1000},
                                                        {810, 812, 664}, {709, 746, 788}, {599, 906, 573}, {1023, 1023, 1025 - 2}})
            boundary.push_back(s);
    }
    for (auto s : boundary) check_shape(vs, s[0], s[1], s[2], Pattern::Random, Pattern::Random, seed++);
    // Adversarial values: overflow tests of the official suite and centering boundaries.
    struct VCase { int n, m, k; Pattern pa, pb; };
    std::vector<VCase> vc = {
        {38, 38, 38, Pattern::SignedOverflow, Pattern::SignedOverflow},
        {18, 18, 18, Pattern::UnsignedOverflow, Pattern::UnsignedOverflow},
        {19, 19, 19, Pattern::UnsignedOverflow, Pattern::UnsignedOverflow},
        {128, 256, 64, Pattern::AllMax, Pattern::AllMax},
        {64, 256, 128, Pattern::AllHalfLow, Pattern::AllHalfLow},
        {64, 256, 128, Pattern::AllHalfHigh, Pattern::AllHalfHigh},
        {64, 256, 128, Pattern::AllHalfLow, Pattern::AllHalfHigh},
        {64, 1024, 64, Pattern::AllHalfHigh, Pattern::AllHalfHigh},
        {64, 1024, 64, Pattern::AllHalfLow, Pattern::AllHalfLow},
        {64, 1024, 64, Pattern::AllMax, Pattern::AllMax},
        {100, 1024, 36, Pattern::SignedOverflow, Pattern::SignedOverflow},
        {77, 77, 77, Pattern::Zero, Pattern::Random},
        {200, 300, 100, Pattern::Extremes, Pattern::Extremes},
        {130, 1000, 140, Pattern::Extremes, Pattern::Extremes},
        {128, 128, 128, Pattern::Small, Pattern::Small},
    };
    if (mode == "full") {
        vc.push_back({1024, 1024, 1024, Pattern::AllMax, Pattern::AllMax});
        vc.push_back({1024, 1024, 1024, Pattern::Extremes, Pattern::Extremes});
        vc.push_back({512, 1024, 512, Pattern::AllHalfHigh, Pattern::AllHalfLow});
        vc.push_back({1024, 1024, 1024, Pattern::SignedOverflow, Pattern::SignedOverflow});
    }
    for (auto& c : vc) check_shape(vs, c.n, c.m, c.k, c.pa, c.pb, seed++);
    // Repeated calls with different shapes must not depend on stale scratch contents.
    for (int rep = 0; rep < 3; ++rep) {
        check_shape(vs, 300, 200, 100, Pattern::Random, Pattern::Random, seed++);
        check_shape(vs, 20, 30, 40, Pattern::Extremes, Pattern::Random, seed++);
        check_shape(vs, 256, 256, 256, Pattern::Random, Pattern::Extremes, seed++);
    }
    std::printf("check mode=%s variants=%zu calls=%lld failures=%d time_s=%.1f\n", mode.c_str(), vs.size(),
                checked_cases, failures, (now_ms() - t0) / 1000);
}

void run_timing(const std::vector<const Variant*>& vs, const Options& opt) {
    std::printf("timing: reps=%d warmup=%d budget_s=%.1f\n", opt.reps, opt.warmup, opt.budget);
    std::printf("CSV,size,variant,rep,ms\n");
    struct Row { std::string size, name; double med, lo, hi, gmacs; int count; };
    std::vector<Row> rows;
    u64 seed = 777;
    for (auto s : opt.sizes) {
        const int n = s[0], m = s[1], k = s[2];
        Rng rng{seed++};
        AlignedBuf a(std::size_t(n) * m), b(std::size_t(m) * k), ref(std::size_t(n) * k), c(std::size_t(n) * k);
        fill(a.p, a.n, Pattern::Random, rng);
        fill(b.p, b.n, Pattern::Random, rng);
        reference(n, m, k, a.p, b.p, ref.p);
        char label[64];
        std::snprintf(label, sizeof label, "%dx%dx%d", n, m, k);
        std::vector<int> reps(vs.size(), opt.reps);
        std::vector<std::vector<double>> samples(vs.size());
        for (std::size_t vi = 0; vi < vs.size(); ++vi) {
            double first = 0;
            for (int w = 0; w < std::max(1, opt.warmup); ++w) {
                const double t0 = now_ms();
                if (!run_case(*vs[vi], n, m, k, Pattern::Random, Pattern::Random, seed, a.p, b.p, ref.p, c.p))
                    reps[vi] = 0;
                if (w == 0) first = now_ms() - t0;
            }
            if (reps[vi] && first * opt.reps > opt.budget * 1000)
                reps[vi] = std::max(1, int(opt.budget * 1000 / std::max(first, 1e-3)));
        }
        const int rounds = *std::max_element(reps.begin(), reps.end());
        for (int r = 0; r < rounds; ++r) {
            for (std::size_t t = 0; t < vs.size(); ++t) {
                const std::size_t vi = (t + std::size_t(r)) % vs.size();
                if (r >= reps[vi]) continue;
                const double t0 = now_ms();
                vs[vi]->fn(n, m, k, a.p, b.p, c.p);
                const double dt = now_ms() - t0;
                samples[vi].push_back(dt);
                std::printf("CSV,%s,%s,%d,%.4f\n", label, vs[vi]->name, r, dt);
            }
        }
        // The last timed output of each variant is verified again.
        for (std::size_t vi = 0; vi < vs.size(); ++vi) {
            if (!reps[vi]) continue;
            run_case(*vs[vi], n, m, k, Pattern::Random, Pattern::Random, seed, a.p, b.p, ref.p, c.p);
            auto x = samples[vi];
            std::sort(x.begin(), x.end());
            const double med = x.size() % 2 ? x[x.size() / 2] : (x[x.size() / 2 - 1] + x[x.size() / 2]) / 2;
            rows.push_back({label, vs[vi]->name, med, x.front(), x.back(), double(n) * m * k / med / 1e6, int(x.size())});
        }
    }
    std::printf("\n| size | variant | median ms | min | max | n | GMAC/s |\n|---|---|---:|---:|---:|---:|---:|\n");
    for (auto& r : rows)
        std::printf("| %s | %s | %.3f | %.3f | %.3f | %d | %.2f |\n", r.size.c_str(), r.name.c_str(), r.med, r.lo, r.hi,
                    r.count, r.gmacs);
}
}  // namespace

int main(int argc, char** argv) {
    Options opt;
    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        auto val = [&](const char* key) -> const char* {
            const std::size_t l = std::strlen(key);
            return a.compare(0, l, key) == 0 ? a.c_str() + l : nullptr;
        };
        if (auto v = val("--variants=")) { if (std::string(v) != "all") opt.variants = split(v, ','); }
        else if (auto v = val("--check=")) opt.check = v;
        else if (auto v = val("--reps=")) opt.reps = std::atoi(v);
        else if (auto v = val("--warmup=")) opt.warmup = std::atoi(v);
        else if (auto v = val("--budget=")) opt.budget = std::atof(v);
        else if (auto v = val("--sizes=")) {
            for (auto& s : split(v, ',')) {
                auto d = split(s, 'x');
                if (d.size() != 3) { std::fprintf(stderr, "bad size %s\n", s.c_str()); return 2; }
                opt.sizes.push_back({std::atoi(d[0].c_str()), std::atoi(d[1].c_str()), std::atoi(d[2].c_str())});
            }
        } else if (a == "--list") opt.list = true;
        else { std::fprintf(stderr, "unknown option %s\n", a.c_str()); return 2; }
    }
    auto& reg = registry();
    std::sort(reg.begin(), reg.end(), [](const Variant& x, const Variant& y) { return std::strcmp(x.name, y.name) < 0; });
    std::vector<const Variant*> vs;
    if (opt.variants.empty()) for (auto& v : reg) vs.push_back(&v);
    else for (auto& name : opt.variants) {
        auto it = std::find_if(reg.begin(), reg.end(), [&](const Variant& v) { return name == v.name; });
        if (it == reg.end()) { std::fprintf(stderr, "unknown variant %s\n", name.c_str()); return 2; }
        vs.push_back(&*it);
    }
    if (opt.list) {
        for (auto& v : reg) std::printf("%s\t%s%s\n", v.name, v.checked ? "" : "[diagnostic, unchecked] ", v.note);
        return 0;
    }
    std::printf("compiler: %s\n", __VERSION__);
#ifdef MP_FLAGS
    std::printf("flags: %s\n", MP_FLAGS);
#endif
    std::printf("variants:");
    for (auto* v : vs) std::printf(" %s", v->name);
    std::printf("\n");
    if (opt.check != "none") {
        std::vector<const Variant*> cv;
        for (auto* v : vs) if (v->checked) cv.push_back(v);
        run_checks(cv, opt.check);
    }
    if (!opt.sizes.empty()) run_timing(vs, opt);
    if (failures) std::printf("RESULT: FAIL (%d mismatches)\n", failures);
    else std::printf("RESULT: PASS\n");
    return failures ? 1 : 0;
}
