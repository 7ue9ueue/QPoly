# Exploration 010 raw results (convolution_mod_large)

Downloaded artifacts of `.github/workflows/ntt-conv-large.yml` on branch `claude/ntt-conv-large`
(text/CSV only; binaries are never uploaded). Each run folder holds one subfolder per job:
`conv-large-N` (kernel: environment, check.txt, calib.txt, time*.csv, phases25.csv),
`conv-large-e2e[-N]` (end to end: cases.json, manifest.txt, checks.txt, timing-*.csv,
phases-*.csv, summary.txt) and `conv-large-official` (all 54 official cases).
Timing CSV columns are documented in `bench_large.cpp` and `launcher_large.c`.

| Run | Round | Content |
| --- | --- | --- |
| [36311854189](https://github.com/7ue9ueue/QPoly/actions/runs/36311854189) | 1 | calibration; b0, b0z, 64-byte-panel top passes (with/without NT stores) |
| [36312561197](https://github.com/7ue9ueue/QPoly/actions/runs/36312561197) | 2 | fused final scale (b0zs); wide panels, separate a/b sweeps (e2e failed: reference whitespace) |
| [36313058400](https://github.com/7ue9ueue/QPoly/actions/runs/36313058400) | 3 | NT-store top level; per-depth timers d1–d3 (e2e failed: reference stderr) |
| [36313358447](https://github.com/7ue9ueue/QPoly/actions/runs/36313358447) | e2e 1 | first end to end (EPYC 9V45): b0zs 364 vs 403499 510 vs 303498 573 ms |
| [36313895572](https://github.com/7ue9ueue/QPoly/actions/runs/36313895572) | e2e 2 | QL_FUSE (depth-0 levels in parse/format) vs b0zs vs 403499, 2x EPYC 7763 |
| [36314351146](https://github.com/7ue9ueue/QPoly/actions/runs/36314351146) | 4 | tile 1024, kept tables, lazy arena e2e (official job failed: mode-0 output file) |
| [36314686184](https://github.com/7ue9ueue/QPoly/actions/runs/36314686184) | 5 | lazy arena confirmation (madvise and always); all 54 official cases pass |
| [36315260768](https://github.com/7ue9ueue/QPoly/actions/runs/36315260768) | final | final file and probe: 54/54 official (108 runs); final vs exp vs 403499 e2e; the verified sources are in `conv-large-official/` |
| [36315509924](https://github.com/7ue9ueue/QPoly/actions/runs/36315509924) | recheck | exploration-009 asm alternatives at 2^25; per-depth timers d1–d6 |
