// Common interface of the four implementations (one translation unit each).
//
// Workload: cyclic convolution modulo P = 998244353 of two length-n sequences,
// n = 2^lg, inputs and outputs canonical residues in [0, P).
//   init(max_n)  allocates and zeroes the implementation's own buffers (untimed)
//   load(x, y, n) copies the inputs into those buffers (untimed)
//   run(n)       the convolution (timed)
//   result()     the n output values (untimed)
// run() includes everything the implementation computes per convolution: root or
// twiddle generation, Montgomery conversions, final scaling and its own allocations.
#pragma once
#include <cstdint>

namespace lcb {
using u32 = std::uint32_t;
constexpr u32 P = 998244353;

struct Impl {
    const char* name;
    int max_lg;
    void (*init)(int max_n);
    void (*load)(const u32* x, const u32* y, int n);
    void (*run)(int n);
    const u32* (*result)();
};

extern const Impl kactl, simd_v0, qgq_393435, ours_406478;
}  // namespace lcb
