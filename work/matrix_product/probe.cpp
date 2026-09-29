// Port/throughput probes for the micro-kernel instruction mix on the target CPU
// (exploration 013). Each probe runs a fixed inline-asm block many times; the report is
// core cycles per block (clock calibrated with a dependent add chain). Blocks model one
// k-step of the 4x8 signed kernel: 8 vpmuldq + 8 vpaddq (+ 4 vbroadcastss + vmovsldup +
// vmovshdup loads), and ablations of it.
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>

namespace {
double calibrate_ghz() {
    double best = 0;
    for (int trial = 0; trial < 5; ++trial) {
        const long iters = 2000000;
        auto t0 = std::chrono::steady_clock::now();
        long x = 0, n = iters;
        asm volatile("1:\n\t.rept 50\n\tinc %0\n\t.endr\n\tdec %1\n\tjnz 1b\n\t" : "+r"(x), "+r"(n));
        auto t1 = std::chrono::steady_clock::now();
        best = std::max(best, 50.0 * iters / std::chrono::duration<double, std::nano>(t1 - t0).count());
    }
    return best;
}

alignas(64) uint32_t buf[4096];

// Each probe body is repeated 16 times per loop iteration (preprocessor repetition: clang's
// assembler treats "$3..." inside .rept as a macro argument); returns ns per body.
#define R4(x) x x x x
#define R16(x) R4(x) R4(x) R4(x) R4(x)
#define PROBE(NAME, BODY)                                                                   \
    double NAME(long iters) {                                                               \
        const uint32_t* p = buf;                                                            \
        auto t0 = std::chrono::steady_clock::now();                                         \
        long n = iters;                                                                     \
        asm volatile("vpxor %%xmm0,%%xmm0,%%xmm0\n\tvpxor %%xmm1,%%xmm1,%%xmm1\n\t"        \
                     "vpxor %%xmm2,%%xmm2,%%xmm2\n\tvpxor %%xmm3,%%xmm3,%%xmm3\n\t"        \
                     "vpxor %%xmm4,%%xmm4,%%xmm4\n\tvpxor %%xmm5,%%xmm5,%%xmm5\n\t"        \
                     "vpxor %%xmm6,%%xmm6,%%xmm6\n\tvpxor %%xmm7,%%xmm7,%%xmm7\n\t"        \
                     "vmovdqu (%1), %%ymm8\n\tvmovdqu 32(%1), %%ymm9\n\t"                   \
                     "vmovdqu 64(%1), %%ymm10\n\tvmovdqu 96(%1), %%ymm11\n\t"               \
                     "vmovdqu 128(%1), %%ymm12\n\tvmovdqu 160(%1), %%ymm13\n\t"             \
                     "1:\n\t" R16(BODY "\n\t")                              \
                     "dec %0\n\tjnz 1b\n\tvzeroupper\n\t"                                   \
                     : "+r"(n)                                                               \
                     : "r"(p)                                                                \
                     : "memory", "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6",    \
                       "xmm7", "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", \
                       "xmm15");                                                             \
        auto t1 = std::chrono::steady_clock::now();                                         \
        return std::chrono::duration<double, std::nano>(t1 - t0).count() / (16.0 * iters); \
    }

// ymm8/9: B even/odd, ymm10..13: A broadcasts, ymm14/15: products, ymm0..7: accumulators.
#define MA(ACC, X, B) "vpmuldq %%ymm" #B ", %%ymm" #X ", %%ymm14\n\tvpaddq %%ymm14, %%ymm" #ACC ", %%ymm" #ACC "\n\t"
#define STEP_REG MA(0,10,8) MA(1,10,9) MA(2,11,8) MA(3,11,9) MA(4,12,8) MA(5,12,9) MA(6,13,8) MA(7,13,9)
#define LOADS "vbroadcastss (%1), %%ymm10\n\tvbroadcastss 4(%1), %%ymm11\n\tvbroadcastss 8(%1), %%ymm12\n\t" \
              "vbroadcastss 12(%1), %%ymm13\n\tvmovsldup 64(%1), %%ymm8\n\tvmovshdup 64(%1), %%ymm9\n\t"
#define LOADS_PB "vpbroadcastd (%1), %%ymm10\n\tvpbroadcastd 4(%1), %%ymm11\n\tvpbroadcastd 8(%1), %%ymm12\n\t" \
                 "vpbroadcastd 12(%1), %%ymm13\n\tvmovdqu 64(%1), %%ymm8\n\tvpsrlq $32, %%ymm8, %%ymm9\n\t"

PROBE(p_mul8, "vpmuldq %%ymm8, %%ymm10, %%ymm0\n\tvpmuldq %%ymm9, %%ymm10, %%ymm1\n\tvpmuldq %%ymm8, %%ymm11, %%ymm2\n\t"
              "vpmuldq %%ymm9, %%ymm11, %%ymm3\n\tvpmuldq %%ymm8, %%ymm12, %%ymm4\n\tvpmuldq %%ymm9, %%ymm12, %%ymm5\n\t"
              "vpmuldq %%ymm8, %%ymm13, %%ymm6\n\tvpmuldq %%ymm9, %%ymm13, %%ymm7")
PROBE(p_add16, "vpaddq %%ymm8, %%ymm0, %%ymm0\n\tvpaddq %%ymm8, %%ymm1, %%ymm1\n\tvpaddq %%ymm8, %%ymm2, %%ymm2\n\t"
               "vpaddq %%ymm8, %%ymm3, %%ymm3\n\tvpaddq %%ymm8, %%ymm4, %%ymm4\n\tvpaddq %%ymm8, %%ymm5, %%ymm5\n\t"
               "vpaddq %%ymm8, %%ymm6, %%ymm6\n\tvpaddq %%ymm8, %%ymm7, %%ymm7\n\t"
               "vpaddq %%ymm9, %%ymm0, %%ymm0\n\tvpaddq %%ymm9, %%ymm1, %%ymm1\n\tvpaddq %%ymm9, %%ymm2, %%ymm2\n\t"
               "vpaddq %%ymm9, %%ymm3, %%ymm3\n\tvpaddq %%ymm9, %%ymm4, %%ymm4\n\tvpaddq %%ymm9, %%ymm5, %%ymm5\n\t"
               "vpaddq %%ymm9, %%ymm6, %%ymm6\n\tvpaddq %%ymm9, %%ymm7, %%ymm7")
PROBE(p_muladd, STEP_REG)
PROBE(p_loads, LOADS)
PROBE(p_step_sd, LOADS STEP_REG)
PROBE(p_step_pb, LOADS_PB STEP_REG)
// Same step with two product registers alternating (removes the single-temp WAW pattern).
#define MA2(ACC, X, B, T) "vpmuldq %%ymm" #B ", %%ymm" #X ", %%ymm" #T "\n\tvpaddq %%ymm" #T ", %%ymm" #ACC ", %%ymm" #ACC "\n\t"
#define STEP_REG2 MA2(0,10,8,14) MA2(1,10,9,15) MA2(2,11,8,14) MA2(3,11,9,15) MA2(4,12,8,14) MA2(5,12,9,15) MA2(6,13,8,14) MA2(7,13,9,15)
PROBE(p_step_sd_t2, LOADS STEP_REG2)
// Loads of the broadcast values only (no dup loads): B vectors stay in registers.
#define LOADS_BC "vbroadcastss (%1), %%ymm10\n\tvbroadcastss 4(%1), %%ymm11\n\tvbroadcastss 8(%1), %%ymm12\n\tvbroadcastss 12(%1), %%ymm13\n\t"
PROBE(p_step_bc_only, LOADS_BC STEP_REG)
// Dup loads only (A broadcasts stay in registers).
#define LOADS_DUP "vmovsldup 64(%1), %%ymm8\n\tvmovshdup 64(%1), %%ymm9\n\t"
PROBE(p_step_dup_only, LOADS_DUP STEP_REG)
// Products all first, then adds (grouped), register-only.
#define STEP_GROUPED "vpmuldq %%ymm8, %%ymm10, %%ymm14\n\tvpmuldq %%ymm9, %%ymm10, %%ymm15\n\tvpaddq %%ymm14, %%ymm0, %%ymm0\n\tvpaddq %%ymm15, %%ymm1, %%ymm1\n\t" \
                     "vpmuldq %%ymm8, %%ymm11, %%ymm14\n\tvpmuldq %%ymm9, %%ymm11, %%ymm15\n\tvpaddq %%ymm14, %%ymm2, %%ymm2\n\tvpaddq %%ymm15, %%ymm3, %%ymm3\n\t" \
                     "vpmuldq %%ymm8, %%ymm12, %%ymm14\n\tvpmuldq %%ymm9, %%ymm12, %%ymm15\n\tvpaddq %%ymm14, %%ymm4, %%ymm4\n\tvpaddq %%ymm15, %%ymm5, %%ymm5\n\t" \
                     "vpmuldq %%ymm8, %%ymm13, %%ymm14\n\tvpmuldq %%ymm9, %%ymm13, %%ymm15\n\tvpaddq %%ymm14, %%ymm6, %%ymm6\n\tvpaddq %%ymm15, %%ymm7, %%ymm7\n\t"
PROBE(p_step_grouped, LOADS STEP_GROUPED)
// vpmuludq instead of vpmuldq.
#define MAU(ACC, X, B) "vpmuludq %%ymm" #B ", %%ymm" #X ", %%ymm14\n\tvpaddq %%ymm14, %%ymm" #ACC ", %%ymm" #ACC "\n\t"
#define STEP_REG_U MAU(0,10,8) MAU(1,10,9) MAU(2,11,8) MAU(3,11,9) MAU(4,12,8) MAU(5,12,9) MAU(6,13,8) MAU(7,13,9)
PROBE(p_step_sd_u, LOADS STEP_REG_U)
// FMA probe (FP0/FP1): 8 vfmadd231pd into 8 accumulators (latency-bound check: 8 chains of 4).
PROBE(p_fma8, "vfmadd231pd %%ymm8, %%ymm10, %%ymm0\n\tvfmadd231pd %%ymm8, %%ymm10, %%ymm1\n\tvfmadd231pd %%ymm8, %%ymm10, %%ymm2\n\t"
              "vfmadd231pd %%ymm8, %%ymm10, %%ymm3\n\tvfmadd231pd %%ymm8, %%ymm10, %%ymm4\n\tvfmadd231pd %%ymm8, %%ymm10, %%ymm5\n\t"
              "vfmadd231pd %%ymm8, %%ymm10, %%ymm6\n\tvfmadd231pd %%ymm8, %%ymm10, %%ymm7")
// Mixed: 4 int mul+add pairs (FP03 + any) plus 4 FMAs (FP01) per block.
PROBE(p_mix_int_fma, MA(0,10,8) MA(1,10,9) MA(2,11,8) MA(3,11,9)
                     "vfmadd231pd %%ymm8, %%ymm12, %%ymm4\n\tvfmadd231pd %%ymm9, %%ymm12, %%ymm5\n\t"
                     "vfmadd231pd %%ymm8, %%ymm13, %%ymm6\n\tvfmadd231pd %%ymm9, %%ymm13, %%ymm7\n\t")

// ---- round 2: blocks of TWO k-steps ----
// Direct kernel, two k-steps.
PROBE(p2_direct, LOADS STEP_REG LOADS STEP_REG)
// Winograd inner-product pair: acc[r][v] += (a[r][2s] + b[2s+1][v]) * (a[r][2s+1] + b[2s][v]).
// ymm8/9 = b[2s] even/odd, ymm10/11 = b[2s+1] even/odd, ymm12/13 = a[r][2s], a[r][2s+1].
#define WIP_R(E, O, OFF) "vbroadcastss " #OFF "(%1), %%ymm12\n\tvbroadcastss " #OFF "+16(%1), %%ymm13\n\t" \
    "vpaddd %%ymm10, %%ymm12, %%ymm14\n\tvpaddd %%ymm8, %%ymm13, %%ymm15\n\tvpmuldq %%ymm15, %%ymm14, %%ymm14\n\tvpaddq %%ymm14, %%ymm" #E ", %%ymm" #E "\n\t" \
    "vpaddd %%ymm11, %%ymm12, %%ymm14\n\tvpaddd %%ymm9, %%ymm13, %%ymm15\n\tvpmuldq %%ymm15, %%ymm14, %%ymm14\n\tvpaddq %%ymm14, %%ymm" #O ", %%ymm" #O "\n\t"
#define WIP_LOADS "vmovsldup 64(%1), %%ymm8\n\tvmovshdup 64(%1), %%ymm9\n\tvmovsldup 96(%1), %%ymm10\n\tvmovshdup 96(%1), %%ymm11\n\t"
PROBE(p2_wip, WIP_LOADS WIP_R(0, 1, 0) WIP_R(2, 3, 4) WIP_R(4, 5, 8) WIP_R(6, 7, 12))
// Packed-B form: s = a + b[2s+1] (8 lanes), t = a' + b[2s]; even = s*t, odd = (s>>32)*(t>>32).
#define WIPP_R(E, O, OFF) "vbroadcastss " #OFF "(%1), %%ymm12\n\tvbroadcastss " #OFF "+16(%1), %%ymm13\n\t" \
    "vpaddd %%ymm10, %%ymm12, %%ymm14\n\tvpaddd %%ymm8, %%ymm13, %%ymm15\n\t" \
    "vpmuldq %%ymm15, %%ymm14, %%ymm12\n\tvpaddq %%ymm12, %%ymm" #E ", %%ymm" #E "\n\t" \
    "vpsrlq $32, %%ymm14, %%ymm14\n\tvpsrlq $32, %%ymm15, %%ymm15\n\tvpmuldq %%ymm15, %%ymm14, %%ymm14\n\tvpaddq %%ymm14, %%ymm" #O ", %%ymm" #O "\n\t"
#define WIPP_LOADS "vmovdqu 64(%1), %%ymm8\n\tvmovdqu 96(%1), %%ymm10\n\t"
PROBE(p2_wip_packed, WIPP_LOADS WIPP_R(0, 1, 0) WIPP_R(2, 3, 4) WIPP_R(4, 5, 8) WIPP_R(6, 7, 12))
// Register-only WIP arithmetic (no loads) to isolate the pipe mix: 16 vpaddd + 8 vpmuldq + 8 vpaddq.
#define WIPR_R(E, O) "vpaddd %%ymm10, %%ymm12, %%ymm14\n\tvpaddd %%ymm8, %%ymm13, %%ymm15\n\tvpmuldq %%ymm15, %%ymm14, %%ymm14\n\tvpaddq %%ymm14, %%ymm" #E ", %%ymm" #E "\n\t" \
    "vpaddd %%ymm11, %%ymm12, %%ymm14\n\tvpaddd %%ymm9, %%ymm13, %%ymm15\n\tvpmuldq %%ymm15, %%ymm14, %%ymm14\n\tvpaddq %%ymm14, %%ymm" #O ", %%ymm" #O "\n\t"
PROBE(p2_wip_regs, WIPR_R(0, 1) WIPR_R(2, 3) WIPR_R(4, 5) WIPR_R(6, 7))
// Direct kernel with the multiplies of each row issued one row ahead of their adds
// (uses ymm14/15 as a 2-deep product pipeline; rows alternate registers).
#define DP(ACC_E, ACC_O, X, T0, T1) "vpaddq %%ymm" #T0 ", %%ymm" #ACC_E ", %%ymm" #ACC_E "\n\tvpaddq %%ymm" #T1 ", %%ymm" #ACC_O ", %%ymm" #ACC_O "\n\t" \
    "vpmuldq %%ymm8, %%ymm" #X ", %%ymm" #T0 "\n\tvpmuldq %%ymm9, %%ymm" #X ", %%ymm" #T1 "\n\t"
PROBE(p2_direct_skew, LOADS DP(0,1,10,14,15) DP(2,3,11,14,15) DP(4,5,12,14,15) DP(6,7,13,14,15)
                      LOADS DP(0,1,10,14,15) DP(2,3,11,14,15) DP(4,5,12,14,15) DP(6,7,13,14,15))
}  // namespace

