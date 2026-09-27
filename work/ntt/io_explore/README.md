# I/O-only exploration

Starting local HEAD: 31ba0a6c6e65e164a9c145e8c73d9f9ba67cfd36.
Starting file: `../yosupo_convolution_asm_radix4_pair_large_fixed_io393435.cpp`,
SHA256 `1b55ca7f3edf44e8e18b9f62503f5bbb3ec2595267dcf52a302b8a0d966a5899`.
The user reports that this I/O adaptation matches the linked judge submission's
speed; no new user run URL or per-case timings were supplied.

Nine variants: unchanged control, byte-sized pair table, SWAR and SSE eight-digit
arithmetic, independent output quotient splitting, 200-byte two-digit output
table, and three combinations. No kernel changes. Hypotheses: reduce lookup
cache traffic, reduce dependent decimal arithmetic, and shorten variable-length
cursor dependencies. Output/input buffering and syscalls are held constant.

Attribution: baseline I/O from QgQ's
[submission393435](https://judge.yosupo.jp/submission/393435), as documented in
exploration006. SWAR reduction follows [Daniel Lemire's derivation](https://lemire.me/blog/2022/01/21/swar-explained-parsing-eight-digits/).
Other helpers are independently implemented here. The SSE hierarchy reduces
pairs with weights [10,1], quads with [100,1], then two quads with [10000,1].

Contracts: unsigned canonical values <998244353, valid ASCII decimal tokens,
ASCII whitespace, and 64 bytes of accessible zero padding or the existing mapped
zero page. Maximum nine digits. Nine-digit lookahead uses bytes 1..8; fallback
preserves short coefficients and headers. Packed output is little-endian. Output
stores have 16 bytes of room; four-byte leading stores may write beyond logical
digits within that reserved room. No speculative read crosses accessible padding.
The NTT retains all existing alignment, range and size contracts.

Run `python3 work/ntt/io_explore/run.py`. `MICRO_ONLY=1` runs only parse/format;
`SANITIZE=1` runs validation without performance measurements. Generated standalone
sources/binaries stay in ignored build/io_explore. The generator asserts the
control's source hash so a changed baseline cannot silently enter the comparison.

Microbenchmark: sizes4096 and1048576, uniform full-range residues, uniform choices
of digit lengths, zeros, and P-1; deterministic seed20260927. Two warmups/nine
repetitions, rotated variant order, exact output validation outside timing.
Parsing reads an already-resident text buffer and writes uint32 coefficients.
Formatting reads resident coefficients and writes an external memory buffer large
enough to avoid flushes. Allocation, input generation, checks and mapping/syscalls
are excluded from these micro timings. This isolates conversion cost.

End-to-end: separate processes, identical generated files, two warmups/nine
repetitions, rotated/reversed order, stdout to a regular temporary file. Timing
includes process launch/wait, mapping, allocation, input, the unchanged NTT and
all output writes/close; it excludes data generation, opening the caller's file
handles, fsync, and checking output. Files stay warm in cache. This is not a
measurement of the judge's pipe/capture infrastructure. Independent scalar
reference checks cover full-size random and zero cases for every variant. The
existing wrapper suite also runs fully on baseline and through2^13 on candidates.

Correctness precedes reported timing. Independent decimal strings, every integer
0..200000, all digit boundaries, alignments, whitespace, guards, missing newline,
and millions of deterministic values are checked. Native ASan/UBSan is separate;
ASan still cannot instrument the unchanged inline assembly. Local execution uses
Clang17 under Rosetta and must not be interpreted as native x64 performance.

Workflow `ntt-io.yml` runs two GCC15.2 native comparisons and a sanitizer job.
CPU/compiler/source hashes, raw samples and commands are saved; interpret by CPU
and same-job baseline. No candidate is promoted before inspecting native results.
