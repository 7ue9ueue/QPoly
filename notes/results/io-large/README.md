# Exploration 011 raw results (convolution_mod_large I/O)

Downloaded artifacts of `.github/workflows/ntt-conv-large.yml` on branch `claude/ntt-conv-large`
(text/CSV only). Per run: `io-large-N` (I/O job: environment, source hashes, `unit.txt`,
`time-{1,2,3}.csv` with `parse,<parser>,<input>,ms,ns/token`, `format,…` and `format_write,…`
lines, 2^25 tokens/values, medians of 5 after a warmup), `conv-large-e2e-N` (end to end: manifest
with generated-source SHA256, checks, `timing-madvise.csv`, `summary.txt` with median (min–max) of 7
per case and the max over the large cases) and, when run, `conv-large-official` (all 54 official
cases: `official_all.csv` verdicts byte-exact / checker-ok). Timing includes process start and exit;
official-job wall times include docker start and are not timing claims.

| Run | Round | Content |
| --- | --- | --- |
| [36317965170](https://github.com/7ue9ueue/QPoly/actions/runs/36317965170) | 1 | fixed-width AVX2 formatter (`eight`), tail parser, guarded input; 54/54 official |
| [36318650592](https://github.com/7ue9ueue/QPoly/actions/runs/36318650592) | 2 | `blocks<1/2>` formatters, 8-token tail parser, probe |
| [36319261495](https://github.com/7ue9ueue/QPoly/actions/runs/36319261495) | 3 | `blocks<4>`, 160 KiB page-aligned buffer |
| [36320182562](https://github.com/7ue9ueue/QPoly/actions/runs/36320182562) | 4 | multi-stream parser `ms` (K = 4, 8), write() buffer sweep |
| [36320880851](https://github.com/7ue9ueue/QPoly/actions/runs/36320880851) | 5 | `ms2` (two tokens per stream step), 16/32/64 KiB chunks |
| [36321423954](https://github.com/7ue9ueue/QPoly/actions/runs/36321423954) | 6 | `ms2` 64/128 KiB; `blocks3` formatter |
| [36321954127](https://github.com/7ue9ueue/QPoly/actions/runs/36321954127) | 7 | `ms3` (K = 4, 8), `blocks3<2>` |
| [36322772709](https://github.com/7ue9ueue/QPoly/actions/runs/36322772709) | 8 | deliverable and probe: e2e and 54 official cases |
