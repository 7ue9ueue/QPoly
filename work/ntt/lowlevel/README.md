# Low-level NTT exploration

Starting source: own `work/ntt/lazy_twiddle/kernel.hpp`, tested commit
329dd66abd711e293b6f85c68f5e90f1fd5fb05f, saved unchanged as `starting_kernel.hpp`.
Starting experiment branch head: de63170. Historical/user files remain unchanged.
The generator applies explicit, small transformations and keeps separate prior
candidate and study-reference controls. No study-reference code enters new kernels.

Initial hypotheses:
- Internal linkage (`static`-equivalent anonymous namespace) may improve IPA/codegen.
- Static leaf scratch may reduce stack setup, at the cost of non-reentrancy.
- Restrict promises, selective forced inlining, hot/noinline attributes, controlled
  radix-loop unrolling, alignment and CPU tuning may improve compiler decisions.
- An explicit AVX2 assembly leaf dot loop can keep all eight accumulators in YMM
  registers and bound live temporaries; intrinsics remain a separate control.
- Alternate fixed-operand modular multiplication: five-multiply Montgomery using
  packed low products, or Shoup reduction, may change throughput/dependencies.
- Prefetch and expanded leaf windows test memory scheduling/layout changes.

Run `python3 work/ntt/lowlevel/run.py` on native AVX2 x64 Linux. CHECK_ONLY=1 and
SANITIZE=1 are supported. Mac/Rosetta supports correctness; GCC-only flags are
omitted locally and only measured on native Linux. Flags are saved per translation
unit. ASan does not instrument inline assembly's memory accesses: the assembly
loop's window/coeff bounds are separately explicit (8 iterations, four independent
leaves) and all outputs are checked against the independent oracle.

The mathematical contract, lazy bounds, alignment, caller ownership and supported
sizes are inherited from exploration 003. Shoup's input is <2^32 and its constant
b<P: q=floor(x*floor(b*2^32/P)/2^32), hence 0<=x*b-q*P<2P. Constants arriving in
Montgomery form are converted once per Fixed construction, preserving surrounding
representation. This precomputation cost is inside timing. Static scratch is
experimental only: concurrent/reentrant calls to that instantiation are unsupported.
Assembly uses GNU AT&T syntax and AVX2, with declared memory/condition-code/YMM
clobbers and early-clobber pointer operands; `-masm=intel` is unsupported.

Primary sources consulted (concepts and compiler semantics; no source pasted):
- [Shoup's modular-arithmetic chapter, Figure 7](https://shoup.net/papers/akl-chapter.pdf)
- [GCC extended asm](https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html)
- [GCC attributes](https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html)
- [GCC restricted pointers](https://gcc.gnu.org/onlinedocs/gcc/Restricted-Pointers.html)
- [Intel optimization reference manual](https://cdrdv2-public.intel.com/821612/248966-Optimization-Reference-Manual-V1-050.pdf)

No external implementation was copied or vendored; no new third-party license
notice is needed. Existing control-source attribution is retained by its generator.

## Combinations and further arithmetic variants

`extra_transforms.py` implements the second/third-round combinations:
- `shoup_cursor`: force-inline selected kernel functions and store incremental
  cursors as ordinary roots. The carry multipliers remain Montgomery encoded,
  so updating the ordinary cursor still uses the same Montgomery multiply.
- `shoup_prepack`: stage tables store two uint32 values per root: ordinary root
  and floor(root*2^32/P). Scratch is N/8 uint32 entries per direction. Tables and
  quotient preparation are timed, and reuse/growth/shrink cases are checked.
- `shoup_wide`: use only 32x32-to-64 products for quotient and residual formation;
  avoids packed low-32 multiplies. No representation or output-range change.
- `inline_h14`: specialize h=1,4 radix groups while keeping Montgomery arithmetic.
- Paired assembly: schedule two leaves' independent products together, retaining
  eight accumulators and using the remaining eight YMM registers as temporaries.

`SELECT_VARIANTS=name1,name2` selects new variants; four controls are always kept.
`CXX=clang++` selects native Clang. All other options retain the same timing bounds.
`arithmetic_driver.inc` separately tests 786,432 lanes per alternative multiplier,
including 0, P boundaries, 4P-1, and the signed 32-bit boundary, against ordinary
modulo arithmetic. These checks verify both congruence and output <2P.

The standalone follow-up is `work/ntt/atcoder_ntt_lowlevel_compare.cpp`, generated
by `make_atcoder.py`; the old verified comparison is preserved separately. It
contains seven timed implementations (original baseline, both previous fused
candidates, Montgomery h=1/4 specialization, Shoup cursor, Shoup prepacked, and
Shoup-wide cursor) and no study-reference kernel. Empty input and optional
`20 9 2` retain the previous comparison's interface and checks. GCC embeds AVX2/BMI
pragmas; no external files or extra -mavx2 switch are needed. Native Clang builds
need explicit target flags. This is for a custom test, not a problem submission.

Read [exploration 004](../../../notes/explorations/004-lowlevel.md) for measured
results, CPU/compiler dependence, rejected variants and exact evidence.

Final decision: prefer Shoup cursor or prepacked roots on the measured AMD
configurations; keep Montgomery for the tested Intel configurations. The wide
variant in the comparison is an unsuccessful ablation, not a recommendation.
There is no universal CPU dispatch rule. Assembly and static scratch did not
establish a robust improvement. The exact standalone passed native GCC C++17
with empty input and `22 3 2`; it has not been submitted to AtCoder.
