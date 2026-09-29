#!/bin/bash
# Local x86-64 build for Rosetta correctness runs on the ARM Mac (timings are not meaningful).
set -euo pipefail
cd "$(dirname "$0")"
sdk=$(xcrun --show-sdk-path)
mkdir -p ../../build/matrix_product
clang++ -arch x86_64 -isysroot "$sdk" -isystem "$sdk/usr/include/c++/v1" -std=c++23 -O2 -march=haswell \
  -Wall -Wno-unknown-pragmas -Wno-unused-function -DMP_FLAGS='"local-rosetta"' \
  bench.cpp kernels/*.cpp -o ../../build/matrix_product/bench_local "$@"
