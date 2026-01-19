Jan3 V3

Running Correctness Tests (KACTL NTT Reference)...
--------------------------------------------------------
PASS: size 2^ 4 (     16)
PASS: size 2^ 5 (     32)
PASS: size 2^ 6 (     64)
PASS: size 2^ 7 (    128)
PASS: size 2^ 8 (    256)
PASS: size 2^ 9 (    512)
PASS: size 2^10 (   1024)
PASS: size 2^11 (   2048)
PASS: size 2^12 (   4096)
PASS: size 2^13 (   8192)
PASS: size 2^14 (  16384)
PASS: size 2^15 (  32768)
PASS: size 2^16 (  65536)
PASS: size 2^17 ( 131072)
PASS: size 2^18 ( 262144)
PASS: size 2^19 ( 524288)
PASS: size 2^20 (1048576)
--------------------------------------------------------
Profiling Algorithm Speed (Average of 10 runs)
--------------------------------------------------------
|     Size (n) |        Avg Time (us) |   Avg Time (ms) |
|--------------|----------------------|-----------------|
| 2^10        |                   10 |           0.010 |

=== Timing Breakdown: 2^10 ===
Root precomputation:         33771 ns
DIF nested loops:            21532 ns
DIF small loops:             20670 ns
Pointwise multiply:           1928 ns
DIT small loops:              9885 ns
DIT nested loops:            14227 ns
Total:                      102013 ns
========================================

| 2^11        |                   18 |           0.018 |

=== Timing Breakdown: 2^11 ===
Root precomputation:         45573 ns
DIF nested loops:            47195 ns
DIF small loops:             40991 ns
Pointwise multiply:           4313 ns
DIT small loops:             19630 ns
DIT nested loops:            28822 ns
Total:                      186524 ns
========================================

| 2^12        |                   36 |           0.036 |

=== Timing Breakdown: 2^12 ===
Root precomputation:         83808 ns
DIF nested loops:            97668 ns
DIF small loops:             81852 ns
Pointwise multiply:           7737 ns
DIT small loops:             39879 ns
DIT nested loops:            56075 ns
Total:                      367019 ns
========================================

| 2^13        |                   70 |           0.070 |

=== Timing Breakdown: 2^13 ===
Root precomputation:        113319 ns
DIF nested loops:           209632 ns
DIF small loops:            168705 ns
Pointwise multiply:          14926 ns
DIT small loops:             77015 ns
DIT nested loops:           116455 ns
Total:                      700052 ns
========================================

| 2^14        |                  146 |           0.146 |

=== Timing Breakdown: 2^14 ===
Root precomputation:        215985 ns
DIF nested loops:           478575 ns
DIF small loops:            317065 ns
Pointwise multiply:          30014 ns
DIT small loops:            154567 ns
DIT nested loops:           271810 ns
Total:                     1468016 ns
========================================

| 2^15        |                  300 |           0.299 |

=== Timing Breakdown: 2^15 ===
Root precomputation:        393123 ns
DIF nested loops:          1026897 ns
DIF small loops:            648162 ns
Pointwise multiply:          59727 ns
DIT small loops:            319696 ns
DIT nested loops:           549498 ns
Total:                     2997103 ns
========================================

| 2^16        |                  622 |           0.622 |

=== Timing Breakdown: 2^16 ===
Root precomputation:        745515 ns
DIF nested loops:          2229129 ns
DIF small loops:           1307918 ns
Pointwise multiply:         118938 ns
DIT small loops:            630255 ns
DIT nested loops:          1186960 ns
Total:                     6218715 ns
========================================

| 2^17        |                 1495 |           1.495 |

=== Timing Breakdown: 2^17 ===
Root precomputation:       1802586 ns
DIF nested loops:          5535428 ns
DIF small loops:           2940648 ns
Pointwise multiply:         253747 ns
DIT small loops:           1472442 ns
DIT nested loops:          2938958 ns
Total:                    14943809 ns
========================================

| 2^18        |                 3035 |           3.035 |

=== Timing Breakdown: 2^18 ===
Root precomputation:       3493272 ns
DIF nested loops:         11467302 ns
DIF small loops:           5759862 ns
Pointwise multiply:         566777 ns
DIT small loops:           2790241 ns
DIT nested loops:          6264073 ns
Total:                    30341527 ns
========================================

