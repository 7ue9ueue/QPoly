#!/usr/bin/env bash
# Regenerates io007.hpp: the exploration-007 I/O section, verbatim, from the 007 deliverable.
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd); S=$HERE/../yosupo_convolution_shoup_avx2_io.cpp
a=$(grep -n "^// Selected uint32 I/O from QgQ's submission 393435" "$S" | cut -d: -f1)
b=$(grep -n "^} // namespace qp_parse_flat" "$S" | cut -d: -f1)
{ echo "// Exploration-007 I/O, extracted verbatim (lines $a-$b) from"
  echo "// work/ntt/yosupo_convolution_shoup_avx2_io.cpp (branch claude/ntt-io-yosupo ed1d92b, SHA256 $(sha256sum "$S" | cut -c1-16)...)."
  echo "// Includes QgQ's submission 393435 mapping/table writer (https://judge.yosupo.jp/submission/393435)"
  echo "// and the exploration-007 two-stage AVX2 parser qp_parse_flat. Do not edit: regenerate with make_io007.sh."
  echo "#pragma once"
  for h in immintrin.h array cerrno cstdint cstdio cstdlib cstring sys/mman.h sys/stat.h unistd.h; do echo "#include <$h>"; done
  sed -n "${a},${b}p" "$S"; } > "$HERE/io007.hpp"
