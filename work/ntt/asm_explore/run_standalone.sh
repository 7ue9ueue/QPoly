#!/usr/bin/env bash
# Native check of the standalone benchmark with the exact Library Checker command.
# Usage: run_standalone.sh <result-dir>. Fails unless every run exits 0, writes nothing
# to stdout and at most 1024 bytes to stderr (the judge's stderr limit).
set -euo pipefail
OUT=${1:-results-standalone}; mkdir -p "$OUT"
ROOT=$(cd "$(dirname "$0")/../../.." && pwd)
SRC="$ROOT/work/ntt/yosupo_bench_asm.cpp"; BIN=$(mktemp -d)
{ lscpu || true; g++ --version; } > "$OUT/environment.txt"
sha256sum "$SRC" > "$OUT/source-hashes.txt"
g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native -o "$BIN/bench" "$SRC"
printf '4 5\n1 2 3 4\n5 6 7 8 9\n' > "$BIN/in.txt"   # stdin is ignored; judge-like example
for i in 1 2 3 4 5; do
  start=$(date +%s.%N)
  "$BIN/bench" < "$BIN/in.txt" > "$BIN/stdout.txt" 2> "$OUT/stderr-$i.txt"
  end=$(date +%s.%N)
  bytes=$(wc -c < "$OUT/stderr-$i.txt")
  echo "run $i: wall $(echo "$end - $start" | bc) s, stderr $bytes bytes, stdout $(wc -c < "$BIN/stdout.txt") bytes" | tee -a "$OUT/summary.txt"
  test ! -s "$BIN/stdout.txt"; test "$bytes" -le 1024; grep -q "PASS" "$OUT/stderr-$i.txt"
done
cat "$OUT/stderr-1.txt"
