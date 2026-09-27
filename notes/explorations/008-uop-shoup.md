# 008 — Instruction-count reductions: flip combine, Shoup, codegen barrier

Date: 2026-09-27. Status: complete (kernel at a local optimum on Zen 3).
Branch `claude/ntt-uop-explore` (from `codex/ntt-simd-explore` adc9023), commits
4108b91 … 3687d37. Code: [work/ntt/uop_explore](../../work/ntt/uop_explore/README.md).

## Question and hypothesis

Earlier raw data (explorations 003–005) show cost per n·log n is flat from 2^12
to 2^22 on AMD and Intel runners: the kernel is compute-bound, not memory-bound.
So gains must come from fewer vector µops or better scheduling, not cache
restructuring. Target changed mid-round from AtCoder to Library Checker
(judge.yosupo.jp/help): official `gcc:15.2` image, `g++ -O2 -std=c++23 -DEVAL
-DONLINE_JUDGE -march=native`, AMD EPYC 7B13 (Zen 3). GitHub's EPYC 7763 runners
are also Zen 3 (Milan), so they are the reference machine below.

## Research

- Qwerty1232, "Making NTT convolution 10x faster with avx2" (Codeforces blog
  142063, github.com/piskareviv/blog_aux_ntt_1): lazy radix-4, recursive order,
  direct8 leaves — the lineage of the record holder.
- Library Checker fastest submissions: 199421/201990 (record-holder kernel, same
  as `study/fast_ntt_v2.cpp`), 393435 (QgQ: adaptive 8/16 leaves with even/odd
  Karatsuba for even log n; I/O later adopted by exploration 007), 405481
  (adamant, complex-double FFT). No code copied into the kernel.
- uops.info, Zen 3: vpmulld/vpmuludq ymm 1 µop on FP0/FP3 only; vpsrlq FP1/FP2;
  vpminud/vpblendd/adds all four pipes.
- Identity used for Shoup: floor(w·2^32/P) = mont(w)·NI mod 2^32 (NI = −P^−1),
  so Shoup quotients come from the Montgomery precomputation (checked for 10^4
  random w).

## Changes (each a `Cfg` switch; see README table)

1. **Flip**: repack Montgomery products with one `vshufps` (1 µop instead of
   shift+blend). The result lanes come out permuted by σ=(1 2) per 128-bit half;
   storing vector i with permutation parity(i) makes every Cooley–Tukey product
   match its partner, and Gentleman–Sande inverse layers regenerate that layout.
   Seeding costs one vpermd per vector; the final scale undoes it at no extra cost.
2. **Shoup** twiddle multiplication (8 µops, 4 on the multiply pipes, vs 10–11).
3. **Opq**: GCC rewrote `A ± (x·w − q·P)` as `A − qP + xw` and `(A + 2P + qP) − xw`
   (5 ops instead of 4). An empty `asm("" : "+x"(r))` restores 4.
4. **LdOdd**: odd lanes of a loaded multiply input via an unaligned load one
   element later (saves a shift per memory-sourced product).
5. **Blk**: Shoup table built 8 values at a time (block layout).
6. Pair tables, Shoup for leaf w·a and scale, pipelined leaf windows, zero-upper-
   half forward shortcut for ordinary convolution, plus several negative results.

## Validation and measurement

Harness `bench.cpp`: independent scalar radix-2 oracle, brute force ≤ 2^8,
boundary patterns, zero-upper-half cases, growing/shrinking sizes with reused
roots; failures exit nonzero. Checked through 2^22 natively in every CI job and
locally under Rosetta. Timing: two warmups, 11–15 interleaved rotated repetitions
× 3 rounds, identical inputs, full cyclic convolution timed, allocation/copies
excluded; fresh mode includes root-table generation. Submissions: 176-case
end-to-end suite natively with the exact judge command, plus 21 alternating runs
on N=M=2^19 (`run_yosupo.sh`). Raw data: [results](../results/ntt-uop-native/README.md).

## Results (EPYC 7763, GCC 15.2, judge flags, fresh 2^20, median ms)

