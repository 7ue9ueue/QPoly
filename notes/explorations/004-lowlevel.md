# Low-level NTT kernels, assembly, and C++ controls

Starting point: own lazy kernel at `329dd66abd711e293b6f85c68f5e90f1fd5fb05f`,
experiment branch `codex/ntt-simd-explore` at `de63170`. Source is frozen in
`work/ntt/lowlevel/starting_kernel.hpp`. New transformations and rationale are in
[the generator and README](../../work/ntt/lowlevel/README.md). Existing user edits,
historical kernels, and reference code are preserved. New code is independently
written; the fast study kernel is only a separately compiled timing control.

## Protocol and assumptions

Cyclic convolution modulo 998244353. Same canonical-input, alignment and size
contract as exploration 003, 2^6 through 2^22. The shared independent scalar oracle,
small brute-force checks, random/boundary inputs, repeated calls, growing/shrinking
sizes and buffer canaries run before timing. Every variant receives the same data,
two warmups, nine repetitions and rotating/reversed timing order. Seven sizes,
fresh and reused roots; copies, allocation, output hashes outside timing. Root and
fixed-operand precomputation inside fresh timing. Same common GCC flags, with
per-variant alignment/tuning overrides explicitly recorded. Summaries verify all
sizes/repetitions and identical output hashes; failures return nonzero.

Static scratch is explicitly non-reentrant and not safe for concurrent calls.
GNU inline assembly uses AT&T syntax, declares all modified registers/memory/flags,
and uses early-clobber pointer operands. ASan cannot instrument assembly memory
accesses, so its success is not a proof of those accesses: loop bounds are explicit
and the independent output/canary checks still apply. Expanded-window and assembly
changes do not change arithmetic or overflow bounds. Shoup's conversion and range
proof is in the README, including the cost of converting Montgomery constants.

## Round 1

