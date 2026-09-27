#!/usr/bin/env bash
# Build and run the round-7 suite on native x86-64 Linux.
# Usage: run.sh <compiler> <result-dir> [ONLY-list]
# Two builds: "native" uses AtCoder's -march=native; "avx2" caps the ISA at
# Haswell (AVX2, 16 ymm registers) so AVX-512 hosts cannot change code generation.
set -euo pipefail
CXX=${1:-g++}; OUT=${2:-results}; export ONLY=${3:-${ONLY:-}}
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$OUT"
if "$CXX" --version | grep -qi clang; then
  # AtCoder C++23 (Clang 21.1.0): -std=gnu++23 -O2 -march=native (+libc++/LTO, omitted).
  COMMON=(-std=gnu++23 -O2 -DATCODER -DNOMINMAX -DONLINE_JUDGE -Wno-unknown-pragmas)
else
  # AtCoder C++23 (GCC 15.2.0) relevant flags; -flto removed by AtCoder in June 2026.
  COMMON=(-std=gnu++23 -O2 -ftrivial-auto-var-init=zero -fconstexpr-depth=1024
          -fconstexpr-loop-limit=524288 -fconstexpr-ops-limit=2097152 -pthread
          -DATCODER -DNOMINMAX -DONLINE_JUDGE)
fi
{ lscpu || true; "$CXX" --version; echo "ONLY=$ONLY"; } > "$OUT/environment.txt"
sha256sum "$HERE"/bench.cpp "$HERE"/entries.inc "$HERE"/baselines/*.hpp "$HERE"/kernels/*.hpp > "$OUT/source-hashes.txt"
for prof in native avx2; do
  if [ $prof = native ]; then ARCH=(-march=native); else ARCH=(-march=haswell -mtune=native); fi
  cmd=("$CXX" "${COMMON[@]}" "${ARCH[@]}" -I"$HERE" "$HERE/bench.cpp" -o "$OUT/bench-$prof")
  echo "${cmd[*]}" >> "$OUT/flags.txt"
  "${cmd[@]}"
done
"$OUT/bench-native" check 22 > "$OUT/check-native.txt"; tail -1 "$OUT/check-native.txt"
"$OUT/bench-avx2" check 20 > "$OUT/check-avx2.txt"; tail -1 "$OUT/check-avx2.txt"
grep -q "ALL CHECKS PASSED" "$OUT/check-native.txt"; grep -q "ALL CHECKS PASSED" "$OUT/check-avx2.txt"
for round in 1 2 3; do
  for prof in native avx2; do
    "$OUT/bench-$prof" time 21 ${REPS:-15} 0 ${MINLOG:-18} > "$OUT/time-$prof-$round.csv"
  done
done
grep ',20,' "$OUT"/time-*.csv | cut -d, -f1-7
