// Candidate registry for round 7. Each wrapper has the harness signature.
#pragma once
#include <type_traits>
#include "flip.hpp"

namespace cand {
template<class C> void flip_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    qflip::Kernel<C>::run(n, a, b, r, ir, s, fresh);
}
//                   Mullo  Flip  Pair  Leaf Shuf
using F_flip      = qflip::Cfg<true,  true, false, 0>;
using F_flip_nm   = qflip::Cfg<false, true, false, 0>;
using F_fp        = qflip::Cfg<true,  true, true,  0>;
using F_fp_nm     = qflip::Cfg<false, true, true,  0>;
using F_fpl1_nm   = qflip::Cfg<false, true, true,  1>;
using F_fpl2_nm   = qflip::Cfg<false, true, true,  2>;
using F_fpl2      = qflip::Cfg<true,  true, true,  2>;
using F_fp_nm_sh  = qflip::Cfg<false, true, true,  0, true>;
using F_fpl2_nm_sh= qflip::Cfg<false, true, true,  2, true>;
}  // namespace cand

#define CANDIDATE_ENTRIES \
    {"f_flip", cand::flip_invoke<cand::F_flip>}, \
    {"f_flip_nm", cand::flip_invoke<cand::F_flip_nm>}, \
    {"f_fp", cand::flip_invoke<cand::F_fp>}, \
    {"f_fp_nm", cand::flip_invoke<cand::F_fp_nm>}, \
    {"f_fpl1_nm", cand::flip_invoke<cand::F_fpl1_nm>}, \
    {"f_fpl2_nm", cand::flip_invoke<cand::F_fpl2_nm>}, \
    {"f_fpl2", cand::flip_invoke<cand::F_fpl2>}, \
    {"f_fp_nm_sh", cand::flip_invoke<cand::F_fp_nm_sh>}, \
    {"f_fpl2_nm_sh", cand::flip_invoke<cand::F_fpl2_nm_sh>},
