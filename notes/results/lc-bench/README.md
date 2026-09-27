# Library Checker NTT comparison — raw results

Harness: [work/ntt/lc_bench](../../../work/ntt/lc_bench/README.md), branch `claude/lc-bench`.
Run [36324984251](https://github.com/7ue9ueue/QPoly/actions/runs/36324984251), commit
`7f5e17befcd834861a3a3cff3c6ff1e1c475f8bf`, GCC 15.2.0 container, flags
`-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`, pinned with `taskset -c 1`.
Each job directory holds `table.md`, `raw.csv` (every timed call), `environment.txt`, `hashes.txt`.
All three jobs: correctness PASS (0 mismatches, 2^7..2^22).

(Run 36324970803, the first push, failed before building: git had normalised the
393435 source's CRLF line endings, so its pinned SHA256 did not match. Fixed with
`vendor/.gitattributes`.)

Median ms per cyclic convolution; speedup = other's time / ours.

| CPU | n | KACTL | simd-v0 | 393435 | ours | ×KACTL | ×simd-v0 | ×393435 |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| EPYC 7763 (job 1) | 2^16 | 5.2344 | 0.5203 | 0.3970 | 0.2525 | 20.73 | 2.06 | 1.57 |
| EPYC 7763 (job 1) | 2^20 | 108.5811 | 9.9634 | 7.7838 | 5.1230 | 21.19 | 1.94 | 1.52 |
| EPYC 7763 (job 1) | 2^22 | 488.7913 | 43.5985 | 33.9730 | 22.6813 | 21.55 | 1.92 | 1.50 |
| EPYC 7763 (job 2) | 2^20 | 111.5771 | 9.9188 | 7.7697 | 5.1243 | 21.77 | 1.94 | 1.52 |
| EPYC 7763 (job 2) | 2^22 | 497.6272 | 43.7922 | 34.2296 | 22.9723 | 21.66 | 1.91 | 1.49 |
| Xeon 8573C (job 3) | 2^20 | 68.2531 | 10.4812 | 7.5992 | 6.3040 | 10.83 | 1.66 | 1.21 |
| Xeon 8573C (job 3) | 2^22 | 539.6742 | 48.9257 | 35.4085 | 29.4907 | 18.30 | 1.66 | 1.20 |

Full tables for 2^10..2^22: `lc-bench-{1,2,3}/table.md`.

## Run 36325403204 (adds the simd-v0 vs KACTL column)

Commit with the extra column; jobs: EPYC 7763, EPYC 9V45, Xeon 8573C; all PASS.
simd-v0 vs KACTL: 5.8× (2^10) rising to 11.6–12.3× (2^20..2^22) on AMD; 3.9–10.3× on Intel.
Ours vs 393435: 1.49–1.60× (7763), 1.39–1.49× (9V45), 1.18–1.27× (8573C).
Tables: `36325403204/lc-bench-{1,2,3}/table.md`.
