# Function-wrapper optimization, 2026-09-27

Starting point: `../yosupo_convolution_asm_radix4_pair_large_fixed_function.cpp`,
saved exactly as `baseline.cpp` (SHA256
`b30879b9af45d09b39efdb4663e789128d1cb43a1fe46521f087de8ea984fcbe`).
Local HEAD was `31ba0a6c6e65e164a9c145e8c73d9f9ba67cfd36`; the kernel was previously
tested at `25a02b570485da55df235100af89ab43afa97230`. This experiment changes the
solve wrapper only, preserving the chosen assembly kernel.

Hypotheses:

- Static aligned work arrays avoid per-call scratch allocation. Cached roots and
  clearing only previously written padding may save additional work. First-call
  zero padding comes from BSS; page-fault costs are still inside the timed call.
- Resizing/reusing input vectors could avoid result allocation and reuse input
  storage. Because vector<int> does not promise 32-byte alignment, reserve seven
  extra live elements and align an interior pointer. A shifted result must be
  moved back before return; resize initialization may outweigh savings.
- A singleton can multiply the longer input in place. Up to 16 terms can be
  accumulated in uint64_t before one modulo operation per output coefficient,
  avoiding a large NTT for a very short operand. Canonical coefficients ensure
  `16*(P-1)^2 < 2^64`. This is separate from the large-case wrapper comparison.

Variants are baseline, static_fresh (always initialize padding/roots),
static_cached (high-water padding + root reuse), reuse_a, and reuse_both. Every
candidate has the same small-input path. Static scratch is single-threaded and
non-reentrant, with two 2^20-word work arrays and two 2^16-word root arrays.
The high-water mark cannot shrink: data above a small intervening transform may
remain dirty from an earlier large call. Vector variants own all mutable state.
All assume canonical inputs and lengths <=2^19; empty inputs return empty.

No vector-layout hacks, writes beyond size(), allocator mismatches, or adoption
of non-owned storage. Signed/unsigned views refer to corresponding 32-bit types;
all AVX2 array addresses remain aligned. Inputs are disposable by-value arguments,
matching the judge's `solve(std::move(a),std::move(b))` call.

`bench.cpp` checks every candidate against independent ordinary-modulo radix-2
and brute-force references, including P-1, zeros, empty/singleton, size boundaries,
growing/shrinking calls, spare vector capacity, unequal lengths, and maximum size.
Every discrepancy exits nonzero. ASan/UBSan do not instrument inline asm itself;
its kernel is unchanged from the earlier reviewed/tested source.

`run.py` runs checks before timing. Native comparison is GCC15.2 with
`-std=c++17 -O2 -mavx2 -mbmi -march=skylake`, with the original source O3/unroll
pragmas. These are controlled native measurements, not a claimed judge environment.
Two warmups, 15 samples, rotating/reversing candidate order; representative sizes
include balanced, uneven, tiny and highly skewed inputs. Each fresh-process
measurement starts a new executable with untouched work arrays; nine repetitions
per variant/size rotate order. Input generation/copying is outside timing; the
entire solve call, allocation, padding, roots, transform, result creation and input
destruction are timed. Result hashing/destruction is outside timing. Output hashes
must agree. Per-job CPU, compiler, commit, exact source/binary hashes and raw
samples are retained. Native jobs share the baseline and candidates in one binary.

Run `python3 work/ntt/solve_wrapper/run.py`. `SANITIZE=1` selects checks only;
`CHECK_ONLY=1` also skips timings; `RESULT_DIR` chooses the evidence directory.
On this ARM Mac, the runner uses Clang/x86_64/Rosetta and labels the environment;
translated timings must not be presented as native x64 speedups.
