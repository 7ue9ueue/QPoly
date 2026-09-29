# 013 — Library Checker matrix_product (1024³ modular matrix multiplication)

Date: 2026-09-29/30
Status: complete. First deliverable judged (user): 53–54 ms (407073: 54/62/54 ms on the max cases,
the 62 a one-case spike; resubmission 53 ms). I/O follow-up below: exploration-011 I/O.

## Question and target

Fastest possible solution for <https://judge.yosupo.jp/problem/matrix_product>:
C = A·B mod 998244353, 1 ≤ N, M, K ≤ 1024, time limit 10 s. Judge: GCC 15.2,
`g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`, AMD EPYC 7B13 (Zen 3), one core,
time = maximum over the 22 cases (the three 1024³ `max_random` cases dominate: 1.07·10⁹
multiply-adds, 20.7 MB input, 1 048 576 output values). The user asked for a step-by-step
exploration (high-level algorithms → SIMD → asm), then a standalone file with the fastest
exploration-007 I/O.

Leader at start: adamant [401223](https://judge.yosupo.jp/submission/401223), 68 ms
(max_random 68 ms, random 31–37 ms). Its design (read, not copied): Strassen–Winograd to
64×64 leaves, a 4×8 `vpmuludq` leaf with `vpbroadcastd` + `vpsrlq` odd lanes, shrink every
8 products, Montgomery at the end; toomer's Rust 404133 (72 ms) is the same structure.

Branch `claude/matrix-product` (from `origin/main` ba465cf), code in
[work/matrix_product](../../work/matrix_product/README.md), CI
`.github/workflows/matrix-product.yml`, raw data in
[results/matrix-product](../results/matrix-product/).

## Method

- **Kernel harness** (`bench.cpp`): every variant against an independent reference
  (transposed B, `unsigned __int128` dot products): 17³ small shapes, 60 random ≤ 300,
  boundary shapes (Strassen padding edges, 1×1024×1, …), adversarial values (all P−1,
  (P±1)/2, the official signed/unsigned overflow tests at their sizes, 1024³ extremes),
  repeated calls with shape changes. Timing: one full call (conversions and packing inside,
  scratch pre-faulted), interleaved rotated rounds, medians. Any mismatch fails the job.
- **kbench / probe**: L1-resident micro-kernel cycles per k-step (clock calibrated with a
  dependent `inc` chain) and Zen 3 port probes of the instruction mix.
- **End-to-end** (`e2e/run_e2e.sh`): the exact judge compile command in the pinned
  `gcc:15.2.0` image, cases on tmpfs, a `library-checker-init` equivalent, docker with the
  judge's limits, spawn→`wait4` wall time, byte-exact outputs (all 22 official cases
  regenerated and hash-checked against `hash.json`), plus a 160-case stress test against the
  official model solution. The leader's 401223 is fetched from the judge API at run time and
  timed in the same job as the in-job reference (runner clocks vary: calibrated 9V74 clocks
  ranged 2.85–3.67 GHz between jobs, so only same-job ratios are compared).
- Hosted runners are random (EPYC 7763 = Zen 3 like the judge, 9V74/9V45, Intel); decisions
  use EPYC 7763 jobs. Local Rosetta runs are for correctness only.

## Step 1 — high-level algorithms in portable C++ (EPYC 7763, 1024³)

| variant | ms |
| --- | ---: |
| s00 textbook i-j-k, `%` per product | 3485 |
| s01 i-j-k, fold every 16 (column walk of B) | 4372 |
| s02 i-k-j, 64-bit row accumulators, fold every 16 (GCC vectorizes) | 163 |
| s03 + cache blocking (1024-column slabs) | 158 |
| s04 plain 4×8 register tile | 366 |
| s14 Strassen–Winograd depth 4 over s04 | 152 |
| s23 Strassen–Winograd depth 3 over the i-k-j leaf (best) | 119 |

Loop order + lazy reduction is the big win (21×); blocking ~3%; Strassen–Winograd helps a
lot (my own 3-temporary schedule, 7 products / 15 additions). Diminishing returns at ~120 ms.

