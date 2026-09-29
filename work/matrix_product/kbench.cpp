// Micro-kernel throughput benchmark (exploration 013): cycles per k-step with all panels
// resident in L1, core clock calibrated with a dependent chain of 1-cycle adds.
// Usage: kbench [--m=DEPTH] [--reps=R] [--kernels=a,b|all]
// Each kernel computes one MR x NR tile from an A panel [m][MR] and a B panel [m][NR] and
// stores canonical results; results are checked against a scalar reference once.
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3")
#endif
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#include "simd.hpp"
#include "simd_kernel.hpp"
#include "asm_kernels.hpp"

using namespace mp;
using namespace mp::simd;

namespace {
using KFn = void (*)(const u32* pa, const u32* pb, int m, u32* c, int ldc);
struct Kernel { const char* name; KFn fn; int mr, nr, rep; };  // rep: 1 = centered/Montgomery inputs, 2 = WIP

i32 g_alpha[4], g_beta[8];
template <int U2>
void kwip(const u32* pa, const u32* pb, int m, u32* c, int ldc) { micro_wip<U2>(pa, pb, m, g_alpha, g_beta, c, ldc, 4, 8); }
template <int U2>
void kwipp(const u32* pa, const u32* pb, int m, u32* c, int ldc) { micro_wipp<U2>(pa, pb, m, g_alpha, g_beta, c, ldc, 4, 8); }
// Asm tile: accumulators from zero (direct) or the Winograd corrections (wip*), then finish.
template <void (*K)(const u32*, const u32*, long, V (&)[8]), int Period, bool Wip>
void kasm(const u32* pa, const u32* pb, int m, u32* c, int ldc) {
    V acc[8];
    if constexpr (Wip) {
        const V be = _mm256_cvtepi32_epi64(_mm_setr_epi32(g_beta[0], g_beta[2], g_beta[4], g_beta[6]));
        const V bo = _mm256_cvtepi32_epi64(_mm_setr_epi32(g_beta[1], g_beta[3], g_beta[5], g_beta[7]));
        for (int r = 0; r < 4; ++r) {
            const V ar = _mm256_set1_epi64x(g_alpha[r]);
            acc[2 * r] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, be));
            acc[2 * r + 1] = _mm256_sub_epi64(_mm256_setzero_si256(), _mm256_add_epi64(ar, bo));
        }
    } else {
        for (auto& x : acc) x = _mm256_setzero_si256();
    }
    K(pa, pb, m / Period, acc);
    for (int r = 0; r < 4; ++r) _mm256_storeu_si256(reinterpret_cast<V*>(c + std::size_t(r) * ldc), finish_s(acc[2 * r], acc[2 * r + 1]));
}
template <int Rep, int Load, int MR, int NRV, int U>
void kmicro(const u32* pa, const u32* pb, int m, u32* c, int ldc) { micro<Rep, Load, MR, NRV, U>(pa, pb, m, c, ldc, MR, 8 * NRV); }

std::vector<Kernel>& kernels() {
    static std::vector<Kernel> k = {
        {"u_bs_4x8_u1", kmicro<0, 0, 4, 1, 1>, 4, 8, 0},
        {"u_sd_4x8_u1", kmicro<0, 1, 4, 1, 1>, 4, 8, 0},
        {"s_bs_4x8_u1", kmicro<1, 0, 4, 1, 1>, 4, 8, 1},
        {"s_sd_4x8_u1", kmicro<1, 1, 4, 1, 1>, 4, 8, 1},
        {"s_sd_4x8_u2", kmicro<1, 1, 4, 1, 2>, 4, 8, 1},
        {"s_sd_4x8_u4", kmicro<1, 1, 4, 1, 4>, 4, 8, 1},
        {"s_sd_4x8_u8", kmicro<1, 1, 4, 1, 8>, 4, 8, 1},
        {"s_sd_6x8_u1", kmicro<1, 1, 6, 1, 1>, 6, 8, 1},
        {"s_sd_6x8_u2", kmicro<1, 1, 6, 1, 2>, 6, 8, 1},
        {"s_sd_2x16_u1", kmicro<1, 1, 2, 2, 1>, 2, 16, 1},
        {"s_sd_2x16_u2", kmicro<1, 1, 2, 2, 2>, 2, 16, 1},
        {"s_sd_3x16_u1", kmicro<1, 1, 3, 2, 1>, 3, 16, 1},
        {"wip_4x8_u1", kwip<1>, 4, 8, 2},
        {"wip_4x8_u2", kwip<2>, 4, 8, 2},
        {"wip_4x8_u4", kwip<4>, 4, 8, 2},
        {"wipp_4x8_u1", kwipp<1>, 4, 8, 2},
        {"wipp_4x8_u2", kwipp<2>, 4, 8, 2},
#define MP_KASM(name, period) {"asm_" #name, kasm<asm_##name, period, #name[0] != 'd'>, 4, 8, #name[0] != 'd' ? 2 : 1},
        MP_ASM_KERNELS(MP_KASM)
    };
    return k;
}

