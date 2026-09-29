#!/usr/bin/env bash
# Judge-like end-to-end correctness and timing for matrix_product (exploration 013), on a
# GitHub-hosted x64 runner (host with docker). usage: run_e2e.sh RESULTS_DIR.
# Variants: e2e/variants.txt lines "NAME [-DKEY=VALUE ...]" (flattened from main_mp.cpp with
# make_submission.py) and "FILE NAME PATH" (an existing single-file source, e.g. a deliverable).
# Env: REPS (default 11), THP_MODES (default "madvise"), CPU (default last), PHASES (default 1).
set -euo pipefail
IMAGE=gcc:15.2.0@sha256:3ae15afe768b06d0c0fe088d822ba5f8045c26630bdacc8d8e7713cf5d8e7289
ROOT=$(git rev-parse --show-toplevel)
E2E=$ROOT/work/matrix_product/e2e
RESULTS=$(realpath -m "$1")
BUILD=$ROOT/build/mp_e2e
CASES=/dev/shm/mp-cases  # Judge volumes live on tmpfs (/var/lib/docker is tmpfs there).
CPU=${CPU:-$(( $(nproc) - 1 ))}
mkdir -p "$RESULTS" "$BUILD/bin" "$BUILD/src" "$CASES/out"
set_thp() { echo "$1" | sudo tee /sys/kernel/mm/transparent_hugepage/enabled >/dev/null; }
{
  echo "revision $(git rev-parse HEAD)"; echo "pinned cpu $CPU"; uname -a; lscpu
  for f in enabled defrag; do echo "thp $f (initial): $(cat /sys/kernel/mm/transparent_hugepage/$f)"; done
  findmnt -no FSTYPE,SIZE /dev/shm
} > "$RESULTS/environment.txt" 2>&1
grep -m1 'Model name' "$RESULTS/environment.txt" || true
python3 "$ROOT/work/matrix_product/cases.py" "$CASES" | tee "$RESULTS/cases.txt"
cp "$CASES/cases.json" "$RESULTS/"
names=""
while read -r first rest; do
  [ -z "$first" ] || [ "${first:0:1}" = "#" ] && continue
  if [ "$first" = FILE ]; then
    set -- $rest; cp "$ROOT/$2" "$BUILD/src/$1.cpp"; names="$names $1"
  else
    python3 "$E2E/make_submission.py" "$E2E/main_mp.cpp" "$BUILD/src/$first.cpp" $rest > /dev/null
    names="$names $first"
    if [ "${PHASES:-1}" = 1 ]; then
      python3 "$E2E/make_submission.py" "$E2E/main_mp.cpp" "$BUILD/src/${first}_phases.cpp" $rest -DMP_PHASES > /dev/null
    fi
  fi
done < "$E2E/variants.txt"
(cd "$BUILD/src" && sha256sum *.cpp) > "$RESULTS/sources-sha256.txt"
docker pull -q "$IMAGE" > /dev/null
# Exact Library Checker C++23 command (library-checker-judge langs/langs.toml), source as main.cpp.
docker run --rm -v "$BUILD":/build -v "$E2E":/e2e:ro "$IMAGE" bash -euc '
  cd /build; g++ --version | head -1 > bin/compiler.txt
  gcc -O2 -static /e2e/init.c -o bin/init
  gcc -O2 /e2e/launcher.c -o bin/launcher
  for src in src/*.cpp; do
    name=$(basename "$src" .cpp); mkdir -p judge/$name; cp "$src" judge/$name/main.cpp
    (cd judge/$name && g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native -o main main.cpp) && cp judge/$name/main bin/$name
  done'
cp "$BUILD/bin/compiler.txt" "$RESULTS/"
(cd "$BUILD/bin" && sha256sum $(ls | grep -v -e compiler.txt -e '\.') ) > "$RESULTS/binaries-sha256.txt" || true
all=$(cd "$BUILD/src" && ls *.cpp | sed 's/\.cpp$//')
timed=$(echo "$all" | grep -v '_phases$' || true)
phased=$(echo "$all" | grep '_phases$' || true)
LIMITS=(--init --net=none --log-driver=none --memory=1024m --memory-swap=1024m --pids-limit 100
        --cpuset-cpus "$CPU" --ulimit stack=-1:-1)
launch() {  # plan-name reps warmups evict-MiB variants case-filter
  local plan=$RESULTS/plan-$1.txt
  { echo "reps $2"; echo "warmups $3"; echo "evict $4"; echo "init /workdir/init"; echo "outdir /casedir/out"
    for v in $5; do echo "variant $v /workdir/$v"; done
    python3 -c "import json,sys
for c in json.load(open('$CASES/cases.json'))['cases']:
    if eval(sys.argv[1]): print('case', c['case'], '/casedir/'+c['case']+'.in', '/casedir/'+c['case']+'.out')" "$6"
  } > "$plan"
  docker run --rm "${LIMITS[@]}" -v "$BUILD/bin":/workdir -v "$CASES":/casedir -v "$RESULTS":/results \
    -w /workdir "$IMAGE" /workdir/launcher "/results/plan-$1.txt" "/results/$1.csv" | tee -a "$RESULTS/checks.txt"
}
set_thp madvise
launch correctness 1 0 0 "$all" 'True'
LARGE='c["in_bytes"] > 1000000'
for mode in ${THP_MODES:-madvise}; do
  set_thp "$mode"
  launch "timing-$mode" "${REPS:-11}" 2 64 "$timed" "$LARGE"
done
if [ -n "$phased" ]; then
  set_thp madvise
  launch phases "${REPS:-11}" 1 64 "$phased" 'c["case"].startswith("max_random")'
fi
echo "thp enabled (final): $(cat /sys/kernel/mm/transparent_hugepage/enabled)" >> "$RESULTS/environment.txt"
python3 "$E2E/summarize_e2e.py" "$RESULTS" | tee "$RESULTS/summary.txt"
