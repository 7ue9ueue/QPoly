// Per-phase microbenchmark for the asm exploration (exploration 009), adapted
// from uop_explore/micro.cpp. Core cycles per unit on L1-resident data,
// calibrated with a dependent-add chain (1 cycle/add). Units: radix-4 loops =
// one butterfly (4 vectors); leaf/bottom/tile = one vector.
// usage: micro [scale]
#include <immintrin.h>
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "kernels/qasm.hpp"

using namespace qasm;
template<int F, int I, int L, int M = 4> using Q = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, F, I, L, M>;

static double now_ns() { return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static double cycle_ns() {
    uint64_t x = 1; const long n = 200000000; double t = now_ns();
    for (long i = 0; i < n; i += 8) asm volatile("add %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0" : "+r"(x));
    return (now_ns() - t) / n;
}
alignas(64) static uint32_t A[256 * 8 + 64], B[256 * 8 + 64], T[1 << 14], IT[1 << 14];
static double CYC; static long SCALE;

template<class F> static void bench(const char* name, const char* what, double units, F&& f) {
    long reps = 2000 * SCALE; f(); f();
    double best = 1e30;
    for (int round = 0; round < 5; ++round) {
        double t = now_ns();
        for (long r = 0; r < reps / 5; ++r) { f(); asm volatile("" ::: "memory"); }
        best = std::min(best, (now_ns() - t) / (reps / 5) / units);
    }
    std::printf("%-12s %-26s %8.2f cycles/unit\n", name, what, best / CYC);
}
template<class C> struct Probe : Kernel<C> {
    using Kernel<C>::Kernel;
    void leaves_all(V* a, V* b) { this->leaf_cursor = ONE; this->leaves(a, b, 256, 256); }
    void tile(V* a, V* b) { this->leaf_cursor = ONE; this->template fixed_tile<256>(a, b, 1); }
    template<bool Inv> void level4(V* a, V* b) {   // the tile's h=4 level: 16 groups of 4 butterflies
        for (int j = 0; j < 256; j += 16) this->template group<Inv, 4>(a + j, b + j, 4, 64 + j / 16);
    }
};
static void reset() {
    std::mt19937 rng(1);
    for (auto& x : A) x = rng() % P; for (auto& x : B) x = rng() % P;
}
// Whole tile, bottom stage and h=4 level for one configuration.
template<class C> static void phases(const char* name) {
    reset();
    int size = 0; Kernel<C>::tables(1 << 12, T, IT, size, true);
    Probe<C> k(T, IT);
    V *a = (V*)A, *b = (V*)B;
    bench(name, "fwd level h=4 per bfly", 128, [&] { k.template level4<false>(a, b); });   // a and b: 128 butterflies
    reset();   // inverse inputs must be < 2P
    bench(name, "inv level h=4 per bfly", 64, [&] { k.template level4<true>(a, nullptr); });
    bench(name, "bottom per vector", 256, [&] { k.leaves_all(a, b); });   // outputs stay valid inputs
    bench(name, "tile per vector", 256, [&] { k.tile(a, b); });
}

int main(int argc, char** argv) {
    std::setvbuf(stdout, nullptr, _IOLBF, 0);   // keep partial output if a phase crashes
    SCALE = argc > 1 ? std::atol(argv[1]) : 10;
    CYC = cycle_ns();
    std::printf("cycle %.4f ns (%.2f GHz)\n", CYC, 1 / CYC);
    reset();
    using C0 = Q<0, 0, 0>;
    int size = 0; Kernel<C0>::tables(1 << 12, T, IT, size, true);
    const int kk = 37;
    const U *px = T + Kernel<C0>::blk(kk), *py = T + Kernel<C0>::blk(2 * kk);
    const U *ipx = IT + Kernel<C0>::blk(kk), *ipy = IT + Kernel<C0>::blk(2 * kk);
    const Twiddle tw{Fixed(splat(px[0]), splat(px[8])), Fixed(splat(py[0]), splat(py[8])), Fixed(splat(py[1]), splat(py[9]))};
    const Twiddle itw{Fixed(splat(ipx[0]), splat(ipx[8])), Fixed(splat(ipy[0]), splat(ipy[8])), Fixed(splat(ipy[1]), splat(ipy[9]))};
    V* a = (V*)A;
    // radix-4 loops at h = 64 (64 butterflies per call)
    bench("cxx", "fwd4 h=64 per bfly", 64, [&] { fwd4<C0, false>(a, 64, tw); });
    bench("cxx", "inv4 h=64 per bfly", 64, [&] { inv4<C0, false>(a, 64, itw); });
    bench("cxx", "fwd4 h=16 per bfly", 64, [&] { for (int g = 0; g < 4; ++g) fwd4<C0, false>(a + 64 * g, 16, tw); });
    bench("cxx", "inv4 h=16 per bfly", 64, [&] { for (int g = 0; g < 4; ++g) inv4<C0, false>(a + 64 * g, 16, itw); });
    bench("cxx", "fwd4 h=4 per bfly", 64, [&] { for (int g = 0; g < 16; ++g) fwd4<C0, false>(a + 16 * g, 4, tw); });
    bench("cxx", "inv4 h=4 per bfly", 64, [&] { for (int g = 0; g < 16; ++g) inv4<C0, false>(a + 16 * g, 4, itw); });
    char key[8], nm[16];
    for (int v = 1; v < 1000; ++v) {
        std::snprintf(key, sizeof key, " %d ", v);
        std::snprintf(nm, sizeof nm, "asm%d", v);
        if (asm_is_ab(v) && std::strstr(ASM_FWD_IDS, key)) {   // a and b together: 2x the butterflies
            V* b = (V*)B;
            bench(nm, "fwd4 h=64 per bfly", 128, [&] { fwd2_asm(v, a, b, 64, px, py); });
            bench(nm, "fwd4 h=16 per bfly", 128, [&] { for (int g = 0; g < 4; ++g) fwd2_asm(v, a + 64 * g, b + 64 * g, 16, px, py); });
            if (4 % ASM_STEP(0, v) == 0)
                bench(nm, "fwd4 h=4 per bfly", 128, [&] { for (int g = 0; g < 16; ++g) fwd2_asm(v, a + 16 * g, b + 16 * g, 4, px, py); });
        } else if (16 % ASM_STEP(0, v) == 0 && std::strstr(ASM_FWD_IDS, key)) {
            bench(nm, "fwd4 h=64 per bfly", 64, [&] { fwd_asm(v, a, 64, px, py); });
            bench(nm, "fwd4 h=16 per bfly", 64, [&] { for (int g = 0; g < 4; ++g) fwd_asm(v, a + 64 * g, 16, px, py); });
            bench(nm, "fwd4 h=4 per bfly", 64, [&] { for (int g = 0; g < 16; ++g) fwd_asm(v, a + 16 * g, 4, px, py); });
        }
        if (16 % ASM_STEP(1, v) == 0 && std::strstr(ASM_INV_IDS, key)) {
            bench(nm, "inv4 h=64 per bfly", 64, [&] { inv_asm(v, a, 64, ipx, ipy); });
            bench(nm, "inv4 h=16 per bfly", 64, [&] { for (int g = 0; g < 4; ++g) inv_asm(v, a + 64 * g, 16, ipx, ipy); });
            if (4 % ASM_STEP(1, v) == 0)
                bench(nm, "inv4 h=4 per bfly", 64, [&] { for (int g = 0; g < 16; ++g) inv_asm(v, a + 16 * g, 4, ipx, ipy); });
        }
    }
    // leaf multiply-accumulate (+ reduce) on built buffers, 64 batches of 4 leaves
    {
        alignas(64) static unsigned char raw[64 * sizeof(LeafBuf) * 2 + 128];
        LeafBuf* L64 = (LeafBuf*)raw;                          // rows on cache lines
        LeafBuf* L32 = (LeafBuf*)(raw + 64 * sizeof(LeafBuf) + 96);   // rows at 32 mod 64
        alignas(16) U w[4] = {ONE, P - ONE, ONE, P - ONE}, wi[4];
        for (int t = 0; t < 4; ++t) wi[t] = w[t] * NI;
        for (int j = 0; j < 64; ++j) { leaf_build<C0>(a + 4 * j, (V*)B + 4 * j, w, wi, L64[j]); L32[j] = L64[j]; }
        bench("cxx al32", "leaf mac per vector", 256, [&] { for (int j = 0; j < 64; ++j) leaf_mac<C0>(a + 4 * j, L32[j]); });
        bench("cxx al64", "leaf mac per vector", 256, [&] { for (int j = 0; j < 64; ++j) leaf_mac<C0>(a + 4 * j, L64[j]); });
        for (int v = 2; v <= ASM_LEAF_MAX; ++v) {
            std::snprintf(nm, sizeof nm, "leaf%d", v);
            bench(nm, "leaf mac per vector", 256, [&] { for (int j = 0; j < 64; ++j) leaf_mac_asm(v, a + 4 * j, &L64[j]); });
        }
    }
    phases<Q<0, 0, 0>>("q_f0i0l0");
    phases<Q<5, 5, 5, 16>>("q_f5i5l5m16");
    phases<Q<11, 71, 5, 16>>("q_f11i71l5m16");
    phases<Q<11, 71, 5, 4>>("q_f11i71l5m4");
}
