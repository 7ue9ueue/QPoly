# Montgomery instruction-selection experiments

Starting source: frozen `baseline.hpp`, the existing ll_inline_h14 at 50908bb.
Both variants preserve roots, traversal and the representation. No reference
kernel is used.

- `h14_mont_mullo` computes all eight low correction words with one `vpmulld`
  instead of two `vpmuludq`. The number of source multiply instructions falls
  from six to five, but hardware cost and dependency latency need measurement.
  The vector constructor duplicates each 64-bit pair's low correction word with
  `vpshufd 0xa0`. Distinct roots in each pair remain supported.
- `h14_mont_shiftmod` expands `q*P` using
  `P=2^30-2^26-2^23+1`. It masks q to 32 bits, then uses three shifts, two
  subtractions and one addition. This trades multiplication pressure for more
  instructions, so a regression is plausible.

If R=2^32, x<4P<R, w<P and q=(x*w*NI) mod R, both compute exactly
`(x*w+q*P)/R`. The numerator is below 2RP<R² and divisible by R; the result is
below 2P. Odd corrected products have zero low 32 bits, preserving OR packing.
The shift expansion's largest intermediate is below 2^62. The scoped change to
Fixed does not change the accumulated-dot-product reducer.

Direct tests cover 2,097,152 lanes with independent ordinary-modulo results,
scalar and four-distinct-pair twiddles, full [0,4P) input and output <2P. Full
convolution and sanitizer evidence is saved per native run. These formulas and
the constructor lane mapping were independently reviewed by a second agent.

Instruction semantics: [Intel Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html).
Assembly operand rules used in the separate whole-loop experiments:
[GCC extended asm](https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html).
