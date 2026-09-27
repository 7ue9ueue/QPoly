#!/usr/bin/env bash
# Every official convolution_mod_large case, one at a time (they do not fit in tmpfs together):
# generate with the official generator and seed, require the .in SHA256 from hash.json, run each
# program under the judge's container limits via the library-checker-init equivalent, require the
# SHA256 of its output to equal hash.json's .out entry (byte-exact), log wall time, delete.
# usage: run_official_all.sh RESULT_DIR SOURCE.cpp [SOURCE.cpp ...]   (single-file programs)
set -euo pipefail
IMAGE=gcc:15.2.0@sha256:3ae15afe768b06d0c0fe088d822ba5f8045c26630bdacc8d8e7713cf5d8e7289
ROOT=$(git rev-parse --show-toplevel)
HERE=$ROOT/work/ntt/conv_large
RESULTS=$(realpath -m "$1"); shift
BUILD=$ROOT/build/conv_large_all
CASES=/dev/shm/qpoly-large-all
CPU=${CPU:-$(( $(nproc) - 1 ))}
mkdir -p "$RESULTS" "$BUILD/bin" "$CASES/out"
names=()
for src in "$@"; do
  name=$(basename "$src" .cpp); names+=("$name")
  mkdir -p "$BUILD/judge/$name"; cp "$src" "$BUILD/judge/$name/main.cpp"
  echo "$name $(sha256sum "$src" | cut -c1-64)" >> "$RESULTS/sources.txt"
done
docker pull -q "$IMAGE"
docker run --rm -v "$BUILD":/build -v "$HERE":/src:ro "$IMAGE" bash -euc '
  cd /build; gcc -O2 -static /src/init.c -o bin/init
  for d in judge/*/; do n=$(basename $d)
    (cd $d && g++ -O2 -std=c++23 -DEVAL -DONLINE_JUDGE -march=native -o main main.cpp -I /opt/ac-library) && cp $d/main bin/$n
  done'
# Problem files (generators, hash.json); cases_large.py with an empty selection only fetches them.
python3 "$HERE/cases_large.py" "$CASES" "none" > /dev/null
python3 - "$CASES" > "$RESULTS/case_list.txt" <<'EOF'
import sys, tomllib, pathlib
w = pathlib.Path(sys.argv[1]) / 'problem'
info = tomllib.loads((w / 'info.toml').read_text())
for t in info['tests']:
    stem = t['name'].rsplit('.', 1)[0]
    for i in range(t['number']):
        print(t['name'], stem, i)
EOF
echo "case,program,wall_ms,exit,output_sha256_ok" > "$RESULTS/official_all.csv"
fails=0
while read -r gen stem i; do
  case=$(printf '%s_%02d' "$stem" "$i")
  NO_MODEL=1 python3 "$HERE/cases_large.py" "$CASES" "$case" > /dev/null   # generates + verifies .in
  want=$(python3 -c "import json;print(json.load(open('$CASES/problem/hash.json'))['$case.out'])")
  for name in "${names[@]}"; do
    rm -f "$CASES/out/actual.out"
    t0=$(date +%s%N)
    set +e
    docker run --rm --init --net=none --log-driver=none --memory=1024m --memory-swap=1024m --pids-limit 100 \
      --cpuset-cpus "$CPU" --ulimit stack=-1:-1 -v "$BUILD/bin":/workdir:ro -v "$CASES":/casedir -w /workdir "$IMAGE" \
      /workdir/init "/casedir/$case.in" /casedir/out/actual.out "/workdir/$name" 2> "$RESULTS/stderr-$case-$name.txt"
    code=$?
    set -e
    t1=$(date +%s%N)
    got=$(sha256sum "$CASES/out/actual.out" 2>/dev/null | cut -c1-64 || true)
    ok=0; [ "$got" = "$want" ] && [ "$code" = 0 ] && ok=1
    [ "$ok" = 1 ] || { fails=$((fails+1)); echo "FAIL $case $name exit=$code"; }
    echo "$case,$name,$(( (t1-t0)/1000000 )),$code,$ok" >> "$RESULTS/official_all.csv"
    [ -s "$RESULTS/stderr-$case-$name.txt" ] || rm -f "$RESULTS/stderr-$case-$name.txt"
  done
  rm -f "$CASES/$case.in" "$CASES/$case.out" "$CASES/out/actual.out"
  python3 - "$CASES" "$case" <<'EOF'
import json, sys, pathlib
p = pathlib.Path(sys.argv[1]) / 'cases.json'
d = json.loads(p.read_text()); d['cases'] = [c for c in d['cases'] if c['case'] != sys.argv[2]]
p.write_text(json.dumps(d))
EOF
done < "$RESULTS/case_list.txt"
total=$(( $(wc -l < "$RESULTS/official_all.csv") - 1 ))
echo "official cases x programs: $total runs, $fails failures (wall_ms includes docker start; not a timing claim)" | tee "$RESULTS/official_all_summary.txt"
[ "$fails" = 0 ]
