// QgQ, Library Checker submission 393435 (https://judge.yosupo.jp/submission/393435):
// its ntt998.hpp region verbatim, compiled under its own pragmas. run() makes the same
// calls as the submission's main(): first operand as raw words, second converted to
// Montgomery form, then convolution_adaptive_mixed_normal_inplace, whose output is
// canonical and in normal form. Twiddles come from compile-time rate tables.
#include "qgq_393435.inc"
#if defined(__clang__)
#pragma clang attribute pop  // 393435 pushes its target attribute and never pops (clang only)
#endif
#include "impl.hpp"
#if !defined(__AVX2__)
#error "393435's fast path needs AVX2"
#endif

namespace {
namespace ntt = eez::ntt998;
ntt::mint *A, *B;
void init(int max_n) {
    A = static_cast<ntt::mint*>(::operator new[](size_t(max_n) * 4, std::align_val_t{64}));
    B = static_cast<ntt::mint*>(::operator new[](size_t(max_n) * 4, std::align_val_t{64}));
    std::memset(A, 0, size_t(max_n) * 4); std::memset(B, 0, size_t(max_n) * 4);
}
void load(const lcb::u32* x, const lcb::u32* y, int n) { std::memcpy(A, x, size_t(n) * 4); std::memcpy(B, y, size_t(n) * 4); }
void run(int n) {
    ntt::detail::convert_to_montgomery(B, size_t(n));
    ntt::detail::convolution_adaptive_mixed_normal_inplace(A, B, size_t(n));
}
const lcb::u32* result() { return reinterpret_cast<const lcb::u32*>(A); }
}  // namespace
const lcb::Impl lcb::qgq_393435 = {"393435", 22, init, load, run, result};
