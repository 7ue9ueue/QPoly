// Candidate registry for round 7. Each wrapper has the harness signature.
#pragma once
#include <type_traits>
#include "flip.hpp"

namespace cand {
template<class C> void flip_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    qflip::Kernel<C>::run(n, a, b, r, ir, s, fresh);
}
//                         Mullo Flip  Pair   LeafOdd
using F_base   = qflip::Cfg<true, false, false, false>;  // rewrite of mullo_bottom
using F_flip   = qflip::Cfg<true, true,  false, false>;
using F_pair   = qflip::Cfg<true, false, true,  false>;
using F_leaf   = qflip::Cfg<true, false, false, true>;
using F_all    = qflip::Cfg<true, true,  true,  true>;
using F_all_nm = qflip::Cfg<false, true, true,  true>;   // h14-style quotient (Intel)
}  // namespace cand

#define CANDIDATE_ENTRIES \
    {"f_base", cand::flip_invoke<cand::F_base>}, \
    {"f_flip", cand::flip_invoke<cand::F_flip>}, \
    {"f_pair", cand::flip_invoke<cand::F_pair>}, \
    {"f_leaf", cand::flip_invoke<cand::F_leaf>}, \
    {"f_all", cand::flip_invoke<cand::F_all>}, \
    {"f_all_nm", cand::flip_invoke<cand::F_all_nm>},
