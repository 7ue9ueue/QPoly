#!/usr/bin/env bash
# Judge-like end-to-end runs for convolution_mod_large on a GitHub-hosted x64 runner.
# usage: run_e2e.sh RESULT_DIR
# Env: CASES_LIST (comma list of official case names), VARIANTS ("name:FLAGS;..." built from
# solve_main.cpp), STANDALONE ("name:MAKE_ARGS;..." single files from make_submission.py, built
# exactly as the judge builds main.cpp), REFS (judge submission ids fetched at run time, not
# stored), REPS (5), THP_MODES ("madvise always"), CPU (default last CPU).
# Mirrors work/ntt/io_yosupo/run.sh: official cases on host tmpfs (/dev/shm), exact judge
# compile command in the pinned gcc:15.2.0 image, solutions launched by an equivalent of
# library-checker-init inside a container with the judge's limits (1024m memory+swap,
# 100 pids, one CPU, unlimited stack). Wall time = posix_spawn -> wait4 (includes exec,
# page faults, write() into the tmpfs output and teardown). Every output is compared
# byte for byte with the hash-verified model output after every run (outside timing).
set -euo pipefail
IMAGE=gcc:15.2.0@sha256:3ae15afe768b06d0c0fe088d822ba5f8045c26630bdacc8d8e7713cf5d8e7289
ROOT=$(git rev-parse --show-toplevel)
HERE=$ROOT/work/ntt/conv_large
RESULTS=$(realpath -m "$1")
BUILD=$ROOT/build/conv_large
CASES=/dev/shm/qpoly-large
CPU=${CPU:-$(( $(nproc) - 1 ))}
CASES_LIST=${CASES_LIST:-max_random_00,fft_killer_00,all_same_00,max_ans_zero_00,small_and_large_00,random_02}
VARIANTS=${VARIANTS-"b0z:-DQL_MODE=0;top:-DQL_MODE=1"}
REFS=${REFS:-403499 303498}
mkdir -p "$RESULTS" "$BUILD/bin" "$BUILD/src" "$CASES/out"
cd "$ROOT"
set_thp() { echo "$1" | sudo tee /sys/kernel/mm/transparent_hugepage/enabled >/dev/null; }
{
  echo "revision $(git rev-parse HEAD)"; echo "pinned cpu $CPU"; uname -a; lscpu; free -m
  for f in enabled defrag shmem_enabled; do echo "thp $f (initial): $(cat /sys/kernel/mm/transparent_hugepage/$f)"; done
  docker info --format 'docker {{.ServerVersion}} cgroup {{.CgroupDriver}} v{{.CgroupVersion}} runtime {{.DefaultRuntime}}'
  findmnt -no FSTYPE,SIZE,OPTIONS /dev/shm
} > "$RESULTS/environment.txt" 2>&1
python3 "$HERE/cases_large.py" "$CASES" "$CASES_LIST" | tee "$RESULTS/cases.txt"
cp "$CASES/cases.json" "$RESULTS/"
docker pull -q "$IMAGE"

