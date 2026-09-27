// Bit-exact unit tests for the generated assembly (exploration 009).
// Each asm radix-4 loop variant must produce exactly the words of qasm::fwd4 /
// qasm::inv4 (C++, same Shoup arithmetic) for h in {1,2,4,8,16,64}, with random
// inputs over the whole valid range (forward < 4P, inverse < 2P) and boundary
// values 0, P-1, P, 2P-1 (and 2P, 4P-1 forward). Each leaf MAC variant must
// match qasm::leaf_mac on windows built by qasm::leaf_build from inputs < 4P.
// Exits 1 on the first mismatch. Usage: unit [iterations]
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
using C = Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true>;
using K = Kernel<C>;

static std::mt19937 rng(9);
static U pick(U bound) {
    static const U edges[] = {0, 1, P - 1, P, P + 1, 2 * P - 1, 2 * P, 3 * P, 4 * P - 1};
    if (rng() % 8 == 0) { U e = edges[rng() % 9]; return e < bound ? e : bound - 1; }
    return rng() % bound;
}
[[noreturn]] static void fail(const char* what, int v, int h, int i) {
    std::printf("FAIL %s variant %d h=%d word %d\n", what, v, h, i);
    std::exit(1);
}

int main(int argc, char** argv) {
    const int iters = argc > 1 ? std::atoi(argv[1]) : 200;
    alignas(64) static U T[1 << 12], IT[1 << 12];
    int size = 0;
    K::tables(1 << 11, T, IT, size, true);
    alignas(64) static U x[4 * 64 * 8 + 64], y[4 * 64 * 8 + 64];
    long checks = 0;
    for (int kind = 0; kind < 2; ++kind) {
        for (int v = 1; v < 100; ++v) {
            char key[8]; std::snprintf(key, sizeof key, " %d ", v);   // generated (not skipped) variants
            if (!std::strstr(kind ? ASM_INV_IDS : ASM_FWD_IDS, key)) continue;
            for (int h : {1, 2, 4, 8, 16, 64}) {
                if (h % ASM_STEP(kind, v)) continue;
                for (int it = 0; it < iters; ++it) {
                    const int k = 1 + int(rng() % 500);
                    const int n = 4 * h * 8;
                    for (int i = 0; i < n + 16; ++i) x[i] = pick(kind ? 2 * P : 4 * P);
                    std::memcpy(y, x, sizeof(U) * (n + 16));
                    const U* t = kind ? IT : T;
                    const U *px = t + K::blk(k), *py = t + K::blk(2 * k);
                    const Twiddle tw{Fixed(splat(px[0]), splat(px[8])), Fixed(splat(py[0]), splat(py[8])),
                                     Fixed(splat(py[1]), splat(py[9]))};
                    if (kind) { inv4<C, false>((V*)x, h, tw); inv_asm(v, (V*)y, h, px, py); }
                    else { fwd4<C, false>((V*)x, h, tw); fwd_asm(v, (V*)y, h, px, py); }
                    for (int i = 0; i < n + 16; ++i) if (x[i] != y[i]) fail(kind ? "inv" : "fwd", v, h, i);
                    ++checks;
                }
            }
        }
        std::printf("PASS %s variants %s\n", kind ? "inv" : "fwd", kind ? ASM_INV_IDS : ASM_FWD_IDS);
    }
    // leaf MAC variants against the C++ MAC on identical buffers
    for (int v = 2; v <= ASM_LEAF_MAX; ++v) {
        for (int it = 0; it < iters * 20; ++it) {
            alignas(64) V a[4], b[4], r1[4], r2[4];
            for (int t = 0; t < 4; ++t) for (int l = 0; l < 8; ++l) { ((U*)&a[t])[l] = pick(4 * P); ((U*)&b[t])[l] = pick(4 * P); }
            alignas(16) U w[4], wi[4];
            for (int t = 0; t < 4; ++t) { U m = mont(1 + rng() % (P - 1)); w[t] = muls(m, 1); wi[t] = m * NI; }
            LeafBuf64 L;
            leaf_build<C>(a, b, w, wi, L);
            leaf_mac<C>(r1, L);
            leaf_mac_asm(v, r2, &L);
            if (std::memcmp(r1, r2, sizeof r1)) fail("leaf", v, 1, 0);
            ++checks;
        }
        std::printf("PASS leaf variant %d\n", v);
    }
    std::printf("ALL UNIT CHECKS PASSED (%ld cases)\n", checks);
}
