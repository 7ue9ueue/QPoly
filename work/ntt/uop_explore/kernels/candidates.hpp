// Candidate registry for round 7. Each wrapper has the harness signature.
#pragma once
#include <type_traits>
#include "flip.hpp"

namespace cand {
template<class C> void flip_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    qflip::Kernel<C>::run(n, a, b, r, ir, s, fresh);
}
// Mul: 0 Montgomery, 1 Montgomery+vpmulld, 2 Shoup.
//                      Mul  Flip   Pair  Leaf Shuf   Tile Aux   Opq    LdOdd
using F_fp_nm  = qflip::Cfg<0, true,  true,  0>;                                   // Intel best so far
using F_fp_nml = qflip::Cfg<0, true,  true,  0, false, 256, true, false, true>;
using S_sh     = qflip::Cfg<2, false, true,  0, true,  256, true>;                 // Zen3 best so far
using S_sh_o   = qflip::Cfg<2, false, true,  0, true,  256, true, true,  false>;
using S_sh_ol  = qflip::Cfg<2, false, true,  0, true,  256, true, true,  true>;
using S_ns_o   = qflip::Cfg<2, false, true,  0, false, 256, true, true,  false>;
using S_ns_ol  = qflip::Cfg<2, false, true,  0, false, 256, true, true,  true>;
}  // namespace cand

#define CANDIDATE_ENTRIES \
    {"f_fp_nm", cand::flip_invoke<cand::F_fp_nm>}, \
    {"f_fp_nml", cand::flip_invoke<cand::F_fp_nml>}, \
    {"s_sh", cand::flip_invoke<cand::S_sh>}, \
    {"s_sh_o", cand::flip_invoke<cand::S_sh_o>}, \
    {"s_sh_ol", cand::flip_invoke<cand::S_sh_ol>}, \
    {"s_ns_o", cand::flip_invoke<cand::S_ns_o>}, \
    {"s_ns_ol", cand::flip_invoke<cand::S_ns_ol>},
