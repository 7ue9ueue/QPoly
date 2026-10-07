# large_opt — further convolution_mod_large optimization (exploration 014)

Target: [Library Checker convolution_mod_large](https://judge.yosupo.jp/problem/convolution_mod_large),
record 0.454 s (submission 406521 = `../yosupo_convolution_mod_large_io_probe.cpp`, the
exploration-011 deliverable's probe twin). Starting point: branch `claude/ntt-conv-large` at 42953d3
(`../io_large/final_io_main.cpp` + `../conv_large/large_core.hpp` + the exploration-009 kernel).
Notes: [exploration 014](../../../notes/explorations/014-conv-large-opt.md).

Judge phase times of 406521 (its stderr, EPYC 7B13, THP madvise, max cases): parse 71 ms (parser
~47 + input page faults ~17 + arena first touch), NTT 205 ms, output 156 ms (format ~36 + write()
~120), ~12 ms outside `main` (exec, input unmap, exit).

## Files

| File | Role |
| --- | --- |
| `parse_ms2s.inc` | `qp_parse_ms2` with stream spacing `SUB + SKEW` (default ms2: 4 streams exactly 32 KiB apart, i.e. the same L1D set) and optional per-step prefetch |
| `main_opt.cpp` | experiment program: the exploration-011 deliverable with macro switches (`QO_PARSE`, `QO_SUB`, `QO_SKEW`, `QO_PF`); defaults reproduce the deliverable's code path |
| `bench_opt.cpp` | `unit` (all parser variants: random/9-digit/1-digit/uniform-length/edge/short streams, mixed whitespace, resumed calls, fixed-width round trip), `time [reps]` (2^25 tokens, interleaved), `one NAME KIND N` (for perf) |
| `run_micro.sh`, `run_perf.sh`, `ci.env`, `../../../.github/workflows/large-opt.yml` | CI: micro timings in the pinned gcc:15.2.0 image; hardware-counter probe on the host; judge-like e2e via `../conv_large/run_e2e.sh`; all official cases via `../conv_large/run_official_all.sh` |

Single files: `python3 work/ntt/io_large/make_submission.py --source ../large_opt/main_opt.cpp --define QO_PARSE=1 ... --out FILE`.
