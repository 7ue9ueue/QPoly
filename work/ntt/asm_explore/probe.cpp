// Instruction-cost probe for the asm exploration (exploration 009).
// Each test runs an asm loop whose body is a fixed instruction mix and reports
// core cycles per loop iteration (calibrated with a dependent add chain, 1/cycle).
// Throughput tests use independent destinations; latency tests chain through one
// register. Data are L1-resident. Build: g++ -O2 -march=native probe.cpp.
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <cpuid.h>

static double now_ns() { return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static double cycle_ns() {
    uint64_t x = 1; const long n = 400000000; double t = now_ns();
    for (long i = 0; i < n; i += 8) asm volatile("add %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0" : "+r"(x));
    return (now_ns() - t) / n;
}
alignas(64) static uint32_t buf[4096];

#define CLOB "xmm0","xmm1","xmm2","xmm3","xmm4","xmm5","xmm6","xmm7","xmm8","xmm9","xmm10","xmm11","xmm12","xmm13","xmm14","xmm15","memory"
// Runs BODY (a string literal using %[p] as the buffer pointer) n times.
#define PROBE(NAME, BODY)                                                                      \
    static void NAME(long n) {                                                                 \
        const uint32_t* p = buf;                                                               \
        asm volatile("vpxor %%xmm0,%%xmm0,%%xmm0\n\tvpxor %%xmm1,%%xmm1,%%xmm1\n\t"            \
                     "vpxor %%xmm2,%%xmm2,%%xmm2\n\tvpxor %%xmm3,%%xmm3,%%xmm3\n\t"            \
                     "vpxor %%xmm8,%%xmm8,%%xmm8\n\tvpxor %%xmm9,%%xmm9,%%xmm9\n\t"            \
                     ".p2align 6\n1:\n\t" BODY "\n\tdec %[n]\n\tjnz 1b"                        \
                     : [n] "+r"(n) : [p] "r"(p) : CLOB);                                       \
    }

// --- broadcast forms (8 independent per iteration)
PROBE(bcast_d, "vpbroadcastd 4(%[p]),%%ymm4\n\tvpbroadcastd 8(%[p]),%%ymm5\n\tvpbroadcastd 12(%[p]),%%ymm6\n\tvpbroadcastd 16(%[p]),%%ymm7\n\t"
               "vpbroadcastd 20(%[p]),%%ymm10\n\tvpbroadcastd 24(%[p]),%%ymm11\n\tvpbroadcastd 28(%[p]),%%ymm12\n\tvpbroadcastd 32(%[p]),%%ymm13")
PROBE(bcast_ss, "vbroadcastss 4(%[p]),%%ymm4\n\tvbroadcastss 8(%[p]),%%ymm5\n\tvbroadcastss 12(%[p]),%%ymm6\n\tvbroadcastss 16(%[p]),%%ymm7\n\t"
                "vbroadcastss 20(%[p]),%%ymm10\n\tvbroadcastss 24(%[p]),%%ymm11\n\tvbroadcastss 28(%[p]),%%ymm12\n\tvbroadcastss 32(%[p]),%%ymm13")
// broadcast + 4 shifts (shift pipes): if a broadcast needs a shuffle pipe, 8 ops share 2 pipes
#define SH4 "vpsrlq $32,%%ymm0,%%ymm4\n\tvpsrlq $32,%%ymm1,%%ymm5\n\tvpsrlq $32,%%ymm2,%%ymm6\n\tvpsrlq $32,%%ymm3,%%ymm7\n\t"
PROBE(bcast_d_sh, SH4 "vpbroadcastd 4(%[p]),%%ymm10\n\tvpbroadcastd 8(%[p]),%%ymm11\n\tvpbroadcastd 12(%[p]),%%ymm12\n\tvpbroadcastd 16(%[p]),%%ymm13")
PROBE(bcast_ss_sh, SH4 "vbroadcastss 4(%[p]),%%ymm10\n\tvbroadcastss 8(%[p]),%%ymm11\n\tvbroadcastss 12(%[p]),%%ymm12\n\tvbroadcastss 16(%[p]),%%ymm13")
PROBE(sh4, SH4)
// broadcast + 12 adds (any pipe)
#define AD12 "vpaddd %%ymm0,%%ymm1,%%ymm4\n\tvpaddd %%ymm0,%%ymm2,%%ymm5\n\tvpaddd %%ymm0,%%ymm3,%%ymm6\n\tvpaddd %%ymm1,%%ymm2,%%ymm7\n\t" \
             "vpaddd %%ymm1,%%ymm3,%%ymm14\n\tvpaddd %%ymm2,%%ymm3,%%ymm15\n\tvpaddd %%ymm8,%%ymm1,%%ymm4\n\tvpaddd %%ymm8,%%ymm2,%%ymm5\n\t" \
             "vpaddd %%ymm8,%%ymm3,%%ymm6\n\tvpaddd %%ymm9,%%ymm1,%%ymm7\n\tvpaddd %%ymm9,%%ymm2,%%ymm14\n\tvpaddd %%ymm9,%%ymm3,%%ymm15\n\t"
PROBE(ad12, AD12)
PROBE(bcast_d_ad12, AD12 "vpbroadcastd 4(%[p]),%%ymm10\n\tvpbroadcastd 8(%[p]),%%ymm11\n\tvpbroadcastd 12(%[p]),%%ymm12\n\tvpbroadcastd 16(%[p]),%%ymm13")
PROBE(bcast_ss_ad12, AD12 "vbroadcastss 4(%[p]),%%ymm10\n\tvbroadcastss 8(%[p]),%%ymm11\n\tvbroadcastss 12(%[p]),%%ymm12\n\tvbroadcastss 16(%[p]),%%ymm13")
PROBE(load_ad12, AD12 "vmovdqa 64(%[p]),%%ymm10\n\tvmovdqa 128(%[p]),%%ymm11\n\tvmovdqa 192(%[p]),%%ymm12\n\tvmovdqa 256(%[p]),%%ymm13")
// --- multiplies
#define MU8(OP) OP " %%ymm0,%%ymm1,%%ymm4\n\t" OP " %%ymm0,%%ymm2,%%ymm5\n\t" OP " %%ymm0,%%ymm3,%%ymm6\n\t" OP " %%ymm1,%%ymm2,%%ymm7\n\t" \
                OP " %%ymm1,%%ymm3,%%ymm10\n\t" OP " %%ymm2,%%ymm3,%%ymm11\n\t" OP " %%ymm8,%%ymm1,%%ymm12\n\t" OP " %%ymm8,%%ymm2,%%ymm13\n\t"
PROBE(muludq8, MU8("vpmuludq"))
PROBE(mulld8, MU8("vpmulld"))
PROBE(muludq8_mem, "vpmuludq 0(%[p]),%%ymm1,%%ymm4\n\tvpmuludq 32(%[p]),%%ymm1,%%ymm5\n\tvpmuludq 64(%[p]),%%ymm1,%%ymm6\n\tvpmuludq 96(%[p]),%%ymm1,%%ymm7\n\t"
                   "vpmuludq 128(%[p]),%%ymm2,%%ymm10\n\tvpmuludq 160(%[p]),%%ymm2,%%ymm11\n\tvpmuludq 192(%[p]),%%ymm2,%%ymm12\n\tvpmuludq 224(%[p]),%%ymm2,%%ymm13")
PROBE(mul4_ad4, "vpmuludq %%ymm0,%%ymm1,%%ymm4\n\tvpmuludq %%ymm0,%%ymm2,%%ymm5\n\tvpmulld %%ymm0,%%ymm3,%%ymm6\n\tvpmulld %%ymm1,%%ymm2,%%ymm7\n\t"
                "vpaddd %%ymm1,%%ymm3,%%ymm10\n\tvpaddd %%ymm2,%%ymm3,%%ymm11\n\tvpaddd %%ymm8,%%ymm1,%%ymm12\n\tvpaddd %%ymm8,%%ymm2,%%ymm13")
PROBE(mul4_sh4, "vpmuludq %%ymm0,%%ymm1,%%ymm4\n\tvpmuludq %%ymm0,%%ymm2,%%ymm5\n\tvpmulld %%ymm0,%%ymm3,%%ymm6\n\tvpmulld %%ymm1,%%ymm2,%%ymm7\n\t"
                "vpsrlq $32,%%ymm1,%%ymm10\n\tvpsrlq $32,%%ymm3,%%ymm11\n\tvpsrlq $32,%%ymm8,%%ymm12\n\tvpsrlq $32,%%ymm2,%%ymm13")
// --- shuffles / odd-lane extraction / blends (8 independent)
PROBE(srlq8, "vpsrlq $32,%%ymm0,%%ymm4\n\tvpsrlq $32,%%ymm1,%%ymm5\n\tvpsrlq $32,%%ymm2,%%ymm6\n\tvpsrlq $32,%%ymm3,%%ymm7\n\t"
             "vpsrlq $32,%%ymm8,%%ymm10\n\tvpsrlq $32,%%ymm9,%%ymm11\n\tvpsrlq $32,%%ymm0,%%ymm12\n\tvpsrlq $32,%%ymm1,%%ymm13")
PROBE(pshufd8, "vpshufd $245,%%ymm0,%%ymm4\n\tvpshufd $245,%%ymm1,%%ymm5\n\tvpshufd $245,%%ymm2,%%ymm6\n\tvpshufd $245,%%ymm3,%%ymm7\n\t"
               "vpshufd $245,%%ymm8,%%ymm10\n\tvpshufd $245,%%ymm9,%%ymm11\n\tvpshufd $245,%%ymm0,%%ymm12\n\tvpshufd $245,%%ymm1,%%ymm13")
PROBE(blend8, MU8("vpblendd $170,"))
PROBE(shufps8, MU8("vshufps $221,"))
PROBE(minud8, MU8("vpminud"))
PROBE(alignr8, MU8("vpalignr $4,"))
// --- unaligned loads: +4 inside a 64-byte line vs crossing a line (8 per iteration)
PROBE(ldu_in, "vmovdqu 4(%[p]),%%ymm4\n\tvmovdqu 68(%[p]),%%ymm5\n\tvmovdqu 132(%[p]),%%ymm6\n\tvmovdqu 196(%[p]),%%ymm7\n\t"
              "vmovdqu 260(%[p]),%%ymm10\n\tvmovdqu 324(%[p]),%%ymm11\n\tvmovdqu 388(%[p]),%%ymm12\n\tvmovdqu 452(%[p]),%%ymm13")
PROBE(ldu_cross, "vmovdqu 36(%[p]),%%ymm4\n\tvmovdqu 100(%[p]),%%ymm5\n\tvmovdqu 164(%[p]),%%ymm6\n\tvmovdqu 228(%[p]),%%ymm7\n\t"
                 "vmovdqu 292(%[p]),%%ymm10\n\tvmovdqu 356(%[p]),%%ymm11\n\tvmovdqu 420(%[p]),%%ymm12\n\tvmovdqu 484(%[p]),%%ymm13")
PROBE(lda8, "vmovdqa 0(%[p]),%%ymm4\n\tvmovdqa 64(%[p]),%%ymm5\n\tvmovdqa 128(%[p]),%%ymm6\n\tvmovdqa 192(%[p]),%%ymm7\n\t"
            "vmovdqa 256(%[p]),%%ymm10\n\tvmovdqa 320(%[p]),%%ymm11\n\tvmovdqa 384(%[p]),%%ymm12\n\tvmovdqa 448(%[p]),%%ymm13")
// --- stores (4 aligned per iteration) and store+load mixes
PROBE(st4, "vmovdqa %%ymm0,1024(%[p])\n\tvmovdqa %%ymm1,1088(%[p])\n\tvmovdqa %%ymm2,1152(%[p])\n\tvmovdqa %%ymm3,1216(%[p])")
// --- latencies (dependent chain through ymm0, 8 per iteration)
#define CH8(I) I "\n\t" I "\n\t" I "\n\t" I "\n\t" I "\n\t" I "\n\t" I "\n\t" I
PROBE(lat_muludq, CH8("vpmuludq %%ymm0,%%ymm0,%%ymm0"))
PROBE(lat_mulld, CH8("vpmulld %%ymm0,%%ymm0,%%ymm0"))
PROBE(lat_add, CH8("vpaddd %%ymm0,%%ymm0,%%ymm0"))
PROBE(lat_srl, CH8("vpsrlq $1,%%ymm0,%%ymm0"))
PROBE(lat_blend, CH8("vpblendd $170,%%ymm1,%%ymm0,%%ymm0"))
PROBE(lat_shufps, CH8("vshufps $221,%%ymm1,%%ymm0,%%ymm0"))
// store-forwarding: store a vector, reload it (aligned, same size) through the chain
PROBE(lat_stld_same, CH8("vmovdqa %%ymm0,2048(%[p])\n\tvmovdqa 2048(%[p]),%%ymm0"))
// store two vectors, reload unaligned across both (forwarding impossible)
PROBE(lat_stld_span, CH8("vmovdqa %%ymm0,2048(%[p])\n\tvmovdqa %%ymm0,2080(%[p])\n\tvmovdqu 2052(%[p]),%%ymm0"))
// load-to-use: pointer-free vector chain via memory operand add
PROBE(lat_ld_add, CH8("vmovdqa %%ymm0,2048(%[p])\n\tvpaddd 2048(%[p]),%%ymm1,%%ymm0"))

struct T { const char* name; void (*fn)(long); double per; const char* note; };
int main(int argc, char** argv) {
    long iters = argc > 1 ? std::atol(argv[1]) : 2000000;
    unsigned r[4]; char brand[49]{};
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    for (int i = 0; i < 4096; ++i) buf[i] = i * 2654435761u;
    double cyc = cycle_ns();
    std::printf("# CPU: %s\n# cycle %.4f ns (%.3f GHz)\n", brand, cyc, 1 / cyc);
    const T tests[] = {
        {"bcast_d x8", bcast_d, 8, "vpbroadcastd ymm,m32"},
        {"bcast_ss x8", bcast_ss, 8, "vbroadcastss ymm,m32"},
        {"sh4", sh4, 1, "4 vpsrlq"},
        {"bcast_d x4 + sh4", bcast_d_sh, 1, ""},
        {"bcast_ss x4 + sh4", bcast_ss_sh, 1, ""},
        {"ad12", ad12, 1, "12 vpaddd"},
        {"bcast_d x4 + ad12", bcast_d_ad12, 1, ""},
        {"bcast_ss x4 + ad12", bcast_ss_ad12, 1, ""},
        {"load x4 + ad12", load_ad12, 1, "vmovdqa loads"},
        {"vpmuludq x8", muludq8, 8, ""},
        {"vpmulld x8", mulld8, 8, ""},
        {"vpmuludq mem x8", muludq8_mem, 8, "folded load"},
        {"mul4 + add4", mul4_ad4, 1, ""},
        {"mul4 + srl4", mul4_sh4, 1, ""},
        {"vpsrlq x8", srlq8, 8, ""},
        {"vpshufd x8", pshufd8, 8, ""},
        {"vpblendd x8", blend8, 8, ""},
        {"vshufps x8", shufps8, 8, ""},
        {"vpminud x8", minud8, 8, ""},
        {"vpalignr x8", alignr8, 8, ""},
        {"loadu in-line x8", ldu_in, 8, ""},
        {"loadu cross-line x8", ldu_cross, 8, ""},
        {"load aligned x8", lda8, 8, ""},
        {"store x4", st4, 4, ""},
        {"lat vpmuludq", lat_muludq, 8, "latency"},
        {"lat vpmulld", lat_mulld, 8, "latency"},
        {"lat vpaddd", lat_add, 8, "latency"},
        {"lat vpsrlq", lat_srl, 8, "latency"},
        {"lat vpblendd", lat_blend, 8, "latency"},
        {"lat vshufps", lat_shufps, 8, "latency"},
        {"lat store->load same", lat_stld_same, 8, "store-forward latency"},
        {"lat store2->loadu span", lat_stld_span, 8, "failed forwarding"},
        {"lat store->add mem", lat_ld_add, 8, "store-forward + add"},
    };
    std::printf("%-26s %10s %12s  %s\n", "test", "cyc/iter", "cyc/instr", "note");
    for (const T& t : tests) {
        t.fn(iters / 10);   // warm up
        double best = 1e30;
        for (int rep = 0; rep < 5; ++rep) {
            double s = now_ns(); t.fn(iters); double e = (now_ns() - s) / iters / cyc;
            if (e < best) best = e;
        }
        std::printf("%-26s %10.3f %12.3f  %s\n", t.name, best, best / t.per, t.note);
    }
}
