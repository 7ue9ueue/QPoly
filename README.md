# SymPoly

This is my NTT optimization showcase project. I am still actively working on it.

## My implementation

My core authored path is the `ntt_{date}_{version}.cpp` progression in `cp/`, where I iteratively optimized the same NTT pipeline:

- `cp/ntt_jan2_v2.cpp` -> `cp/ntt_jan2_v3.cpp`
- `cp/ntt_jan3_v1.cpp` -> `cp/ntt_jan3_v7.cpp`

How I worked:

- Start from a correct AVX2 NTT baseline
- Benchmark by size (`2^k`) and compare against KACTL for correctness
- Profile hot stages (root precompute, DIF/DIT loops, pointwise multiply)
- Apply one optimization at a time (modmul variant, loop fusion/unroll, radix scheduling, alignment, memory layout), then re-measure

This repo also contains references/study/experiment files, but the section above is the main implementation track I wrote and evolved.

## What I am studying

- AVX2 intrinsics for polynomial/NTT workloads
- Modular arithmetic optimizations (Montgomery, Barrett/Shoup style reduction)
- NTT structure and scheduling (DIF/DIT, radix-2/radix-4 strategies)
- Memory and micro-optimization details (alignment, unrolling, loop layout)

## Techniques used in my code

- SIMD-heavy AVX2 kernels (`__m256i`)
- Mixed-stage NTT design with DIF forward + DIT inverse
- Radix-4 implementation (with mixed radix handling where needed)
- Instruction-level parallelism (ILP)-aware scheduling
- Twiddle/root precomputation strategies
- Modular multiplication design tradeoff: Montgomery vs Barrett/Shoup reduction
- Correctness validation against KACTL reference NTT
- Iterative profiling + benchmarking across powers of two

## Montgomery vs Barrett/Shoup (my choice)

I studied and implemented both approaches for SIMD modular multiplication:

- `Montgomery multiplication`: uses `M_INV` and Montgomery-domain reduction (`REDC`)
- `Barrett/Shoup reduction`: uses precomputed `bp = floor((b * 2^32) / MOD)` and computes `a*b - q*MOD`

Implementation notes:

- Core implementation exploration is in `experiments/SIMD_modmul.cpp`
- Benchmark run/results are documented in `tests/modmul/modmul_bench.cpp` (comment block at the end)

Benchmark snapshot from `tests/modmul/modmul_bench.cpp`:

- `_mm256_mont_mul (int): 0.0110911s`
- `_mm256_shoup_mul (int): 0.0135459s`

So, based on these measurements, I mainly chose Montgomery multiplication for the hot NTT path in later versions, while keeping Barrett/Shoup as an important studied and tested alternative.

## Float trick experiment (why I did not use it)

I also tried the float/double modular multiplication approach in `tests/float/float_test.cpp` and related modmul benchmarks.

- With `MOD = 998244353` (about `9e8`), coefficient products are around `1e18`
- That exceeds exact integer precision of IEEE `double` mantissa (`53` bits), so safe reduction needs extra correction logic / wider integer handling (practically moving toward `__int128`-style checks)
- That extra work hurts performance, so I did not use the float trick in the main NTT implementation

Benchmark context (`tests/modmul/modmul_bench.cpp`):

- `mul_mod_f64_avx2 (double): 0.0180423s`
- `_mm256_mont_mul (int): 0.0110911s`

## Progress snapshot

From my local benchmark notes (`cp/NOTES.md` / `cp/BENCHMARK.md`):

- Early version (`Jan2_v2`) at `2^20`: `15870 us` (`15.870 ms`)
- Later version (`Jan3_v1`) at `2^20`: `13538 us` (`13.539 ms`)
- Record-holder reference implementation (library tester snapshot) at `2^20`: `6662 us` (`6.662 ms`)
- My fastest implementation (`cp/ntt_ver0.91.cpp`) at `2^20`: `9924 us` (`9.924 ms`)

## KACTL benchmark (AtCoder)

`kactl_bench.cpp` is the benchmark file (run on AtCoder).  
The results below are copied from the end of `kactl_bench.cpp`.

### Correctness summary

- PASS from size `2^4` through `2^20` against KACTL reference

### SIMD NTT vs KACTL NTT

| Size | SIMD (us) | KACTL (us) | Speedup |
|---|---:|---:|---:|
| 2^12 | 26.9 | 129.5 | 4.81x |
| 2^13 | 55.6 | 281.7 | 5.06x |
| 2^14 | 110.4 | 637.5 | 5.77x |
| 2^15 | 227.4 | 1466.6 | 6.45x |
| 2^16 | 478.7 | 3183.8 | 6.65x |
| 2^17 | 1092.6 | 6770.8 | 6.20x |
| 2^18 | 2161.1 | 14189.7 | 6.57x |
| 2^19 | 4673.0 | 31940.9 | 6.84x |
| 2^20 | 10072.2 | 69126.7 | 6.86x |
| 2^21 | 20873.8 | 164404.8 | 7.88x |
| 2^22 | 45394.0 | 416031.5 | 9.16x |
