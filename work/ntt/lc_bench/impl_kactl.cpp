// KACTL NTT (kactl.github.io, CC0) as in kactl_bench.cpp, compiled under that file's pragmas.
// Its root table is a function-local static: built by the warmup, then reused (the only
// implementation here that keeps roots between calls). cyclic_conv takes its vectors by
// value; load() builds them and run() moves them in, so run() times KACTL's own work
// including its internal allocations (bit-reversal table, result vector).
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2")
#include <algorithm>
#include <vector>
#include "kactl.inc"
#include "impl.hpp"

namespace {
std::vector<int> va, vb, vc;
void init(int) {}
void load(const lcb::u32* x, const lcb::u32* y, int n) { va.assign(x, x + n); vb.assign(y, y + n); }
void run(int n) { vc = KACTL::cyclic_conv(std::move(va), std::move(vb), n); }
const lcb::u32* result() { return reinterpret_cast<const lcb::u32*>(vc.data()); }
}  // namespace
const lcb::Impl lcb::kactl = {"KACTL", 22, init, load, run, result};
