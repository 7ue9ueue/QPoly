## Cyclic convolution mod 998244353: median time per call

CPU: AMD EPYC 7763 64-Core Processor  
Compiler: GCC 15.2.0, flags `-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`  
Implementations: KACTL (reference), simd-v0 (the user's first AVX2 NTT), 393435 (QgQ, fastest other Library Checker submission), ours (exploration 009 kernel, submission 406478)

| n | KACTL ms | simd-v0 ms | 393435 ms | ours ms | ours vs KACTL | ours vs simd-v0 | ours vs 393435 | simd-v0 vs KACTL | 393435 vs KACTL | reps | spread |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2^10 | 0.0471 | 0.0081 | 0.0044 | 0.0030 | 15.89x | 2.72x | 1.49x | 5.84x | 10.69x | 1001 | 0.7% |
| 2^11 | 0.1019 | 0.0150 | 0.0089 | 0.0059 | 17.29x | 2.54x | 1.52x | 6.81x | 11.41x | 1001 | 0.6% |
| 2^12 | 0.2198 | 0.0291 | 0.0199 | 0.0125 | 17.65x | 2.34x | 1.60x | 7.55x | 11.05x | 1001 | 1.7% |
| 2^13 | 0.4772 | 0.0584 | 0.0405 | 0.0265 | 18.01x | 2.20x | 1.53x | 8.17x | 11.80x | 1001 | 2.1% |
| 2^14 | 1.0674 | 0.1193 | 0.0891 | 0.0563 | 18.95x | 2.12x | 1.58x | 8.95x | 11.98x | 1001 | 0.5% |
| 2^15 | 2.3652 | 0.2467 | 0.1812 | 0.1184 | 19.97x | 2.08x | 1.53x | 9.59x | 13.05x | 512 | 4.1% |
| 2^16 | 5.2507 | 0.5204 | 0.3984 | 0.2534 | 20.72x | 2.05x | 1.57x | 10.09x | 13.18x | 233 | 2.7% |
| 2^17 | 11.2436 | 1.0875 | 0.8146 | 0.5392 | 20.85x | 2.02x | 1.51x | 10.34x | 13.80x | 109 | 2.1% |
| 2^18 | 23.6218 | 2.2903 | 1.7768 | 1.1489 | 20.56x | 1.99x | 1.55x | 10.31x | 13.29x | 52 | 1.3% |
| 2^19 | 49.7341 | 4.7554 | 3.5984 | 2.3852 | 20.85x | 1.99x | 1.51x | 10.46x | 13.82x | 24 | 0.7% |
| 2^20 | 118.1383 | 9.8884 | 7.8218 | 5.0955 | 23.18x | 1.94x | 1.54x | 11.95x | 15.10x | 11 | 8.1% |
| 2^21 | 251.0753 | 20.4853 | 15.8317 | 10.5208 | 23.86x | 1.95x | 1.50x | 12.26x | 15.86x | 11 | 5.9% |
| 2^22 | 503.5770 | 43.3604 | 33.9615 | 22.5564 | 22.33x | 1.92x | 1.51x | 11.61x | 14.83x | 11 | 1.9% |

"A vs B" = B's median time / A's median time (above 1.00x: A is faster). spread = largest interquartile range / median among the four in that row.

Correctness: every timed call checked (brute force n <= 2^11, KACTL above); all-(P-1) and sparse inputs at 2^7..2^22: PASS (0 mismatches). Total 31.5 s.
