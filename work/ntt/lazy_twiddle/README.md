# Lazy radix-4 / incremental-twiddle exploration

Starting experiment commit: `1e5a80f`. Starting code: the user's
`kactl_bench.cpp` Montgomery arithmetic and exploration 002's independently
written direct8 leaf method. `kernel.hpp` is a new implementation; no study/reference
code is copied into it. The existing study v2 snapshot is only a separate benchmark
control. The standalone AtCoder file contains **no study/reference NTT code**.

## Derivation and contracts

Modulus P=998244353, Montgomery R=2^32, powers of two 64<=N<=2^22 tested. Inputs
are canonical ordinary residues. A and B are disjoint, mutable, 32-byte-aligned
arrays of N uint32_t; A receives canonical output and B is destroyed. The caller
owns all memory. No concurrent sharing of buffers or root state. The kernel does
not allocate. `Kernel::run` takes N, A, B, root scratch, inverse-root scratch,
root_size and fresh. Start root_size at zero; retain it with the root buffers for
reuse. Sizes outside the contract, other moduli, aliasing and misalignment are
unsupported. The benchmark intentionally uses generous scratch for common controls.

**Lazy ranges.** Forward inputs/outputs are in [0,4P); inverse inputs/outputs in
[0,2P). For canonical twiddle w<P and a<4P, Montgomery multiplication returns <2P:
`(a*w+(2^32-1)*P)/2^32 < 2P`, since 4P<2^32. Before adding two terms without a
reduction, both are <2P. Subtraction is `a+2P-b`, also <4P. This removes reductions
before multiply and at forward stores while preserving 32-bit unsigned bounds.

The factorized forward butterfly computes C=a2*x, D=a3*x; then
`u=reduce2(a0+C)`, `v=reduce2(a0+2P-C)`, `s=(a1+D)*y`, `t=(a1+2P-D)*z`.
Outputs are u+s, u+2P-s, v+t, v+2P-t. a0/a1 are first brought below 2P.
The inverse moves reductions to sums that will be added again, leaving differences
unreduced before canonical-root Montgomery products. Identity cases replace the
omitted multiplication's range reduction explicitly.

**Alternative factorization.** x=y^2 and z=I*y. The twisted variant computes
a1*y, a2*y^2, a3*y^3 independently, followed by an I multiplication of a difference.
It has the same multiplication count but a different dependency graph/register
lifetime. It was slower in the first native comparison.

**Incremental twiddles.** Let q[b]=3^((P-1)/2^(b+2)), and
`r[k]=product(q[b] for set bits b of k)`. If t is the number of trailing one bits
of k, `r[k+1]/r[k]=q[t]/product(q[0:t])`. For r[2k], shift q's index by one.
Each stage stores a four-lane 64-bit cursor containing its x,y,z roots. Updating
those lanes in parallel avoids the O(N) root table. The fixed-rate experiment
stores a multiplier and its Montgomery correction factor in each rate's low/high
32 bits, permitting the product and correction chains to start independently.

**Leaf weights.** The partial transform factors into products modulo x^8-r[j]^2.
For a batch of four leaves the factors are w,-w,I*w,-I*w. A separate scalar cursor
advances w once per batch with the derived shifted carry rule. Leaf inputs are
canonicalized; eight accumulated products plus Montgomery correction satisfy
`8*(P-1)^2+(2^32-1)*P <2^64`. Their reduction is <3P; reduce by 2P for the inverse.
The inverse has N/8 transform gain and the leaf has introduced R^-1; multiplying
by `(N/8)^-1 * R^2` via Montgomery multiplication gives ordinary canonical output.

**RootMode:** 0 uses canonical root tables with N/8 scratch entries per direction;
1 is fully incremental; 2 retains N/16 transform roots but uses incremental leaves;
3 uses fully incremental fixed-rate updates. Modes 1 and 3 do not dereference root
scratch. All fixed metadata is constexpr; setup/allocation of metadata is not timed.
`Tile` is measured in 8-coefficient vectors. Two input tiles of 256 vectors occupy
16 KiB. LeafBatch=2 tests lower register pressure against the default batch of four.

**Leaf scheduling.** LeafSchedule=0 permits compiler unrolling; 1 forces a counted
eight-step accumulation loop; 2 requests two-way unrolling. On GCC 13, the counted
version reduced the leaf function from 646 to 262 static instructions, its stack
reservation from 0x720 to 0x1a0 bytes, and vector instructions referencing rsp from
160 to 12. These are assembly counts, not hardware-counter measurements. Runtime
improved modestly; the counted and two-way variants have CPU-dependent ordering.

**Final normalization.** FuseTop=true combines the outer inverse radix-2 stage
with normalization when log2(N) is even (including 20 and 22). Its unreduced sums
and differences are <4P, legal inputs to the canonical scaling multiplier, so two
reduce2 operations and a memory pass disappear. Odd log2 sizes use the ordinary
normalization path. The separate variant makes this change measurable.

## Reproduce

```sh
# Linux x64 native GCC correctness, followed by fresh/reuse timings:
bash work/ntt/lazy_twiddle/run.sh

# Native or macOS/Rosetta correctness with ASan/UBSan:
SANITIZE=1 CHECK_ONLY=1 RESULT_DIR=build/lazy-check bash work/ntt/lazy_twiddle/run.sh

# Regenerate the single source file for AtCoder:
python3 work/ntt/lazy_twiddle/make_atcoder.py
```

`generate.py` reuses historical controls and emits only the selected experimental
translation units into ignored `build/lazy_twiddle/`. The independent reference,
brute-force checks, boundary checks, changing sizes and timing protocol are shared
with exploration 002. Every timing job uses the same compiler settings for controls
and candidates, identical inputs, two warmups, nine measured repetitions, and
alternating/rotated order. Fresh mode includes bulk root generation where used;
reuse mode primes each exact implementation before timing. Allocations and copies
are excluded. Source/binary hashes, CPU, compiler, commit and all timings are saved.

## AtCoder comparison

Paste **all of `work/ntt/atcoder_ntt_compare.cpp`** into a C++17-or-later custom test.
It is self-contained and uses heap storage, not a giant stack. Empty input runs
correctness and a default benchmark through 2^20, five repetitions, fresh roots.

Optional input has three integers:

```text
20 9 2
```

They select maximum log2 length, timed repetitions, and mode (0=fresh, 1=reuse,
2=both). Maximum log2 is 22; repetitions range from 1 to 25. Larger settings cost
more time and memory. Output includes per-implementation median/min/max in ms and
speedup versus historical v0.91. Any coefficient, guard, or checksum mismatch
terminates with nonzero status. Successful output ends with `ALL CHECKS PASSED`.
This is a benchmark/custom-test program, not an answer submission for an NTT problem.

The scalar correctness oracle is independent ordinary radix-2 code; it is not a
timed competitor. The historical baseline has only its internal profiling removed.
The previous direct8 candidate and selected new kernels share timing boundaries.

The final file compares v0.91, the previous direct8 candidate, full incremental
with a counted leaf loop, and the full-incremental/hybrid variants with fused final
normalization. It compiled with plain `g++ -std=c++17 -O2` and passed empty-input
and `22 3 2` tests. The default used 1.36 s wall time / 36,336 KiB RSS on one Xeon
8370C runner; actual AtCoder limits/performance can differ. No AtCoder submission
was performed. See [exploration 003](../../../notes/explorations/003-lazy-twiddles.md)
for CPU-specific timings, rejected ideas, exact commits and native evidence.
