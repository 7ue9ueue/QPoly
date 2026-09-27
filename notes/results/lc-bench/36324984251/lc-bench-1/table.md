## Cyclic convolution mod 998244353: median time per call

CPU: AMD EPYC 7763 64-Core Processor  
Compiler: GCC 15.2.0, flags `-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`  
Implementations: KACTL (reference), simd-v0 (the user's first AVX2 NTT), 393435 (QgQ, fastest other Library Checker submission), ours (exploration 009 kernel, submission 406478)

| n | KACTL ms | simd-v0 ms | 393435 ms | ours ms | ours vs KACTL | ours vs simd-v0 | ours vs 393435 | 393435 vs KACTL | reps | spread |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2^10 | 0.0471 | 0.0081 | 0.0044 | 0.0030 | 15.84x | 2.71x | 1.48x | 10.69x | 1001 | 0.7% |
| 2^11 | 0.1018 | 0.0150 | 0.0089 | 0.0059 | 17.29x | 2.54x | 1.51x | 11.42x | 1001 | 0.7% |
| 2^12 | 0.2194 | 0.0291 | 0.0200 | 0.0124 | 17.65x | 2.34x | 1.61x | 10.98x | 1001 | 1.5% |
| 2^13 | 0.4784 | 0.0583 | 0.0404 | 0.0265 | 18.08x | 2.20x | 1.53x | 11.83x | 1001 | 2.2% |
| 2^14 | 1.0791 | 0.1193 | 0.0892 | 0.0563 | 19.16x | 2.12x | 1.58x | 12.09x | 1001 | 0.6% |
| 2^15 | 2.3852 | 0.2466 | 0.1807 | 0.1182 | 20.18x | 2.09x | 1.53x | 13.20x | 509 | 4.2% |
| 2^16 | 5.2344 | 0.5203 | 0.3970 | 0.2525 | 20.73x | 2.06x | 1.57x | 13.18x | 231 | 4.2% |
| 2^17 | 11.1973 | 1.0912 | 0.8158 | 0.5388 | 20.78x | 2.03x | 1.51x | 13.73x | 107 | 2.1% |
| 2^18 | 24.5450 | 2.3055 | 1.7758 | 1.1521 | 21.31x | 2.00x | 1.54x | 13.82x | 51 | 2.6% |
| 2^19 | 54.3923 | 4.7977 | 3.5964 | 2.3941 | 22.72x | 2.00x | 1.50x | 15.12x | 23 | 2.2% |
| 2^20 | 108.5811 | 9.9634 | 7.7838 | 5.1230 | 21.19x | 1.94x | 1.52x | 13.95x | 11 | 1.3% |
| 2^21 | 234.0464 | 20.5898 | 15.8525 | 10.5555 | 22.17x | 1.95x | 1.50x | 14.76x | 11 | 3.0% |
| 2^22 | 488.7913 | 43.5985 | 33.9730 | 22.6813 | 21.55x | 1.92x | 1.50x | 14.39x | 11 | 1.2% |

"A vs B" = B's median time / A's median time (above 1.00x: A is faster). spread = largest interquartile range / median among the four in that row.

Correctness: every timed call checked (brute force n <= 2^11, KACTL above); all-(P-1) and sparse inputs at 2^7..2^22: PASS (0 mismatches). Total 31.2 s.
