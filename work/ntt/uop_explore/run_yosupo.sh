#!/usr/bin/env bash
# Library Checker end-to-end validation and compute-time comparison on max input.
# Usage: run_yosupo.sh <result-dir>. Needs g++ 15.2 (official gcc:15.2 image) and python3.
set -euo pipefail
OUT=${1:-results-yosupo}; mkdir -p "$OUT"
ROOT=$(cd "$(dirname "$0")/../../.." && pwd)
LC=(g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native)   # langs.toml C++23
{ lscpu || true; g++ --version; } > "$OUT/environment.txt"
sha256sum "$ROOT"/work/ntt/yosupo_convolution_shoup.cpp "$ROOT"/study/fast_ntt_v2.cpp \
  "$ROOT"/work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed.cpp > "$OUT/source-hashes.txt"
"${LC[@]}" -o "$OUT/shoup" "$ROOT/work/ntt/yosupo_convolution_shoup.cpp"
"${LC[@]}" -o "$OUT/record" "$ROOT/study/fast_ntt_v2.cpp"
"${LC[@]}" -o "$OUT/user_asm" "$ROOT/work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed.cpp"
g++ -O2 -std=c++17 -o "$OUT/reference" "$ROOT/work/ntt/yosupo_scalar_reference.cpp"
python3 "$ROOT/work/ntt/uop_explore/verify_yosupo.py" "$OUT/shoup" "$OUT/reference" | tee "$OUT/verify.txt"
python3 - "$OUT" <<'EOF'
import random, subprocess, sys, time, re, statistics, os
out = sys.argv[1]; P = 998244353; rng = random.Random(7); n = m = 1 << 19
path = os.path.join(out, 'max.txt')
with open(path, 'w') as f:
    f.write(f'{n} {m}\n' + ' '.join(str(rng.randrange(P)) for _ in range(n)) + '\n'
            + ' '.join(str(rng.randrange(P)) for _ in range(m)) + '\n')
progs = {'shoup': os.path.join(out, 'shoup'), 'record': os.path.join(out, 'record'), 'user_asm': os.path.join(out, 'user_asm')}
outputs = {}; comp = {k: [] for k in progs}; wall = {k: [] for k in progs}
for rep in range(15):
    for k in (list(progs) if rep % 2 == 0 else list(progs)[::-1]):
        with open(path) as f:
            t = time.perf_counter(); r = subprocess.run([progs[k]], stdin=f, capture_output=True, check=True); t = time.perf_counter() - t
        outputs.setdefault(k, r.stdout.split())
        m_ = re.search(rb'([0-9.]+)\s*ms', r.stderr) or re.search(rb'compute_ms=([0-9.]+)', r.stderr)
        if m_: comp[k].append(float(m_.group(1)))
        wall[k].append(t * 1000)
assert outputs['shoup'] == outputs['record'] == outputs['user_asm'], 'outputs differ'
with open(os.path.join(out, 'max-timing.txt'), 'w') as f:
    for k in progs:
        line = (f'{k}: compute_ms median {statistics.median(comp[k]):.4f} min {min(comp[k]):.4f} ' if comp[k] else f'{k}: (no timer) ') \
               + f'wall_ms median {statistics.median(wall[k]):.2f} samples {comp[k] or ""}'
        print(line); f.write(line + '\n')
print('outputs identical for N=M=2^19')
EOF
