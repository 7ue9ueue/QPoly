# Exploration 010: convolution_mod_large (N, M <= 2^24)

Target: <https://judge.yosupo.jp/problem/convolution_mod_large>. Output length up to
2^25 − 1, so the transform length is 2^25 while 998244353 only has roots of unity of
order 2^23. Judge: `g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`, AMD EPYC
7B13 (Zen 3), one logical CPU (`judge.slice` cpuset `0`, isolated), 1024 MiB counted
from `memory.current` (includes the tmpfs pages of our output file), 10 s limit.

Starting point: exploration-009 kernel `../asm_explore/kernels/qasm.hpp` (branch
`claude/ntt-asm-explore` 1e64289), selected configuration of
`../yosupo_convolution_asm_shoup.cpp`. Its x^8 − w leaf formulation only needs roots of
order n/8, so the arithmetic supports n ≤ 2^26 unchanged; the work here is structure.

## Files

| File | Purpose |
| --- | --- |
| `large.hpp` | Drivers: `run_b0` (qasm recursion at full size, optional zero-upper top), `run_top` (fused top pass over column panels, per-row qasm recursion, fused inverse top pass + scale). Contract in the header. |
| `bench_large.cpp` | Correctness (`check`) and timing (`time`, `phases`). Oracles: textbook NTT and brute force ≤ 2^20; for 2^21–2^26, `b0` verified at 8 random points and all entries bit-identical to it; cyclic results against the folded verified linear product. Poisoned upper halves prove the zero-upper contract. |
| `calib.cpp` | Machine calibration: DRAM bandwidth, page-fault/zeroing costs, tmpfs write/read at 335 MB, exploration-007 parser/formatter at 2^25 tokens. |
| `io007.hpp`, `make_io007.sh` | Exploration-007 I/O extracted verbatim from `../yosupo_convolution_shoup_avx2_io.cpp`. |
| `run.sh`, `../../../.github/workflows/ntt-conv-large.yml` | CI (pinned `gcc:15.2.0`, judge flags). |

## Timing boundaries

`bench_large time`: one call of the entry, root tables generated inside the timer (as a
submission does), arrays pre-faulted; input copies, zeroing and checksums outside.
Two warmups, interleaved rotated order, medians of 7 per round, 3 rounds per job.

See `notes/explorations/010-conv-large.md` for hypotheses and results.
