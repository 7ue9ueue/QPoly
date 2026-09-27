## Cyclic convolution mod 998244353: median time per call

CPU: AMD EPYC 7763 64-Core Processor  
Compiler: GCC 15.2.0, flags `-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`  
Implementations: KACTL (reference), simd-v0 (the user's first AVX2 NTT), 393435 (QgQ, fastest other Library Checker submission), ours (exploration 009 kernel, submission 406478)

| n | KACTL ms | simd-v0 ms | 393435 ms | ours ms | ours vs KACTL | ours vs simd-v0 | ours vs 393435 | 393435 vs KACTL | reps | spread |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2^10 | 0.0472 | 0.0082 | 0.0044 | 0.0030 | 15.90x | 2.77x | 1.49x | 10.68x | 1001 | 0.7% |
| 2^11 | 0.1020 | 0.0152 | 0.0089 | 0.0059 | 17.22x | 2.57x | 1.51x | 11.42x | 1001 | 0.8% |
| 2^12 | 0.2194 | 0.0292 | 0.0200 | 0.0125 | 17.52x | 2.33x | 1.60x | 10.98x | 1001 | 1.3% |
| 2^13 | 0.4794 | 0.0584 | 0.0405 | 0.0265 | 18.09x | 2.20x | 1.53x | 11.83x | 1001 | 2.2% |
| 2^14 | 1.0806 | 0.1193 | 0.0893 | 0.0566 | 19.08x | 2.11x | 1.58x | 12.11x | 1001 | 0.8% |
| 2^15 | 2.3877 | 0.2470 | 0.1811 | 0.1185 | 20.16x | 2.08x | 1.53x | 13.18x | 511 | 4.1% |
| 2^16 | 5.2047 | 0.5215 | 0.3977 | 0.2572 | 20.24x | 2.03x | 1.55x | 13.09x | 233 | 3.9% |
| 2^17 | 11.1142 | 1.0920 | 0.8181 | 0.5389 | 20.62x | 2.03x | 1.52x | 13.58x | 110 | 2.1% |
| 2^18 | 23.6955 | 2.3044 | 1.7756 | 1.1597 | 20.43x | 1.99x | 1.53x | 13.34x | 51 | 1.4% |
| 2^19 | 50.1368 | 4.7861 | 3.6270 | 2.4172 | 20.74x | 1.98x | 1.50x | 13.82x | 24 | 0.9% |
| 2^20 | 111.5771 | 9.9188 | 7.7697 | 5.1243 | 21.77x | 1.94x | 1.52x | 14.36x | 11 | 3.9% |
| 2^21 | 240.3445 | 20.4789 | 15.8419 | 10.5038 | 22.88x | 1.95x | 1.51x | 15.17x | 11 | 3.6% |
| 2^22 | 497.6272 | 43.7922 | 34.2296 | 22.9723 | 21.66x | 1.91x | 1.49x | 14.54x | 11 | 3.5% |

"A vs B" = B's median time / A's median time (above 1.00x: A is faster). spread = largest interquartile range / median among the four in that row.

Correctness: every timed call checked (brute force n <= 2^11, KACTL above); all-(P-1) and sparse inputs at 2^7..2^22: PASS (0 mismatches). Total 31.4 s.