| 2^19        |                 6235 |           6.235 |

=== Timing Breakdown: 2^19 ===
Root precomputation:       6517956 ns
DIF nested loops:         25031668 ns
DIF small loops:          10792641 ns
Pointwise multiply:        1481637 ns
DIT small loops:           5249663 ns
DIT nested loops:         13265990 ns
Total:                    62339555 ns
========================================

| 2^20        |                13659 |          13.659 |

=== Timing Breakdown: 2^20 ===
Root precomputation:      13707332 ns
DIF nested loops:         58184576 ns
DIF small loops:          20923922 ns
Pointwise multiply:        3087704 ns
DIT small loops:          10394426 ns
DIT nested loops:         30275177 ns
Total:                   136573137 ns
========================================

--------------------------------------------------------

Jan3 V4

Running Correctness Tests (KACTL NTT Reference)...
--------------------------------------------------------
PASS: size 2^ 4 (     16)
PASS: size 2^ 5 (     32)
PASS: size 2^ 6 (     64)
PASS: size 2^ 7 (    128)
PASS: size 2^ 8 (    256)
PASS: size 2^ 9 (    512)
PASS: size 2^10 (   1024)
PASS: size 2^11 (   2048)
PASS: size 2^12 (   4096)
PASS: size 2^13 (   8192)
PASS: size 2^14 (  16384)
PASS: size 2^15 (  32768)
PASS: size 2^16 (  65536)
PASS: size 2^17 ( 131072)
PASS: size 2^18 ( 262144)
PASS: size 2^19 ( 524288)
PASS: size 2^20 (1048576)
--------------------------------------------------------
Profiling Algorithm Speed (Average of 10 runs)
--------------------------------------------------------
|     Size (n) |        Avg Time (us) |   Avg Time (ms) |
|--------------|----------------------|-----------------|
| 2^10        |                   10 |           0.010 |

=== Timing Breakdown: 2^10 ===
Root precomputation:         32776 ns
DIF nested loops:            21303 ns
DIF small loops:             20299 ns
Pointwise multiply:           1873 ns
DIT small loops:              9608 ns
DIT nested loops:            10618 ns
Total:                       96477 ns
========================================

| 2^11        |                   18 |           0.018 |

=== Timing Breakdown: 2^11 ===
Root precomputation:         45170 ns
DIF nested loops:            44255 ns
DIF small loops:             40112 ns
Pointwise multiply:           3984 ns
DIT small loops:             19318 ns
DIT nested loops:            21151 ns
Total:                      173990 ns
========================================

| 2^12        |                   34 |           0.034 |

=== Timing Breakdown: 2^12 ===
Root precomputation:         68662 ns
DIF nested loops:            96386 ns
DIF small loops:             79755 ns
Pointwise multiply:           7625 ns
DIT small loops:             38610 ns
DIT nested loops:            45984 ns
Total:                      337022 ns
========================================

| 2^13        |                   70 |           0.070 |

=== Timing Breakdown: 2^13 ===
Root precomputation:        112541 ns
DIF nested loops:           212316 ns
DIF small loops:            170083 ns
Pointwise multiply:          15059 ns
DIT small loops:             76881 ns
DIT nested loops:           101374 ns
Total:                      688254 ns
========================================

| 2^14        |                  148 |           0.148 |

=== Timing Breakdown: 2^14 ===
Root precomputation:        208198 ns
DIF nested loops:           500861 ns
DIF small loops:            324717 ns
Pointwise multiply:          30761 ns
DIT small loops:            157571 ns
DIT nested loops:           233205 ns
Total:                     1455313 ns
========================================

| 2^15        |                  343 |           0.343 |

=== Timing Breakdown: 2^15 ===
Root precomputation:        446854 ns
DIF nested loops:          1213159 ns
DIF small loops:            731149 ns
Pointwise multiply:          61436 ns
DIT small loops:            360036 ns
DIT nested loops:           547187 ns
Total:                     3359821 ns
========================================

| 2^16        |                  709 |           0.709 |