# Sources: our variants (single translation unit with local includes) and references.
: > "$RESULTS/manifest.txt"
IFS=';' read -ra VARS <<< "$VARIANTS"
for v in "${VARS[@]}"; do
  name=${v%%:*}; flags=${v#*:}
  echo "variant $name flags $flags" >> "$RESULTS/manifest.txt"
done
IFS=';' read -ra STANDS <<< "${STANDALONE:-}"
for v in "${STANDS[@]}"; do
  name=${v%%:*}; margs=${v#*:}
  gen="$HERE/make_submission.py"   # "@io ARGS" selects the exploration-011 generator
  case "$margs" in "@io"*) gen="$ROOT/work/ntt/io_large/make_submission.py"; margs=${margs#@io};; esac
  python3 "$gen" $margs --out "$BUILD/src/$name.cpp" | tee -a "$RESULTS/manifest.txt"
done
for id in $REFS; do
  curl -fsSL "https://v3.api.judge.yosupo.jp/submissions/$id" | python3 -c \
    "import json,sys; d=json.load(sys.stdin); open('$BUILD/src/ref$id.cpp','w').write(d['source'])"
  echo "reference ref$id https://judge.yosupo.jp/submission/$id sha256 $(sha256sum "$BUILD/src/ref$id.cpp" | cut -c1-64)" >> "$RESULTS/manifest.txt"
done
find "$HERE" -maxdepth 1 -type f | sort | xargs sha256sum > "$RESULTS/harness-sha256.txt"

FLAGS='-O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native'
standalone=$(for v in "${STANDS[@]}"; do echo -n "${v%%:*} "; done)
docker run --rm -v "$BUILD":/build -v "$ROOT/work/ntt":/ntt:ro -e FLAGS="$FLAGS" -e VARIANTS="$VARIANTS" -e REFS="$REFS" -e STANDALONE_NAMES="$standalone" "$IMAGE" bash -euc '
  cd /build; g++ --version | head -1 > bin/compiler.txt; echo "$FLAGS" >> bin/compiler.txt
  gcc -O2 -static /ntt/conv_large/init.c -o bin/init
  gcc -O2 /ntt/conv_large/launcher_large.c -o bin/launcher
  g++ -O2 -std=c++17 /ntt/conv_large/check_output.cpp -o bin/check_output
  IFS=";" read -ra VARS <<< "$VARIANTS"
  for v in "${VARS[@]}"; do
    name=${v%%:*}; flags=${v#*:}
    g++ $FLAGS $flags -I /ntt/conv_large -o bin/$name /ntt/conv_large/solve_main.cpp
    g++ $FLAGS $flags -DQPOLY_PHASES -I /ntt/conv_large -o bin/${name}_phases /ntt/conv_large/solve_main.cpp
  done
  for id in $REFS; do
    mkdir -p judge/ref$id; cp src/ref$id.cpp judge/ref$id/main.cpp
    (cd judge/ref$id && g++ $FLAGS -o main main.cpp -I /opt/ac-library) && cp judge/ref$id/main bin/ref$id
  done
  for name in $STANDALONE_NAMES; do
    mkdir -p judge/$name; cp src/$name.cpp judge/$name/main.cpp
    (cd judge/$name && g++ $FLAGS -o main main.cpp -I /opt/ac-library) && cp judge/$name/main bin/$name
  done'
cp "$BUILD/bin/compiler.txt" "$RESULTS/"
ours=$(for v in "${VARS[@]}"; do echo -n "${v%%:*} "; done)
ours_all="$ours $standalone"
refs=$(for id in $REFS; do echo -n "ref$id "; done)

LIMITS=(--init --net=none --log-driver=none --memory=1024m --memory-swap=1024m
        --pids-limit 100 --cpuset-cpus "$CPU" --ulimit stack=-1:-1)
launch() {  # plan-name reps warmups variants case-filter
  local plan=$RESULTS/plan-$1.txt
  { echo "reps $2"; echo "warmups $3"; echo "evict 0"
    echo "init /workdir/init"; echo "outdir /casedir/out"
    for v in $4; do echo "variant $v /workdir/$v"; done
    python3 -c "import json,sys
for c in json.load(open('$CASES/cases.json'))['cases']:
    if eval(sys.argv[1]): print('case', c['case'], '/casedir/'+c['case']+'.in', '/casedir/'+c['case']+'.out')" "$5"
  } > "$plan"
  docker run --rm "${LIMITS[@]}" -v "$BUILD/bin":/workdir -v "$CASES":/casedir \
    -v "$RESULTS":/results -w /workdir "$IMAGE" /workdir/launcher "/results/plan-$1.txt" "/results/$1.csv" \
    | tee -a "$RESULTS/checks.txt"
}
# Correctness: every build on every generated case (exact bytes vs hash-verified output).
launch correctness 1 0 "$ours_all $refs $(for v in $ours; do echo -n "${v}_phases "; done)" 'True'
for mode in ${THP_MODES:-madvise always}; do
  set_thp "$mode"
  launch "timing-$mode" "${REPS:-5}" 1 "$ours_all $refs" 'True'
  [ -n "${ours// }" ] && launch "phases-$mode" 3 1 "$(for v in $ours; do echo -n "${v}_phases "; done)" 'True'
done
set_thp always
python3 "$HERE/summarize_e2e.py" "$RESULTS" | tee "$RESULTS/summary.txt"
