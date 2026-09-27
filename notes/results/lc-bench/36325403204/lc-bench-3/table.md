## Cyclic convolution mod 998244353: median time per call

CPU: INTEL(R) XEON(R) PLATINUM 8573C  
Compiler: GCC 15.2.0, flags `-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`  
Implementations: KACTL (reference), simd-v0 (the user's first AVX2 NTT), 393435 (QgQ, fastest other Library Checker submission), ours (exploration 009 kernel, submission 406478)

| n | KACTL ms | simd-v0 ms | 393435 ms | ours ms | ours vs KACTL | ours vs simd-v0 | ours vs 393435 | simd-v0 vs KACTL | 393435 vs KACTL | reps | spread |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2^10 | 0.0346 | 0.0090 | 0.0048 | 0.0038 | 9.04x | 2.34x | 1.26x | 3.86x | 7.16x | 1001 | 6.3% |
| 2^11 | 0.0749 | 0.0170 | 0.0106 | 0.0083 | 9.00x | 2.04x | 1.27x | 4.41x | 7.09x | 1001 | 9.1% |
| 2^12 | 0.1627 | 0.0343 | 0.0227 | 0.0179 | 9.08x | 1.91x | 1.27x | 4.74x | 7.16x | 1001 | 4.6% |
| 2^13 | 0.3377 | 0.0676 | 0.0476 | 0.0374 | 9.03x | 1.81x | 1.27x | 5.00x | 7.09x | 1001 | 8.0% |
| 2^14 | 0.7822 | 0.1411 | 0.1016 | 0.0829 | 9.44x | 1.70x | 1.23x | 5.55x | 7.70x | 1001 | 8.0% |
| 2^15 | 1.8083 | 0.2937 | 0.2168 | 0.1745 | 10.36x | 1.68x | 1.24x | 6.16x | 8.34x | 601 | 6.9% |
| 2^16 | 3.8674 | 0.6189 | 0.4599 | 0.3716 | 10.41x | 1.67x | 1.24x | 6.25x | 8.41x | 281 | 6.4% |
| 2^17 | 8.0839 | 1.2836 | 0.9571 | 0.7658 | 10.56x | 1.68x | 1.25x | 6.30x | 8.45x | 131 | 4.7% |
| 2^18 | 17.1298 | 2.7040 | 2.0333 | 1.6846 | 10.17x | 1.61x | 1.21x | 6.34x | 8.42x | 62 | 4.3% |
| 2^19 | 36.2281 | 5.8700 | 4.3454 | 3.5648 | 10.16x | 1.65x | 1.22x | 6.17x | 8.34x | 29 | 5.1% |
| 2^20 | 79.7594 | 12.8743 | 9.3423 | 7.8710 | 10.13x | 1.64x | 1.19x | 6.20x | 8.54x | 13 | 3.6% |
| 2^21 | 227.3047 | 26.8667 | 20.1572 | 16.9577 | 13.40x | 1.58x | 1.19x | 8.46x | 11.28x | 11 | 11.4% |
| 2^22 | 588.2054 | 56.9670 | 42.0564 | 35.7292 | 16.46x | 1.59x | 1.18x | 10.33x | 13.99x | 11 | 7.1% |

"A vs B" = B's median time / A's median time (above 1.00x: A is faster). spread = largest interquartile range / median among the four in that row.

Correctness: every timed call checked (brute force n <= 2^11, KACTL above); all-(P-1) and sparse inputs at 2^7..2^22: PASS (0 mismatches). Total 32.9 s.
