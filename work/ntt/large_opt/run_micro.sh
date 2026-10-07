#!/usr/bin/env bash
# Exploration 014 micro job (inside the pinned gcc:15.2.0 image, judge flags): unit tests, then
# interleaved in-memory timings of the I/O variants, the overlap experiment and transform-level
# checks/timings (bench_ntt). Usage: run_micro.sh RESULT_DIR.
set -euo pipefail
OUT=${1:-results-micro}; CXX=${CXX:-g++}
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$OUT"; BIN=$(mktemp -d)
{ lscpu || true; "$CXX" --version; } > "$OUT/environment.txt" 2>&1
sha256sum "$HERE"/*.cpp "$HERE"/*.hpp "$HERE"/*.inc "$HERE"/*.sh "$HERE"/../io_large/*.inc "$HERE"/../conv_large/*.hpp > "$OUT/source-hashes.txt"
FLAGS=(-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native)
"$CXX" "${FLAGS[@]}" "$HERE/bench_opt.cpp" -o "$BIN/bench_opt"
"$CXX" "${FLAGS[@]}" "$HERE/bench_ntt.cpp" -o "$BIN/bench_ntt"
"$CXX" "${FLAGS[@]}" -S "$HERE/asm_probe.cpp" -o "$OUT/asm_probe.s"   # judge compiler's code for the I/O loops
"$BIN/bench_opt" unit > "$OUT/unit.txt"; tail -1 "$OUT/unit.txt"; grep -q "ALL OPT UNIT CHECKS PASSED" "$OUT/unit.txt"
if [ "${MICRO_NTT:-1}" = 1 ]; then "$BIN/bench_ntt" check "${NTT_CHECK_LG:-25}" > "$OUT/ntt-check.txt"; tail -1 "$OUT/ntt-check.txt"; grep -q "ALL NTT CHECKS PASSED" "$OUT/ntt-check.txt"; fi
if [ "${MICRO_FMT:-0}" = 1 ]; then "$BIN/bench_opt" fmtunit > "$OUT/fmtunit.txt"; tail -1 "$OUT/fmtunit.txt"; grep -q "ALL FMT UNIT CHECKS PASSED" "$OUT/fmtunit.txt"
  for round in 1 2; do "$BIN/bench_opt" fmttime "${MICRO_REPS:-7}" > "$OUT/fmttime-$round.csv"; done; cat "$OUT"/fmttime-*.csv; fi
if [ "${MICRO_PARSE:-1}" = 1 ]; then for round in 1 2; do "$BIN/bench_opt" time "${MICRO_REPS:-7}" > "$OUT/time-$round.csv"; done; fi
if [ "${MICRO_OVL:-1}" = 1 ]; then for round in 1 2; do "$BIN/bench_opt" ovl "${MICRO_REPS:-7}" > "$OUT/ovl-$round.csv"; done; cat "$OUT"/ovl-*.csv; fi
if [ "${MICRO_ABLATE:-0}" = 1 ]; then for round in 1 2; do "$BIN/bench_opt" ablate "${MICRO_REPS:-7}" > "$OUT/ablate-$round.csv"; "$BIN/bench_opt" cache "${MICRO_REPS:-7}" > "$OUT/cache-$round.csv"; done; cat "$OUT"/ablate-*.csv "$OUT"/cache-*.csv; fi
if [ "${MICRO_NTT:-1}" = 1 ]; then for round in 1 2; do "$BIN/bench_ntt" time 25 "${MICRO_REPS:-7}" > "$OUT/ntt-time-$round.csv"; done; cat "$OUT"/ntt-time-*.csv; fi
