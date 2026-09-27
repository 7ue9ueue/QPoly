// Our current best for n <= 2^22: the exploration-009 kernel (Shoup radix-4 with generated
// inline assembly), verbatim from the source of our submission 406478, compiled under its
// own pragmas. Same kernel configuration as that submission's main(). Fresh roots every
// call (root_size = 0), as in the submission. The submission also passes the input lengths
// so the zero upper halves of padded inputs skip the first forward layer; here the inputs
// fill all n words, so that shortcut never applies and every implementation does the same
// full cyclic convolution.
#include "ours_406478.inc"
#include "impl.hpp"

namespace {
using Kernel = qasm::Kernel<qasm::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, 11, 71, 0, 4, 23, 0, 2, 2, 104>>;
uint32_t *A, *B, *roots, *inv_roots;
void* alloc(size_t bytes) { void* p = std::aligned_alloc(64, bytes); std::memset(p, 0, bytes); return p; }
void init(int max_n) {
    // Contract: 16 words of padding after the data (odd-lane loads read 4 bytes past the
    // last vector); root tables n/8 words.
    A = (uint32_t*)alloc((size_t(max_n) + 16) * 4); B = (uint32_t*)alloc((size_t(max_n) + 16) * 4);
    roots = (uint32_t*)alloc((size_t(max_n) / 8 + 16) * 4); inv_roots = (uint32_t*)alloc((size_t(max_n) / 8 + 16) * 4);
}
void load(const lcb::u32* x, const lcb::u32* y, int n) { std::memcpy(A, x, size_t(n) * 4); std::memcpy(B, y, size_t(n) * 4); }
void run(int n) {
    int root_size = 0;
    Kernel::run(n, A, B, roots, inv_roots, root_size, true);
}
const lcb::u32* result() { return A; }
}  // namespace
const lcb::Impl lcb::ours_406478 = {"ours-406478", 22, init, load, run, result};
