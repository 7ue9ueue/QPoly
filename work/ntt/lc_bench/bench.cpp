// Speed comparison: KACTL, simd-v0, QgQ 393435 and our 406478 kernel.
// usage: bench [MIN_LG MAX_LG [RAW_CSV]]   (default 10 22; sizes n = 2^lg, lg <= 22)
//
// Workload: cyclic convolution mod 998244353 of two random length-n sequences.
// Timed region: one run() call (see impl.hpp); input copies, allocation and result
// checks are outside the timer. Each size: two untimed warmup rounds, then R rounds;
// every round calls each implementation once, in an order rotated by one per round.
// R is chosen from the warmup so a size takes ~1.5 s (at least 11, at most 1001).
// Reported: median ms; spread = interquartile range / median of the worst implementation.
// Correctness: every call's output is compared with a reference (brute force for
// n <= 2^11, KACTL above, KACTL itself brute-force checked); additional all-(P-1) and
// sparse inputs at every size. Any mismatch prints FAIL and exits with status 1.
#include <algorithm>
#include <chrono>
#include <cpuid.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#include <string>
#include <vector>
#include "impl.hpp"

using lcb::u32;
constexpr int N_IMPL = 4;
const lcb::Impl* const IMPLS[N_IMPL] = {&lcb::kactl, &lcb::simd_v0, &lcb::qgq_393435, &lcb::ours_406478};
constexpr int KACTL = 0, V0 = 1, QGQ = 2, OURS = 3;
int failures = 0;

double now_ms() {
    return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count();
}

std::string cpu_name() {
    unsigned r[4];
    char brand[49] = {};
    if (__get_cpuid_max(0x80000000, nullptr) < 0x80000004) return "unknown CPU";
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    std::string s(brand);
    s.erase(0, s.find_first_not_of(' '));
    s.erase(s.find_last_not_of(' ') + 1);
    return s;
}

std::vector<u32> brute(const std::vector<u32>& x, const std::vector<u32>& y) {
    const size_t n = x.size();
    std::vector<unsigned long long> c(n);
    for (size_t i = 0; i < n; ++i)
        for (size_t j = 0; j < n; ++j) c[(i + j) & (n - 1)] = (c[(i + j) & (n - 1)] + (unsigned long long)x[i] * y[j]) % lcb::P;
    return std::vector<u32>(c.begin(), c.end());
}

// Runs `impl` once on x*y and compares with ref; returns the run() time in ms.
double call(int impl, const std::vector<u32>& x, const std::vector<u32>& y, const std::vector<u32>& ref, const char* what) {
    const lcb::Impl& m = *IMPLS[impl];
    const int n = int(x.size());
    m.load(x.data(), y.data(), n);
    const double t0 = now_ms();
    m.run(n);
    const double t = now_ms() - t0;
    if (std::memcmp(m.result(), ref.data(), size_t(n) * 4) != 0) {
        if (++failures <= 20) std::printf("FAIL %s n=%d input=%s\n", m.name, n, what);
    }
    return t;
}

std::vector<u32> reference(const std::vector<u32>& x, const std::vector<u32>& y) {
    if (x.size() <= 2048) return brute(x, y);
    IMPLS[KACTL]->load(x.data(), y.data(), int(x.size()));
    IMPLS[KACTL]->run(int(x.size()));
    return std::vector<u32>(IMPLS[KACTL]->result(), IMPLS[KACTL]->result() + x.size());
}

// All implementations on boundary and sparse inputs, every size from 2^7.
void check_patterns(int max_lg, std::mt19937& rng) {
    for (int lg = 7; lg <= max_lg; ++lg) {
        const size_t n = size_t(1) << lg;
        std::vector<u32> full(n, lcb::P - 1), sparse(n, 0), rnd(n);
        for (int k = 0; k < 5; ++k) sparse[rng() % n] = rng() % lcb::P;
        sparse[0] = 1; sparse[n - 1] = lcb::P - 1;
        for (auto& v : rnd) v = rng() % lcb::P;
        const std::vector<u32>* cases[][2] = {{&full, &full}, {&sparse, &rnd}, {&rnd, &sparse}};
        const char* names[] = {"all P-1", "sparse*random", "random*sparse"};
        for (int c = 0; c < 3; ++c) {
            const auto ref = reference(*cases[c][0], *cases[c][1]);
            for (int m = 0; m < N_IMPL; ++m) call(m, *cases[c][0], *cases[c][1], ref, names[c]);
        }
    }
}

