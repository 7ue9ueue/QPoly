# Judge-targeted I/O exploration (Library Checker convolution_mod)

Continuation of exploration 007 aimed at <https://judge.yosupo.jp/problem/convolution_mod>.
Starting files: judge submission [406388](https://judge.yosupo.jp/submission/406388),
byte-identical to `../yosupo_convolution_asm_radix4_pair_large_fixed_io393435.cpp`
(SHA256 `1b55ca7f…`), and the 007 deliverable
`../yosupo_convolution_asm_radix4_pair_large_fixed_io_sse.cpp` (SHA256 `d2d02e0f…`).
Branch start: `d65e0a8` (`codex/ntt-io-explore`). The NTT kernel text is asserted
byte-identical in every generated variant.

## Judge facts used (sources read 2026-09-27)

- [Help page](https://judge.yosupo.jp/help): AMD EPYC 7B13 (Zen 3), c2d-highcpu-8,
  one core, 1 GiB. C++17 compile (library-checker-judge `langs/langs.toml`):
  `g++ -O2 -std=c++17 -DEVAL -DONLINE_JUDGE -march=native -o main main.cpp`.
- `judge/judge.go`: runs `library-checker-init /casedir/input.in /casedir/actual.out ./main`
  inside `docker create --init` with 1 GiB memory/swap, 100 pids, unlimited stack.
  `langs/init/src/main.rs` opens both paths as regular files and `dup2`s them.
- `packer/base/prepare-docker.sh`: `/var/lib/docker` is **tmpfs**, so input and
  output files are tmpfs files; judge containers share an isolated CPU 0 partition.
  `docker-daemon.json`: crun 1.15, cgroupfs driver. Host image: Ubuntu 22.04.
- `executor/execute.go`: time is the span between the first and last 1 ms polls of
  the container's `cgroup.procs` that show at least two tasks. It includes exec,
  dynamic loading, page faults, all I/O and process teardown; resolution ~1 ms.
- The judge's transparent-huge-page setting is **not known**. Ubuntu's default is
  `madvise`; GitHub runners start with `always`. Timing runs all three settings.

## Files

- `cases.py DEST`: downloads library-checker-problems (Apache-2.0) generators at
  commit `1814c4e5`, regenerates all 53 official tests with the official seeds, and
  requires every `.in` and model-solution `.out` to match `hash.json`. Our output
  format equals the model format, so checks are byte-exact. Nothing is vendored.
- `variants.py OUT [names]` and `extra_variants.py`: text transforms of the two
  starting files; `*_phases` builds add clock marks (never used for timing claims).
- `parse_quad.inc`, `format_avx2.inc`: new AVX2 parser/formatter (contracts in the
  file headers), included verbatim by variants and by `unit_io.cpp`.
- `init.c`: equivalent of `library-checker-init`. `launcher.c`: timing runner.
- `judge_replica.py`: docker-per-run, host-side ~1 ms cgroup poll (judge method).
- `run.sh RESULTS`: whole pipeline; `summarize.py`: medians and phase tables.

## Timing boundaries

`launcher` runs inside the pinned `gcc:15.2.0` image with the judge's container
limits, pinned to one CPU. Per run: unlink the output, touch 64 MiB to evict caches
(`timing-*`, `phases`), then time `posix_spawn(init IN OUT ./variant)` to `wait4`.
Timed: both execs, dynamic loading, `main`, all page faults, writes into a new
tmpfs file and teardown. Not timed: output verification (byte-exact against the
hash-checked model output after every run), cache eviction, unlinking. Variant
order rotates each repetition and reverses on odd ones; 2 warmups, 11 measured
repetitions per case and variant; 24 official cases with inputs over 1 MB.

Phase builds split the same window at: `main` entry, input mapped, parsed, NTT
done, output flushed; `write()` time is accumulated around each system call.

## New code contracts

Parser: 1–9 digit unsigned tokens separated by one or more bytes <= `' '`; 64
readable bytes after the last token's separator (existing padded input owner).
Formatter: values < 10^9; up to 7 bytes written past the logical end; 96 bytes of
room per 8-value block (80 are provably sufficient), 16 per scalar tail value.
Both are single-threaded and allocate nothing. The SSE digit weighting follows the
exploration-007 parser; the rest is independently written for this exploration.

## Validation

`unit_io`: 8.0M formatted values (0..2·10^6 exhaustively, all digit boundaries,
random full-range and random-length values, every tail length and source
alignment, 97-byte buffers forcing constant flushes) and 16.0M parsed values
(single-space, mixed whitespace including CRLF/tabs/double spaces, split calls,
missing final separator, 0..64-token runs), with guard pages 64 bytes after input
and 8 bytes after the output buffer. Three planted defects are caught. Then every
build must reproduce all 53 official outputs byte for byte, and pass the existing
151-case edge suite (pipe/file input, page-exact EOF). The sanitizer job repeats
this with ASan/UBSan; the inline-assembly kernel is outside ASan instrumentation.
