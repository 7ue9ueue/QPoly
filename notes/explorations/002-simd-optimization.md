# 002: Partial transforms, leaf products, and cache traversal

Date: 2026-09-26. Complete: 18 variants, two successful native comparison runs
(four timing jobs), one native ASan/UBSan job, plus local Rosetta exploration.

## Starting points and scope

Started at `31ba0a6c6e65e164a9c145e8c73d9f9ba67cfd36`, preserving all user edits.
Reviewed the v0.91 family, refactored `kactl_bench.cpp`, related `core/ntt`, `perf/NTT`,
modular arithmetic tests/experiments, and the `study/` implementations. The historical
numbers are milliseconds: 9.924 ms versus 6.662 ms at N=2^20, modulus 998244353.
The old reference timing's precise source attribution is not established. The two
fast study snapshots were tested as candidates, not assumed to be the record source.

Code and complete contract: [experiment directory](../../work/ntt/simd_explore/README.md).
`generate.py` records source hashes and extracts kernels; source originals are unchanged.
New code uses the original radix-4 arithmetic and root indexing. Primary external
research: [FFTW codelets](https://fftw.org/fftw3_doc/Generating-your-own-code.html),
[FFTW3 paper](https://fftw.org/fftw-paper-ieee.pdf). No external source was imported.

## Environment and blockers

GitHub authentication worked outside the sandbox. Automatic approval review rejected
the initial public branch push. Work continued locally, and the user explicitly
approved the public branch plus follow-up native runs before any successful push.
An isolated clone in `build/ntt-runner` keeps the main checkout's Git state untouched.

Local AVX2 execution was newly verified: x86_64 Mach-O under Rosetta, macOS 26.2,
Apple M2 MacBook Air (4 performance + 4 efficiency cores), Apple Clang. Twelve
initial variants passed all power-of-two sizes 2^6–2^22 and changing-size/repeat
checks. Timings were slow/noisy and are not evidence of native AVX2 ordering.
[Local raw results](../results/ntt-simd-local/round1/) include all timings and hashes.

First native run [36273320700](https://github.com/7ue9ueue/QPoly/actions/runs/36273320700)
failed compilation because kernel extraction removed a Linux mmap header needed
by an unused helper in the reference snapshot. Adding the common include fixed it.
[Failure log](../results/ntt-simd-native/36273320700/build-failure.txt) retained.

## First successful native comparison

[Run 36273395507](https://github.com/7ue9ueue/QPoly/actions/runs/36273395507), exact
commit `87d0fc97e26624772cd6c95c699eed52a4dc2fab`. GCC 13.3.0,
`-std=c++23 -O3 -mavx2 -mbmi -funroll-loops`, same flags for all kernels.
Two separate jobs: Intel Xeon 6973P-C and AMD EPYC 7763. Fifteen variants.

Both jobs passed: independent scalar NTT at every power 2^6–2^22; small brute-force
checks; zero, max, constant, alternating, wrapping-impulse inputs; repeated roots;
growing/shrinking requests; additional large max-coefficient/impulse checks at
2^16, 2^20, 2^22. All timed output checksums agreed. Failures exit nonzero.

Timings use identical cyclic convolution inputs, two warmup sweeps and nine timed
sweeps in alternating/rotating order. Allocation/input copying excluded; fresh root
tables, forward transforms, products, inverse and normalization included. Separate
reuse mode primes the exact implementation immediately before each measurement.
Study v2 has constexpr plan metadata and v3 has a pre-main small plan; startup is
not timed for those kernels. Details and untested cases are in the code README.

Median milliseconds at 2^20, fresh large-table workload (min–max in parentheses):

| Variant | Intel 6973P-C | AMD EPYC 7763 |
| --- | ---: | ---: |
| Historical v0.91 | 10.402 (10.308–12.137) | 10.147 (10.067–10.181) |
| Existing refactored SIMD | 10.696 (10.447–11.399) | 10.099 (10.085–10.273) |
| Fused 8-point codelets | 10.843 (10.543–11.300) | 11.755 (11.613–12.035) |
| Fused leaf forward/product/inverse | 11.454 (11.195–11.849) | 12.709 (12.573–13.103) |
| Half root table + fused pipeline | 10.885 (10.787–11.131) | 12.477 (12.356–12.740) |
| Recursive fused transforms | 11.052 (10.961–11.243) | 12.686 (12.609–12.765) |
| Direct leaf products, batch 1 | 8.758 (8.706–9.324) | 9.116 (9.042–9.220) |
| Direct leaf products, batch 4 | 8.260 (8.211–8.434) | 8.246 (8.186–8.369) |
| Recursive + direct leaf products | 7.709 (7.655–7.831) | 8.285 (8.265–8.808) |
| Existing study v2 | 6.551 (6.458–7.057) | 6.572 (6.532–7.004) |
| Study v2, 256-vector blocks | 6.538 (6.464–6.808) | 6.485 (6.449–6.535) |
| Existing study v3 | 7.032 (6.931–7.702) | 7.358 (7.322–7.425) |

Complete 2^12, 2^16, 2^18–2^22 data, both modes, CPU/compiler/commit and SHA-256
hashes: [retained artifacts](../results/ntt-simd-native/36273395507/),
[summary](../results/ntt-simd-native/36273395507/summary.csv).

## Interpretation

- Simple fusion is unsuccessful: fewer passes did not offset the changed instruction
  schedule/register pressure. The latter explanation is a hypothesis, not profiling.
- Cutting unused roots helps the fused version slightly but does not rescue it.
- Direct degree-7 products replace the final three forward/inverse layers. This
  produces the first clear improvement, with batch 4 better than batch 1 on both CPUs.
- Recursing through two forwards, leaf products and the inverse as one subtree
  helps Intel materially, but is inconclusive versus batch-4 iteration on AMD at 2^20.
  It helps both at 2^22. CPU-dependent scheduling matters.
- Existing study v2 remains faster. Changing its cache threshold yielded small,
  size-dependent shifts; do not claim a new reference record from those measurements.
- New variants beat the existing SIMD baseline across the measured sizes, but the
  best new 2^20 result does not yet beat the existing fast reference.

## Confirmation and identity specialization

[Run 36273615803](https://github.com/7ue9ueue/QPoly/actions/runs/36273615803), exact
commit `7722004b7925454eaa7d4c3272d2d3804dabb4f5`. Two AMD EPYC 7763 jobs,
same GCC/flags/workload, 18 variants. All coefficient comparisons passed, all
timed checksums agreed, and the separate native ASan/UBSan correctness job passed
with `-O1 -g -fsanitize=address,undefined -fno-sanitize-recover=all` appended.
Each variant received 97 correctness convolution calls per native job, including
fresh/repeated and boundary cases; each timing job retained 2,268 measured calls.

Radix-4 groups at k=0 have three identity multiplications that can be omitted.
This improves both direct-product schedules. Removing the recursive top radix-2
identities was mixed at 2^20 despite a clear win at 2^22: keep it as a separate
candidate rather than assuming fewer operations always determine ordering.

Fresh-table 2^20 median ms (min–max), separate runners of the same CPU model:

| Variant | AMD job 1 | AMD job 2 |
| --- | ---: | ---: |
| Historical v0.91 | 10.018 (9.954–10.106) | 10.123 (10.021–10.296) |
| Existing refactored SIMD | 10.016 (9.952–10.141) | 10.178 (10.034–10.308) |
| Direct batch 4 | 8.267 (8.159–8.307) | 8.050 (8.015–8.137) |
| Direct batch 4 + radix-4 identities | **7.953 (7.897–8.066)** | **7.791 (7.757–7.831)** |
| Recursive direct + radix-4 identities | 7.990 (7.967–8.003) | 7.817 (7.806–7.880) |
| Recursive + radix-4 and radix-2 identities | 7.678 (7.656–7.817) | 7.995 (7.922–8.036) |
| Existing study v2 | **6.482 (6.462–6.511)** | **6.528 (6.496–6.594)** |

The conservative direct candidate reduces time by **20.6% and 23.0%** versus
historical v0.91 in these jobs (1.26x and 1.30x speedups). Root reuse still gives
7.855/7.748 ms versus refactored SIMD 9.626/9.697 ms: the gain is not just setup.
At 2^22 the recursive identity2 candidate gives 34.071/36.383 ms versus refactored
43.635/48.092 ms, but the different large-size spreads reinforce reporting each job.

Changing study v2's cache threshold did not yield a robust new record. At 2^20,
the default, threshold-8, and threshold-10 times overlap or differ by small amounts;
no threshold promotion. No claim is made that 6.5 ms has been beaten.

Artifacts: [raw timings, hashes, environment, run metadata and sanitizer output](../results/ntt-simd-native/36273615803/),
[summary](../results/ntt-simd-native/36273615803/summary.csv).

## Handoff and next experiments

Freeze `direct8_identity` as a useful candidate derived from the user's kernel;
keep `recursive_identity2` as the alternative for cache traversal/large lengths.
The [standalone candidate sources and API](../../work/ntt/simd_explore/candidates/)
were checked against hashes of the exact native-tested generated code. Original
implementations remain unchanged. The benchmark generator preserves rejected
variants for reproducible ablations. Study v2 remains the fastest tested starting
point; neither new candidate replaces it as overall baseline.

The exported candidates additionally passed a local Rosetta ASan/UBSan
[interface smoke test](../results/ntt-simd-local/candidate-smoke/README.md) using
exact N/8 root buffers and requiring canonical outputs, with fresh/reuse calls,
random brute-force cases, and maximum-coefficient inputs through 2^20.

Next, investigate the remaining gap via the fast reference's lazy radix-4 reduction
schedule and incremental twiddle generation; inspect generated assembly/spills
before more fusion. Benchmark CPU affinity/code alignment to understand the mixed
radix-2 specialization result. A fresh Intel run of the final identity variants and
native Clang are untested. The historical AtCoder environment was not reproduced.