struct Row { int lg, reps; double med[N_IMPL], spread; };

Row measure(int lg, std::mt19937& rng, FILE* csv) {
    const size_t n = size_t(1) << lg;
    std::vector<u32> x(n), y(n);
    for (auto& v : x) v = rng() % lcb::P;
    for (auto& v : y) v = rng() % lcb::P;
    const auto ref = reference(x, y);
    double warm = 0;
    for (int w = 0; w < 2; ++w) {
        warm = 0;
        for (int m = 0; m < N_IMPL; ++m) warm += call(m, x, y, ref, "random (warmup)");
    }
    const int reps = std::clamp(int(1500.0 / warm), 11, 1001);
    std::vector<double> t[N_IMPL];
    for (int r = 0; r < reps; ++r)
        for (int k = 0; k < N_IMPL; ++k) {
            const int m = (r + k) % N_IMPL;
            t[m].push_back(call(m, x, y, ref, "random"));
            if (csv) std::fprintf(csv, "%d,%s,%d,%.6f\n", lg, IMPLS[m]->name, r, t[m].back());
        }
    Row row{lg, reps, {}, 0};
    for (int m = 0; m < N_IMPL; ++m) {
        std::sort(t[m].begin(), t[m].end());
        auto q = [&](double f) { return t[m][size_t(f * (reps - 1) + 0.5)]; };
        row.med[m] = reps % 2 ? t[m][reps / 2] : (t[m][reps / 2 - 1] + t[m][reps / 2]) / 2;
        row.spread = std::max(row.spread, (q(0.75) - q(0.25)) / row.med[m]);
    }
    return row;
}

int main(int argc, char** argv) {
    const int min_lg = argc > 2 ? std::atoi(argv[1]) : 10, max_lg = argc > 2 ? std::atoi(argv[2]) : 22;
    if (min_lg < 7 || max_lg > 22 || min_lg > max_lg) { std::fprintf(stderr, "sizes: 7 <= MIN_LG <= MAX_LG <= 22\n"); return 2; }
    FILE* csv = argc > 3 ? std::fopen(argv[3], "w") : nullptr;
    if (csv) std::fprintf(csv, "lg,impl,rep,ms\n");
    const double start = now_ms();
    for (auto* m : IMPLS) m->init(1 << 22);
    std::mt19937 rng(20260927);

    check_patterns(max_lg, rng);
    std::vector<Row> rows;
    for (int lg = min_lg; lg <= max_lg; ++lg) rows.push_back(measure(lg, rng, csv));
    if (csv) std::fclose(csv);

    std::printf("## Cyclic convolution mod 998244353: median time per call\n\n");
    #ifdef __clang__
    const char* compiler = "Clang";
#else
    const char* compiler = "GCC";
#endif
    std::printf("CPU: %s  \nCompiler: %s %s", cpu_name().c_str(), compiler, __VERSION__);
#ifdef LCB_FLAGS
    std::printf(", flags `%s`", LCB_FLAGS);
#endif
    std::printf("  \nImplementations: KACTL (reference), simd-v0 (the user's first AVX2 NTT), "
                "393435 (QgQ, fastest other Library Checker submission), ours (exploration 009 kernel, submission 406478)\n\n");
    std::printf("| n | KACTL ms | simd-v0 ms | 393435 ms | ours ms | ours vs KACTL | ours vs simd-v0 | ours vs 393435 | 393435 vs KACTL | reps | spread |\n");
    std::printf("|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|\n");
    for (const Row& r : rows) {
        std::printf("| 2^%d |", r.lg);
        for (int m = 0; m < N_IMPL; ++m) std::printf(" %.4f |", r.med[m]);
        std::printf(" %.2fx | %.2fx | %.2fx | %.2fx | %d | %.1f%% |\n", r.med[KACTL] / r.med[OURS], r.med[V0] / r.med[OURS],
                    r.med[QGQ] / r.med[OURS], r.med[KACTL] / r.med[QGQ], r.reps, 100 * r.spread);
    }
    std::printf("\n\"A vs B\" = B's median time / A's median time (above 1.00x: A is faster). "
                "spread = largest interquartile range / median among the four in that row.\n\n");
    std::printf("Correctness: every timed call checked (brute force n <= 2^11, KACTL above); "
                "all-(P-1) and sparse inputs at 2^7..2^%d: %s (%d mismatches). Total %.1f s.\n",
                max_lg, failures ? "FAIL" : "PASS", failures, (now_ms() - start) / 1000);
    return failures ? 1 : 0;
}