[Native run 36276460065](https://github.com/7ue9ueue/QPoly/actions/runs/36276460065),
commit `8c50c52baead9760da3fa54bc3b3fbbe8c849ae0`. All three jobs passed, including
ASan/UBSan. 19 entries (15 new variants plus four controls). Local Rosetta checks
also passed through 2^22; translated timings are not used.

Fresh-root 2^20 medians (min–max), milliseconds; compare within columns only:

| Variant | EPYC 7763 | Xeon 8573C |
| --- | ---: | ---: |
| v0.91 | 9.9402 (9.9262–10.0176) | 12.6832 (12.5472–12.7669) |
| Previous incremental fused | 6.7886 (6.7689–6.8123) | 8.6361 (8.5174–8.6910) |
| Previous hybrid fused | 6.9359 (6.9157–6.9747) | 8.8151 (8.6073–9.3138) |
| Internal linkage (static-equivalent) | 6.9582 | 8.7902 |
| Static leaf scratch | 6.7492 | 8.5822 |
| Selectively forced inline | 6.6314 (6.6026–6.6647) | 8.5702 (8.4509–8.6762) |
| Assembly leaf, hybrid | 6.8451 | 8.6649 |
| Five-multiply Montgomery | 6.8825 | 9.6140 |
| Shoup fixed multiplication | 6.5421 (6.5231–6.5601) | 9.6907 (9.4503–9.8807) |
| Expanded leaf windows | 7.5969 | 9.3220 |
| Fast-reference control | 6.4379 (6.4203–6.4928) | 8.2488 (8.0708–8.4083) |

Results are CPU-dependent: Shoup improves AMD but regresses Intel. Its quotient
precomputation cost is included. Selective inlining helps both relative to hybrid;
static linkage alone is neutral. `restrict`, hot/noinline attributes, alignment,
prefetch and tune changes do not establish a robust gain in this round. More
memory preparation for expanded windows regresses. First assembly scheduling
provides a small/mixed change and is not a compelling standalone improvement.

Assembly counts over the complete object (not dynamic counters): static-linkage
and previous hybrid both have 2499 decoded instructions, 9 calls, 72 vector
instructions referencing rsp, 374 vpmuludq, no vpmulld. This is consistent with
no useful effect from `static` alone in this context. Inlining expands the object
to 4608 instructions while improving AMD timing; code size alone is not decisive.
Shoup has 142 vpmuludq plus 110 vpmulld, versus 374 vpmuludq for the old hybrid.

[Raw evidence, per-file flags and assembly](../results/ntt-lowlevel-native/36276460065/).

## Round 2 hypotheses

Combine selective inlining with Shoup/assembly/static scratch. Test a paired
assembly schedule, small-stage specialization, packed root/correction tables,
Shoup tables storing ordinary roots plus precomputed quotients, ordinary-residue
incremental Shoup cursors, and retaining Montgomery arithmetic only in the leaf.
The goal is to reduce precomputation and instruction dependencies without hiding
preparation outside timing.


[Run 36276741949](https://github.com/7ue9ueue/QPoly/actions/runs/36276741949),
commit `8a62258` (full revision in run.json), 33 entries. Native checks and
ASan/UBSan passed, as did local Rosetta correctness through 2^22.

Fresh 2^20 median (min–max), ms:

| Variant | EPYC 7763 | Xeon 8370C |
| --- | ---: | ---: |
| v0.91 | 10.0233 | 12.1274 |
| Prior incremental fused | 7.0223 | 8.0534 |
| Prior hybrid fused | 6.7451 (6.7342–6.7744) | 7.9600 (7.9400–8.0972) |
| Shoup + inline + ordinary-residue cursor | **6.1407 (6.1369–6.1881)** | 8.5544 (8.5251–8.5819) |
| Shoup + inline + packed root/quotient table | 6.1792 (6.1715–6.2189) | 8.5152 (8.5083–8.5616) |
| Shoup + inline | 6.3240 | 8.8160 |
| Montgomery + inline + stages h=1,4 specialized | 6.7211 | **7.8186 (7.7887–7.9189)** |
| Paired assembly + inline | 6.7655 | 7.9271 |
| Paired assembly + Shoup + inline | 6.3204 | 8.8153 |
| Fast reference | 6.4629 (6.4391–6.5003) | 7.4677 (7.4536–7.5355) |

The best AMD candidate uses 5.0% less time than the fast reference in this job,
with nonoverlapping observed timing ranges. This is a promising single-job result,
not a universal record. Shoup still regresses Intel. Converting the incremental
cursor to ordinary residues avoids repeated Montgomery-to-ordinary conversion in
fixed-operand construction while retaining Montgomery-encoded update multipliers.
Alternatively, packed tables store a regular root and its Shoup quotient once;
this costs more setup/memory but amortizes fixed preparation across butterflies.

Assembly does not establish a robust gain: paired assembly plus Shoup is nearly
equal to Shoup plus inlining alone. Static scratch is not consistently helpful,
and can therefore be omitted from a reusable candidate. Inlining's isolated effect
also varies with code layout, reinforcing the need for whole-kernel comparisons.

[Raw round 2 evidence](../results/ntt-lowlevel-native/36276741949/).

## Round 3 confirmation and alternate instruction mix

Seven selected variants plus four controls, two jobs per compiler (GCC/Clang).
New Shoup-wide uses six 32x32-to-64 multiplies instead of two such multiplies plus
two packed low-32 multiplies. Its exact 64-bit residual is in [0,2P), permitting
packing without an extra modular reduction. Direct arithmetic tests check 786,432
lanes per multiplier against independent modulo arithmetic, including the full
[0,4P) lazy range and values above INT32_MAX.

[Run 36277035927](https://github.com/7ue9ueue/QPoly/actions/runs/36277035927),
commit `50908bb1167af6a32d2b97621a29694814cdebf1`. All five jobs passed: four native
correctness/timing jobs, plus ASan/UBSan and exact standalone verification. GCC
13.3.0 and Clang 18.1.3. Across the three rounds: 32 new configurations and four
controls, eight native timing jobs, three sanitizer jobs. The last three new
wide-product configurations were tested in the final 11-entry selection.

Final fresh-root 2^20 medians, ms (compare within a column):

| Implementation | EPYC 7763 / GCC | EPYC 7763 / Clang | EPYC 9V45 / GCC | Xeon 8370C / Clang |
| --- | ---: | ---: | ---: | ---: |
| v0.91 | 10.0080 | 9.6785 | 6.7042 | 12.6586 |
| Prior incremental fused | 6.8170 | 7.6896 | 4.4999 | 9.2253 |
| Prior hybrid fused | 6.9543 | 6.8159 | 4.5671 | 8.2814 |
| Shoup ordinary cursor | 6.1802 | **5.9285** | 4.1775 | 8.4762 |
| Shoup packed root/quotient | **6.1665** | 5.9430 | **4.1276** | 8.5435 |
| Montgomery h=1,4 specialization | 6.9585 | 6.7411 | 4.5254 | **8.2225** |
| Paired assembly + inline | 6.7811 | 6.8660 | 4.5209 | 8.3607 |
| Shoup-wide cursor | 7.6017 | 8.6329 | 5.1067 | 10.8405 |
| Fast-reference control | 6.4758 | 6.3743 | 4.3473 | 7.6396 |

On AMD, the best new candidate uses **4.8%, 7.0%, 5.1% less time than the reference**
in those jobs, and **9.5%, 13.0%, 8.3% less than the better of the two prior
candidates**. Reductions versus v0.91 are 38.4–38.7%. GCC's EPYC 7763 advantage
reproduces round 2. The EPYC 7763 winning observed ranges were 6.1371–6.2769 ms
(GCC prepacked) and 5.8931–5.9862 ms (Clang cursor), versus reference ranges
6.4206–6.6441 and 6.3483–6.3890. EPYC 9V45 prepacked's 4.0815–4.2776 range was also
below its reference's 4.3316–4.5693 range. These are observed ranges, not confidence
intervals. Intel does not show the same advantage. Clang and GCC ran in separate
jobs, so their absolute times are not a controlled compiler-only comparison.

At 2^22, the AMD candidates also beat the same-job reference: EPYC 7763 GCC
27.1631 vs 29.0981 ms, EPYC 7763 Clang 25.9283 vs 28.7440 ms, and EPYC 9V45 GCC
18.6242 vs 19.9342 ms. Reused-root mode favors packed roots more strongly: at
2^20 prepacked takes 5.8740 ms (7763 GCC), 5.7260 ms (7763 Clang), and 3.9318 ms
(9V45 GCC). Full size/mode/repetition data are preserved, including slow outliers.

Shoup-wide is rejected: avoiding packed low products increased work and regressed
all tested CPU/compiler configurations. It is kept as a clearly named comparison
variant in the standalone file, not selected as the preferred kernel. Assembly
also fails to establish a reproducible improvement across jobs. No new CPU/ISA
requirement beyond the existing AVX2/BMI contract was introduced.

## Deliverables and decisions

- Prefer **Shoup cursor or Shoup prepacked on the measured AMD configurations**.
  Keep both: fresh/reuse mode and CPU affect ordering. Cursor needs no large root
  scratch; prepacked roots need N/8 uint32 entries per direction and amortize
  preparation especially well on repeated transforms.
- Keep the prior Montgomery candidates for Intel. The h=1,4 specialization gives
  a small improvement in some jobs, but not a universal improvement.
- `static` is not a general speed keyword. Internal linkage alone was neutral in
  this experiment. Shared static scratch is not consistently faster and changes
  reentrancy/thread-safety, so the preferred candidates use caller/local memory.
  The existing immutable constants are already constexpr, with no dynamic setup.
- Selective inlining matters in combinations, but forcing all code inline is not
  justified. Restrict promises, hot/noinline hints, alignment and native tuning
  did not establish robust gains. The Montgomery-to-Shoup representation changes
  and amortized fixed-operand preparation account for the meaningful progress.

[atcoder_ntt_lowlevel_compare.cpp](../../work/ntt/atcoder_ntt_lowlevel_compare.cpp)
is self-contained and independently checks results. It retains the usual empty
input default (2^20, five repetitions, fresh roots) or `20 9 2` (nine repetitions,
both modes). It passed plain `g++ -std=c++17 -O2`, empty input and `22 3 2` on an
EPYC 9V45 runner. Default wall time 1.03 seconds, peak RSS 36,604 KiB on that runner;
these are not AtCoder limits or predicted AtCoder timings. No AtCoder submission
was made. The old comparison remains byte-for-byte unchanged.

Exact delivered SHA-256:
`9de507f026aebb83bd5134ff655df9411d71e559cc85f328914a6af3c86077f3`.
The saved native source hash matches the local file. The arithmetic tests verify
2,359,296 lanes total per job, separately from convolution tests. There are no
remaining permission or device blockers.

[Final native evidence](../results/ntt-lowlevel-native/36277035927/) includes raw
timings, summaries, CPU/compiler metadata, per-translation-unit flags, source and
binary hashes, assembly, sanitizers, and standalone output. Primary research links
and the independent derivation are in the [README](../../work/ntt/lowlevel/README.md).

Next useful work: measure on the actual AtCoder CPU/compiler, and profile the
remaining radix/leaf balance before attempting deeper assembly or a different
leaf decomposition. Larger redesigns such as transposed multi-polynomial leaves
or Karatsuba leaves remain untested; this experiment does not exhaust all NTT
algorithms. Other moduli, sizes above 2^22, misalignment, overlap, noncanonical
input and concurrent static-scratch calls are outside the tested contract.
