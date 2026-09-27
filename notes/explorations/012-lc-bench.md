# 012 — Clean comparison: KACTL, simd-v0, QgQ 393435, ours (406478)

Date: 2026-09-27. Branch `claude/lc-bench`, starting commit `42953d3` (claude/ntt-conv-large).
Code: [work/ntt/lc_bench](../../work/ntt/lc_bench/README.md). Results: [results/lc-bench](../results/lc-bench/README.md).

## Question

How does our best kernel for n ≤ 2^22 compare, on Library Checker's compiler/flags and a
Zen 3 CPU, with KACTL, the user's first SIMD NTT (simd-v0) and the fastest convolution_mod
submission by someone else (QgQ 393435, 23 ms)?

- Best of ours for n ≤ 2^22: the exploration-009 kernel (submission 406478, 16 ms; the
  010/011 large-convolution files reuse it up to 2^22). Its judge source was fetched and
  equals `work/ntt/yosupo_convolution_asm_shoup_io_sse.cpp` minus the `QPOLY_TIMING` lines.
- 393435 fetched from `https://v3.api.judge.yosupo.jp/submissions/393435` (SHA256 79ae944f…,
  CRLF, no license notice) into `work/ntt/lc_bench/vendor/`.

## Method (summary; details in the harness README)

Verbatim code extraction from pinned sources, one translation unit per implementation under
its own pragmas, judge flags, no LTO. Cyclic convolution of random full-length inputs, so
our zero-upper-half shortcut is off. Timed: one call including roots/conversions/scaling;
input copies outside. Rounds interleave all four with rotated order; median of ≥ 11 rounds.
Every call checked against brute force (n ≤ 2^11) or KACTL, plus all-(P−1)/sparse inputs.

Caveats: KACTL keeps static roots after warmup (favours KACTL); 393435 has compile-time
rate tables; ours and simd-v0 rebuild roots each call. This is the NTT alone — the judge
times also include I/O (about half of the 16 ms / 23 ms).

## Findings (run 36324984251, three jobs)

- EPYC 7763 (2 jobs, agree within ~1%): ours is **1.49–1.61× faster than 393435** at every
  size 2^10..2^22 (2^20: 5.12 vs 7.78 ms), 1.91–2.77× faster than simd-v0, 16–23× faster than KACTL.
- Xeon Platinum 8573C (1 job): ours vs 393435 **1.20–1.33×** (2^20: 6.30 vs 7.60 ms), vs simd-v0
  1.66–2.48×. The Shoup kernel's lead is smaller on Intel, as in exploration 008.
- simd-v0 → ours is ~1.9–2.0× at 2^18..2^22 on Zen 3; the gain is larger at small n (2.7× at 2^10).
- Noise: row spread (worst IQR/median) ≤ 4.2% on EPYC; Intel 2^21/2^22 rows 10–18%, driven by KACTL.
