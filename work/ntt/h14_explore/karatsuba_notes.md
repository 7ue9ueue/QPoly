# Weighted cyclic-eight Karatsuba leaf

Starting source: frozen h14 `baseline.hpp`. The leaf is independently derived
from A(x)=Ae(y)+x*Ao(y), B(x)=Be(y)+x*Bo(y), y=x^2, y^4=w. Compute weighted
cyclic-four products E=Ae*Be, O=Ao*Bo, M=(Ae+Ao)*(Be+Bo). Reconstruction is
C_even=E+y*O and C_odd=M-E-O. Here multiplication by y rotates four coefficients
and multiplies the wrapped coefficient by w. No reference code was used.

Two unrelated leaves occupy the low/high 128-bit halves of each AVX2 register.
Their roots can differ. Each cyclic-four product has its own sliding wrap window
and four shuffle/broadcast accumulation steps. The batch still contains four
leaves, processed in pairs. Both variants replace only the direct8 leaf.

- `h14_karatsuba_pair`: straightforward three-product implementation.
- `h14_karatsuba_shared`: reuse canonical weighted Ae/Ao to obtain the weighted
  sum by addition; use packed Montgomery multiplication for the two O3 wrap
  coefficients rather than evaluating unused odd SIMD lanes.

## Operation accounting

Karatsuba reduces the scalar coefficient products from 64 to 48 **per leaf**.
That does not mean 25% fewer total multiplication instructions. Per **two** leaves,
the source-level wide AVX2 multiply counts are:

| Work | Original direct8 | Straight Karatsuba | Shared Karatsuba |
|---|---:|---:|---:|
| Coefficient products | 32 | 24 | 24 |
| Weighted input preparation | 12 | 18 | 12 |
| REDC of accumulated products | 8 | 12 | 12 |
| Final O3 wrap | 0 | 6 | 3 |
| Subtotal | 52 | 60 | 51 |
| Vector Fixed constructor, before CSE | 0 | 4 | 1 |
| Total before CSE | 52 | 64 | 52 |

The original additionally computes two scalar low correction products in its
scalar Fixed constructors. The straightforward variant repeats the same vector
constructor four times; the optimizer may common those constructions. Shared
Karatsuba explicitly constructs it once. Counts exclude additions, shifts,
minima, masks, loads/stores, shuffles, and any compiler-introduced spills. The
shared version still introduces multiple split/recombine shuffles and live
vectors, so a loss is plausible even though its raw core product count is lower.
Native disassembly and timings, rather than this source count, decide performance.

## Representation and ranges

Incoming coefficients can be in [0,4P); each is first canonicalized. Root w is
Montgomery encoded. Wrapped window entries therefore remain ordinary canonical
coefficients. Each cyclic-four raw accumulator sums four products below P^2;
adding a Montgomery correction is below 2*P*2^32 because 4P<2^32. REDC returns
below 2P and represents the product times R^-1, matching the original leaf.

E and O are reduced below P; M remains below 2P. Thus M+2P-E-O lies in [0,4P),
without underflow or uint32 overflow, and one reduction by 2P is sufficient.
The rotated O is canonical except its wrapped coefficient, whose multiplication
returns below 2P; E+rotated O is below 3P and similarly reduces below 2P. The
shared packed wrap already returns canonical coefficients in the selected lanes.
All outputs satisfy the inverse-transform's original [0,2P) requirement.

Window storage consists of two eight-word rows. All four 128-bit stores finish
before reads. Load start indices 4,3,2,1 and length four stay inside each row.
No extra root buffers, ownership change, or overlapping-buffer support is added.

The direct ordinary-modulo oracle lives in ignored
`build/h14_karatsuba_agent/direct.cc`. It checks arbitrary coefficients across
[0,4P), P boundaries, signed-32-bit boundaries, independent roots including zero,
one, P-1 and Montgomery one, plus deterministic random inputs. It verifies
congruence and the strict output bound, independent of the NTT implementation.

Both final variants passed all 524,288 direct lane checks and the complete
convolution oracle through every power 2^6..2^22, fresh/repeated calls, changing
sizes, and large coefficient boundaries under Rosetta. Flags included `-O3
-mavx2 -mbmi -funroll-loops -ftrivial-auto-var-init=zero`. Logs are
`build/h14_karatsuba_agent/direct.txt` and `checks.txt`. This is local correctness
evidence only; no translated timing is a native-performance claim.