## Step 2 — AVX2 intrinsics

Key facts (uops.info, Zen 3): `vpmuludq`/`vpmuldq` run on FP0/FP3 only, `vpaddq` on all four
pipes, FMA on FP0/FP1, and `vpbroadcastd` from memory costs an FP1/FP2 op, **but
`vbroadcastss`, `vmovsldup`, `vmovshdup` from memory are pure load-port ops**. So a 4×8 tile
can get A broadcasts and B even/odd lanes for free.

- Signed centered values (|x| ≤ (P−1)/2, A with Montgomery factor 2³²) allow 32 products
  between folds instead of 8; `v04` (signed, load-only) 61.5 vs `v01` (adamant-style) 67.4 ms.
- GCC needs care: without an empty-asm pointer barrier it merges the two dup loads into one
  load + two shuffles; unrolled loops re-associate the adds and spill (fixed with an
  empty-asm register barrier per accumulator and `O3`); aligned-load intrinsics segfaulted
  natively on 16-byte-aligned panels (clang folded them locally).
- Kernel alone (L1): 5.5 cycles per k-step (≈5.8 MACs/cycle) vs a 4.25 port model. Port
  probes showed why: **8 `vpmuldq` + 8 `vpaddq` take 4.95 cycles** (not 4): adds are issued on
  the multiply pipes. Loads are free (+0.1 cycle).
- **Winograd's 1968 inner-product trick** at kernel level:
  acc += (a₂ₛ + b₂ₛ₊₁)(a₂ₛ₊₁ + b₂ₛ) with row/column corrections αᵢ, βⱼ subtracted up front
  halves the multiplies at equal op count; with 25% multiplies the pipes saturate (probe:
  32 ops in 8.04 cycles). Folds every 8 products (factors ≤ P−1). Compiled: 5.36 vs 5.47.
- Vectorized conversions (Shoup Montgomery scaling, centering, 4×8 in-register transposes):
  packing 4.96 → 0.82 ms, unpacking 1.30 → 0.27 ms.
- Strassen additions alone: 1.75 / 2.60 / 4.87 ms at depth 2/3/4; fused S/T/C passes −17–19%.
- Best step 2: Strassen depth 4 over the signed load-only kernel with vector conversions,
  43.3 ms (from 67.4 for the adamant-style kernel without Strassen).

## Step 3 — generated inline asm (`gen_asm.py`)

Schedules of the direct and Winograd kernels (fold placement, load hoisting, row pairing,
shifted-sum order), each with a tail loop. L1 cycles per k-step, EPYC 7763 (3 jobs agree):

| kernel | m=64 | m=128 | m=1024 |
| --- | ---: | ---: | ---: |
| intrinsics direct, best | 5.79 | 5.59 | 5.49 |
| asm direct, natural order | 6.14 | 5.97 | 5.86 |
| asm direct, GCC-like mul-mul-add-add order | 5.68 | 5.49 | 5.34 |
| asm Winograd, dup loads | 5.59 | 5.38 | 5.26 |
| asm Winograd, packed B, shifts for odd lanes | 5.45 | 5.19 | 5.05 |
| asm Winograd, shifts first | 5.31 | 5.06 | 4.88 |
| **asm Winograd, shifts first, two rows paired, burst fold (`sh_burst_p1`)** | **5.29** | **5.05** | **4.84** |
| same, folds spread (half/quarter bursts) | 5.48–5.55 | 5.22–5.27 | 4.97–5.02 |

4.84 cycles = 6.6 MACs/cycle, ~93% of the 36-op-per-k-pair bound. Whole 128³ leaf with
corrections and tile loop: 5.19 cycles (6.17 MACs/cycle); 256³ 5.02; 64³ 5.58. Prefetching
hurt; loop order did not matter.

## End to end (judge-like harness)

