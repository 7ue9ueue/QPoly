# h14 continuation evidence

All performance measurements are native x64, GCC15.2.0. Four successful rounds
cover38 new variants plus h14/v91, nine timing jobs and four sanitizer jobs.
Local Clang/Rosetta runs are correctness-only and are not pooled with these data.

- [36278374567](36278374567/): container metadata failure before benchmarking.
- [36278509138](36278509138/):17 entries, leaf assembly/traversal and C++ ablations.
- [36278897141](36278897141/):14 entries, forward assembly and combinations.
- [36279149290](36279149290/):15 entries, inverse assembly, twiddle storage, multiply alternatives.
- [36279532832](36279532832/):9 entries, Karatsuba and final combinations; exact standalone validation.

Read [exploration005](../../explorations/005-h14.md) for findings, limits and sources.
The final best candidate has a modest measured~2% gain on EPYC7763. The user's
AtCoder run is separate evidence under `notes/results/ntt-atcoder-user/2026-09-27`.
