#!/usr/bin/env python3
"""Recreate official convolution_mod_large tests; usage: cases_large.py DEST_DIR [case,...].

Downloads the Library Checker generators (Apache-2.0) at a pinned commit, runs them
with the official per-case seeds (problem.py: case <gen>_<i> uses seed i) and requires
every .in to match the published hash.json. Expected .out files come from the model
solution and must match hash.json too. Nothing from library-checker-problems is
vendored into this repository. Large cases are ~335 MB each way, so pass a subset.
"""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import sys
import tomllib
import urllib.request

COMMIT = '1814c4e5205517e368bb57a8d1127eb961cfeaae'
RAW = f'https://raw.githubusercontent.com/yosupo06/library-checker-problems/{COMMIT}/'
PROBLEM = 'convolution/convolution_mod_large/'
dest = Path(sys.argv[1]).resolve()
wanted = set(sys.argv[2].split(',')) if len(sys.argv) > 2 and sys.argv[2] else None
work = dest / 'problem'
(work / 'common').mkdir(parents=True, exist_ok=True)
(work / 'gen').mkdir(exist_ok=True)
(work / 'sol').mkdir(exist_ok=True)


def fetch(path, target):
    if not target.exists():
        with urllib.request.urlopen(RAW + path, timeout=120) as response:
            target.write_bytes(response.read())


fetch('common/random.h', work / 'common/random.h')
for name in ('info.toml', 'hash.json', 'sol/correct.cpp', 'fastio.h'):
    fetch(PROBLEM + name, work / name)
info = tomllib.loads((work / 'info.toml').read_text())
hashes = json.loads((work / 'hash.json').read_text())
(work / 'params.h').write_text(''.join(
    f'#define {key} (long long){value}\n' for key, value in info['params'].items()))


def compile_cpp(source, binary):
    if not binary.exists():
        subprocess.run([os.getenv('CXX', 'g++'), '-O2', '-std=c++17', '-march=native',
                        '-I', str(work / 'common'), str(source), '-o', str(binary)], check=True)


def sha(path):
    h = hashlib.sha256()
    with open(path, 'rb') as f:
        for block in iter(lambda: f.read(1 << 22), b''):
            h.update(block)
    return h.hexdigest()


compile_cpp(work / 'sol/correct.cpp', work / 'correct')
listing = dest / 'cases.json'
cases = json.loads(listing.read_text())['cases'] if listing.exists() else []
have = {c['case'] for c in cases}
for test in info['tests']:
    name = test['name']
    stem = name.rsplit('.', 1)[0]
    for i in range(test['number']):
        case = f'{stem}_{i:02d}'
        if (wanted is not None and case not in wanted) or case in have:
            continue
        fin, fout = dest / (case + '.in'), dest / (case + '.out')
        if name.endswith('.cpp'):
            fetch(PROBLEM + 'gen/' + name, work / 'gen' / name)
            compile_cpp(work / 'gen' / name, work / 'gen' / stem)
            with open(fin, 'wb') as f:
                subprocess.run([str(work / 'gen' / stem), str(i)], stdout=f, check=True)
        else:
            fetch(PROBLEM + 'gen/' + case + '.in', fin)
        assert sha(fin) == hashes[case + '.in'], case + '.in'
        if not os.getenv('NO_MODEL'):   # NO_MODEL=1: callers compare output hashes instead
            with open(fin, 'rb') as f, open(fout, 'wb') as g:
                subprocess.run([str(work / 'correct')], stdin=f, stdout=g, check=True)
            assert sha(fout) == hashes[case + '.out'], case + '.out'
        with open(fin, 'rb') as f:
            n, m = map(int, f.readline().split()[:2])
        cases.append({'case': case, 'n': n, 'm': m, 'in_bytes': fin.stat().st_size,
                      'out_bytes': fout.stat().st_size if fout.exists() else None, 'out_sha256': hashes[case + '.out']})
        print(f'case {case}: n={n} m={m} in={fin.stat().st_size} out={fout.stat().st_size if fout.exists() else "-"}', flush=True)
listing.write_text(json.dumps({'problems_commit': COMMIT, 'cases': cases}, indent=1) + '\n')
print(f'PASS {len(cases)} official cases: .in and model .out match hash.json at {COMMIT}')
