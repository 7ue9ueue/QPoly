#!/usr/bin/env bash
# Build and run the round-7 suite on native x86-64 Linux.
# Usage: run.sh <compiler> <result-dir> [ONLY-list]
# Target: Library Checker (judge.yosupo.jp/help, langs.toml): official gcc:15.2 image,
#   g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native   on AMD EPYC 7B13 (Zen 3).
# Profiles: "lc" is that exact command (-march=native resolves to znver3 on EPYC 7763
# runners, i.e. identical code); "znver3" pins the judge's ISA/tuning on any runner.
set -euo pipefail
CXX=${1:-g++}; OUT=${2:-results}; export ONLY=${3:-${ONLY:-}}
HERE=$(cd "$(dirname "$0")" && pwd)
mkdir -p "$OUT"
COMMON=(-O2 -std=c++23 -DEVAL -DONLINE_JUDGE)
{ lscpu || true; "$CXX" --version; echo "ONLY=$ONLY"; } > "$OUT/environment.txt"
sha256sum "$HERE"/bench.cpp "$HERE"/entries.inc "$HERE"/baselines/*.hpp "$HERE"/kernels/*.hpp > "$OUT/source-hashes.txt"
for prof in lc znver3; do
  if [ $prof = lc ]; then ARCH=(-march=native); else ARCH=(-march=znver3); fi
  cmd=("$CXX" "${COMMON[@]}" "${ARCH[@]}" -I"$HERE" "$HERE/bench.cpp" -o "$OUT/bench-$prof")
  echo "${cmd[*]}" >> "$OUT/flags.txt"
  "${cmd[@]}"
done
"$OUT/bench-lc" check 22 > "$OUT/check-lc.txt"; tail -1 "$OUT/check-lc.txt"
grep -q "ALL CHECKS PASSED" "$OUT/check-lc.txt"
if grep -qw avx2 /proc/cpuinfo && grep -qi 'AuthenticAMD' /proc/cpuinfo; then
  "$OUT/bench-znver3" check 20 > "$OUT/check-znver3.txt"; grep -q "ALL CHECKS PASSED" "$OUT/check-znver3.txt"
fi
for round in 1 2 3; do
  for prof in lc znver3; do
    [ $prof = znver3 ] && ! grep -qi 'AuthenticAMD' /proc/cpuinfo && continue
    "$OUT/bench-$prof" time 21 ${REPS:-15} 0 ${MINLOG:-18} > "$OUT/time-$prof-$round.csv"
  done
done
grep ',20,' "$OUT"/time-*.csv | cut -d, -f1-7
