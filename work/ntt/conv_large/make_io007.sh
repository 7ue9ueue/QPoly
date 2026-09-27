#!/usr/bin/env bash
# Regenerates the exploration-007 I/O headers, verbatim, from the two 007 deliverables:
#   io007.hpp      <- ../yosupo_convolution_shoup_avx2_io.cpp (two-stage AVX2 parser qp_parse_flat,
#                     64 KiB output buffer; the 007 continuation's selected I/O, as in judge 406412)
#   io007_sse.hpp  <- ../yosupo_convolution_asm_shoup_io_sse.cpp (per-token SSE parser read_sse_short,
#                     512 KiB output buffer; 007's first selected I/O, as in judge 406478, 16 ms)
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
header() {  # source first last description
  echo "// Exploration-007 I/O, extracted verbatim (lines $2-$3) from"
  echo "// work/ntt/$(basename "$1") ($5SHA256 $(sha256sum "$1" | cut -c1-16)...)."
  echo "// Includes QgQ's submission 393435 mapping/table writer (https://judge.yosupo.jp/submission/393435)"
  echo "// and $4. Do not edit: regenerate with make_io007.sh."
  echo "#pragma once"
  for h in immintrin.h array cerrno cstdint cstdio cstdlib cstring sys/mman.h sys/stat.h unistd.h; do echo "#include <$h>"; done
}
S=$HERE/../yosupo_convolution_shoup_avx2_io.cpp
a=$(grep -n "^// Selected uint32 I/O from QgQ's submission 393435" "$S" | cut -d: -f1)
b=$(grep -n "^} // namespace qp_parse_flat" "$S" | cut -d: -f1)
{ header "$S" "$a" "$b" "the exploration-007 two-stage AVX2 parser qp_parse_flat" "branch claude/ntt-io-yosupo ed1d92b, "
  sed -n "${a},${b}p" "$S"; } > "$HERE/io007.hpp"
S=$HERE/../yosupo_convolution_asm_shoup_io_sse.cpp
a=$(grep -n "^// Selected uint32 I/O from QgQ's submission 393435" "$S" | cut -d: -f1)
b=$(( $(grep -n "^int main" "$S" | cut -d: -f1) - 1 ))   # through arena(), just before main()
{ header "$S" "$a" "$b" "the exploration-007 per-token SSE parser read_sse_short (sse_short_lut8)" "branch claude/ntt-asm-explore 1e64289, "
  sed -n "${a},${b}p" "$S"; } > "$HERE/io007_sse.hpp"
