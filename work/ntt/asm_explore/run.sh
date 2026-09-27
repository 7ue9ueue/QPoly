#!/usr/bin/env bash
# Build and run the exploration-009 suite on native x86-64 Linux.
# Usage: run.sh <compiler> <result-dir>
# Target: Library Checker (judge.yosupo.jp/help): gcc:15.2 image,
#   g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native   on AMD EPYC 7B13 (Zen 3).
# All sources carry the submissions' "O3,unroll-loops" optimize pragma.
set -euo pipefail
CXX=${1:-g++}; OUT=${2:-results}
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$OUT"; BIN=$(mktemp -d)   # binaries stay out of the uploaded results
LC=("$CXX" -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native -I"$HERE")
{ lscpu || true; "$CXX" --version; } > "$OUT/environment.txt"
sha256sum "$HERE"/*.cpp "$HERE"/*.inc "$HERE"/*.py "$HERE"/kernels/* "$HERE"/../uop_explore/kernels/flip.hpp > "$OUT/source-hashes.txt"
echo "${LC[*]}" > "$OUT/flags.txt"
for prog in probe unit micro bench; do "${LC[@]}" "$HERE/$prog.cpp" -o "$BIN/$prog"; done
"$BIN/unit" 300 > "$OUT/unit.txt"; tail -1 "$OUT/unit.txt"; grep -q "ALL UNIT CHECKS PASSED" "$OUT/unit.txt"
"$BIN/bench" check 22 > "$OUT/check.txt"; tail -1 "$OUT/check.txt"; grep -q "ALL CHECKS PASSED" "$OUT/check.txt"
"$BIN/probe" > "$OUT/probe.txt"
"$BIN/micro" 10 > "$OUT/micro.txt"
for round in 1 2 3; do
  "$BIN/bench" time 21 ${REPS:-11} 0 19 > "$OUT/time-$round.csv"
done
grep ',20,' "$OUT"/time-*.csv | cut -d, -f1-7
