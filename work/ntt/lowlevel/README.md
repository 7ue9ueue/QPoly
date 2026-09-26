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
