# Whole-leaf assembly experiments

Starting source: `baseline.hpp`, frozen `ll_inline_h14` from
`50908bb1167af6a32d2b97621a29694814cdebf1`. The mathematics is our own previous
direct-eight leaf algorithm; no fast-reference code is incorporated.

`asm_transforms.py` supplies pure `transform(source, variant)` transformations:

| Variant | Accumulation schedule | Canonical B coefficients |
|---|---|---|
| `asm_leaf_full` | one leaf at a time within each coefficient iteration | 128 bytes of stack scratch |
| `asm_leaf_pair` | two leaves interleaved to expose independent multiplies | 128 bytes of stack scratch |
| `asm_leaf_inplace` | two leaves interleaved | written back to the already destructive B input |

Each variant handles the entire four-leaf batch in one GNU inline-assembly block:
canonicalize both inputs, construct wrapped windows, multiply/accumulate in eight
YMM registers, Montgomery-reduce those same registers, and write results directly
to A. This eliminates the prior assembly experiment's accumulator arrays and its
boundary between accumulation and reduction. It does not eliminate the wrapped
windows: those occupy 256 bytes. The in-place variant therefore reduces leaf
scratch from 384 to 256 bytes. No scratch allocation persists between calls.

These are hypotheses, not measured speedup claims. The large block can also harm
surrounding register allocation, and constrains compiler scheduling.

## Constraints and arithmetic

- Four leaves per invocation, AVX2 x86-64, GNU extended assembly with AT&T syntax.
- A and B are disjoint and 32-byte aligned; each contains at least 32 coefficients.
  B destruction is already allowed by the convolution API; the in-place variant
  additionally stores its canonical values.
- Every input coefficient is below `4P`; every weight is a canonical Montgomery
  residue below `P`, with `P=998244353`. Input canonicalization produces values
  below `P`. Weighted-window preparation uses exactly the baseline Montgomery
  arithmetic and canonicalizes its result.
- Each of eight unsigned 64-bit sums is below `8*(P-1)^2`. Its correction is at
  most `(2^32-1)*P`; their sum is below `2^64`, as asserted by the baseline.
  Reduction yields a value below `3P`, which one conditional subtraction of `2P`
  reduces below `2P`. The output representation is unchanged.
- All sixteen YMM registers, condition codes, and memory effects are declared.
  Mutated pointer/count operands are early-clobber outputs. Numeric local labels
  allow multiple inlined copies without assembler symbol collisions.
- The scratch array has `__attribute__((uninitialized))`: each byte is explicitly
  written by assembly before any read, so suppressing AtCoder's optional automatic
  zero-initialization is valid. No user input or uninitialized byte is exposed.

## Local validation

On the development Mac, all three variants plus the unchanged baseline passed
the existing independent convolution harness through `2^22`, with fresh roots,
repeated calls, large coefficient boundaries and buffer guards. Compile flags
included `-O3 -mavx2 -mbmi -funroll-loops -ftrivial-auto-var-init=zero`, Clang,
x86-64 target, Rosetta execution. This is correctness evidence only, not native
timing evidence. Local generated sources/output are in ignored
`build/h14_asm_check/`.

A separate ordinary-modulo leaf oracle checked 393,216 output lanes over 4,096
four-leaf batches per variant, including incoming coefficients near `P`, `2P`,
`3P`, and `4P`, random values throughout `[0,4P)`, and random Montgomery weights.
It verified both congruence and the output bound `<2P`. All passed. Inline assembly
memory instructions are not instrumented by ASan, so independent comparisons and
the explicit access/initialization audit remain necessary alongside sanitizer runs.

Native timing and further checks are recorded by the main experiment harness.
