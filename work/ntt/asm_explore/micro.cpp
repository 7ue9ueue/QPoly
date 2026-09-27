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
#include <utility>
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
static uint32_t* const B_ = B;
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

// Bottom stage per vector for every generated fused-bottom variant (and the C++ leaf-5 path).
template<int B> static void bottom_one() {
    if constexpr (asm_bottom_has(B)) {
        using CB = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, B>;
        reset();
        int size = 0; Kernel<CB>::tables(1 << 12, T, IT, size, true);
        Probe<CB> k(T, IT);
        char nm[16]; std::snprintf(nm, sizeof nm, "bottom%d", B);
        bench(nm, "bottom per vector", 256, [&] { k.leaves_all((V*)A, (V*)B_); });
    }
}
template<int... I> static void bottoms(std::integer_sequence<int, I...>) {
    {
        using CL = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 5, 4>;
        reset(); int size = 0; Kernel<CL>::tables(1 << 12, T, IT, size, true);
        Probe<CL> k(T, IT);
        bench("leaf5", "bottom per vector", 256, [&] { k.leaves_all((V*)A, (V*)B_); });
    }
    (bottom_one<I>(), ...);
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
    // Whole 2^20 transform and its C++ phases outside the tiles, on full-size arrays
    // (fresh roots, zero upper halves as for the judge). Units: cycles per vector of n/8.
    {
        const int n = 1 << 20, nv = n / 8, h = nv / 2;
        U* fa = (U*)std::aligned_alloc(64, size_t(n + 64) * 4);
        U* fb = (U*)std::aligned_alloc(64, size_t(n + 64) * 4);
        U* fr = (U*)std::aligned_alloc(64, size_t(n) * 4);
        U* fir = (U*)std::aligned_alloc(64, size_t(n) * 4);
        std::mt19937 rng(5);
        auto fill = [&] { for (int i = 0; i < n; ++i) { fa[i] = i < n / 2 ? rng() % P : 0; fb[i] = i < n / 2 ? rng() % P : 0; } };
        auto whole = [&](auto tag, const char* name) {
            using K = Kernel<typename decltype(tag)::type>;
            double best = 1e30;
            for (int rep = 0; rep < 7; ++rep) {
                fill(); int rs = 0;
                double t = now_ns(); K::run(n, fa, fb, fr, fir, rs, true, n / 2, n / 2); t = now_ns() - t;
                if (rep) best = std::min(best, t);
            }
            std::printf("%-14s %-26s %8.2f cycles/unit\n", name, "2^20 run per vector", best / nv / CYC);
        };
        struct T0 { using type = Q<0, 0, 0>; }; struct T1 { using type = Q<11, 71, 5, 4>; };
        whole(T0{}, "q_f0i0l0"); whole(T1{}, "q_f11i71l5m4");
        fill();
        const long saved_scale = SCALE; SCALE = 1;   // 2000 repetitions of full-size passes
        int rs = 0; Kernel<C0>::tables(n / 16, fr, fir, rs, true);
        Kernel<C0> k(fr, fir);
        V *va = (V*)fa, *vb = (V*)fb;
        bench("cxx", "top copy a+b per vector", nv, [&] { for (int i = 0; i < h; ++i) { va[i + h] = va[i]; vb[i + h] = vb[i]; } });
        bench("cxx", "identity fwd h=2^14 a+b", nv, [&] { k.template group<false>(va, vb, nv / 8, 0); k.template group<false>(va + h, vb + h, nv / 8, 0); });
        bench("cxx", "identity inv h=2^14", nv, [&] { k.template group<true>(va, nullptr, nv / 8, 0); k.template group<true>(va + h, nullptr, nv / 8, 0); });
        const Fixed scale(splat(12345), splat(U((uint64_t(12345) << 32) / P)));
        bench("cxx", "final scale per vector", nv, [&] {
            for (int i = 0; i < h; ++i) {
                V x = va[i], y = va[i + h];
                va[i] = shrink(scale.mul<2, false, false, true>(plus(x, y)), P);
                va[i + h] = shrink(scale.mul<2, false, false, true>(diff(x, y)), P);
            }
        });
        for (int v = 1; v <= 5; ++v) {
            char nm[16]; std::snprintf(nm, sizeof nm, "id%d", v);
            if (fid_step(v)) bench(nm, "identity fwd h=2^14 a+b", nv, [&] { for (V* f : {va, vb, va + h, vb + h}) fid_asm(v, f, nv / 8, nullptr, fr); });
            if (iid_step(v)) bench(nm, "identity inv h=2^14", nv, [&] { for (V* f : {va, va + h}) iid_asm(v, f, nv / 8, nullptr, fir); });
            alignas(32) U sc[16] = {}; sc[1] = 12345; sc[9] = U((uint64_t(12345) << 32) / P);
            std::snprintf(nm, sizeof nm, "sc%d", v);
            if (scale_step(v)) bench(nm, "final scale per vector", nv, [&] { scale_asm(v, va, h, nullptr, sc); });
        }
        bench("cxx", "nontrivial fwd h=2^12 a+b", nv, [&] { for (int g = 0; g < 8; ++g) k.template group<false>(va + g * nv / 8, vb + g * nv / 8, nv / 32, 5 + g); });
        SCALE = saved_scale;
        std::free(fa); std::free(fb); std::free(fr); std::free(fir);
    }
    bottoms(std::make_integer_sequence<int, 96>{});
    phases<Q<0, 0, 0>>("q_f0i0l0");
    phases<Q<11, 71, 5, 4>>("q_f11i71l5m4");
    phases<Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 3>>("q_f11i71b3");
    phases<Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 8>>("q_f11i71b8");
    phases<Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 9>>("q_f11i71b9");
    phases<Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 10>>("q_f11i71b10");
    phases<Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 11>>("q_f11i71b11");
}
