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
I/O: exploration 007 (`io007.hpp`, extracted verbatim from `../yosupo_convolution_shoup_avx2_io.cpp`).

## Deliverable

`../yosupo_convolution_mod_large.cpp` = `python3 make_submission.py` (single file from
`final_main.cpp` + `io007.hpp` + `large_core.hpp` + `qasm.hpp` with only the selected asm
variants). `--probe` builds `../yosupo_convolution_mod_large_probe.cpp`, which additionally
prints one stderr line (phase ms, THP mode, CPU) — useful once on the judge, which shows stderr.

## Files

| File | Purpose |
| --- | --- |
| `large_core.hpp` | Final driver `Core<Sel>::run`: qasm recursion at full size, zero-upper first level, final scale fused into the last inverse level. Contract in the header. |
| `final_main.cpp` | Final program: 007 I/O; qasm `run()` for lengths ≤ 2^22, `Core::run` above; THP arena faulted on first touch for lengths ≥ 2^23. |
| `large.hpp` | Experimental drivers on top of the core: `run_b0` switches (zero-upper, fused scale, NT stores, kept tables), fused top pass over column panels (`run_top`), `middle` for I/O fusion, per-depth timers. |
| `solve_main.cpp` | Experiment program (QL_MODE, QL_FUSE, QL_LAZY_ARENA switches) for the e2e harness. |
| `bench_large.cpp` | Correctness (`check`) and timing (`time`, `phases`). Oracles: textbook NTT and brute force ≤ 2^20; for 2^21–2^25, `b0` verified at 8 random points and all entries bit-identical to it; cyclic results against the folded verified linear product; poisoned upper halves prove the zero-upper contract. |
| `calib.cpp` | Machine calibration: DRAM bandwidth, page-fault costs, tmpfs write/read at 331 MB, 007 parser/formatter at 2^25 tokens. |
| `check_output.cpp` | Independent output checker (scalar parse, 8 random evaluation points). |
| `cases_large.py`, `run_e2e.sh`, `launcher_large.c`, `init.c`, `summarize_e2e.py` | Judge-like end-to-end timing: official cases on tmpfs (hash-verified), judge flags, 1 GiB container, spawn→exit wall time; references fetched from the judge API at run time (not stored). |
| `run_official_all.sh` | All 54 official cases one at a time, output SHA256 against `hash.json`. |
| `make_submission.py`, `make_io007.sh` | Single-file generator; 007 I/O extraction. |
| `run.sh`, `ci.env`, `../../../.github/workflows/ntt-conv-large.yml` | CI (pinned `gcc:15.2.0`, judge flags); `ci.env` selects each round's jobs. |

## Timing boundaries

`bench_large time`: one call of the entry, root tables generated inside the timer (as a
submission does), arrays pre-faulted; input copies, zeroing and checksums outside.
Two warmups, interleaved rotated order, medians of 7 per round, 3 rounds per job.
`run_e2e.sh`: posix_spawn of the init equivalent → wait4, i.e. exec, loading, page faults,
parse, transform, formatting, `write()` into a new tmpfs file and teardown; outputs checked
(byte-exact, or whitespace-insensitive for references) after every run.

See `notes/explorations/010-conv-large.md` for hypotheses and results.
