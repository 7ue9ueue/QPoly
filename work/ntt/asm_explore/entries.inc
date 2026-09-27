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
template<int F, int I, int L, int M, int B = 0, int T = 0, int Id = 0, int Sc = 0>
using Q = qasm::Kernel<qasm::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, F, I, L, M, B, T, Id, Sc>>;
// Library Checker path: the judge wrapper knows N and M, i.e. which upper halves are zero.
template<class K> void lc_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    auto nz = [n](const uint32_t* f) { int k = n; while (k > 0 && f[k - 1] == 0) --k; return k; };
    K::run(n, a, b, r, ir, s, fresh, nz(a), nz(b));
}
}  // namespace cand

// QE(F, I, L, M): AsmF, AsmI, AsmLeaf, AsmMinH (asm loops only for h >= M).
// QB(F, I, M, B): fused assembly bottom stage variant B (replaces the leaf path).
#define QE(F, I, L, M) {"q_f" #F "i" #I "l" #L "m" #M, cand::invoke<cand::Q<F, I, L, M>>}
#define QB(F, I, M, B) {"q_f" #F "i" #I "m" #M "b" #B, cand::invoke<cand::Q<F, I, 0, M, B>>}
// QT(F, I, M, B, T): as QB plus copy-free top level T, run through the zero-upper-half detection
// (LQ: same detection without T) so that both see the ordinary-convolution shortcut.
#define QT(F, I, M, B, T) {"lc_f" #F "i" #I "m" #M "b" #B "t" #T, cand::lc_invoke<cand::Q<F, I, 0, M, B, T>>}
#define LLIVE {"lc_live", cand::lc_invoke<cand::Live>}
// QX(B, Id, Sc): f11/i71 at every h, fused bottom B, identity-group loop Id, scale loop Sc.
#define QX(B, Id, Sc) {"q_f11i71b" #B "id" #Id "sc" #Sc, cand::invoke<cand::Q<11, 71, 0, 4, B, 0, Id, Sc>>}
#ifndef ENTRY_LIST
#define ENTRY_LIST                                                                         \
    QE(0, 0, 0, 4), QX(23, 0, 0), QX(27, 0, 0),                                             \
    QX(23, 1, 0), QX(23, 2, 0), QX(23, 4, 0), QX(23, 0, 2), QX(23, 0, 4), QX(23, 2, 2), QX(23, 4, 4)
#endif
const Entry ENTRIES[] = {
    {"live", cand::invoke<cand::Live>},
    ENTRY_LIST
};
