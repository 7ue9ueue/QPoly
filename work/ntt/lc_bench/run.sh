#!/usr/bin/env bash
# Build and run the comparison with Library Checker's compiler flags.
# usage: run.sh [OUT_DIR] [MIN_LG MAX_LG]   (default results 10 22)
# Writes OUT_DIR/{table.md, raw.csv, environment.txt, hashes.txt}; exits non-zero on
# any correctness failure. Needs g++ (the judge uses GCC 15.2), python3 and x86-64 AVX2.
set -euo pipefail
OUT=${1:-results}; MIN=${2:-10}; MAX=${3:-22}
HERE=$(cd "$(dirname "$0")" && pwd); ROOT=$(cd "$HERE/../../.." && pwd)
CXX=${CXX:-g++}
FLAGS="-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native"   # Library Checker's C++ command
mkdir -p "$OUT"; OUT=$(cd "$OUT" && pwd)
BUILD=$(mktemp -d)
grep -qw avx2 /proc/cpuinfo 2>/dev/null || { echo "needs an x86-64 CPU with AVX2" >&2; exit 2; }
{ lscpu || true; echo; $CXX --version; echo "flags: $FLAGS"; echo "commit: $(git -C "$ROOT" rev-parse HEAD 2>/dev/null || echo unknown)"; } > "$OUT/environment.txt"
python3 "$HERE/extract.py" "$BUILD/gen"
(cd "$ROOT" && sha256sum kactl_bench.cpp work/ntt/yosupo_convolution_asm_shoup_io_sse.cpp \
    work/ntt/lc_bench/vendor/submission_393435.cpp work/ntt/lc_bench/*.cpp work/ntt/lc_bench/*.hpp) > "$OUT/hashes.txt"
# One translation unit per implementation, each with its original pragmas; no LTO.
for f in "$HERE"/*.cpp; do
  $CXX $FLAGS -DLCB_FLAGS="\"$FLAGS\"" -I"$HERE" -I"$BUILD/gen" -c "$f" -o "$BUILD/$(basename "$f" .cpp).o"
done
$CXX $FLAGS "$BUILD"/*.o -o "$BUILD/bench"
PIN=(); command -v taskset > /dev/null && PIN=(taskset -c 1)
"${PIN[@]}" "$BUILD/bench" "$MIN" "$MAX" "$OUT/raw.csv" | tee "$OUT/table.md"
