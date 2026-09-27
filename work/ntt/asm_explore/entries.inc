// Registry of implementations compiled into bench.cpp (exploration 009).
// "live" is the kernel of Library Checker submission 406403 (qflip s_ns_olbp),
// compiled from uop_explore/kernels/flip.hpp unchanged; every q_* entry is the
// qasm copy with the same configuration plus the listed assembly switches.
#pragma once
#include <type_traits>
using Fn = void (*)(int, uint32_t*, uint32_t*, uint32_t*, uint32_t*, int&, bool);
struct Entry { const char* name; Fn fn; };

#include "../uop_explore/kernels/flip.hpp"
#include "kernels/qasm.hpp"

namespace cand {
template<class K> void invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    K::run(n, a, b, r, ir, s, fresh);
}
using Live = qflip::Kernel<qflip::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true>>;
// AsmF / AsmI: gen_asm.py VARIANTS id (1 df, 2 ls, 3 lsnf, 5 ls2t, 7 spt); AsmLeaf: 1 = C++ with
// 64-byte aligned leaf buffer, >= 2 LEAF_VARIANTS id.
template<int F, int I, int L>
using Q = qasm::Kernel<qasm::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, F, I, L>>;
}  // namespace cand

#define QE(F, I, L) {"q_f" #F "i" #I "l" #L, cand::invoke<cand::Q<F, I, L>>}
#ifndef ENTRY_LIST
#define ENTRY_LIST                                                                         \
    QE(0, 0, 0), QE(0, 0, 1),                                                              \
    QE(1, 1, 0), QE(2, 2, 0), QE(2, 3, 0), QE(3, 3, 0), QE(5, 5, 0), QE(7, 7, 0),          \
    QE(0, 0, 2), QE(0, 0, 3), QE(0, 0, 4), QE(0, 0, 5), QE(0, 0, 6), QE(0, 0, 7), QE(0, 0, 8)
#endif
const Entry ENTRIES[] = {
    {"live", cand::invoke<cand::Live>},
    ENTRY_LIST
};
