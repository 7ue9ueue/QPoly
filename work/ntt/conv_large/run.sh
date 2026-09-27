#!/usr/bin/env bash
# Exploration 010 suite on native x86-64 Linux (inside the pinned gcc:15.2.0 image).
# Usage: run.sh RESULT_DIR. Env: CHECK_LG (default 25), REPS (default 7), PASSES
# (default "check calib time"), ONLY (entry list for bench_large).
# Target: Library Checker `cpp` = g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native
# on AMD EPYC 7B13 (Zen 3); decisions use EPYC 7763 (Zen 3) runners only.
set -euo pipefail
OUT=${1:-results}; CXX=${CXX:-g++}
HERE=$(cd "$(dirname "$0")" && pwd)
PASSES=${PASSES:-check calib time}
mkdir -p "$OUT"; BIN=$(mktemp -d)   # binaries stay out of the uploaded results
LC=("$CXX" -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native -I"$HERE")
{ lscpu || true; "$CXX" --version; uname -a
  for f in enabled defrag shmem_enabled; do echo "thp $f: $(cat /sys/kernel/mm/transparent_hugepage/$f 2>/dev/null)"; done
  findmnt -no FSTYPE,SIZE,OPTIONS /dev/shm || true; free -m || true; } > "$OUT/environment.txt" 2>&1
sha256sum "$HERE"/*.cpp "$HERE"/*.hpp "$HERE"/*.sh "$HERE"/../asm_explore/kernels/qasm.hpp > "$OUT/source-hashes.txt"
echo "${LC[*]}" > "$OUT/flags.txt"
for prog in bench_large calib; do "${LC[@]}" "$HERE/$prog.cpp" -o "$BIN/$prog"; done
if [[ " $PASSES " == *" check "* ]]; then
  "$BIN/bench_large" check "${CHECK_LG:-25}" > "$OUT/check.txt"; tail -1 "$OUT/check.txt"
  grep -q "ALL CHECKS PASSED" "$OUT/check.txt"
fi
if [[ " $PASSES " == *" calib "* ]]; then "$BIN/calib" /dev/shm > "$OUT/calib.txt"; cat "$OUT/calib.txt"; fi
if [[ " $PASSES " == *" time "* ]]; then
  for round in 1 2 3; do "$BIN/bench_large" time 25 "${REPS:-7}" > "$OUT/time25-$round.csv"; done
  "$BIN/bench_large" phases 25 5 > "$OUT/phases25.csv"
  "$BIN/bench_large" time 24 "${REPS:-7}" > "$OUT/time24.csv"
  "$BIN/bench_large" time 23 "${REPS:-7}" > "$OUT/time23.csv"
  cut -d, -f1-7 "$OUT"/time25-*.csv "$OUT/phases25.csv"
fi
