# Shared-constant multiplication schedule

The frozen h14 forward butterfly multiplies `c` and `d` by the same `Fixed x`.
The new `Fixed::pair` exposes the two independent even-lane products/corrections
together, completes those chains, and then starts the odd-lane chains. It uses
the same twelve unsigned 32x32-to-64 multiplications and the same Montgomery
congruence/range contract as two independent calls. No additional tables,
scratch, alias assumption or representation change is introduced.

- `h14_pairmul_small` applies this helper at h=1 and h=4, preserving the baseline
  at larger stages. The existing constant-h paths eliminate the selection there.
- `h14_pairmul_all` applies it at all forward stages as a controlled comparison.

The compiler remains free to reorder intrinsics, so this is a hypothesis about
its scheduling/register-allocation choices. It is not a claim that C++ statement
order guarantees an instruction schedule.

Inspection of saved native GCC 13 assembly
`notes/results/ntt-lowlevel-native/36277035927/lowlevel-g++-1/ll_inline_h14-assembly.txt`
shows existing interleaving but also stack traffic in the h=1 nonidentity path:
the branch at object address 0x2810 starts `c`'s products, begins `d`'s odd
products at 0x2865, and spills a butterfly intermediate at 0x28bf before starting
the next multiplications. That motivates an alternative bounded-live-value
expression; it does not establish the spill is avoidable or that GCC 15 will
make the same decision. The instruction listing is from the preexisting native
artifact, not from a translated local timing run.

No assembly or arithmetic implementation was copied from an external reference.

Both variants passed the independent oracle locally under Rosetta through every
power 2^6..2^22, fresh/repeated calls, changing sizes and large coefficient
boundaries. Flags included `-O3 -mavx2 -mbmi -funroll-loops
-ftrivial-auto-var-init=zero`; evidence is in ignored
`build/h14_pairmul_agent/checks.txt`. Native timing and assembly remain necessary.
