#!/usr/bin/env bash
# Exploration 014: hardware-counter probe on the runner host (not in a container). Builds bench_opt
# statically in the pinned image, then tries `perf stat` for a few parser variants. Records whether
# the VM exposes a PMU at all. Usage: run_perf.sh RESULT_DIR.
set -uo pipefail
OUT=${1:-results-perf}; mkdir -p "$OUT"
IMAGE=gcc:15.2.0@sha256:3ae15afe768b06d0c0fe088d822ba5f8045c26630bdacc8d8e7713cf5d8e7289
ROOT=$(git rev-parse --show-toplevel)
{ uname -a; lscpu; echo "perf_event_paranoid $(cat /proc/sys/kernel/perf_event_paranoid)"; ls /sys/bus/event_source/devices/ ; } > "$OUT/environment.txt" 2>&1
sudo apt-get update -qq > /dev/null 2>&1
sudo apt-get install -y -qq "linux-tools-$(uname -r)" linux-tools-common > "$OUT/apt.txt" 2>&1 || sudo apt-get install -y -qq linux-tools-azure >> "$OUT/apt.txt" 2>&1 || true
docker run --rm -v "$ROOT":/src -w /src "$IMAGE" g++ -O2 -std=c++23 -march=native -static work/ntt/large_opt/bench_opt.cpp -o /src/bench_opt_static
EV=cycles,instructions,L1-dcache-loads,L1-dcache-load-misses,cache-references,cache-misses,branch-misses
for v in m2 s17 s17p; do
  echo "== $v" >> "$OUT/perf.txt"
  sudo perf stat -e "$EV" "$ROOT/bench_opt_static" one "$v" 0 5 >> "$OUT/perf.txt" 2>&1 || echo "perf failed for $v" >> "$OUT/perf.txt"
done
cat "$OUT/environment.txt" | tail -3; cat "$OUT/perf.txt"
