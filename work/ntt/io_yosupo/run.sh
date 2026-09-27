#!/usr/bin/env bash
# Judge-like correctness and timing on a GitHub-hosted x64 Linux runner.
# usage: run.sh RESULT_DIR. Env: VARIANTS=a,b (default all), SANITIZE=1,
# REPS (default 11), REPLICA_REPS (default 15, 0 disables), CPU (default last).
set -euo pipefail
IMAGE=gcc:15.2.0@sha256:3ae15afe768b06d0c0fe088d822ba5f8045c26630bdacc8d8e7713cf5d8e7289
ROOT=$(git rev-parse --show-toplevel)
HARNESS=$ROOT/work/ntt/io_yosupo
RESULTS=$(realpath -m "$1")
BUILD=$ROOT/build/io_yosupo
CASES=/dev/shm/qpoly-cases  # Judge volumes live on tmpfs (/var/lib/docker).
CPU=${CPU:-$(( $(nproc) - 1 ))}
mkdir -p "$RESULTS" "$BUILD/bin" "$CASES/out"
cd "$ROOT"

{
  echo "revision $(git rev-parse HEAD)"; echo "pinned cpu $CPU"; uname -a; lscpu; lscpu -e
  for f in enabled defrag shmem_enabled; do
    echo "thp $f: $(cat /sys/kernel/mm/transparent_hugepage/$f)"; done
  docker info --format 'docker {{.ServerVersion}} cgroup {{.CgroupDriver}} v{{.CgroupVersion}} runtime {{.DefaultRuntime}}'
  findmnt -no FSTYPE,SIZE /dev/shm
} > "$RESULTS/environment.txt" 2>&1
python3 "$HARNESS/cases.py" "$CASES" | tee "$RESULTS/cases.txt"
cp "$CASES/cases.json" "$RESULTS/"
python3 "$HARNESS/variants.py" "$BUILD/src" ${VARIANTS:-} > "$RESULTS/manifest.json"
find "$HARNESS" -type f | sort | xargs sha256sum > "$RESULTS/harness-sha256.txt"
docker pull -q "$IMAGE"

# Exact Library Checker C++17 command (langs/langs.toml), each source as main.cpp.
FLAGS='-O2 -std=c++17 -DEVAL -DONLINE_JUDGE -march=native'
[ "${SANITIZE:-0}" = 1 ] && FLAGS="$FLAGS -O1 -g -fsanitize=address,undefined -fno-sanitize-recover=all -fno-omit-frame-pointer"
docker run --rm -v "$BUILD":/build -v "$ROOT/work/ntt":/ntt:ro -e FLAGS="$FLAGS" "$IMAGE" bash -euc '
  cd /build; g++ --version | head -1 > bin/compiler.txt; echo "$FLAGS" >> bin/compiler.txt
  gcc -O2 -static /ntt/io_yosupo/init.c -o bin/init
  gcc -O2 /ntt/io_yosupo/launcher.c -o bin/launcher
  g++ -O2 -std=c++17 /ntt/yosupo_scalar_reference.cpp -o bin/reference
  for src in src/*.cpp; do
    name=$(basename "$src" .cpp); mkdir -p judge/$name; cp "$src" judge/$name/main.cpp
    (cd judge/$name && g++ $FLAGS -o main main.cpp -I /opt/ac-library) && cp judge/$name/main bin/$name
  done
  ldd "$(ls -d judge/*/main | head -1)" >> bin/compiler.txt'
cp "$BUILD/bin/compiler.txt" "$RESULTS/"
names=$(cd "$BUILD/src" && ls *.cpp | sed 's/\.cpp$//')
timed=$(echo "$names" | grep -v '_phases$' || true)
phased=$(echo "$names" | grep '_phases$' || true)

LIMITS=(--init --net=none --log-driver=none --memory=1024m --memory-swap=1024m
        --pids-limit 100 --cpuset-cpus "$CPU")
[ "${SANITIZE:-0}" = 1 ] || LIMITS+=(--ulimit stack=-1:-1)  # Judge: unlimited stack.
launch() {  # plan-name reps warmups evict-MiB variants case-filter
  local plan=$RESULTS/plan-$1.txt
  { echo "reps $2"; echo "warmups $3"; echo "evict $4"
    echo "init /workdir/init"; echo "outdir /casedir/out"
    for v in $5; do echo "variant $v /workdir/$v"; done
    python3 -c "import json,sys
for c in json.load(open('$CASES/cases.json'))['cases']:
    if eval(sys.argv[1]): print('case', c['case'], '/casedir/'+c['case']+'.in', '/casedir/'+c['case']+'.out')" "$6"
  } > "$plan"
  docker run --rm "${LIMITS[@]}" -v "$BUILD/bin":/workdir -v "$CASES":/casedir \
    -v "$RESULTS":/results -w /workdir "$IMAGE" /workdir/launcher "/results/plan-$1.txt" "/results/$1.csv" \
    | tee -a "$RESULTS/checks.txt"
}
# Every build, every official case: exact bytes versus hash-verified model output.
launch correctness 1 0 0 "$names" 'True'
docker run --rm -v "$BUILD":/build -v "$ROOT/work/ntt":/ntt:ro "$IMAGE" bash -euc '
  apt-get update -qq >/dev/null && apt-get install -y -qq python3 >/dev/null
  for v in '"$(echo $timed)"'; do
    printf "%s: " $v; python3 /ntt/verify_yosupo_convolution.py /build/bin/$v /build/bin/reference --quick
  done' | tee -a "$RESULTS/checks.txt"
[ "${SANITIZE:-0}" = 1 ] && exit 0

LARGE='c["in_bytes"] > 1000000'
launch timing-cold "${REPS:-11}" 2 64 "$timed" "$LARGE"
launch timing-warm "${REPS:-11}" 2 0 "$timed" "$LARGE"
[ -n "$phased" ] && launch phases "${REPS:-11}" 2 64 "$phased" "$LARGE"
if [ "${REPLICA_REPS:-15}" != 0 ]; then
  python3 "$HARNESS/judge_replica.py" "$IMAGE" "$BUILD/bin" "$CASES" "$CPU" "${REPLICA_REPS:-15}" \
    "$RESULTS/replica.csv" "${REPLICA_VARIANTS:-base,sse_short}" max_random_00,fft_killer_00 \
    | tee -a "$RESULTS/checks.txt"
fi
python3 "$HARNESS/summarize.py" "$RESULTS" | tee "$RESULTS/summary.txt"
