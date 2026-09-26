# AVX2 NTT exploration, September 2026

Starting repository commit: `31ba0a6c6e65e164a9c145e8c73d9f9ba67cfd36`.
Historical input sources are left untouched. `generate.py` extracts only their
computational portions and emits independent translation units into ignored
`build/simd_explore/`. Every source and generated file is hashed in each run.

## Sources

- `cp/ntt_ver0.91.cpp`: README's historical 9.924 ms implementation; profiling
  clock calls removed, arithmetic/scheduling retained.
- `kactl_bench.cpp`: previously verified SIMD implementation, not the scalar KACTL
  comparator. The `kactl_simd` label always means this SIMD kernel.
- `study/fast_ntt_v2.cpp`: existing untracked fast-reference snapshot with blocked
  radix-4 transforms, incremental roots, and direct degree-7 leaf products.
- `study/fast_ntt_v3.cpp`: existing untracked fast-reference snapshot with partial
  transforms and direct leaf products. Returns lazy residues, compared modulo P.
- `study/fast_ntt_v4.cpp` is byte-identical to v2 and was not duplicated.

The study files do not identify their NTT authors or licenses in the computational
sections. Preserve the originals and do not invent attribution or a license.
The v3 I/O attribution is unrelated to its NTT. The exact source of the historical
6.662 ms measurement has not been established; test both plausible fast references.
No external implementation was downloaded or incorporated.

Research consulted: [FFTW codelet generation](https://fftw.org/fftw3_doc/Generating-your-own-code.html)
and [Frigo and Johnson, FFTW3](https://fftw.org/fftw-paper-ieee.pdf). The relevant
ideas are fixed-size straight-line kernels, removing identity operations, and
ordering work for registers/cache. These are inspiration, not NTT timing evidence.

## Variants and hypotheses

| Label | Change / question |
| --- | --- |
| v91 | Historical baseline without internal profiling |
| kactl_simd | Refactored existing SIMD baseline |
| fused8 | Fuse three small forward/inverse loops into vector-local codelets |
| pipeline8 | Fuse two leaf forwards, pointwise product, and leaf inverse |
| halfroots | Pipeline8 plus generate N/2 rather than N roots |
| trivial_top | Halfroots plus omit identity multiply in the outer radix-2 stage |
| recursive | Halfroots plus paired recursive radix-4 forward/product/inverse traversal |
| recursive_direct8 | Pair the cache-local traversal with four direct leaf products |
| direct8_identity | Batch-4 direct products plus radix-4 identity specialization |
| recursive_identity | Recursive direct products plus radix-4 identity specialization |
| recursive_identity2 | Additionally remove the top radix-2 identity multiplies |
| direct8_b1 | Trivial_top plus stop at 8 coefficients and directly multiply modulo x^8-w |
| direct8_b4 | Same leaf arithmetic, interleave four independent products |
| study_v2 | Existing fast reference, 64-vector traversal block |
| study_v2_t4/t8/t10 | Change traversal blocks to 16/256/1024 vectors |
| study_v3 | Second existing fast reference |

The direct8 candidates generate N/8 roots and normalize by N/8 rather than N.
For leaf j, `w = rt[j]^2` in Montgomery representation; canonicalizing the eight
input products before accumulation keeps `8*(P-1)^2+(2^32-1)*P < 2^64`. One lazy
reduction by 2P restores the [0,2P) range after the accumulated Montgomery reduce.

## Contract and timing

- Cyclic convolution modulo P=998244353, common tested domain N=2^6 through 2^22.
  A zero-padded ordinary convolution can use these kernels, but an arbitrary-length
  public API and sizes below 64 are not supplied by this experiment.
- Inputs are canonical [0,P), normal representation. Two disjoint mutable input
  buffers; A receives the result. B may be destroyed. All buffers are at least
  32-byte aligned (the driver uses 64), and are caller-owned. No alias support.
- Montgomery R=2^32. Roots carry R; pointwise products introduce R^-1, removed by
  inverse normalization. Existing butterflies use [0,2P); 4P<2^32. Study kernels
  have their own documented lazy ranges; the driver compares canonical residues.
- Fresh mode includes table generation for the user kernels. Reuse mode primes
  the exact implementation immediately before the measured call. Study v2 has a
  compile-time constant plan; study v3 constructs its fixed-size plan before main.
  Thus fresh mode is a fresh *large table* workload, not process-startup timing.
- Allocations, input generation/copies, output hashing, and validation are excluded.
  Forward transforms, pointwise/leaf products, inverse, and normalization are timed.
- Identical inputs, two warmup sweeps and nine timed sweeps, rotating and reversed
  variant order. Report medians and min/max per process and CPU, not pooled hosts.
- Common compiler options; original target/optimization pragmas are stripped. v2's
  unused GNU `std::__lg` helper uses equivalent `std::bit_width` for libc++ portability.

## Run

Native Linux x64 with AVX2/BMI and GCC:

```sh
bash work/ntt/simd_explore/run.sh
python3 work/ntt/simd_explore/summarize.py results/timings.csv
```

macOS with working Rosetta AVX2 support and the command-line SDK:

```sh
bash work/ntt/simd_explore/run_local.sh notes/results/ntt-simd-local/round2
python3 work/ntt/simd_explore/summarize.py notes/results/ntt-simd-local/round2/timings.csv
```

Rosetta passed an explicit AVX2 probe on this ARM64 Mac, macOS 26.2. Its timings
are translated Apple Silicon execution and cannot establish native AVX2 gains.
The Actions workflow uses an isolated clone/branch so existing user edits stay intact.
Public upload was initially rejected by automatic approval review. The user then
explicitly approved the public experiment branch and follow-up native runs. The
branch is `codex/ntt-simd-explore` in `7ue9ueue/QPoly`.

## Validation

Independent scalar radix-2/% reference at every tested power, brute-force cyclic
products through N=256, deterministic random seed 0xC0FFEE, small zero/max/one/
alternating/wrapping-impulse cases, repeated fresh/reuse calls, and growing/shrinking
requests. Added large all-P-1 and wrapping-impulse checks at 2^16, 2^20, 2^22.
Buffer-end canaries and benchmark checksums supplement coefficient comparisons.
Any mismatch exits nonzero. Unsupported moduli, aliasing, noncanonical inputs,
misalignment, and N>2^22 are not validated by this harness.

See `notes/explorations/002-simd-optimization.md` for measured results and decisions.

## Usable candidate sources

`candidates/direct8_identity.cpp` and `candidates/recursive_identity2.cpp` are frozen
copies of the exact generated kernels tested at commit `7722004`; source hashes
were verified against native artifacts before freezing (only the include path and
a provenance comment differ). Link one or both with your driver and include
`candidates/api.hpp`. The first is the conservative ~7.8–8.0 ms candidate at 2^20
on the tested AMD runners. The second is useful for cache traversal experiments
and larger sizes; its extra radix-2 specialization had mixed 2^20 results.

Compile with the same C++23, O3, AVX2/BMI and unroll flags as the benchmark.
These are experimental low-level interfaces with explicit caller-owned scratch,
not a replacement of the historical sources or a new public polynomial API.
