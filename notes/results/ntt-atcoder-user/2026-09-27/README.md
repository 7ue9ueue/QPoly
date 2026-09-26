# User-reported AtCoder comparison

Source: output pasted by the user in this task, received by 2026-09-27.
Compiler reports15.2.0. Input configuration max_log2=20, repetitions=10, mode=0.
All powers2^6 through2^20 passed, as did maximum coefficients, cyclic wraparound,
changing sizes. Final checksum9904829975434143650. CPU, exact submission source
hash, full compile command and per-repetition samples were not supplied. The names
and checksum match the previous low-level comparison; exact source identity is
not independently verified. No run URL was supplied.

The table is the user's reported2^20 summary, not raw individual samples:

| Implementation | Median ms | Minimum ms | Maximum ms | Speedup vs v91 |
| --- | ---: | ---: | ---: | ---: |
| v91 |11.6617|11.4917|11.7277|1.0000|
| lazy_inc_fused |8.2809|8.2456|8.3407|1.4083|
| lazy_hybrid_fused |8.2110|8.1328|8.2438|1.4203|
| ll_inline_h14 |7.9968|7.9592|8.0819|1.4583|
| ll_shoup_cursor |8.5220|8.4087|8.5648|1.3684|
| ll_shoup_prepack |8.6599|8.5497|8.7314|1.3466|
| ll_shoup_wide_cursor |9.1445|9.1217|9.2514|1.2753|

ll_inline_h14 has31.4% less time than v91 and2.6% less than the previous hybrid.
It also won at2^18 and2^19 but not every smaller size (2^16 favored incremental,
2^17 favored Shoup-prepack medians, with broad ranges). This supports using h14
as the next target baseline, not predicting performance on unidentified CPUs.
Do not pool these results with Actions runner measurements.
