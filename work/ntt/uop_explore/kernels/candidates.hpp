// Candidate registry for round 7. Each wrapper has the harness signature.
#pragma once
#include <type_traits>
#include "flip.hpp"

namespace cand {
template<class C> void flip_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    qflip::Kernel<C>::run(n, a, b, r, ir, s, fresh);
}
// Mul: 0 Montgomery, 1 Montgomery+vpmulld, 2 Shoup.
//                  Mul  Flip   Pair  Leaf Shuf
using F_nm   = qflip::Cfg<0, false, false, 0>;   // rewrite control, ~h14
using F_flip = qflip::Cfg<1, true,  false, 0>;
using F_fp   = qflip::Cfg<1, true,  true,  0>;
using F_fp_nm= qflip::Cfg<0, true,  true,  0>;
using S_p    = qflip::Cfg<2, false, true,  0>;
using S_p_sh = qflip::Cfg<2, false, true,  0, true>;
using S_pl1  = qflip::Cfg<2, false, true,  1>;
}  // namespace cand

#define CANDIDATE_ENTRIES \
    {"f_nm", cand::flip_invoke<cand::F_nm>}, \
    {"f_flip", cand::flip_invoke<cand::F_flip>}, \
    {"f_fp", cand::flip_invoke<cand::F_fp>}, \
    {"f_fp_nm", cand::flip_invoke<cand::F_fp_nm>}, \
    {"s_p", cand::flip_invoke<cand::S_p>}, \
    {"s_p_sh", cand::flip_invoke<cand::S_p_sh>}, \
    {"s_pl1", cand::flip_invoke<cand::S_pl1>},