// Dependent chain of 1-cycle adds: returns core cycles per nanosecond.
double calibrate_ghz() {
    double best = 0;
    for (int trial = 0; trial < 5; ++trial) {
        const long iters = 2000000;
        auto t0 = std::chrono::steady_clock::now();
        long x = 0, n = iters;
        asm volatile(
            "1:\n\t"
            ".rept 50\n\tinc %0\n\t.endr\n\t"
            "dec %1\n\tjnz 1b\n\t"
            : "+r"(x), "+r"(n));
        auto t1 = std::chrono::steady_clock::now();
        const double ns = std::chrono::duration<double, std::nano>(t1 - t0).count();
        best = std::max(best, 50.0 * iters / ns);
    }
    return best;
}

u64 rng_state = 88172645463325252ULL;
u32 rnd() { rng_state ^= rng_state << 13; rng_state ^= rng_state >> 7; rng_state ^= rng_state << 17; return u32(rng_state >> 32); }
}  // namespace

int main(int argc, char** argv) {
    int m = 256, reps = 20000;
    std::vector<std::string> want;
    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        if (a.rfind("--m=", 0) == 0) m = std::atoi(a.c_str() + 4);
        else if (a.rfind("--reps=", 0) == 0) reps = std::atoi(a.c_str() + 7);
        else if (a.rfind("--kernels=", 0) == 0 && a != "--kernels=all") {
            std::string s = a.substr(10);
            for (std::size_t p = 0; p <= s.size();) {
                std::size_t e = s.find(',', p);
                if (e == std::string::npos) e = s.size();
                want.push_back(s.substr(p, e - p));
                p = e + 1;
            }
        }
    }
    const double ghz = calibrate_ghz();
    std::printf("calibrated core clock: %.3f GHz, depth m=%d, reps=%d\n", ghz, m, reps);
    std::printf("| kernel | ns/call | cycles/k-step | MACs/cycle | check |\n|---|---:|---:|---:|---|\n");
    int failures = 0;
    for (auto& k : kernels()) {
        if (!want.empty() && std::find(want.begin(), want.end(), k.name) == want.end()) continue;
        std::vector<u32> araw(std::size_t(m) * k.mr), braw(std::size_t(m) * k.nr);
        for (auto& x : araw) x = rnd() % P;
        for (auto& x : braw) x = rnd() % P;
        u32* pa = static_cast<u32*>(std::aligned_alloc(64, (araw.size() * 4 + 127) / 64 * 64));
        u32* pb = static_cast<u32*>(std::aligned_alloc(64, (braw.size() * 4 + 127) / 64 * 64));
        for (std::size_t i = 0; i < araw.size(); ++i) { const u32 x = to_mont(araw[i]); pa[i] = k.rep ? u32(center(x)) : x; }
        for (std::size_t i = 0; i < braw.size(); ++i) pb[i] = k.rep ? u32(center(braw[i])) : braw[i];
        if (k.rep == 2) wip_alpha4(pa, m, g_alpha), wip_beta8(pb, m, g_beta);
        std::vector<u32> c(std::size_t(k.mr) * k.nr);
        k.fn(pa, pb, m, c.data(), k.nr);
        bool ok = true;
        for (int r = 0; r < k.mr; ++r)
            for (int j = 0; j < k.nr; ++j) {
                unsigned __int128 s = 0;
                for (int t = 0; t < m; ++t) s += u64(araw[std::size_t(t) * k.mr + r]) * braw[std::size_t(t) * k.nr + j];
                ok &= c[std::size_t(r) * k.nr + j] == u32(s % P);
            }
        failures += !ok;
        double best = 1e30;
        for (int trial = 0; trial < 5; ++trial) {
            auto t0 = std::chrono::steady_clock::now();
            for (int r = 0; r < reps; ++r) {
                k.fn(pa, pb, m, c.data(), k.nr);
                asm volatile("" ::: "memory");
            }
            auto t1 = std::chrono::steady_clock::now();
            best = std::min(best, std::chrono::duration<double, std::nano>(t1 - t0).count() / reps);
        }
        const double cyc = best * ghz / m;
        std::printf("| %s | %.1f | %.3f | %.3f | %s |\n", k.name, best, cyc, 4.0 * k.mr * (k.nr / 8) * 2 / cyc,
                    ok ? "ok" : "FAIL");
        std::free(pa), std::free(pb);
    }
    std::printf("RESULT: %s\n", failures ? "FAIL" : "PASS");
    return failures ? 1 : 0;
}
