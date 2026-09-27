# Library Checker NTT comparison

Times four NTT convolutions on the same inputs, in the same process, with Library
Checker's compiler and flags (GCC 15.2, `-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`).

| Name | What | Source |
| --- | --- | --- |
| KACTL | KACTL NTT (kactl.github.io, CC0), scalar reference | `kactl_bench.cpp` |
| simd-v0 | the user's first AVX2 Montgomery NTT | `kactl_bench.cpp` |
| 393435 | QgQ's [submission 393435](https://judge.yosupo.jp/submission/393435), the fastest `convolution_mod` submission by someone else (23 ms) | [vendor/submission_393435.cpp](vendor/submission_393435.cpp) |
| ours | exploration-009 kernel (Shoup radix-4 + generated inline asm), our [submission 406478](https://judge.yosupo.jp/submission/406478) (16 ms); current best for n ≤ 2^22 | `work/ntt/yosupo_convolution_asm_shoup_io_sse.cpp` |

`vendor/submission_393435.cpp` is the submission source as returned by
`https://v3.api.judge.yosupo.jp/submissions/393435` on 2026-09-27 (SHA256 79ae944f…).
It carries no license notice; it is kept for attribution and benchmarking only. Our
406478 judge source equals the local file minus its two `QPOLY_TIMING` lines.

## Run

```sh
bash work/ntt/lc_bench/run.sh results 10 22     # x86-64 Linux with AVX2, GCC, python3
```

CI: `.github/workflows/lc-bench.yml` (push to `claude/lc-bench` or manual dispatch), three
jobs; each job's table appears in the run summary and `results/` is uploaded.

## Method

- `extract.py` copies each implementation's code verbatim out of its SHA256-pinned
  source (drops only I/O and `main()`); simd-v0 is wrapped in `namespace simd0`.
- One translation unit per implementation (`impl_*.cpp`), each under its source's own
  pragmas, same flags, no LTO. Each wrapper makes the calls its submission makes.
- Workload: cyclic convolution mod 998244353 of two random full-length sequences,
  n = 2^10 … 2^22. Every implementation does the full transform (our kernel's
  zero-upper-half shortcut for padded inputs does not apply).
- Timed: one `run()` call. Inside: roots/twiddles, Montgomery conversions, scaling and
  the implementation's own allocations. Outside: input copies (pages already touched),
  result checks. simd-v0 and ours regenerate roots every call; 393435 uses compile-time
  rate tables; KACTL keeps its static root table after warmup (favours KACTL).
- Per size: 2 warmup rounds, then R rounds (R ≥ 11, ~1.5 s per size); each round calls
  all four once, order rotated per round. Median reported; `spread` is the largest
  IQR/median in the row. Process pinned to one CPU with `taskset` when available.
- Correctness: every call (warmups and timed) is compared with a reference — O(n²)
  brute force for n ≤ 2^11, KACTL above — plus all-(P−1) and sparse inputs at 2^7…2^22.
  A mismatch prints `FAIL` and the program exits 1.

Outputs: `table.md` (the table), `raw.csv` (every timed call), `environment.txt`
(lscpu, compiler, commit), `hashes.txt`.
