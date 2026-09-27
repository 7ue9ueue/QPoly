#!/usr/bin/env bash
# Library Checker end-to-end validation and max-input timing for generated asm submissions.
# Usage: run_yosupo.sh <result-dir> <candidate.cpp>...   (the live submission file is the baseline)
# Each program is built twice: the exact judge command (end-to-end checks, wall time) and
# with -DQPOLY_TIMING (compute_ms on stderr; quiet submissions print only then).
# Exact judge command (langs.toml C++23): g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native.
set -euo pipefail
OUT=${1:-results-yosupo}; shift; mkdir -p "$OUT"
ROOT=$(cd "$(dirname "$0")/../../.." && pwd)
LC=(g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native)
BIN=$(mktemp -d)
{ lscpu || true; g++ --version; } > "$OUT/environment.txt"
sha256sum "$ROOT/work/ntt/yosupo_convolution_shoup.cpp" "$@" > "$OUT/source-hashes.txt"
"${LC[@]}" -o "$BIN/live" "$ROOT/work/ntt/yosupo_convolution_shoup.cpp"
names=(live)
"${LC[@]}" -DQPOLY_TIMING -o "$BIN/live.t" "$ROOT/work/ntt/yosupo_convolution_shoup.cpp"
for src in "$@"; do
  name=$(basename "$src" .cpp); names+=("$name")
  "${LC[@]}" -o "$BIN/$name" "$src"
  "${LC[@]}" -DQPOLY_TIMING -o "$BIN/$name.t" "$src"
done
g++ -O2 -std=c++17 -o "$BIN/reference" "$ROOT/work/ntt/yosupo_scalar_reference.cpp"
for name in "${names[@]:1}"; do
  python3 "$ROOT/work/ntt/uop_explore/verify_yosupo.py" "$BIN/$name" "$BIN/reference" | tee -a "$OUT/verify.txt"
done
python3 - "$BIN" "$OUT" "${names[@]}" <<'PY'
import os, random, re, statistics, subprocess, sys, time
bindir, out, names = sys.argv[1], sys.argv[2], sys.argv[3:]
P = 998244353; n = m = 1 << 19
inputs = {'random': lambda r: r.randrange(P), 'one_digit': lambda r: r.randrange(10)}
report = open(os.path.join(out, 'max-timing.txt'), 'w')
for label, gen in inputs.items():
    rng = random.Random(7)
    path = os.path.join(bindir, f'max_{label}.txt')
    with open(path, 'w') as f:
        f.write(f'{n} {m}\n' + ' '.join(str(gen(rng)) for _ in range(n)) + '\n'
                + ' '.join(str(gen(rng)) for _ in range(m)) + '\n')
    outputs, comp, wall = {}, {k: [] for k in names}, {k: [] for k in names}
    for rep in range(25):
        for k in (names if rep % 2 == 0 else names[::-1]):
            with open(path) as f:   # exact judge build: wall time and output
                t = time.perf_counter(); r = subprocess.run([os.path.join(bindir, k)], stdin=f, capture_output=True, check=True)
                wall[k].append((time.perf_counter() - t) * 1000)
            outputs.setdefault(k, r.stdout)
            with open(path) as f:   # -DQPOLY_TIMING build: compute_ms
                r = subprocess.run([os.path.join(bindir, k + '.t')], stdin=f, capture_output=True, check=True)
            mm = re.search(rb'compute_ms=([0-9.]+)', r.stderr)
            comp[k].append(float(mm.group(1)))
    assert all(outputs[k] == outputs['live'] for k in names), 'outputs differ'
    cb, wb = statistics.median(comp['live']), statistics.median(wall['live'])
    for k in names:
        c, w = statistics.median(comp[k]), statistics.median(wall[k])
        line = (f'[{label}] {k}: compute_ms median {c:.4f} (x{c / cb:.3f}) min {min(comp[k]):.4f} '
                f'wall_ms median {w:.2f} (x{w / wb:.3f}) min {min(wall[k]):.2f} samples {comp[k]}')
        print(line); report.write(line + '\n')
    print(f'[{label}] outputs identical for N=M=2^19')
PY
