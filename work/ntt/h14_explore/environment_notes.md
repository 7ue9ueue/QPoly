# AtCoder environment research for the h14 exploration

Checked 2026-09-26. These are compiler-setting approximations for experiments,
not a claim to reproduce the actual AtCoder CPU or timing environment.

## Verified AtCoder settings

The current official C++ entry is `C++23 (GCC 15.2.0)`. Relevant flags from the
published command are:

```text
-O2 -std=gnu++23 -Wall -Wextra
-fconstexpr-depth=1024
-fconstexpr-loop-limit=524288
-fconstexpr-ops-limit=2097152
-fmodules -ftrivial-auto-var-init=zero -march=native
-pthread -fopenmp -Wl,--as-needed
-DATCODER -DNOMINMAX -DONLINE_JUDGE
```

The actual command also adds third-party include/library directories, many
library-specific definitions, `-lstdc++exp`, and many third-party libraries.
Those do not need to be installed just to test this self-contained integer NTT.
The official installation scripts are linked beside the language entry.
[AtCoder language list](https://img.atcoder.jp/file/language-update/2025-10/language-list.html)

On June 15, 2026, at approximately 18:00 JST, AtCoder removed `-flto=auto` from
this GCC environment because of a reported compiler bug. The change applies
specifically to C++23 GCC 15.2.0; reproductions should not inherit the older LTO
setting from cached rules pages.
[AtCoder June 2026 announcement](https://atcoder.jp/posts/language_update20260616_en)

No current CPU model was found in the official language list, practice rules,
or judge-update announcements checked. The user's pasted result identifies GCC
15.2.0 but not the CPU. In particular, its timing order is insufficient to name
the processor. A CPUID brand/model banner in the next standalone file can make
the user's next measurement more informative. Any processor inferred from older
community posts should remain a hypothesis.

The practice rules measure submission execution as the maximum of real time
and CPU time, so threading would need separate evaluation and cannot simply be
claimed to reduce judged time. Our kernels remain single-threaded.
[AtCoder practice rules](https://atcoder.jp/contests/practice/rules)

## Implications for our existing sources

The standalone's `#pragma GCC optimize("O3,unroll-loops")` affects following
function definitions even when the outer command specifies `-O2`. Preserve it
when comparing with the user's result; the effective kernel optimization is
not described fully by the outer command alone.
[GCC function-specific pragmas](https://gcc.gnu.org/onlinedocs/gcc/Function-Specific-Option-Pragmas.html)

`-ftrivial-auto-var-init=zero` can insert zero initialization for automatic
scratch arrays. Test this setting explicitly and inspect whether zeroing
survives optimization in the leaf loops. This is a hypothesis about overhead,
not a finding that our current kernel necessarily performs redundant zeroing.
[GCC 15.2 optimization options](https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Optimize-Options.html#index-ftrivial-auto-var-init)

GCC provides a per-variable `__attribute__((uninitialized))` opt-out. A focused
experiment may apply it only to scratch that is fully written before every
read, with an explicit proof of that property. It should not conceal a genuine
uninitialized read. For inline assembly, operand declarations must describe all
memory read/written regardless of this attribute.
[GCC 15.2 variable attributes](https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/Common-Variable-Attributes.html#index-uninitialized-variable-attribute)

`-march=native` enables instructions supported by the compiling host, whereas
`-mtune=native` selects cost/scheduling tuning within the chosen ISA. Therefore,
AtCoder's native flag and our old `-mavx2 -mbmi` profile are not identical.
[GCC x86 options](https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html)

`#pragma GCC target("avx2,bmi")` enables those features; it does not state an
AVX2 ceiling when the command already enables a wider architecture. Even
256-bit intrinsics can potentially be compiled using a wider feature set.
Use an explicit architecture/feature cap for controlled AVX2 comparisons and
check disassembly. `prefer-vector-width=256` is only a preference, not a ban on
AVX-512 instructions. Target attributes also influence whether callees can be
inlined, so target changes need compilation and disassembly checks.
[GCC 15.2 x86 function attributes](https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc/x86-Function-Attributes.html)

## Feasible native GitHub Actions approximation

Use an x64 Linux runner and the official `gcc:15.2.0` container, with compiler
version, image digest, flags and host CPU recorded. The public Docker Hub tag API
was checked successfully; at research time the tag is active and gives:

```text
multi-architecture index:
sha256:3ae15afe768b06d0c0fe088d822ba5f8045c26630bdacc8d8e7713cf5d8e7289
linux/amd64 image:
sha256:c101370f78e4a30be178c11dd18aeee64c65d617908a98157db2392ca73ab04f
```

Pinning the index digest alongside `gcc:15.2.0` avoids silently using a newer
compiler behind a moving `gcc:15` tag. A container matches the compiler and
userspace, not CPU microarchitecture, host kernel, clocks or contention.
[Docker official GCC image](https://hub.docker.com/_/gcc),
[queried tag metadata](https://hub.docker.com/v2/repositories/library/gcc/tags/15.2.0)

Suggested controlled profile: the relevant AtCoder flags above, replacing
`-march=native` with `-march=x86-64 -mavx2 -mbmi -mtune=native`, retaining the
source pragmas, and omitting unrelated external libraries. This deliberately
limits ISA while reproducing the compiler version and automatic initialization.
Label it `GCC15.2 / AtCoder-like / AVX2 capped`; do not label it actual AtCoder.
An additional `-march=native` run is useful only as a separately identified
native-ISA experiment.

Before comparing candidates, confirm `g++ -dumpfullversion` reports `15.2.0`,
record `g++ -v`, `g++ -Q --help=target` with the effective flags, CPU metadata,
source/binary hashes, and exact input. Compare baseline and candidate within
each job, with the same timing boundaries. The new user-run result remains the
decisive target measurement.
