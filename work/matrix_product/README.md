# Exploration 013: Library Checker matrix_product

Target: <https://judge.yosupo.jp/problem/matrix_product> — C = A·B mod 998244353 with
1 ≤ N, M, K ≤ 1024 (max case 1024³ ≈ 1.07·10⁹ multiply-adds, 20.7 MB of input text,
1 048 576 output values). Judge: GCC 15.2, `g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE
-march=native`, AMD EPYC 7B13 (Zen 3), one core; the reported time is the maximum case.
Records and results: [exploration 013](../../notes/explorations/013-matrix-product.md).

## Files

| File | Purpose |
| --- | --- |
| `common.hpp`, `bench.cpp` | Variant registry, grow-only THP scratch arena, kernel benchmark: correctness against an independent reference (transposed B, `unsigned __int128` dot products) on ~5 000 small shapes, random/boundary shapes and adversarial values (all P−1, (P±1)/2, the official overflow tests at their sizes, 1024³ extremes), then interleaved timing of one full call per variant. |
| `kernels/step1.cpp` | Step 1, portable C++: naive, lazy reduction, i-k-j order, blocking, a plain register tile, Strassen–Winograd over the tile and over the i-k-j leaf. |
| `simd.hpp`, `simd_kernel.hpp`, `kernels/step2.cpp`, `kernels/step2_sw.cpp`, `sw_driver.hpp` | Step 2, AVX2 intrinsics: signed-centered representation, load-only broadcasts, 4×8/6×8/2×16 tiles, the Winograd inner-product kernels, vectorized conversions, Strassen–Winograd drivers (plain, fused, hybrid). |
| `strassen.hpp` | Strassen–Winograd recursions over a recursive-quadrant layout (three-temporary schedule, fused passes, hybrid). |
| `gen_asm.py` → `asm_kernels.hpp`, `kernels/step3_asm.cpp` | Step 3: generated GCC inline-asm micro-kernels (direct and Winograd families, fold placement, row pairing, load hoisting) with tails; asm leaves inside the Strassen drivers. |
| `kbench.cpp`, `probe.cpp` | L1-resident kernel throughput (core clock calibrated with a dependent add chain) and Zen 3 port probes for the kernel's instruction mix. |
| `e2e/` | Judge-like end-to-end: `main_mp.cpp` (the program; switches below), `io007.hpp` (exploration-007 I/O, verbatim), `parse_ms2.inc` and `fmt_bcd.inc` (exploration-011 parser and fixed-width formatter, copied unchanged; `fmt_bcd.inc` adds `blocks3p`), `parse_sink.inc` (ms2 chunk loop handing values to a sink; measured, not used), `make_submission.py` (flattens to one file), `run_e2e.sh` + `launcher.c` + `init.c` (docker with judge limits, tmpfs cases, exact compile command, token-wise output checks like the judge's wcmp), `stress.py`, `summarize_e2e.py`, `variants.txt`. |
| `cases.py` | Regenerates all 22 official cases from the pinned library-checker-problems commit and checks inputs and model outputs against `hash.json`. |
| `yosupo_matrix_product.cpp` | The deliverable (exploration-011 I/O); `yosupo_matrix_product_io007.cpp` is the earlier, judged version (007 I/O, 53 ms). |
| `run.sh`, `ci_config.sh`, `summarize.py` | CI entry (`.github/workflows/matrix-product.yml`, branch `claude/matrix-product`), per-round settings, per-CPU summaries. |

## Kernel contract (all registered variants)

`fn(n, m, k, a, b, c)`: row-major `a` (n×m), `b` (m×k), `c` (n×k) with unpadded strides,
canonical inputs in [0, P), canonical outputs; 1 ≤ n, m, k ≤ 1024; 64-byte aligned, no
aliasing. Scratch in `mp::scratch(bytes, slot)` persists between calls and is never assumed
zero. Single-threaded, not reentrant.

## Representation and bounds (signed kernels)

- Values are centered, |x| ≤ H = (P−1)/2; the A side carries the Montgomery factor 2³², so
  the final REDC returns canonical dot products without another multiplication.
- Direct kernels: products ≤ H² ≈ 2.49·10¹⁷; a fold `x ← (x ≫ 32)·(2³² mod P) + (x mod 2³²)`
  leaves |x| < 6.49·10¹⁷, and 32 more products keep |x| < 8.62·10¹⁸ < 2⁶³.
- Winograd inner-product kernels: per k-pair (a₂ₛ + b₂ₛ₊₁)(a₂ₛ₊₁ + b₂ₛ), factors ≤ P−1, so a
  fold every 8 products; accumulators start at −(αᵢ + βⱼ) with αᵢ = Σ a₂ₛa₂ₛ₊₁ and
  βⱼ = Σ b₂ₛb₂ₛ₊₁ (centered residues), computed per leaf panel.
- Strassen: A/B-side sums are reduced back to [−H, H]; C-side sums stay canonical.
- Padding: n to 4·2ᴰ, k to 8·2ᴰ, m to 2·2ᴰ (zeros contribute nothing, also to α and β).

## Running

Local (Rosetta, correctness only): `./build_local.sh && ../../build/matrix_product/bench_local --check=quick`.
CI: edit `ci_config.sh` and `e2e/variants.txt`, push `claude/matrix-product`; artifacts per job.
Summaries: `python3 summarize.py RUN_DIR BASELINE` and `e2e/summarize_e2e.py RESULTS`.

## Program switches (`e2e/main_mp.cpp`)

`MP_KERNEL` (asm kernel name), `MP_DEPTH_MAX` (Strassen depth cap), `MP_IO011` (exploration-011
I/O: ms2 parser on whole matrices, `blocks3<4>` output, `MP_OBUF` buffer bytes, `MP_PARSE_CH`
chunk bytes, `MP_OUT_DIRECT` format from tiles, `MP_SINK` fused parse→pack), `MP_CHUNKED`
(007 I/O parsed in row chunks), `MP_LAZY_ARENA` (no up-front population), `MP_FUSED` /
`MP_FUSE_DEPTH` (fused Strassen passes), `MP_EARLY_UNMAP`, `MP_FAST_EXIT`, `MP_PHASES`.
The deliverable: `python3 e2e/make_submission.py e2e/main_mp.cpp yosupo_matrix_product.cpp
-DMP_KERNEL=sh_burst_p1 -DMP_DEPTH_MAX=3 -DMP_IO011 -DMP_LAZY_ARENA --asm-only sh_burst_p1
--header <the file's first 22 comment lines>`.
