# AtCoder-targeted continuation of ll_inline_h14

Starting experiment head: a1a32294d7d91b3e2daf79994cccf54511ad3fd8. Frozen kernel
is extracted from `work/ntt/atcoder_ntt_lowlevel_compare.cpp`, tested source commit
50908bb1167af6a32d2b97621a29694814cdebf1. The frozen `baseline.hpp` implements the
same Kernel<true,false,2,256,4,2,true> as the user's `ll_inline_h14` measurement.
No fast-reference implementation is copied or compiled into this new suite.

User-reported AtCoder baseline: GCC15.2.0, fresh 2^20, ten repetitions,
ll_inline_h14 median7.9968 ms, min7.9592/max8.0819. Original v91 median11.6617 ms.
Exact submitted source hash and CPU were not supplied. This evidence chooses our
target baseline, but is not directly comparable to Actions wall times.

## Hypotheses

- Whole-leaf assembly can avoid the C++/assembly accumulator boundary of earlier
  experiments. Three schedules include a variant that overwrites disposable B
  with canonical coefficients to reduce scratch. See asm_notes.md.
- Bottom-stage fusion can keep transformed leaves nearby; compile-time tile
  traversal may simplify stage/key arithmetic. See stage_notes.md.
- The documented AtCoder automatic-zero-init flag may add scratch initialization;
  scoped uninitialized attributes are tested only on fully overwritten scratch.
- Alternate odd-lane extraction, split accumulation chains, tile size, and leaf
  unrolling are measured against the same frozen h14 baseline.

## Contracts and verification

Cyclic convolution P=998244353, powers of two 64 through2^22. Canonical input,
32-byte aligned and disjoint mutable A/B, caller-owned aligned root scratch;
A receives canonical output and B is destroyed. Root state is paired with its
buffers; fresh/reuse and changing-size semantics are unchanged. Hybrid roots use
N/16 uint32 entries per direction. No shared mutable static scratch is introduced.
Forward values <4P; inverse values <2P; all direct8 products are canonicalized
before eight-product accumulation. The previous overflow proof remains valid.

`generate.py` produces explicit named variants. `run.py` checks independent
ordinary-modulo reference, small brute force, coefficient boundaries, fresh/reuse,
growing/shrinking sizes and canaries; canonical output equality is required.
Direct leaf tests check 393216 lanes across all three assembly variants throughout
[0,4P), with an independent ordinary-modulo small-polynomial oracle and <2P bounds.
ASan cannot instrument inline-assembly memory accesses. Their bounds, clobbers and
in-place B access were independently reviewed; ordinary C++ is sanitizer checked.
GNU assembly uses AT&T syntax. Assembly source and tests are written independently.

## Benchmarks and environment

Native runs use pinned official GCC15.2.0 container, automatic zero initialization,
no LTO, relevant AtCoder flags, and the source's O3/unroll pragmas. `-march=skylake`
provides a consistent AVX2 ceiling (also on AMD runners); this is a controlled
compiler-setting approximation, not an AtCoder CPU emulator. See environment_notes.md
for official sources, image digests, and omitted irrelevant library-link flags.
Record actual CPU/compiler/container/flags and never rescale between machines.

Two warmups/nine measurements per variant/size/mode, seven sizes12,16,18,19,20,21,22,
rotated/reversed order and identical inputs. Fresh includes root generation;
allocation, input copies and output hashing are excluded. Reuse primes each exact
implementation. Saved hashes identify generated sources and executable.

`profile.py` adds coarse chrono instrumentation to the baseline: clock reads once
per tile phase and large outer group, not per butterfly. It prints forward, leaf,
inverse, roots, final-normalization and total ns at2^20, and validates against the
uninstrumented baseline. This is diagnostic timing with overhead, not a speed claim
or hardware-counter profile. Local Rosetta timings are never native evidence.

Run: `python3 work/ntt/h14_explore/run.py`; optional CHECK_ONLY=1, SANITIZE=1,
RESULT_DIR=path, SELECT_VARIANTS=comma,separated,names. The v91 and h14 controls
are always included. The three direct assembly leaf checks remain independent of
selected benchmark entries. Binaries/generated translation units stay in build/.
