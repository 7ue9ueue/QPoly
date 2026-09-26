# Forward twiddle representation

The phase profile assigns roughly 54% to forward transforms. In the frozen
implementation, one `Twiddle` consists of six live SIMD quantities: x/y/z roots
and their low Montgomery correction multipliers, occupying 192 bytes if spilled.
The native GCC 15 listing from run 36278509138 still contains vector-constant
stack stores/reloads inside `visit`; this motivates reducing represented state.
It does not establish that all such accesses are spills or that smaller C++
objects necessarily produce fewer machine instructions.

Three focused variants change only the forward twiddle type:

- `h14_forward_scalar`: three pairs of uint32 root/correction values (24 bytes).
  Each multiplication expresses broadcasts at its use, allowing the compiler to
  retain scalar state longer or share broadcasts when beneficial.
- `h14_forward_late`: three uint32 roots (12 bytes); each multiplier expresses
  the low correction multiplication at use. The compiler may common this back
  into the first variant. This is an ablation of retained correction state.
- `h14_forward_packed`: three YMM registers, each containing a root in low lane
  halves and its correction in high halves (96 bytes). Multiplication extracts
  correction halves as needed. It may trade shifts for fewer live vectors.

The input to each multiplier remains x<4P with Montgomery root w<P. The packed
variant uses only the low halves for `vpmuludq`; its higher halves are exactly
`uint32(w*NI)`. All variants perform the same six wide multiplications for each
eight-lane fixed multiplication, with the same result below 2P. No new root
table, allocation, alias promise, or externally visible range is introduced.

Inverse twiddles, table generation, leaf products, and normalization still use
the frozen `Fixed`, making forward representation the controlled change. Do not
combine these variants directly with the complete radix-4 assembly helper: that
helper explicitly assumes the old six-vector `Twiddle` layout. The independent
whole-leaf assembly variants do not depend on this forward layout.

No study/reference implementation was copied.

All three variants passed the full independent-oracle preflight locally under
Rosetta: every power 2^6..2^22, fresh/repeated calls, changing sizes, and large
coefficient boundaries. Flags included `-O3 -mavx2 -mbmi -funroll-loops
-ftrivial-auto-var-init=zero`. The output is in ignored
`build/h14_forward_agent/checks.txt`; this is correctness evidence, not a native
performance measurement.