| Kernel | ms | vs h14 |
| --- | ---: | ---: |
| h14 (AtCoder baseline) | 6.60 | 1.000 |
| asm_large_fixed (previous LC submission kernel) | 6.55 | 0.993 |
| record holder (study v2 / 199421) | 6.44 | 0.978 |
| f_flip (Montgomery-vpmulld + flip) | 6.11–6.17 | 0.925–0.935 |
| Shoup + pair + shuffle (s_p_sh, run 36282232212) | 5.79–5.84 | 0.880–0.886 |
| + Shoup leaf/scale (s_sh, 36282451044) | 5.73–5.77 | 0.870–0.874 |
| + Opq barrier (s_sh_o, 36282742022) | 5.55–5.59 | 0.840–0.850 |
| + LdOdd (s_ns_ol) | 5.51–5.56 | 0.834–0.848 |
| + Blk tables (s_ns_olb, 36282928940) / + Pipe (s_ns_olbp) | 5.49–5.56 | 0.833–0.841 |

About 14.5% less time than the record holder compiled with our harness pragma
(`O3,unroll-loops`) and 16% less than the previous submission kernel, measured in
the same processes. The record holder is ~3% faster without that pragma (as it was
submitted): 6.26–6.27 ms in run 36285228524, so the fair kernel margin is ~12.3%.
The end-to-end submission comparison below builds it exactly as submitted. Rewrite control `f_nm`
matched h14 exactly (1.000), so gains are attributable.

Other CPUs: Zen 4/5 (EPYC 9V74/9V45) show the same ordering (best 0.823–0.83);
the pipelined leaf helps there (−2.5% on 9V45). On Intel (8573C, 8370C, 6973P)
vpmulld is expensive: mullo kernels are 6–9% slower than h14, Shoup loses, and the
best is Montgomery + flip + pair + LdOdd (`f_fp_nml`, 0.935–0.948).

Submission (N=M=2^19, judge command; runs 36283674322, 36284690367 and 36285476294, the last
for the final file, SHA256 644e9f3e…, 176/176 checks on EPYC 7763, 8370C, 8573C):
with arrays pre-faulted before the timer (as the record holder does), stderr
compute time is 5.58–5.69 ms vs 6.30–6.42 ms for the record holder. The first
version without pre-faulting reported 6.62 ms: ~1,300 page faults (zero upper
halves, root tables) landed inside the timer. Wall time with the exploration-007
SSE I/O and a pre-faulted 2 MiB-aligned arena: 19.4–19.8 ms, vs 22.2–22.4 ms for
the current asm+SSE file and 23.0 ms for the record holder. Runners use THP
`always`, so the huge-page hint could not be evaluated; the judge's setting is unknown.

Per-phase cycles (micro.cpp, 7763, 3.2 GHz): radix-4 butterfly ~16 (µop floor
~12.5–13.3), leaf ~25 per vector (~23 pipelined; floor ~17), whole 2^20 run ≈136
cycles/vector: seven radix-4 levels ≈84, bottom (h=1 + leaf) ≈39, top/scale ≈9.

Optimization pragmas (run 36285228524, 7763, 2^20): O3 alone equals the default
O3+unroll-loops; plain -O2 is 10% slower for our kernel; adding pre-RA scheduling
(`schedule-insns,sched-pressure`) costs 3–4% on Zen 3 but helps Intel 6973P (−2%).

## Unsuccessful or neutral

- Leaf windows built in registers with vpalignr/vperm2i128 (run 36285017214):
  4–9% slower on Zen 3 — the shuffles compete for the same pipes, more than the
  store-forwarding stalls they remove.

- Leaf odd-lane reuse via extra loads (Leaf 1/2), via register reuse one leaf at a
  time (3) or interleaved (4/5): worse on Zen 3 (up to +3%); 3 helps Zen 4/5.
- Shuffle-based odd extraction, tiles 64/1024, 2-way interleaving, Clang 21 (the
  leaf-reuse modes regressed there): neutral or worse. Pair tables: ~1% on Intel only.
- Pipelined leaf windows: −2.2 cycles per bottom vector in isolation but neutral
  at 2^20 on Zen 3; kept because it helps Zen 4/5 and Intel.

## Decision and next step

Use `s_ns_olbp` (Shoup) for Library Checker/AMD and `f_fp_nml` for Intel/AtCoder.
The remaining gap to the µop floor is scheduling on the two multiply pipes and
the leaf's store→unaligned-load pattern; further progress likely needs a
different leaf formulation or fewer multiplications per butterfly, not
micro-tuning. The user is improving decimal I/O separately.
