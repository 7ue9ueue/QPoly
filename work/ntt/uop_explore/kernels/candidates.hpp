// Candidate registry for round 7. Each wrapper has the harness signature.
#pragma once
#include <type_traits>
#include "flip.hpp"

namespace cand {
template<class C> void flip_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    qflip::Kernel<C>::run(n, a, b, r, ir, s, fresh);
}
// Mul: 0 Montgomery, 1 Montgomery+vpmulld, 2 Shoup.
//                     Mul  Flip   Pair  Leaf Shuf  Tile  Aux
using F_flip  = qflip::Cfg<1, true,  false, 0>;
using F_fp_nm = qflip::Cfg<0, true,  true,  0>;             // Intel best so far
using S_sh_m  = qflip::Cfg<2, false, true,  0, true, 256, false>;  // round-3 s_p_sh
using S_sh    = qflip::Cfg<2, false, true,  0, true, 256, true>;   // + Shoup leaf w*a and scale
using S_sh64  = qflip::Cfg<2, false, true,  0, true, 64,  true>;
using S_sh1k  = qflip::Cfg<2, false, true,  0, true, 1024, true>;
using S_ns    = qflip::Cfg<2, false, true,  0, false, 256, true>;
}  // namespace cand

#define CANDIDATE_ENTRIES \
    {"f_flip", cand::flip_invoke<cand::F_flip>}, \
    {"f_fp_nm", cand::flip_invoke<cand::F_fp_nm>}, \
    {"s_sh_m", cand::flip_invoke<cand::S_sh_m>}, \
    {"s_sh", cand::flip_invoke<cand::S_sh>}, \
    {"s_sh64", cand::flip_invoke<cand::S_sh64>}, \
    {"s_sh1k", cand::flip_invoke<cand::S_sh1k>}, \
    {"s_ns", cand::flip_invoke<cand::S_ns>},
