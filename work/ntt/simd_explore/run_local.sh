#!/usr/bin/env bash
# Rosetta correctness / exploratory timing only. Not native x64 performance.
set -euo pipefail
dest=${1:-notes/results/ntt-simd-local/round1}
mkdir -p "$dest" build/simd_explore
sdk=$(xcrun --show-sdk-path)
{ uname -a; sw_vers; clang++ --version; git rev-parse HEAD; } > "$dest/environment.txt"
python3 work/ntt/simd_explore/generate.py > "$dest/source-hashes.txt"
flags=(-arch x86_64 -isysroot "$sdk" -isystem "$sdk/usr/include/c++/v1" -std=c++23 -O3 -mavx2 -mbmi -funroll-loops -Wno-shift-op-parentheses -Wno-unknown-attributes -Iwork/ntt/simd_explore -Ibuild/simd_explore)
printf '%s\n' "clang++ ${flags[*]}" > "$dest/flags.txt"
for source in build/simd_explore/*.cpp; do
  clang++ "${flags[@]}" -c "$source" -o "${source%.cpp}.o"
done
clang++ "${flags[@]}" work/ntt/simd_explore/bench.cpp build/simd_explore/*.o -o build/simd_explore/bench
shasum -a 256 build/simd_explore/*.cpp build/simd_explore/bench > "$dest/generated-hashes.txt"
build/simd_explore/bench | tee "$dest/timings.csv"
