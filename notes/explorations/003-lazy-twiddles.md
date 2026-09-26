# 003: Independently written lazy radix-4 and incremental twiddles

Date: 2026-09-26. Complete: 27 variants/configurations, eight native timing jobs,
three all-variant native sanitizer stages, and a verified standalone AtCoder file.

## Scope and provenance

User requested further exploration, allowed changing the kernel, prohibited direct
copying of the fast reference, and requested a single-file AtCoder comparison.
Started from experiment branch commit `1e5a80f` and the user's Montgomery arithmetic
in `kactl_bench.cpp`, plus exploration 002's own direct8 algorithm. The new
[kernel](../../work/ntt/lazy_twiddle/kernel.hpp) is independently written. Its
reduction bounds, factorization and carry-based root recurrence are documented in
[the README](../../work/ntt/lazy_twiddle/README.md). No study/reference implementation
is copied into the kernel or standalone file. The existing study v2 is compiled
unchanged as a **separate timing control only**.

The main checkout's historical/user-edited sources remain untouched. Work is
published through the previously authorized `codex/ntt-simd-explore` branch in the
isolated `build/ntt-runner` clone. No renewed permission or device setup was needed.

## Experiments

1. Rewrite radix-4 range scheduling: forward [0,4P), inverse [0,2P), canonical
   twiddles. Omit reductions before products and at forward stores when bounds allow.
2. Redistribute multiplications to independent w,w^2,w^3 input products, followed
   by an imaginary-root multiply. Same arithmetic count, different dependency graph.
3. Replace O(N) root tables with parallel 64-bit-lane stage cursors. Derive rates
   from binary carries in the existing root enumeration.
4. Advance four leaf factors as w,-w,Iw,-Iw with a scalar recurrence.
5. Traverse paired forward transforms and inverse within cache-sized subtrees;
   compare 64/256/1024-vector tiles and full recursion.
6. Precompute root update correction factors to shorten the Montgomery dependency
   chain; compare a hybrid using small transform tables and incremental leaves.
7. Compare leaf batches of two/four and compiler unrolling. Assembly showed many
   stack-resident intermediate products in the expanded four-leaf kernel.

All runs use cyclic convolution, P=998244353, canonical input and output, common
GCC 13.3 `-std=c++23 -O3 -mavx2 -mbmi -funroll-loops`, two warmups, nine timed
repetitions, rotating/reversed order, fresh and reuse modes. Allocations/copies
excluded; bulk roots (where used), both forwards, products, inverse/normalization
included. Small constexpr metadata is outside timing. Independent scalar oracle,
brute force, extremes, impulses, repeated and changing sizes cover 2^6–2^22.
The table versus incremental comparison intentionally includes the setup difference;
reuse measurements separately quantify the transform-only benefit.

## Round 1: lazy ranges pay off

