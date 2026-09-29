#!/bin/bash
# CI entry point: build the kernel benchmark with Library Checker's flags, run the
# correctness suite, then timing. Usage: run.sh RESULTS_DIR (settings in ci_config.sh).
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
out=$(mkdir -p "$1" && cd "$1" && pwd)
source "$here/ci_config.sh"
CXX=${CXX:-g++}
FLAGS="-O2 -std=c++23 -march=native"
{
  echo "date: $(date -u +%FT%TZ)"
  echo "commit: ${GITHUB_SHA:-$(git -C "$here" rev-parse HEAD 2>/dev/null || echo unknown)}"
  echo "compiler: $($CXX --version | head -1)"
  echo "flags: $FLAGS"
  echo "cpu: $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2- | sed 's/^ //')"
  echo "mhz: $(grep -m1 'cpu MHz' /proc/cpuinfo | cut -d: -f2- | sed 's/^ //')"
  echo "nproc: $(nproc)"
  echo "thp: $(cat /sys/kernel/mm/transparent_hugepage/enabled 2>/dev/null || echo n/a)"
  echo "march_native: $($CXX -march=native -Q --help=target 2>/dev/null | grep -E '^\s+-march=' | head -1 | tr -s ' ')"
} | tee "$out/environment.txt"
cd "$here"
mkdir -p "$out/build"
$CXX $FLAGS -DMP_FLAGS="\"$FLAGS\"" bench.cpp kernels/*.cpp -o "$out/build/bench"
sha256sum bench.cpp common.hpp strassen.hpp kernels/*.cpp kernels/*.hpp 2>/dev/null > "$out/sources-sha256.txt" || true
cpu=${CPU_PIN:-0}
run() { taskset -c "$cpu" "$out/build/bench" "$@"; }
run --check="$CHECK" --variants="$CHECK_VARIANTS" | tee "$out/check.txt"
grep -q '^RESULT: PASS' "$out/check.txt"
run --check=none --variants="$TIME_VARIANTS" --sizes="$SIZES" --reps="$REPS" --budget="$BUDGET" | tee "$out/timing.txt"
grep -q '^RESULT: PASS' "$out/timing.txt"
grep '^|' "$out/timing.txt" > "$out/table.md"
