# Complete inverse radix-4 assembly loops

`inverse_asm_transforms.py` independently translates the inverse butterfly from
frozen `ll_inline_h14` (`baseline.hpp`, commit
`50908bb1167af6a32d2b97621a29694814cdebf1`). No fast-reference source is used.

- `asm_inverse_serial`: fixed register allocation and serial Montgomery products.
- `asm_inverse_pair`: interleave the independent `amb*y`/`cmd*z` products, then
  the two independent products by `x`.

Both change only lazy, untwisted, non-identity **inverse** butterflies. Identity
and forward butterflies remain in C++. The Python emitter imports `_single` and
`_pair` from our `radix_asm_transforms.py`; each generated C++ file is self-contained.
These transformations also compose with the forward-assembly transformation.

## Formula and range

For each SIMD position, with all four inputs below `2P`:

```
ab  = low(a+b)              cd  = low(c+d)
amb = Mont(a+2P-b, y)       cmd = Mont(c+2P-d, z)
o0  = low(ab+cd)            o1  = low(amb+cmd)
o2  = Mont(ab+2P-cd, x)     o3  = Mont(amb+2P-cmd, x)
```

Here `low` conditionally subtracts `2P`, and each root is a canonical Montgomery
residue below `P`. Every argument to `Mont` is below `4P`; its result is below
`2P`. Sums passed to `low` are below `4P`, so each output is below `2P`. Since
`4P<2^32`, these unsigned 32-bit additions do not overflow. The original
Montgomery 64-bit overflow proof is unchanged. No new arithmetic reduction
saving is claimed: this experiment changes register allocation and scheduling.

The entire loop fits in sixteen YMM registers: four live coefficients, six
twiddle components, `P` and `2P`, and four temporaries. Four contiguous data
pointers advance by 32 bytes per iteration; roots load once before the loop.
There is no vector spill or scratch access inside the loop. The all-register
clobber and explicit twiddle materialization can nevertheless cost time around
the block, particularly at `h=1` or `h=4`. Restricting assembly to larger stages
is an appropriate separate ablation if measured results justify it.

## Interface and correctness checks

- GNU x86-64 extended assembly, AT&T syntax, AVX2; `h>=1`.
- Coefficient storage is 32-byte aligned with four disjoint spans of `h` vectors;
  the six-vector twiddle structure is separate and naturally aligned.
- Structure sizes are asserted. Every modified YMM register, condition codes and
  memory side effect is declared; moving pointers/count are early-clobber outputs.
- No uninitialized scratch is used inside the block. Sanitizers do not instrument
  its memory instructions, so independent checks and the explicit access audit
  supplement ordinary sanitizer testing.

Clang x86-64/Rosetta validation used `-O3 -mavx2 -mbmi -funroll-loops
-ftrivial-auto-var-init=zero`. Both variants, the original baseline and a combined
forward+inverse paired-assembly variant passed the independent convolution
harness through `2^22`, including repeated calls, changing sizes and boundaries.

Direct inverse checks verified **11,141,120 output lanes** at `h=1,4,16,64`, over
random inputs across `[0,2P)`, boundaries near `P` and `2P`, and arbitrary canonical
twiddles. Each result had to agree bitwise with unchanged C++, agree modulo `P`
with an independent ordinary-residue inverse formula, stay below `2P`, and leave
eight trailing guard coefficients unchanged. All passed.

Ignored local sources/results are in `build/h14_inverse_asm_check/`. These are
correctness checks only; native performance belongs in the main experiment record.