[Run 36274679608](https://github.com/7ue9ueue/QPoly/actions/runs/36274679608), commit
`31495153252dc39c4c8288eec86fa8c7c1922146`, 13 variants including four controls.
Both jobs passed all correctness tests. Also passed local Rosetta correctness.

Fresh 2^20 medians in milliseconds, reported separately by CPU:

| Variant | EPYC 7763 | EPYC 9V74 |
| --- | ---: | ---: |
| Historical v0.91 | 10.0650 | 8.6820 |
| Previous direct8 candidate | 7.7445 | 6.6906 |
| New strict-range/table ablation | 8.1606 | 6.9084 |
| Lazy ranges, tables | 7.2904 | 6.0859 |
| Lazy ranges, incremental roots | 7.1796 | 5.9293 |
| Lazy ranges, incremental, tile 256 | **7.0067** | **5.8505** |
| Alternative input-twist factorization, tables | 7.6518 | 6.3163 |
| Existing fast-reference control | 6.5204 | 5.6458 |

The lazy-range ablation is clearly beneficial. Input-twist factorization was slower.
Incremental roots and cache tiling provide smaller additional gains. The strict
rewrite is not assumed equivalent in instruction scheduling to the previous candidate.
No comparison is made between 9V74 absolute times and the historical ~6.5 ms record.
Native [raw results and summary](../results/ntt-lazy-native/36274679608/) preserve
all sizes, spreads, hashes and environment metadata.

## Round 2: update scheduling and the hybrid

[Run 36275006868](https://github.com/7ue9ueue/QPoly/actions/runs/36275006868), commit
`d34b87d29369cef5751bb93434a2608f8012d3b9`, 20 variants. Both timing jobs and the
full ASan/UBSan correctness stage passed. The overall workflow failed at the later
standalone compile step, not during algorithm validation.

Fresh 2^20 median (min–max), ms:

| Variant | EPYC 7763 | EPYC 9V74 |
| --- | ---: | ---: |
| Historical v0.91 | 9.992 (9.955–10.073) | 8.689 (8.597–8.818) |
| Previous direct8 candidate | 7.930 (7.865–7.995) | 6.877 (6.805–7.020) |
| Lazy table | 7.062 (7.048–7.107) | 5.890 (5.874–5.941) |
| Incremental, tile 256 | 7.201 (7.177–7.336) | 5.996 (5.976–6.055) |
| Fixed-rate incremental, tile 256 | 7.175 (7.145–7.243) | 6.002 (5.982–6.019) |
| Hybrid tables + incremental leaves, tile 256 | **6.978 (6.953–7.175)** | **5.802 (5.786–5.815)** |
| Fixed-rate incremental, leaf batch 2 | 7.635 (7.602–7.758) | 6.434 (6.390–6.468) |
| Existing fast-reference control | 6.486 (6.464–6.502) | 5.566 (5.543–5.616) |

Shortening the root update chain did not materially improve overall runtime.
Two-leaf batching regressed. The hybrid won this round, but full incremental versus
table ordering changed from round 1: preserve both and avoid overclaiming tiny
ordering differences across jobs/code revisions. Lazy reductions beat the prior
candidate on both processors in both runs. The fast reference still leads.

[Artifacts](../results/ntt-lazy-native/36275006868/) include native assembly. In the
`leaf<4>` function, many intermediate vector products are stored on the stack;
this motivated the counted/two-way-unrolled leaf experiments in round 3.

## Standalone packaging issue

The first exact `g++ -std=c++17 -O2` standalone compilation exposed that GCC's
synthesized static-initializer function does not inherit the AVX2 target pragma.
The old baseline's global intrinsic-initialized constants therefore failed with a
target-option mismatch. The fix replaces only those global initializers with
literal vector constants. It does not change butterfly arithmetic. The delivered
file must pass this no-extra-AVX-flags compilation test before handoff.

## Round 3: bounded unrolling reduces stack traffic

[Run 36275277471](https://github.com/7ue9ueue/QPoly/actions/runs/36275277471), commit
`9f37e3fa249a22ce83cca61d7d365b455891ea35`, 25 variants. Both benchmark jobs,
all-variant ASan/UBSan, and exact standalone C++17 default and 2^22/both-mode tests
passed. The GCC target-pragmas/global-initialization issue was resolved.

Fresh 2^20 median (min–max), ms:

| Variant | EPYC 7763 | EPYC 9V74 |
| --- | ---: | ---: |
| Historical v0.91 | 10.105 (10.007–10.794) | 8.610 (8.581–8.660) |
| Previous direct8 candidate | 7.739 (7.687–7.897) | 6.848 (6.822–6.964) |
| Fully incremental, counted leaf | **6.865 (6.844–7.130)** | 5.912 (5.883–5.993) |
| Fully incremental, two-way leaf | 6.915 (6.860–7.043) | 5.870 (5.857–5.937) |
| Hybrid, counted leaf | 7.046 (7.018–7.125) | 5.698 (5.687–5.706) |
| Hybrid, two-way leaf | 7.019 (6.999–7.128) | **5.684 (5.665–5.712)** |
| Existing fast-reference control | 6.491 (6.454–6.668) | 5.611 (5.600–5.702) |

The small gap on 9V74 does not establish a reference-record improvement. Counted
or two-way loops are a useful improvement, while two-leaf batching still regressed.
Native assembly in this run shows leaf<4,0> has 646 static instructions, 160 vector
instructions referencing rsp, and a 0x720-byte stack reservation; leaf<4,1> has
262, 12, and 0x1a0 respectively. Leaf<4,2> has 291, 12, and 0x1a0. These counts
include intentional local-array accesses, so they are not a pure spill-counter
measurement; the sharp reduction is consistent with the register-pressure diagnosis.

[Raw results, assembly and standalone output](../results/ntt-lazy-native/36275277471/).
The then-current four-implementation standalone default took 1.13 seconds wall time
and 36,372 KiB peak RSS on EPYC 7763; larger inputs are deliberately configurable.
Those resource numbers belong to this exact intermediate file, not an AtCoder host.

Round 4 adds final radix-2/normalization fusion and selects the final standalone
comparison implementations. This change removes a complete memory pass and the
two reduce2 operations at the last radix-2 stage when log2(N) is even.

## Round 4 and final decision

[Run 36275521910](https://github.com/7ue9ueue/QPoly/actions/runs/36275521910), commit
`329dd66abd711e293b6f85c68f5e90f1fd5fb05f`, 27 configurations including controls.
All jobs passed: two native correctness/timing jobs, ASan/UBSan through 2^22, and
the standalone compiled with plain `g++ -std=c++17 -O2` (no -mavx2 argument).

Fresh 2^20 median (min–max), ms; compare within each column only:

| Implementation | AMD EPYC 7763 | Intel Xeon Platinum 8573C |
| --- | ---: | ---: |
| Historical v0.91 | 9.9252 (9.9138–10.0218) | 10.9753 (10.9255–11.0573) |
| Previous direct8 candidate | 7.9008 (7.8497–8.0224) | 8.2496 (8.2316–10.1852) |
| Incremental + counted leaf, no final fusion | 7.0965 (7.0689–7.1322) | 7.2403 (7.1723–9.0633) |
| **Incremental + counted leaf + fused normalization** | 7.0435 (7.0332–7.0676) | **7.1086 (7.0671–7.1439)** |
| Hybrid + two-way leaf, no final fusion | 6.8061 (6.7954–6.8618) | 7.3320 (7.3094–7.8130) |
| **Hybrid + two-way leaf + fused normalization** | **6.7572 (6.7521–6.7629)** | 7.2041 (7.1954–7.2244) |
| Existing fast-reference control | 6.4761 (6.4415–6.4866) | 6.8703 (6.8664–6.9304) |

The best new candidate in each job cuts time by **31.9% / 35.2% versus v0.91**,
or **14.5% / 13.8% versus exploration 002's direct8 candidate**. The remaining gap
to the reference is **4.3% / 3.5%**. No overall record improvement is claimed.
Fusing the final normalization provides a small additional improvement in both
schedules and both jobs; broad lazy-range / leaf-schedule gains are much larger.
Some Intel samples had large outliers, which are retained in the raw results.

Keep **both** final kernel configurations. Full incremental versus hybrid ordering
varied even across jobs of the same CPU model; a universal dispatch rule is not
justified. The standalone contains both for testing on the actual AtCoder host.
The previous baseline and candidate remain unmodified.

Final raw timings, CPU/compiler metadata, source/binary hashes, sanitizer and
standalone outputs: [results directory](../results/ntt-lazy-native/36275521910/).
Every timing job used nine measured repetitions per size/mode/configuration.
The final sanitizer exercised 97 convolution checks per configuration, including
large maxima and cyclic impulses. The independent oracle uses ordinary modular
arithmetic, not the new Montgomery or root recurrence code.

## Delivered AtCoder file

[work/ntt/atcoder_ntt_compare.cpp](../../work/ntt/atcoder_ntt_compare.cpp) is a single
source file, C++17 or later, requiring x64 AVX2/BMI. No local includes, giant stack
allocations, study/reference NTT implementation, or extra compiler flags required
with GCC. The two historical comparison kernels have their global vector constants
written as literals to avoid GCC static-init target mismatch. It includes v0.91,
the previous direct8 candidate, incremental/counted without final fusion, and both
final fused candidates. The scalar correctness oracle is independent and untimed.

Empty input: check through 2^20, then five repetitions with fresh roots. Optional
input `20 9 2`: maximum log2, repetitions, mode; mode 0=fresh, 1=reuse, 2=both.
Maximum supported log2 is 22. Invalid arguments fail with status 2; correctness
or checksum mismatches fail with status 1. Success ends with `ALL CHECKS PASSED`.

The exact final file passed empty-input and `22 3 2` native tests on Intel Xeon
Platinum 8370C. Default wall time **1.36 seconds**, peak RSS **36,336 KiB**. These
are that runner's resource measurements, not a guarantee of AtCoder time limits.
It has not been submitted to AtCoder. Final source SHA-256:
`cf24fc5a4d0be01516c51095ce193a1cf7e4dc3a0f7c2f08f22a653499830c63`.
The local delivered file was checked against the native artifact hash.

## What to pursue next

- Use the delivered file to compare both schedules on AtCoder before choosing one.
- Investigate code layout, alignment, and per-function compiler options; gains
  near 1–3% require extra care given changing hybrid/incremental ordering.
- Consider independently implementing another fixed-twiddle multiplication scheme
  (e.g. Shoup) as an isolated experiment with its own bounds; not tested here.
- Unsupported/untested: other moduli, N>2^22, overlapping/misaligned buffers,
  noncanonical inputs, and a generic arbitrary-length convolution API.
