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
