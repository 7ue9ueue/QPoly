# Exploration 014 raw results (convolution_mod_large further optimization)

Downloaded artifacts of `.github/workflows/large-opt.yml` on branch `claude/conv-large-opt` (text/CSV
and generated sources). Per run: `micro-N` (pinned gcc:15.2.0 image, judge flags: `unit.txt`,
`fmtunit.txt`, `ntt-check.txt`, timing CSVs `time-*.csv` (parsers, ms and ns/token), `fmttime-*.csv`,
`fmtablate-*.csv`, `ablate-*.csv`, `cache-*.csv`, `ovl-*.csv`, `ntt-time-*.csv`, `asm_probe.s`),
`e2e-N` (judge-like end to end via `work/ntt/large_opt/run_e2e_opt.sh`: manifest with generated-source
SHA256, `checks.txt`, `timing-madvise.csv` with wall/user/sys and, for probe builds, in-process phases;
`summary.txt` (max over cases) and `summary_opt.txt` (phases)), `perf` (hardware-counter probe) and,
when run, `official` (all 54 cases). Timing includes process start and exit. CPU per job in
`environment.txt`; compare only within a job.

| Run | Round | Content |
| --- | --- | --- |
| [37679652788](https://github.com/7ue9ueue/QPoly/actions/runs/37679652788), [37679653335](https://github.com/7ue9ueue/QPoly/actions/runs/37679653335) | 1 | ms2 stream skew / prefetch; PMU probe (none) |
| [37699451725](https://github.com/7ue9ueue/QPoly/actions/runs/37699451725) | 2 | N1 generated twiddles; parse/NTT overlap experiment |
| [37700082427](https://github.com/7ue9ueue/QPoly/actions/runs/37700082427) | 3 | ms2 step ablations, cache vs DRAM, GCC assembly probe |
| [37700708764](https://github.com/7ue9ueue/QPoly/actions/runs/37700708764) | 4 | ms4 (four tokens per step) |
| [37701694680](https://github.com/7ue9ueue/QPoly/actions/runs/37701694680) | 5 | inline-asm formatter (exhaustive check), e2e f2/f4 |
| [37702666337](https://github.com/7ue9ueue/QPoly/actions/runs/37702666337) | 6 | bottom-stage lookahead, formatter ablations, probe phases |
| [37714249648](https://github.com/7ue9ueue/QPoly/actions/runs/37714249648) | 7 | four-store formatter, prefetchw, top-group overlap, combinations |
| [37714525878](https://github.com/7ue9ueue/QPoly/actions/runs/37714525878) | 7b | conversion-only parser ablation |
| [37714684067](https://github.com/7ue9ueue/QPoly/actions/runs/37714684067), [37714943080](https://github.com/7ue9ueue/QPoly/actions/runs/37714943080) | 8, 9 | software-pipelined ms4 (two forms) |
| [37715313558](https://github.com/7ue9ueue/QPoly/actions/runs/37715313558) | 10 | s4q vs deliverable on 5 runners; non-temporal region copy |
| [37728644492](https://github.com/7ue9ueue/QPoly/actions/runs/37728644492) | 11 | final files: e2e on 5 runners, all 54 official cases |
| [37729362053](https://github.com/7ue9ueue/QPoly/actions/runs/37729362053) (+ `-attempt-2`) | 12 | two-stream four-token parser (micro) |