int main() {
    for (int i = 0; i < 4096; ++i) buf[i] = uint32_t(i * 2654435761u >> 3);
    const double ghz = calibrate_ghz();
    std::printf("calibrated core clock: %.3f GHz\n| probe | cycles/block | expected (port model) |\n|---|---:|---|\n", ghz);
    struct { const char* name; double (*fn)(long); const char* model; } probes[] = {
        {"8 vpmuldq (indep.)", p_mul8, "4 (FP0/FP3)"},
        {"16 vpaddq (8 chains)", p_add16, "4 (FP0-3) or chain-bound 2"},
        {"8 mul + 8 add, regs", p_muladd, "4"},
        {"6 loads only", p_loads, "3 (2 loads/cycle)"},
        {"step sd: 6 loads + 16", p_step_sd, "4 if loads are free"},
        {"step pb: vpbroadcastd+vpsrlq", p_step_pb, "5.25 (5 FP12 ops)"},
        {"step sd, 2 product regs", p_step_sd_t2, "4"},
        {"step, bcast loads only", p_step_bc_only, "4"},
        {"step, dup loads only", p_step_dup_only, "4"},
        {"step sd grouped order", p_step_grouped, "4"},
        {"step sd with vpmuludq", p_step_sd_u, "4"},
        {"8 FMA (8 chains, lat 4)", p_fma8, "4"},
        {"4 imul+add + 4 FMA", p_mix_int_fma, "2-3"},
        {"2 steps direct (12 ld, 16 mul, 16 add)", p2_direct, "8 ideal, ~10 seen"},
        {"2 steps Winograd pair (12 ld, 8 mul, 24 add)", p2_wip, "8 if the mix helps"},
        {"2 steps Winograd packed B (10 ld, 8 mul, 16 add, 8 shift)", p2_wip_packed, "8"},
        {"Winograd pair arithmetic, regs only", p2_wip_regs, "8"},
        {"2 steps direct, adds skewed one row", p2_direct_skew, "8-10"},
    };
    for (auto& pr : probes) {
        double best = 1e30;
        for (int t = 0; t < 7; ++t) best = std::min(best, pr.fn(200000));
        std::printf("| %s | %.3f | %s |\n", pr.name, best * ghz, pr.model);
    }
    return 0;
}