Deliverable: [work/matrix_product/yosupo_matrix_product.cpp](../../work/matrix_product/yosupo_matrix_product.cpp)
— exploration-007 I/O (padded mmap input, two-stage AVX2 parser, table writer, 64 KiB
buffer) with rows parsed in small chunks and packed straight into the Strassen layout;
Strassen–Winograd depth 3 (128³ leaves) over `sh_burst_p1`; output gathered row by row
from the C tiles. SHA256 `6b7716165c608ede7c8c2f0dbf7ed59a10928a8f29e15a840f2a05aa20d8b4e7`,
95 471 bytes; regenerate with `python3 e2e/make_submission.py e2e/main_mp.cpp
yosupo_matrix_product.cpp -DMP_KERNEL=sh_burst_p1 -DMP_DEPTH_MAX=3 -DMP_CHUNKED --asm-only
sh_burst_p1 --header <comment block>` (the file's first 17 lines).

Measured on EPYC 7763 (max-case medians, same jobs): leader 401223 73.3–74.9 ms, ours
57.2–57.9 ms (**0.77–0.79×**). With the judge reporting 68 ms for 401223, the estimate is
≈53 ms. Phases (7763): setup 0.96, parse+pack 6.5, multiply 40.9, output 7.1, the rest
(~2.6 ms) is exec/loading/teardown.

Findings from the end-to-end rounds:
- Depth 3 beats depth 4 end to end (d4: 60.4 vs 59.6 ms) and depth 2.
- Fused Strassen passes save ~0.5 ms of additions but their larger workspace costs ~0.7 ms of
  page zeroing: no gain end to end; the hybrid (fused below the top) is neutral.
- Chunked parse+pack (no row-major buffers): −0.45 ms setup; formatting straight from the
  tiles was 0.4 ms slower than gather-then-write, the row-buffered version keeps the gain.
- `_exit(0)` after the final flush is **1.0–1.5 ms slower** than returning (the input
  destructor's `munmap` before exit beats the kernel's exit teardown), on all four CPUs.
- THP `never` costs ~6 ms (7763: 64.5 vs 58.5); `always` ≈ `madvise`.

## Not pursued / inconclusive

- 64-bit leaf outputs combined at the bottom level (skipping per-leaf REDC/canonicalization):
  ~17% of the finish+combine ops, ~0.5 ms, only fits L2 at depth 4 where additions and
  workspace cancel it.
- FP64 FMA hybrids (exact low 32 bits via `vpmulld` + FP approximation of the high part):
  load- and register-bound on AVX2 (needs two representations of both operands).
- 48-multiplication 4×4 schemes and alternative-basis Strassen: ≤2% fewer products or
  additions, far more additions or basis transforms; not worth it at depth ≤ 4.
- Other I/O (e.g. exploration 011's multi-stream parser / fixed-width writer) was out of
  scope: the user asked for exploration 007's I/O.

## Evidence

Raw per-job results (environment, checks, timings, kbench, probes, e2e CSVs) for every CI
round: [results/matrix-product](../results/matrix-product/README.md).

## Final confirmation

- [Run 36641297766](https://github.com/7ue9ueue/QPoly/actions/runs/36641297766), exact file
  (then SHA256 936b8e78…), judge compile command, 4 jobs: 22/22 official cases byte-exact and
  the 160-case stress test identical to the model solution in every job. Max-case medians
  (15 reps): EPYC 7763 **57.50 / 57.32 ms** vs 401223 74.14 / 73.72 (0.776 / 0.778); EPYC 9V74
  48.88 vs 63.25 (0.773); EPYC 9V45 40.06 vs 48.07 (0.833). Random cases 21–29 ms (7763).
- [Run 36641551534](https://github.com/7ue9ueue/QPoly/actions/runs/36641551534): the delivered
  file (SHA256 6b771616…) differs only in comments and builds to the identical judge-flag
  binary (SHA256 aa99cf7b… on both EPYC 7763 jobs); 22/22 again.
- Untested: the judge itself (not submitted), THP `never` on the judge (−6 ms locally if the
  judge used it), other CPUs than the runners. The asm requires x86-64 with AVX2.

## Decision

Keep. Deliverable ready for the user to submit (judge estimate ≈ 53 ms vs 68 ms). The
generator, harnesses and all variants stay in `work/matrix_product` for further work;
remaining ideas are in [IDEAS.md](../IDEAS.md).

## I/O follow-up (2026-09-30): exploration 011's I/O

Judge result of the first deliverable (user, submissions 407073 and a resubmission): max cases
54 / 62 / 54 ms (the 62 is the known one-case spike), then 53 ms — as estimated.
The NTT side's fastest I/O is exploration 011's (convolution_mod_large), not 007's: parser
`qp_parse_ms2` (128 KiB chunks cut into four lockstep streams, two tokens per stream step,
007's `qp_parse_flat` as fallback and tail; 68 → 47 ms per 2^25 tokens there) and formatter
`qp_fixed::blocks3<4>` (fixed 10-byte fields: right-aligned digits, space padded; 84 → 37 ms per
2^25 values) with a 160 KiB buffer. matrix_product's checker is testlib `wcmp` too (token
comparison), so padded fields are accepted. Both files are copied unchanged into
`work/matrix_product/e2e/` (`fmt_bcd.inc` gains a separate `blocks3p`). The ms2 fast path needs
calls larger than CH/2 + 64 tokens, so A and B are each parsed in one call, into the C region
and the Strassen workspace (dead until the multiply; no extra memory), then packed as before.
Outputs are now compared token-wise (launcher and stress test), like the judge.

| EPYC 7763, max-case median ms (same jobs) | round 18 (2 jobs) | round 19 (2 jobs) |
| --- | --- | --- |
| leader 401223 | 74.7 / 74.9 | 73.9 / 74.3 |
| submitted file (007 I/O) | 58.1 / 58.0 | 57.3 / 57.5 |
| 011 I/O | 54.9 / 55.0 | — |
| **011 I/O + lazily faulted arena** | 54.7 / 55.0 | **53.9 / 54.2** |
| 011 I/O, output straight from the C tiles (no row gather) | 54.9 / 55.3 | — |
| 011 I/O, 64 KiB output buffer | 55.1 / 55.3 | — |
| fused parse→pack through a parser sink (lazy / populated arena) | — | 54.1 / 54.4, 54.4 / 54.8 |

Phases (7763, 011 I/O + lazy arena): parse 4.2 (was 5.3), pack 1.2–1.4 (now includes the arena's
first-touch faults), multiply 40.2–40.5, output 5.5 (was 7.0), ~2.6 ms outside main.
Unsuccessful: formatting straight from the tiles (`blocks3p`), a sink-based parser that packs
while parsing (`parse_sink.inc`: fused 5.4 ms vs 4.2 + 1.2 separate), a 64 KiB buffer.
What remains of the I/O is mostly kernel work: `write()` into tmpfs (~4 ms for 10.5 MB),
input page faults (~1 ms), exec/loading/teardown (~2.6 ms).

Deliverable replaced (run [36643697758](https://github.com/7ue9ueue/QPoly/actions/runs/36643697758)):
[yosupo_matrix_product.cpp](../../work/matrix_product/yosupo_matrix_product.cpp), SHA256
`4ecc061da36f639ea68c654d4dfd603af3c80d42747fec5435073de5bc306dfc`, 129,609 bytes
(`-DMP_KERNEL=sh_burst_p1 -DMP_DEPTH_MAX=3 -DMP_IO011 -DMP_LAZY_ARENA --asm-only sh_burst_p1`;
judge-flag binary 5aa5099f… on EPYC 7763). The submitted version is kept as
[yosupo_matrix_product_io007.cpp](../../work/matrix_product/yosupo_matrix_product_io007.cpp)
(SHA256 6b771616…). 4 jobs: 22/22 official cases token-equal, 160-case stress token-identical.
Max-case medians, THP madvise: EPYC 7763 **53.8 / 54.3 / 54.6 ms vs 57.3 / 57.8 / 58.2** for the
submitted file (−3.5 ms, −6.1%) and 73.7 / 74.5 / 74.8 for 401223; 9V74 57.2 vs 61.3. THP `always`
the same; `never` 60.6–61.7 vs 62.8–64.0. Judge estimate from the submitted file's 53 ms: ≈ 50 ms.
