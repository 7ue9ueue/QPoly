#pragma once
#include <cstdint>
// Cyclic convolution, P=998244353, tested for power-of-two 64 <= n <= 2^22.
// a,b: disjoint 32-byte-aligned mutable arrays of n canonical uint32_t coefficients.
// r,ir: disjoint 32-byte-aligned scratch arrays of at least n/8 uint32_t values each.
// Initialize root_size=0. Set fresh=true to regenerate tables; otherwise retain
// r,ir,root_size together between calls. Larger future n needs larger scratch capacity.
// a receives canonical output; b is destroyed. Caller owns all buffers.
// No allocation is performed by invoke. Not safe to share mutable buffers concurrently.
namespace direct8_identity {
void invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir,
            int& root_size, bool fresh);
}
namespace recursive_identity2 {
void invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir,
            int& root_size, bool fresh);
}
