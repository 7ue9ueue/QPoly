## Cyclic convolution mod 998244353: median time per call

CPU: INTEL(R) XEON(R) PLATINUM 8573C  
Compiler: GCC 15.2.0, flags `-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native`  
Implementations: KACTL (reference), simd-v0 (the user's first AVX2 NTT), 393435 (QgQ, fastest other Library Checker submission), ours (exploration 009 kernel, submission 406478)

| n | KACTL ms | simd-v0 ms | 393435 ms | ours ms | ours vs KACTL | ours vs simd-v0 | ours vs 393435 | 393435 vs KACTL | reps | spread |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 2^10 | 0.0294 | 0.0075 | 0.0040 | 0.0030 | 9.67x | 2.48x | 1.32x | 7.31x | 1001 | 1.9% |
| 2^11 | 0.0626 | 0.0141 | 0.0085 | 0.0064 | 9.72x | 2.20x | 1.32x | 7.39x | 1001 | 1.0% |
| 2^12 | 0.1333 | 0.0277 | 0.0183 | 0.0138 | 9.66x | 2.00x | 1.33x | 7.27x | 1001 | 1.9% |
| 2^13 | 0.2847 | 0.0561 | 0.0391 | 0.0305 | 9.34x | 1.84x | 1.28x | 7.28x | 1001 | 1.7% |
| 2^14 | 0.6567 | 0.1163 | 0.0838 | 0.0655 | 10.02x | 1.77x | 1.28x | 7.84x | 1001 | 0.8% |
| 2^15 | 1.5147 | 0.2428 | 0.1764 | 0.1387 | 10.92x | 1.75x | 1.27x | 8.59x | 592 | 1.0% |
| 2^16 | 3.2665 | 0.5139 | 0.3772 | 0.2984 | 10.95x | 1.72x | 1.26x | 8.66x | 334 | 2.7% |
| 2^17 | 6.8792 | 1.0872 | 0.7946 | 0.6378 | 10.79x | 1.70x | 1.25x | 8.66x | 158 | 1.4% |
| 2^18 | 14.4799 | 2.2654 | 1.7117 | 1.3843 | 10.46x | 1.64x | 1.24x | 8.46x | 75 | 0.8% |
| 2^19 | 30.4911 | 4.8631 | 3.5643 | 2.8733 | 10.61x | 1.69x | 1.24x | 8.55x | 35 | 0.6% |
| 2^20 | 68.2531 | 10.4812 | 7.5992 | 6.3040 | 10.83x | 1.66x | 1.21x | 8.98x | 16 | 4.1% |
| 2^21 | 221.0899 | 22.4845 | 16.2328 | 13.5095 | 16.37x | 1.66x | 1.20x | 13.62x | 11 | 18.5% |
| 2^22 | 539.6742 | 48.9257 | 35.4085 | 29.4907 | 18.30x | 1.66x | 1.20x | 15.24x | 11 | 9.8% |

"A vs B" = B's median time / A's median time (above 1.00x: A is faster). spread = largest interquartile range / median among the four in that row.

Correctness: every timed call checked (brute force n <= 2^11, KACTL above); all-(P-1) and sparse inputs at 2^7..2^22: PASS (0 mismatches). Total 29.9 s.
