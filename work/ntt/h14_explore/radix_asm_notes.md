# Complete forward radix-4 assembly loops

`radix_asm_transforms.py` builds two independent variants from frozen
`baseline.hpp` (`ll_inline_h14`, commit
`50908bb1167af6a32d2b97621a29694814cdebf1`). No fast-reference source is used.

- `asm_radix4_serial`: manually allocated whole-loop registers with serial
  Montgomery products.
- `asm_radix4_pair`: same register allocation, interleaving the independent
  `c*x`/`d*x` chains and then the independent `bd*y`/`bmd*z` chains.

Both replace only the lazy, untwisted, non-identity forward butterfly. Identity
butterflies and every inverse butterfly stay in C++. All `h` values, including
the existing specialized 1/4 cases, use the assembly when this condition holds.

## Register allocation and purpose

The complete loop uses four coefficient registers, six twiddle registers, two
modulus registers and four temporary registers: exactly sixteen YMM registers.
Twiddles are loaded before the loop, and four contiguous pointers advance by one
vector per iteration. No vector spills or scratch accesses occur inside the loop.
This could improve compiler register allocation and instruction scheduling, but
the all-register clobber and forced materialization of the twiddle structure can
also add overhead around the block, especially when `h` is small. Native timing
is required; these are hypotheses rather than claimed improvements.

The paired version fits without additional registers by saving odd input lanes,
then reusing the input registers for even-lane corrections. The four independent
chains then merge into the corrected even and odd products. All Montgomery
operations and reductions are otherwise the existing algorithm.

## Contract and bounds

- GNU extended assembly, AT&T syntax, AVX2, x86-64. `h>=1`.
- Data is 32-byte aligned, with four non-overlapping spans of `h` vectors.
  The supplied twiddle is separate from that data.
- Input values are below `4P`. The first two vectors are reduced below `2P`;
  each twiddle is canonical below `P`. Fixed multiplication returns below `2P`.
  Intermediate sum/difference bounds and final values below `4P` are unchanged
  from the baseline proof. `4P<2^32` prevents wraparound in those sums.
- The two-vector Fixed layout and six-vector Twiddle layout are asserted. Both
  consist solely of naturally aligned AVX2 vector members in declaration order.
- All sixteen YMM clobbers, condition codes, and memory effects are declared.
  Four moving pointers and the loop count are early-clobber read/write operands.
- There is no uninitialized scratch storage in these assembly loops.

## Local correctness evidence

Both variants and the unchanged baseline passed the existing independent
convolution harness through `2^22`, including fresh/repeated calls, changing sizes,
large coefficient boundaries and buffer guards. A separate direct differential
test checked **11,141,120 radix output lanes** at `h=1,4,16,64`, spanning random
incoming values across `[0,4P)`, boundaries near multiples of `P`, and arbitrary
canonical twiddles. It required bitwise equality with the C++ butterfly, checked
the `<4P` output bound and verified eight guard coefficients after each block.

Tests ran with Clang, `-O3 -mavx2 -mbmi -funroll-loops
-ftrivial-auto-var-init=zero`, x86-64 target under Rosetta. These are correctness
checks, not native speed measurements. Ignored local evidence is in
`build/h14_radix_asm_check/`. As with other inline assembly, ASan does not
instrument the instructions inside the block; the explicit access audit and
independent checks supplement sanitizer runs.
