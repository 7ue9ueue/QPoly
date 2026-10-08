# large_opt — further convolution_mod_large optimization (exploration 014)

Target: [Library Checker convolution_mod_large](https://judge.yosupo.jp/problem/convolution_mod_large),
record 0.454 s (submission 406521 = `../yosupo_convolution_mod_large_io_probe.cpp`, the
exploration-011 deliverable's probe twin). Starting point: branch `claude/ntt-conv-large` at 42953d3
(`../io_large/final_io_main.cpp` + `../conv_large/large_core.hpp` + the exploration-009 kernel).
Notes: [exploration 014](../../../notes/explorations/014-conv-large-opt.md).

## Deliverable

`../yosupo_convolution_mod_large_opt.cpp` (and `_probe.cpp`) = `final_opt_main.cpp` inlined by
`python3 work/ntt/io_large/make_submission.py --source ../large_opt/final_opt_main.cpp [--probe] --out …`:
the exploration-011 program with the `qp_parse_ms4` parser (256 KiB + skew chunks) and the
`qp_fmt_asm::blocks2_s4` formatter. About −5 ms end to end on EPYC 7763 (judge: EPYC 7B13, same Zen 3).

## Files

| File | Role |
| --- | --- |
| `final_opt_main.cpp` | deliverable program (selected variant only) |
| `main_opt.cpp` | experiment program; macros select parser (`QO_PARSE`, `QO_SUB`, `QO_SKEW`, `QO_PF`), formatter (`QO_FMT`, `QO_PFW`), transform driver (`QO_TW`, `QO_AH`) and the parse/transform overlap (`QO_OV`); defaults reproduce the exploration-011 deliverable |
| `parse_ms4.inc` | `qp_parse_ms4`: four tokens per stream step (selected); optional side job and non-temporal region copy |
| `parse_ms2s.inc` | ms2 with stream skew / prefetch / side job (round 1, refuted on Zen 3) |
| `parse_ms4p.inc` | software-pipelined ms4 (rounds 8–9, slower) |
| `parse_ablate.inc` | ms2 step ablations and conversion-only diagnostic |
| `fmt_asm.inc` | inline-asm `blocks3`: 8-store (`block8`, `blocks<G>`) and four-store (`block8_s4`, `blocks2_s4`, selected) layouts |
| `core_tw.hpp` | `qopt::CoreAh<C, TW, AHEAD>`: Core::run with generated bottom twiddles (N1) and/or bottom inputs prepared ahead; `a_top_done` for the overlap; all refuted |
| `bench_opt.cpp` | `unit`, `time`, `cache`, `ablate`, `ovl`, `fmtunit [limit]` (exhaustive to 10^9), `fmttime`, `fmtablate`, `one` |
| `bench_ntt.cpp` | transform variants: `check [lg]` (bit-identical to Core, generator vs tables, oracles), `time lg reps` (warm/fresh tables) |
| `asm_probe.cpp` | compiled with `-S` in CI to inspect GCC 15.2's code for the I/O loops |
| `run_micro.sh`, `run_perf.sh`, `run_e2e_opt.sh`, `launcher_opt.c`, `summarize_opt.py`, `ci.env`, `../../../.github/workflows/large-opt.yml` | CI: micro timings (gcc:15.2.0 image); PMU probe; judge-like e2e (copy of exploration 010's with probe-phase parsing and a wall/user/sys/phase summary); all official cases |
