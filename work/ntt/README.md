# New NTT implementation work

Place new variants and small shared test drivers here. Start from a relevant
existing source and record its path and commit in the associated exploration note.
Use descriptive filenames such as `stage_roots.cpp` or `small_stage_codelets.cpp`.

The [SIMD exploration](simd_explore/README.md) now contains an 18-variant generator,
native/local correctness and benchmark drivers, and frozen usable candidates.
Direct 8-coefficient products with identity specialization improve the user's
baseline, while the existing study v2 reference remains faster. See
[current status](../../notes/STATUS.md) and the linked raw native evidence.

Build into `build/` at the repository root. Retain source and useful notes in Git;
keep executables and temporary generated files out of version control.

The newer [lazy-reduction exploration](lazy_twiddle/README.md) independently
implements radix-4 butterflies, incremental twiddles, bounded leaf unrolling,
and final normalization fusion. It includes the kernel API, variant generator,
correctness/benchmark scripts, and measured successful and unsuccessful ideas.

[atcoder_ntt_compare.cpp](atcoder_ntt_compare.cpp) is a self-contained C++17
comparison ready for an AtCoder custom test. Empty input uses size 2^20, five
repetitions, and fresh roots; `20 9 2` measures nine repetitions with both fresh
and reused roots. It compares v0.91, the previous direct8 candidate, and three
new variants, checks against an independent scalar oracle, and contains no fast
study-reference kernel. See [exploration 003](../../notes/explorations/003-lazy-twiddles.md)
for native evidence and limitations.

The [low-level continuation](lowlevel/README.md) tests assembly, C++ controls,
Shoup multiplication and their combinations. Shoup cursor/prepacked candidates
beat the same-job study reference on measured AMD CPUs; Intel retains different
preferences. [atcoder_ntt_lowlevel_compare.cpp](atcoder_ntt_lowlevel_compare.cpp)
is the new single-file comparison, with the same empty-input / `20 9 2` interface.
The previous file remains unchanged. The wide-product Shoup entry is retained as
an unsuccessful comparison, not a recommended default kernel.

The [h14 continuation](h14_explore/README.md) uses the user's AtCoder result as
its baseline and tests38 further configurations. Packed Montgomery correction
words plus fixed/bottom traversal produced a modest~2% measured gain on EPYC7763;
whole-loop assembly and algorithmic alternatives are retained with their results.
[atcoder_ntt_h14_compare.cpp](atcoder_ntt_h14_compare.cpp) is the new eight-entry
standalone, printing CPU metadata and `speedup_vs_h14`. Use `20 10 0` or `20 10 2`.
AtCoder/Intel validation of the final combination remains open.

The [convolution_mod_large exploration](conv_large/README.md) (010) scales the
exploration-009 kernel to transform length 2^25 (N, M ≤ 2^24) with a zero-upper first
level, the final scale fused into the last inverse level and a lazily faulted THP arena.
[yosupo_convolution_mod_large.cpp](yosupo_convolution_mod_large.cpp) (exploration-007 I/O)
passes all 54 official cases; 528 ms vs 758 ms for the current leader on the same EPYC 7763
runner. [yosupo_convolution_mod_large_probe.cpp](yosupo_convolution_mod_large_probe.cpp) also
prints a one-line phase/THP/CPU report to stderr.
