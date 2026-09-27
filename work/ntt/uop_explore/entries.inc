// Registry of implementations compiled into bench.cpp.
#pragma once
using Fn = void (*)(int, uint32_t*, uint32_t*, uint32_t*, uint32_t*, int&, bool);
struct Entry { const char* name; Fn fn; };

#include "baselines/h14.hpp"
#include "baselines/mullo_bottom.hpp"
#include "baselines/asm_large_fixed.hpp"
#include "baselines/ref_yosupo.hpp"
#include "kernels/candidates.hpp"

const Entry ENTRIES[] = {
    {"h14", ll_inline_h14::invoke},
    {"asm_large_fixed", asm_radix4_pair_large_fixed::invoke},
    {"ref_yosupo", ref_yosupo::invoke},
    CANDIDATE_ENTRIES
};
