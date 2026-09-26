# Stage/traversal hypotheses

Starting source: the frozen `baseline.hpp`, independently derived from
`kernel_ll_inline_h14` at experiment revision `50908bb`. All five transformations
retain Montgomery arithmetic and the original hybrid root preparation. They use
`Kernel<true,false,2,256,4,2,true>`. No reference implementation was consulted or
copied for these changes.

- `h14_fuse_bottom`: move each final h=1 forward group immediately before its four
  direct8 products and immediately follow those products with h=1 inverse. This
  can improve locality and remove two complete traversals of the tile. It may
  worsen instruction-cache pressure or register lifetime across the fused block.
- `h14_fuse_two`: additionally fuse h=4 around each sixteen-vector subtree.
  Upper tile stages still use the baseline traversal. Leaf factors are consumed
  in exactly the same increasing order, so the incremental cursor is unchanged.
- `h14_fixed_tile`: specialize the four possible tile sizes (4, 16, 64, 256
  vectors), exposing every stage length and group-index divisor as a constant.
  Keep a function boundary once per tile and counted group loops to bound code
  expansion. Tests whether address/index simplification outweighs code size.
- `h14_fixed_bottom`: combine constant tile stages with the first bottom-fusion
  experiment, testing whether the compiler can improve the composed path.
- `h14_pair_forward`: put the A and B butterfly calculations within the same
  `j` iteration, reusing twiddle state and exposing adjacent independent work.
  Forward arithmetic is unchanged; inverse traversal remains the baseline.

Fusion does not remove the lazy reductions at the leaf boundary: direct8 still
canonicalizes its inputs and returns values below 2P before inverse butterflies.
Supported sizes, canonical output, disjoint aligned buffers, fresh/reused root
semantics and caller-owned scratch all remain the baseline contract.

`stage_transforms.transform(source, variant)` is namespace-agnostic and asserts
every expected source match. Generated code is temporary build output; this
module and the frozen source fully describe each change.

Local preflight: all five variants compiled with Apple Clang for x86_64 AVX2 and
`-O3 -funroll-loops -ftrivial-auto-var-init=zero`, then passed the existing
independent-oracle harness under Rosetta at every power 2^6 through 2^22, fresh
and repeated calls, changing sizes, and large coefficient boundaries. Output is
in ignored `build/h14_stage_agent/checks.txt`. This is correctness evidence only;
native measurements and sanitizer evidence belong to the main experiment run.
