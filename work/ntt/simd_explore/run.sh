#!/usr/bin/env bash
set -euo pipefail
test "$(uname -m)" = x86_64
grep -qw avx2 /proc/cpuinfo
mkdir -p build/simd_explore results
python3 work/ntt/simd_explore/generate.py | tee results/source-hashes.txt
flags=(-std=c++23 -O3 -mavx2 -mbmi -funroll-loops -Iwork/ntt/simd_explore -Ibuild/simd_explore)
printf '%s\n' "g++ ${flags[*]}" > results/flags.txt
for source in build/simd_explore/*.cpp; do
  g++ "${flags[@]}" -c "$source" -o "${source%.cpp}.o"
done
g++ "${flags[@]}" work/ntt/simd_explore/bench.cpp build/simd_explore/*.o -o build/simd_explore/bench
sha256sum build/simd_explore/*.cpp build/simd_explore/bench > results/generated-hashes.txt
build/simd_explore/bench | tee results/timings.csv
