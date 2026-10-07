#!/usr/bin/env bash
# Exploration 014 micro job (inside the pinned gcc:15.2.0 image, judge flags): unit tests, then
# interleaved in-memory timings of the I/O variants. Usage: run_micro.sh RESULT_DIR.
set -euo pipefail
OUT=${1:-results-micro}; CXX=${CXX:-g++}
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$OUT"; BIN=$(mktemp -d)
{ lscpu || true; "$CXX" --version; } > "$OUT/environment.txt" 2>&1
sha256sum "$HERE"/*.cpp "$HERE"/*.inc "$HERE"/*.sh "$HERE"/../io_large/*.inc "$HERE"/../conv_large/io007.hpp > "$OUT/source-hashes.txt"
"$CXX" -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native "$HERE/bench_opt.cpp" -o "$BIN/bench_opt"
"$BIN/bench_opt" unit > "$OUT/unit.txt"; tail -1 "$OUT/unit.txt"; grep -q "ALL OPT UNIT CHECKS PASSED" "$OUT/unit.txt"
for round in 1 2; do "$BIN/bench_opt" time "${MICRO_REPS:-7}" > "$OUT/time-$round.csv"; done
cat "$OUT/time-1.csv" "$OUT/time-2.csv"
