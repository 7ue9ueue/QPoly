#!/usr/bin/env bash
# Exploration 011 I/O unit tests and in-memory timing on native x86-64 Linux (pinned gcc:15.2.0,
# judge flags). Usage: run_io.sh RESULT_DIR. Needs a writable /dev/shm (format+write timing).
set -euo pipefail
OUT=${1:-results-io}; CXX=${CXX:-g++}
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$OUT"; BIN=$(mktemp -d)
{ lscpu || true; "$CXX" --version; findmnt -no FSTYPE,SIZE,OPTIONS /dev/shm || true; } > "$OUT/environment.txt" 2>&1
sha256sum "$HERE"/*.cpp "$HERE"/*.inc "$HERE"/*.sh "$HERE"/../conv_large/io007.hpp > "$OUT/source-hashes.txt"
"$CXX" -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native "$HERE/bench_io_large.cpp" -o "$BIN/bench_io"
"$BIN/bench_io" unit > "$OUT/unit.txt"; tail -1 "$OUT/unit.txt"; grep -q "ALL IO UNIT CHECKS PASSED" "$OUT/unit.txt"
for round in 1 2 3; do "$BIN/bench_io" time 5 > "$OUT/time-$round.csv"; done
cat "$OUT/time-1.csv"
