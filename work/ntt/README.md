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
