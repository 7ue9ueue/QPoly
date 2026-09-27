# Round 7: instruction-count reductions (exploration 008)

Kernel family `qflip` in [kernels/flip.hpp](kernels/flip.hpp), written for this round.
The structure follows the user's h14/mullo_bottom lineage: radix-4 recursion,
256-vector fixed tiles, a fused h=1 stage with direct degree-7 leaf products,
O(N/16) root tables and a fused top/scale stage. Every idea is a template
switch in `Cfg<...>` so that it can be measured in isolation.

| Switch | Meaning |
| --- | --- |
| `Mul` | 0 Montgomery (vpmuludq quotients), 1 Montgomery + one vpmulld quotient, 2 Shoup |
| `Flip` | parity-permuted storage so Montgomery products repack with one `vshufps` |
| `Pair` | twiddle table holds (w, quotient) pairs; leaf weights computed as vectors |
| `Leaf` | leaf multiply-accumulate variants (0 = plain, the best on Zen 3) |
| `Shuf` | odd-lane extraction with `vpshufd` instead of `vpsrlq` |
| `Tile` | fixed tile size in vectors (64/256/1024) |
| `Aux` | Shoup also for the leaf's w*a multiply and the final scale |
| `Opq` | empty-asm barrier on products (stops GCC re-association) |
| `LdOdd` | odd lanes of loaded multiply inputs come from an unaligned load |
| `Il` | two interleaved butterflies per loop iteration |
| `Blk` | Shoup tables in blocks of 8 values + 8 quotients (8-lane generation) |
| `Pipe` | bottom stage builds the next leaf batch's windows before this batch's MAC |

Best Library Checker configuration: `Cfg<2, false, true, 0, false, 256, true,
true, true, 1, true, true>` (`s_ns_olbp`; `s_ns_olb` without `Pipe` is equal on
Zen 3). Contract: n a power of two in [64, 2^22]; a, b canonical, 32-byte aligned,
disjoint, with 4 readable bytes after each array (LdOdd); a receives the
canonical cyclic convolution, b is destroyed; root buffers hold n/8 + 8 words.
Forward values < 4P, inverse values < 2P; Shoup and Montgomery products < 2P
for any 32-bit input; leaf sums < 8(P-1)^2 + (2^32-1)P < 2^64.
`run(..., nza, nzb)` skips the forward top radix-2 layer when an input's upper
half is zero (ordinary convolution padding).

## Files

- `bench.cpp`, `entries.inc`: correctness (independent scalar oracle, brute force,
  boundary values, zero-upper-half cases, changing sizes, fresh/reuse) and
  interleaved timing. `ONLY=a,b` selects entries.
- `baselines/`: h14, mullo_bottom and asm_large_fixed extracted verbatim from
  `../atcoder_ntt_h14_compare.cpp`; `ref_yosupo.hpp` is the record-holder kernel
  from `study/fast_ntt_v2.cpp`, for timing comparison only.
- `kernels/candidates.hpp`: registered configurations.
- `micro.cpp`: per-phase cycles on L1-resident data (clock-calibrated).
- `run.sh`: CI build/check/timing with Library Checker flags (`lc`) and a
  `-march=znver3` profile; `run_yosupo.sh`: end-to-end submission checks and
  max-input compute/wall comparison; `summarize.py`: tables per job.
- `make_yosupo.py`: generates `../yosupo_convolution_shoup.cpp` (deliverable,
  SSE I/O from exploration 007) and `generated/yosupo_shoup_basicio.cpp`.
- `verify_yosupo.py`: copy of `../verify_yosupo_convolution.py` that accepts the
  optional `compute_ms=` stderr line.

CI: `.github/workflows/ntt-uop.yml` on branch `claude/ntt-uop-explore` (official
`gcc:15.2.0` container, pinned digest). Results: `notes/results/ntt-uop-native/`.
See [exploration 008](../../../notes/explorations/008-uop-shoup.md).
