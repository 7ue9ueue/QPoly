// Per-phase microbenchmark for the qflip kernel on L1-resident data.
// Reports core cycles per unit, calibrated with a dependent-add chain (1 cycle/add).
// usage: micro [iterations-scale]
#include <immintrin.h>
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#include <vector>
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "kernels/flip.hpp"

using namespace qflip;
using Best = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true>;   // s_ns_olb
using MontFlip = Cfg<0, true, true, 0, false, 256, true, false, true>;       // f_fp_nml
using BestPipe = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true>;

static double now_ns() { return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static double cycle_ns() {   // dependent integer adds: one per cycle
    uint64_t x = 1; const long n = 200000000; double t = now_ns();
    for (long i = 0; i < n; i += 8) asm volatile("add %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0" : "+r"(x));
    return (now_ns() - t) / n;
}
alignas(64) static uint32_t A[256 * 8 + 64], B[256 * 8 + 64], T[1 << 14], IT[1 << 14];

template<class C> struct Probe : Kernel<C> {
    using Kernel<C>::Kernel;
    void leaves_all(V* a, V* b) { this->leaf_cursor = ONE; this->leaves(a, b, 256, 256); }
    void tile(V* a, V* b) { this->leaf_cursor = ONE; this->template fixed_tile<256>(a, b, 1); }
};

template<class C> void run(const char* name, double cyc, long scale) {
    std::mt19937 rng(1);
    for (auto& x : A) x = rng() % P; for (auto& x : B) x = rng() % P;
    int size = 0; Kernel<C>::tables(1 << 12, T, IT, size, true);
    Probe<C> k(T, IT);
    V *a = (V*)A, *b = (V*)B;
    const Twiddle tw = k.template twiddle<false>(37), itw = k.template twiddle<true>(37);
    auto bench = [&](const char* what, double units, auto&& f) {
        long reps = 2000 * scale; f(); double t = now_ns();
        for (long r = 0; r < reps; ++r) { f(); asm volatile("" ::: "memory"); }
        double ns = (now_ns() - t) / reps / units;
        std::printf("%-10s %-20s %8.2f cycles/unit (%.3f ns)\n", name, what, ns / cyc, ns);
    };
    bench("empty", 1, [] {});
    bench("fwd4 per butterfly", 64, [&] { fwd4<C, false>(a, 64, tw); });            // 64 butterflies
    bench("inv4 per butterfly", 64, [&] { inv4<C, false>(a, 64, itw); });
    alignas(16) U w[4] = {ONE, P - ONE, ONE, P - ONE}, wi[4];
    for (int t = 0; t < 4; ++t) wi[t] = w[t] * NI;
    bench("leaf4 per vector", 256, [&] { for (int j = 0; j < 256; j += 4) leaf4<C>(a + j, b + j, w, wi); });   // per vector
    LeafBuf L[2];
    bench("leaf pipelined", 256, [&] {   // build batch j+1 before MAC of batch j
        leaf_build<C>(a, b, w, wi, L[0]);
        for (int j = 0; j < 256; j += 4) {
            if (j + 4 < 256) leaf_build<C>(a + j + 4, b + j + 4, w, wi, L[((j >> 2) + 1) & 1]);
            leaf_mac<C>(a + j, L[(j >> 2) & 1]);
        }
    });
    bench("leaf mac only", 256, [&] { for (int j = 0; j < 256; j += 4) leaf_mac<C>(a + j, L[0]); });
    bench("bottom per vector", 256, [&] { k.leaves_all(a, b); });                  // per vector: fwd h=1 + leaf + inv h=1
    bench("tile per vector", 256, [&] { k.tile(a, b); });                        // per vector: whole 256-vector tile
}

int main(int argc, char** argv) {
    long scale = argc > 1 ? std::atol(argv[1]) : 10;
    double cyc = cycle_ns();
    std::printf("cycle %.4f ns (%.2f GHz)\n", cyc, 1 / cyc);
    std::printf("units: fwd4/inv4 = one radix-4 butterfly (4 vectors); leaf/bottom/tile = one vector\n");
    run<Best>("shoup", cyc, scale);
    run<BestPipe>("shoup_pipe", cyc, scale);
    run<MontFlip>("montflip", cyc, scale);
}
