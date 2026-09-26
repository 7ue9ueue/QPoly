# Frozen candidate interface validation

Apple M2, macOS 26.2, x86_64 executable via Rosetta. Exit status 0, ASan/UBSan
enabled with nonrecovering errors. Tests both frozen sources, canonical outputs,
exact N/8-sized root buffers, fresh/reused tables, small random brute-force
convolutions, and large all-P-1 cases up to 2^20. See `result.txt`.

```sh
clang++ -arch x86_64 \
  -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk \
  -isystem /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1 \
  -std=c++23 -O1 -mavx2 -mbmi -fsanitize=address,undefined \
  -fno-sanitize-recover=all \
  work/ntt/simd_explore/candidates/direct8_identity.cpp \
  work/ntt/simd_explore/candidates/recursive_identity2.cpp \
  work/ntt/simd_explore/candidates/smoke.cpp -o build/candidate-smoke
./build/candidate-smoke
```
