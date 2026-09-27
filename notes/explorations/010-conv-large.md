# 010 — convolution_mod_large (N, M ≤ 2^24): structure for 2^25 transforms

Date: 2026-09-27. Status: in progress (rounds 1–4 measured).
Branch `claude/ntt-conv-large` from `claude/ntt-asm-explore` 1e64289 (exploration 009),
plus the exploration-007 I/O files from `claude/ntt-io-yosupo` ed1d92b. Code:
[work/ntt/conv_large](../../work/ntt/conv_large/README.md). Raw data:
[results/ntt-conv-large](../results/ntt-conv-large/).

## Target and constraints

[Library Checker convolution_mod_large](https://judge.yosupo.jp/problem/convolution_mod_large):
N, M ≤ 2^24, output length ≤ 2^25 − 1, mod 998244353 (roots of unity only to order 2^23),
10 s. Judge (library-checker-judge sources): `g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE
-march=native`, EPYC 7B13 (Zen 3), one logical CPU (`judge.slice` cpuset 0, isolated), 1024 MiB
read from `memory.current` (includes the tmpfs pages of our output), input/output files on
tmpfs mounted without `huge=` (4 KiB pages), wall time by 1 ms cgroup polling. Largest tests
are N = M = 2^24 (max_random, fft_killer ×10, max_ans_zero, all_same ×3), ~331 MB each way.

Leaderboard at start (v3 API, 654 AC): QgQ 403499 0.737 s (575 MiB), Rohan_Kapri 0.742,
anonymous 303498 0.777, adamant ~0.81 (735 MiB). Per-case data: small_and_large (half the I/O,
same 2^25 transform) is ~160 ms faster than max_random, so the leaders spend ~0.3 s in I/O and
~0.4 s in the transform. 303498 and 403499 were read for structure only (both: one length-2^25
cyclic convolution with x^8/x^16 − w leaves and depth-first radix-4 traversal); no code copied.

## Research (background agent report, links)

No public design is fundamentally faster than an NTT split to x^k − w leaves; see
Qwerty1232's [blog](https://piskareviv.github.io/blog_aux_ntt_1/) ([CF 142063](https://codeforces.com/blog/entry/142063)),
pajenegod [CF 117947](https://codeforces.com/blog/entry/117947). Large-size structure:
[Bailey 1990](https://www.davidhbailey.com/dhbpapers/fftq.pdf) (two passes),
[Frigo et al.](https://dl.acm.org/doi/10.1145/2071379.2071383) (cache-oblivious bound),
[van der Hoeven–Lecerf 2024](https://www.texmacs.org/joris/ntt/ntt.html) (measured +34–52% cost per
butterfly from 2^20 to 2^26 on x86). Doubles ([adamant CF 142860](https://codeforces.com/blog/entry/142860),
FLINT fft_small), Nussbaumer/SSA, Karatsuba/Toom at the top, truncated FFT and mixed radix do
not help the max case (arguments in the report). Largest untapped lever per the report: I/O
(length-branchless parsing, fixed-width branchless formatting — outside this exploration's scope,
which keeps the exploration-007 I/O by request).

## Calibration (calib.cpp, EPYC 7763, runs 36311854189)

Single-core DRAM: read 22–27 GB/s, write 17–19, NT write 23–25, copy 40–44 (r+w).
256 MiB first touch: 4 KiB pages 84–102 ms, THP 14–15 ms (munmap 15 vs 1 ms).
007 parser on 2^25 random residues 68 ms (2.03 ns/token); 007 table writer 87 ms (2.6 ns/value);
writing 331 MB into tmpfs: write() 130 ms (2.5 GB/s, chunk size irrelevant), MAP_SHARED +
memcpy 226–237 ms (slower); reading a 331 MB tmpfs file: lazy mmap 17 ms (+10 ms unmap),
MAP_POPULATE 22 ms, read() 31 ms. So ~330 ms of the program is fixed by I/O and the system.

## Rounds

All timings: `bench_large time 25` (N = M = 2^24 random, one convolution call timed, root tables
built inside the timer, arrays pre-faulted), GCC 15.2 in the pinned image, judge flags; medians
of 7 after 2 warmups, 3 rounds per job; only EPYC 7763 jobs used for decisions. Every entry is
bit-identical to `b0` (checked each rep) and passes the correctness suite (textbook oracle and
brute force ≤ 2^20; for 2^21–2^25 `b0` verified at 8 random points, others equal to it; cyclic
2^21–2^25 against the folded verified linear product; poisoned upper halves).

| Entry | Idea | EPYC 7763 ms |
| --- | --- | ---: |
| b0 | exploration-009 recursion at full size (full tables, n/16 entries each) | 210–216 |
| b0z | + zero-upper radix-4 top (first level is a copy) | 210–217 |
| **b0zs** | + final 1/n scale fused into the last inverse level | **204.6–210.5** |
| b0zsn | + non-temporal stores in the top level | 219–220 |
| tL (round 1) | fused top pass over 64-byte column panels, then rows in cache | 237–430 |
| tL (round 2) | same with 256 B–2 KiB panels, a/b paired or separate | 221–282 |

Per-depth timers (b0zs, run 36313058400): depth-0 forward 11 ms (memory-bound), forward groups at
depths 1–3 10.0–10.9 ms each for a+b (compute alone ≈ 9.4), inverse 4.6–4.9 ms (≈ compute),
depths ≥ 4 and the leaves 139.5 ms (compute estimate 133), depth-0 inverse + scale 7.1 ms.
The recursion is within ~5–15% of compute speed below the top level; the top-pass designs lose
because gathering 16–1024 row streams costs more DRAM efficiency than the passes they save.

## End to end (run_e2e.sh: official cases, judge flags, 1 GiB container, tmpfs, madvise)

| Program (run 36313895572, 2× EPYC 7763) | max over 6 large cases |
| --- | ---: |
| **b0zs + 007 I/O** | **545.8 ms** |
| QL_FUSE (depth-0 levels inside parse/format) | 568–570 ms (rejected) |
| QgQ 403499 (judge 0.737 s) | 753.5–754.2 ms |

b0zs phases (max_random): spawn 1.6, parse+arena 98.8, NTT 212.4, format+write 218.8, exit
10.7 ms. On EPYC 9V45 (run 36313358447): 364 ms vs 510 (403499) and 573 (303498).
