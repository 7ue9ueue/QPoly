#!/usr/bin/env bash
set -euo pipefail
dest=${RESULT_DIR:-results}
mkdir -p "$dest" build/lazy_twiddle
python3 work/ntt/lazy_twiddle/generate.py > "$dest/source-hashes.txt"
flags=(-std=c++23 -O3 -mavx2 -mbmi -funroll-loops -Ibuild/lazy_twiddle -Iwork/ntt/simd_explore -Iwork/ntt/lazy_twiddle)
compiler=g++
if [[ $(uname -s) == Darwin ]]; then
  compiler=clang++
  sdk=$(xcrun --show-sdk-path)
  flags+=(-arch x86_64 -isysroot "$sdk" -isystem "$sdk/usr/include/c++/v1" -Wno-shift-op-parentheses -Wno-unknown-attributes)
else
  test "$(uname -m)" = x86_64
  grep -qw avx2 /proc/cpuinfo
fi
if [[ ${SANITIZE:-0} == 1 ]]; then
  flags+=(-O1 -g -fsanitize=address,undefined -fno-sanitize-recover=all -fno-omit-frame-pointer)
fi
printf '%s\n' "$compiler ${flags[*]}" > "$dest/flags.txt"
for source in build/lazy_twiddle/*.cpp; do
  "$compiler" "${flags[@]}" -c "$source" -o "${source%.cpp}.o"
done
"$compiler" "${flags[@]}" work/ntt/simd_explore/bench.cpp build/lazy_twiddle/*.o -o build/lazy_twiddle/bench
shasum -a 256 work/ntt/lazy_twiddle/kernel.hpp build/lazy_twiddle/*.cpp build/lazy_twiddle/bench > "$dest/generated-hashes.txt"
if [[ ${SANITIZE:-0} == 1 || ${CHECK_ONLY:-0} == 1 ]]; then
  build/lazy_twiddle/bench --check | tee "$dest/correctness.txt"
else
  build/lazy_twiddle/bench | tee "$dest/timings.csv"
fi