=== Timing Breakdown: 2^16 ===
Root precomputation:        866697 ns
DIF nested loops:          2575351 ns
DIF small loops:           1469758 ns
Pointwise multiply:         121607 ns
DIT small loops:            706159 ns
DIT nested loops:          1208797 ns
Total:                     6948369 ns
========================================

| 2^17        |                 1468 |           1.468 |

=== Timing Breakdown: 2^17 ===
Root precomputation:       1750959 ns
DIF nested loops:          5470963 ns
DIF small loops:           2920737 ns
Pointwise multiply:         243733 ns
DIT small loops:           1444994 ns
DIT nested loops:          2567107 ns
Total:                    14398493 ns
========================================

| 2^18        |                 3042 |           3.042 |

=== Timing Breakdown: 2^18 ===
Root precomputation:       3411517 ns
DIF nested loops:         11554548 ns
DIF small loops:           5891768 ns
Pointwise multiply:         562335 ns
DIT small loops:           2900375 ns
DIT nested loops:          5545874 ns
Total:                    29866417 ns
========================================

| 2^19        |                 6373 |           6.373 |

=== Timing Breakdown: 2^19 ===
Root precomputation:       6717404 ns
DIF nested loops:         25093909 ns
DIF small loops:          11274799 ns
Pointwise multiply:        1500833 ns
DIT small loops:           5543808 ns
DIT nested loops:         12489413 ns
Total:                    62620166 ns
========================================

| 2^20        |                13127 |          13.127 |

=== Timing Breakdown: 2^20 ===
Root precomputation:      12493745 ns
DIF nested loops:         55083189 ns
DIF small loops:          20757352 ns
Pointwise multiply:        2856892 ns
DIT small loops:          10077709 ns
DIT nested loops:         27951219 ns
Total:                   129220106 ns
========================================

--------------------------------------------------------

jan3_v6

Running Correctness Tests (KACTL NTT Reference)...
--------------------------------------------------------
PASS: size 2^ 4 (     16)
PASS: size 2^ 5 (     32)
PASS: size 2^ 6 (     64)
PASS: size 2^ 7 (    128)
PASS: size 2^ 8 (    256)
PASS: size 2^ 9 (    512)
PASS: size 2^10 (   1024)
PASS: size 2^11 (   2048)
PASS: size 2^12 (   4096)
PASS: size 2^13 (   8192)
PASS: size 2^14 (  16384)
PASS: size 2^15 (  32768)
PASS: size 2^16 (  65536)
PASS: size 2^17 ( 131072)
PASS: size 2^18 ( 262144)
PASS: size 2^19 ( 524288)
PASS: size 2^20 (1048576)
--------------------------------------------------------
Profiling Algorithm Speed (Average of 10 runs)
--------------------------------------------------------
|     Size (n) |        Avg Time (us) |   Avg Time (ms) |
|--------------|----------------------|-----------------|
| 2^10        |                    8 |           0.009 |

=== Timing Breakdown: 2^10 ===
Root precomputation:         30639 ns
DIF nested loops:            18116 ns
DIF small loops:             17606 ns
Pointwise multiply:           1809 ns
DIT small loops:              8555 ns
DIT nested loops:            11180 ns
Total:                       87905 ns
========================================

| 2^11        |                   16 |           0.016 |

=== Timing Breakdown: 2^11 ===
Root precomputation:         40960 ns
DIF nested loops:            41331 ns
DIF small loops:             34798 ns
Pointwise multiply:           3411 ns
DIT small loops:             16923 ns
DIT nested loops:            22933 ns
Total:                      160356 ns
========================================

| 2^12        |                   31 |           0.031 |

=== Timing Breakdown: 2^12 ===
Root precomputation:         61133 ns
DIF nested loops:            90751 ns
DIF small loops:             68796 ns
Pointwise multiply:           6749 ns
DIT small loops:             33473 ns
DIT nested loops:            48322 ns
Total:                      309224 ns
========================================

| 2^13        |                   62 |           0.062 |

=== Timing Breakdown: 2^13 ===
Root precomputation:         99455 ns
DIF nested loops:           202709 ns
DIF small loops:            136953 ns
Pointwise multiply:          13919 ns
DIT small loops:             66753 ns
DIT nested loops:           104267 ns
Total:                      624056 ns
========================================

