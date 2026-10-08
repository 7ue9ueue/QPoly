# 014 — convolution_mod_large: further optimization after the 454 ms record

Date: 2026-10-07. Status: in progress. Branch `claude/conv-large-opt` from `claude/ntt-conv-large`
42953d3 (exploration 011). Code: [work/ntt/large_opt](../../work/ntt/large_opt/README.md). Raw data:
[results/conv-large-opt](../results/conv-large-opt/) (one folder per run id).

## Starting point and target

Record 0.454 s = submission 406521 (user Aiyiyi, C++17) = `work/ntt/yosupo_convolution_mod_large_io_probe.cpp`
(exploration-011 deliverable's probe twin, SHA256 ac34ca15…). The same source resubmitted as C++23
(408717, 2026-10-07) scored 0.460 (max fft_killer_09 with an output-phase spike; every phase 1–2%
slower): judge run-to-run variation is about ±5 ms, so a real gain of ~10 ms is needed to beat 454
reliably.

Judge phase times (406521's own stderr, EPYC 7B13, THP `madvise`, max cases): parse 71 ms (parser
~47, input page faults ~17, arena first touch), NTT 205 ms, output 156 ms (format ~36, write() ~120),
~12–15 ms outside `main` (exec, munmap of the 331 MB input, exit). On EPYC 7763 runners (judge-like
e2e): wall ~455–462 ms = user ~295–300 + sys ~155–165 ms (rusage).

## Ideas (brainstorm) and outcome

| # | Idea | Phase | Outcome |
| --- | --- | --- | --- |
| P1 | ms2's four streams are exactly 32 KiB apart (same L1D set): skew them | parse | refuted on Zen 3 (±0.2%); Intel 8573C −5…6% |
| P2 | software prefetch per stream | parse | refuted (Zen 3 +2…4% slower) |
| P3 | four tokens per stream step (`qp_parse_ms4`), after ablations | parse | Zen 3 −1.3% parser (≈ −1 ms e2e), Zen 5 −10…14% |
| N1 | bottom-level twiddles generated on the fly, tables n/64 | NTT | refuted as built: +5% (219 vs 208 ms); see round 6 |
| OV | interleave independent NTT work into the parse loop | parse/NTT | memory-bound top group ~45% hidden (−2.3 ms); compute-bound butterflies −20% (slower) |
| F1 | formatter as inline asm without spills (76 vs ~97 instructions / 8 values) | out | micro −1…3%; e2e mixed (layout effects?); see round 6 |
| K | write()/faults/munmap | kernel | no user lever (mmap output, fallocate, MAP_POPULATE, read() measured or reasoned slower) |
| — | hardware counters on the runners | — | blocked: the VMs expose no PMU (`perf stat`: all hardware events `<not supported>`) |

## Findings so far

- Parser (EPYC 7763, ns/token, ablations of the ms2 step loop, run 37700082427): scan chain only
  (load → compare → movemask → tzcnt/blsr → advance) 0.78; + windows/rows/shuffle 0.89; + multiply-adds
  0.92; + combine 1.06; + stores 1.24 (full step loop). Cached text is no faster than DRAM text. The
  complete parser (47 ms = 1.39 ns/token) spends ~13% outside the step loop (region memcpy, tails).
- Formatter: GCC 15.2 compiles `blocks3<4>` to ~390 instructions per 32 values (59 spill/reload
  instructions, 24 constant rematerializations in the loop); the asm version (76 per 8 values, no
  spills) is barely faster (36.5–36.8 vs 37.2–37.8 ms), so instruction count is not its limit.
- N1: scalar twiddle generation right before each asm bottom call sits on the critical path.
- e2e noise: on one 7763 host, two builds with identical formatter instructions (`f2`, `f4`) differed by
  11 ms of user time — likely code layout. Decisions need several runners and phase times.
