# Raw results — exploration 013 (matrix_product)

One directory per CI round of `.github/workflows/matrix-product.yml` on branch
`claude/matrix-product` (repository `7ue9ueue/QPoly`), named `<round>-<run id>`; run pages
are `https://github.com/7ue9ueue/QPoly/actions/runs/<run id>`. Each job directory holds the
text artifacts only (binaries omitted):

- `bench-N/`: `environment.txt` (CPU, compiler, flags, THP), `check.txt` (correctness suite),
  `timing.txt` (all samples as `CSV,size,variant,rep,ms` plus the median table), `table.md`,
  `kbench.txt` (L1 kernel cycles per k-step, whole-leaf benchmark), `probe.txt` (port probes),
  `sources-sha256.txt`.
- `e2e-N/`: `environment.txt`, `cases.txt`/`cases.json` (hash-checked official cases),
  `checks.txt` (launcher PASS lines, stress result), `correctness.csv`, `timing-<thp>.csv`
  (spawn→wait4 wall time, rusage, stderr phase marks), `phases.csv`, `summary.txt`,
  `sources-sha256.txt`, `compiler.txt`.

Summaries: `python3 work/matrix_product/summarize.py <round dir> <baseline>` (bench) and
`python3 work/matrix_product/e2e/summarize_e2e.py <e2e job dir>`.

| Round | Content |
| --- | --- |
| 01 | Step 1 portable C++ variants (naive → Strassen over a plain tile). |
| 02 | Step 1 finish (Strassen over the i-k-j leaf, depth 5) and first AVX2 kernels; Strassen over SIMD. |
| 03 | kbench (L1 cycles/k-step) and phase split of Strassen+SIMD (packing 4.8 ms). |
| 03b | Zen 3 port probes: 8 mul + 8 add = 4.95 cycles; loads free. |
| 03c | Winograd-pair probes; vectorized conversions (packing 0.8 ms). |
| 04 | Winograd inner-product intrinsics kernel; Strassen over it. |
| 05 | Strassen additions alone per depth; packed-B Winograd kernel. |
| 06 | First generated asm kernels (Winograd packed-B 5.05 cycles/k-step). |
| 07 | More schedules (shifts first 4.88), asm leaves in Strassen, plain GEMM with asm. |
| 08 | First end-to-end run (EPYC 9V74 only). |
| 09 / 09b | Fused Strassen passes (bench) / e2e with the leader 401223 as in-job reference. |
| 10 | sh-form schedule family (`sh_burst_p1` 4.84); chunked parse+pack. |
| 11 | Hybrid fused levels; row-buffered chunked output (best program, 0.78× the leader). |
| 12 | Whole-leaf benchmark (64³/128³/256³). |
| 13 | Validation of the first deliverable: 22 cases, native stress, THP madvise/always/never. |
| 14 | Why that deliverable was 1.2 ms slower: `_exit` (not layout or alignment). |
| 15 | Early `munmap` of the input (no gain) and `_exit` again (slower). |
| 16 | Final confirmation of the deliverable (SHA256 936b8e78…): 22 cases, stress, timing vs 401223. |
| 17 | Comment-only update (SHA256 6b771616…): identical judge-flag binary (aa99cf7b… on EPYC 7763), 22 cases. |
| 18 | I/O: exploration-011 parser/formatter path (token-wise checks), direct-from-tiles output, lazy arena, 64 KiB buffer. |
| 19 | I/O: fused parse→pack through a sink-based parser (no gain) vs 011 I/O + lazy arena. |
| 20 | I/O deliverable (SHA256 4ecc061d…) vs the submitted 007-I/O file: 22 cases, stress, THP madvise/always/never. |