| 2^14        |                  134 |           0.134 |

=== Timing Breakdown: 2^14 ===
Root precomputation:        186231 ns
DIF nested loops:           458104 ns
DIF small loops:            282403 ns
Pointwise multiply:          29409 ns
DIT small loops:            136707 ns
DIT nested loops:           247921 ns
Total:                     1340775 ns
========================================

| 2^15        |                  279 |           0.279 |

=== Timing Breakdown: 2^15 ===
Root precomputation:        335679 ns
DIF nested loops:          1021249 ns
DIF small loops:            567236 ns
Pointwise multiply:          57558 ns
DIT small loops:            293838 ns
DIT nested loops:           513869 ns
Total:                     2789429 ns
========================================

| 2^16        |                  576 |           0.576 |

=== Timing Breakdown: 2^16 ===
Root precomputation:        650326 ns
DIF nested loops:          2203687 ns
DIF small loops:           1154857 ns
Pointwise multiply:         113190 ns
DIT small loops:            560242 ns
DIT nested loops:          1080445 ns
Total:                     5762747 ns
========================================

| 2^17        |                 1272 |           1.272 |

=== Timing Breakdown: 2^17 ===
Root precomputation:       1459481 ns
DIF nested loops:          4968028 ns
DIF small loops:           2403359 ns
Pointwise multiply:         214662 ns
DIT small loops:           1177901 ns
DIT nested loops:          2496857 ns
Total:                    12720288 ns
========================================

| 2^18        |                 2547 |           2.547 |

=== Timing Breakdown: 2^18 ===
Root precomputation:       2805951 ns
DIF nested loops:         10217700 ns
DIF small loops:           4528040 ns
Pointwise multiply:         491455 ns
DIT small loops:           2298478 ns
DIT nested loops:          5122496 ns
Total:                    25464120 ns
========================================

| 2^19        |                 5310 |           5.310 |

=== Timing Breakdown: 2^19 ===
Root precomputation:       5571557 ns
DIF nested loops:         21925802 ns
DIF small loops:           9155634 ns
Pointwise multiply:        1266758 ns
DIT small loops:           4443907 ns
DIT nested loops:         10729887 ns
Total:                    53093545 ns
========================================

| 2^20        |                11195 |          11.195 |

=== Timing Breakdown: 2^20 ===
Root precomputation:      11096430 ns
DIF nested loops:         47704793 ns
DIF small loops:          18028294 ns
Pointwise multiply:        2503280 ns
DIT small loops:           8805270 ns
DIT nested loops:         23807363 ns
Total:                   111945430 ns
========================================

--------------------------------------------------------

jan3 v9

=== Timing Breakdown: 2^20 (Average of 20 runs) ===
Root precomputation:        822821 ns
DIF nested loops:          4689850 ns
DIF small loops:           1762077 ns
Pointwise multiply:         253808 ns
DIT small loops:            874323 ns
DIT nested loops:          2297345 ns
----------------------------------------
Total (Breakdown Sum):    10700226 ns
========================================


-----
Current Issues:

DIT 2^20: ~1.35 ms memory only.
Single run: Shoup 2.5x faster. Issue: Shoup use port 0 only. Mont use port 0 + port 1. 
Port Contention

Feature,Montgomery,Shoup
SIMD Width,4 elements (32-bit → 64-bit),8 elements (32-bit)
Primary Mult.,_mm256_mul_epu32,_mm256_mullo_epi32
Intel Ports,Port 0 AND Port 1,Port 0 Only
Max Throughput,2 ops / cycle,1 op / cycle
Efficiency,High Port Parallelism,High Data Density

Current Benchmark

Root precomputation:         4080 ns
DIF nested loops:         3724448 ns
DIF small loops:          1948715 ns
Pointwise multiply:       1948715 ns
DIT small loops:           187634 ns
DIT nested loops:         1911701 ns

Root precomputation:       578153 ns
DIF nested loops:         4330260 ns
DIF small loops:          1696902 ns
Pointwise multiply:        267527 ns
DIT small loops:           823790 ns
DIT nested loops:         2226882 ns

Root precomputation:        4646 ns
DIF nested loops:        4014116 ns
Pointwise multiply:      3161525 ns
DIT nested loops:        2388033 ns