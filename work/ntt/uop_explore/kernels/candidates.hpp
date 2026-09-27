// Candidate registry for round 7. Each wrapper has the harness signature.
#pragma once
#include <type_traits>
#include "flip.hpp"

namespace cand {
template<class C> void flip_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    qflip::Kernel<C>::run(n, a, b, r, ir, s, fresh);
}
// Mul: 0 Montgomery, 1 Montgomery+vpmulld, 2 Shoup.
//                      Mul  Flip   Pair  Leaf Shuf   Tile Aux   Opq   LdOdd Il Blk
using F_fp_nml = qflip::Cfg<0, true,  true,  0, false, 256, true, false, true>;        // Intel best
using S_ns_ol  = qflip::Cfg<2, false, true,  0, false, 256, true, true,  true>;        // Zen3 best
using S_ns_oli = qflip::Cfg<2, false, true,  0, false, 256, true, true,  true, 2>;
using S_ns_olb = qflip::Cfg<2, false, true,  0, false, 256, true, true,  true, 1, true>;
using S_sh_olb = qflip::Cfg<2, false, true,  0, true,  256, true, true,  true, 1, true>;
using S_ns_olb1k = qflip::Cfg<2, false, true, 0, false, 1024, true, true, true, 1, true>;
using S_ns_olbp  = qflip::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true>;   // + pipelined leaves
using S_l3       = qflip::Cfg<2, false, true, 3, false, 256, true, true, true, 1, true, false>;  // leaf register reuse
using S_l3p      = qflip::Cfg<2, false, true, 3, false, 256, true, true, true, 1, true, true>;
using S_l4p      = qflip::Cfg<2, false, true, 4, false, 256, true, true, true, 1, true, true>;
using S_l5p      = qflip::Cfg<2, false, true, 5, false, 256, true, true, true, 1, true, true>;
}  // namespace cand

#define CANDIDATE_ENTRIES \
    {"f_fp_nml", cand::flip_invoke<cand::F_fp_nml>}, \
    {"s_ns_oli", cand::flip_invoke<cand::S_ns_oli>}, \
    {"s_ns_olb", cand::flip_invoke<cand::S_ns_olb>}, \
    {"s_sh_olb", cand::flip_invoke<cand::S_sh_olb>}, \
    {"s_ns_olb1k", cand::flip_invoke<cand::S_ns_olb1k>},

// Library Checker path: detects zero upper halves (as the judge wrapper knows N, M).
namespace cand {
inline void lc_invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& s, bool fresh) {
    auto nz = [n](const uint32_t* f) { int k = n; while (k > 0 && f[k - 1] == 0) --k; return k; };
    qflip::Kernel<S_ns_olb>::run(n, a, b, r, ir, s, fresh, nz(a), nz(b));
}
}
#undef CANDIDATE_ENTRIES
#define CANDIDATE_ENTRIES \
    {"f_fp_nml", cand::flip_invoke<cand::F_fp_nml>}, \
    {"s_ns_olb", cand::flip_invoke<cand::S_ns_olb>}, \
    {"s_ns_olbp", cand::flip_invoke<cand::S_ns_olbp>}, \
    {"s_l3p", cand::flip_invoke<cand::S_l3p>}, \
    {"s_l4p", cand::flip_invoke<cand::S_l4p>}, \
    {"s_l5p", cand::flip_invoke<cand::S_l5p>}, \
    {"s_ns_olb_lc", cand::lc_invoke},
