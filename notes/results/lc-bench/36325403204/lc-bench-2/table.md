## Cyclic convolution mod 998244353: median time per call

CPU: AMD EPYC 9V45 96-Core Processor  
Compiler: GCC 15.2.0, flags `-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`  
Implementations: KACTL (reference), simd-v0 (the user's first AVX2 NTT), 393435 (QgQ, fastest other Library Checker submission), ours (exploration 009 kernel, submission 406478)

| n | KACTL ms | simd-v0 ms | 393435 ms | ours ms | ours vs KACTL | ours vs simd-v0 | ours vs 393435 | simd-v0 vs KACTL | 393435 vs KACTL | reps | spread |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2^10 | 0.0314 | 0.0053 | 0.0026 | 0.0019 | 16.74x | 2.86x | 1.41x | 5.86x | 11.86x | 1001 | 0.5% |
| 2^11 | 0.0678 | 0.0100 | 0.0053 | 0.0038 | 17.82x | 2.63x | 1.39x | 6.77x | 12.85x | 1001 | 1.8% |
| 2^12 | 0.1445 | 0.0194 | 0.0120 | 0.0080 | 18.00x | 2.41x | 1.49x | 7.46x | 12.07x | 1001 | 0.2% |
| 2^13 | 0.3101 | 0.0394 | 0.0241 | 0.0172 | 18.03x | 2.29x | 1.40x | 7.88x | 12.88x | 1001 | 1.7% |
| 2^14 | 0.6792 | 0.0806 | 0.0547 | 0.0367 | 18.48x | 2.19x | 1.49x | 8.43x | 12.43x | 1001 | 0.9% |
| 2^15 | 1.5493 | 0.1677 | 0.1100 | 0.0780 | 19.87x | 2.15x | 1.41x | 9.24x | 14.09x | 786 | 0.4% |
| 2^16 | 3.5406 | 0.3471 | 0.2456 | 0.1651 | 21.44x | 2.10x | 1.49x | 10.20x | 14.42x | 348 | 1.9% |
| 2^17 | 7.7551 | 0.7327 | 0.5004 | 0.3492 | 22.21x | 2.10x | 1.43x | 10.58x | 15.50x | 160 | 1.9% |
| 2^18 | 16.4957 | 1.5226 | 1.1040 | 0.7446 | 22.15x | 2.04x | 1.48x | 10.83x | 14.94x | 75 | 0.6% |
| 2^19 | 35.6227 | 3.2256 | 2.2451 | 1.5846 | 22.48x | 2.04x | 1.42x | 11.04x | 15.87x | 35 | 0.7% |
| 2^20 | 83.7155 | 6.7175 | 4.9258 | 3.3760 | 24.80x | 1.99x | 1.46x | 12.46x | 17.00x | 15 | 4.6% |
| 2^21 | 171.8969 | 13.9195 | 9.8740 | 7.0220 | 24.48x | 1.98x | 1.41x | 12.35x | 17.41x | 11 | 0.8% |
| 2^22 | 358.0139 | 29.3195 | 21.5649 | 15.1356 | 23.65x | 1.94x | 1.42x | 12.21x | 16.60x | 11 | 0.4% |

"A vs B" = B's median time / A's median time (above 1.00x: A is faster). spread = largest interquartile range / median among the four in that row.

Correctness: every timed call checked (brute force n <= 2^11, KACTL above); all-(P-1) and sparse inputs at 2^7..2^22: PASS (0 mismatches). Total 24.7 s.
