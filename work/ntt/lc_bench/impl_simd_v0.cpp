// simd-v0: the user's original AVX2 Montgomery NTT from kactl_bench.cpp, compiled under
// that file's pragmas. Fresh roots every call (reset_roots, then run_simd_convolution
// regenerates them), as in kactl_bench.cpp's timing loop.
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2")
#include <immintrin.h>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include "simd_v0.inc"
#include "impl.hpp"

namespace {
simd0::v8i *A, *B;
uint32_t *roots, *inv_roots;
void* alloc(size_t bytes) { void* p = std::aligned_alloc(64, bytes); std::memset(p, 0, bytes); return p; }
void init(int max_n) {
    A = (simd0::v8i*)alloc(size_t(max_n) * 4); B = (simd0::v8i*)alloc(size_t(max_n) * 4);
    roots = (uint32_t*)alloc(size_t(max_n) * 4); inv_roots = (uint32_t*)alloc(size_t(max_n) * 4);
}
void load(const lcb::u32* x, const lcb::u32* y, int n) { std::memcpy(A, x, size_t(n) * 4); std::memcpy(B, y, size_t(n) * 4); }
void run(int n) {
    int root_size = 0;
    simd0::reset_roots(roots, inv_roots, root_size);
    simd0::run_simd_convolution(n, A, B, roots, inv_roots, root_size);
}
const lcb::u32* result() { return reinterpret_cast<const lcb::u32*>(A); }
}  // namespace
const lcb::Impl lcb::simd_v0 = {"simd-v0", 22, init, load, run, result};
