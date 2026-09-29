#!/usr/bin/env python3
"""Recreate the official matrix_product tests; usage: cases.py DEST_DIR [--no-out].

Adapted from work/ntt/io_yosupo/cases.py. Downloads the Library Checker
generators (Apache-2.0) at a pinned commit, runs them with the official per-case
seeds, and requires every .in file and every model-solution .out file to match
the published hash.json byte for byte. Nothing from library-checker-problems is
vendored into this repository. --no-out skips the (slow, O(n^3)) model outputs.
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
PROBLEM = 'linear_algebra/matrix_product/'
dest = Path(sys.argv[1]).resolve()
want_out = '--no-out' not in sys.argv
work = dest / 'problem'
(work / 'common').mkdir(parents=True, exist_ok=True)
(work / 'gen').mkdir(exist_ok=True)
(work / 'sol').mkdir(exist_ok=True)


def fetch(path, target):
    with urllib.request.urlopen(RAW + path, timeout=60) as response:
        target.write_bytes(response.read())


fetch('common/random.h', work / 'common/random.h')
for name in ('info.toml', 'hash.json', 'sol/correct.cpp'):
    fetch(PROBLEM + name, work / name)
info = tomllib.loads((work / 'info.toml').read_text())
hashes = json.loads((work / 'hash.json').read_text())
# Same text as library-checker-problems problem.py param_to_str for integers.
(work / 'params.h').write_text(''.join(
    f'#define {key} (long long){value}\n' for key, value in info['params'].items()))


def compile_cpp(source, binary):
    subprocess.run([os.getenv('CXX', 'g++'), '-O2', '-std=c++17',
                    '-I', str(work / 'common'), str(source), '-o', str(binary)], check=True)


if want_out:
    compile_cpp(work / 'sol/correct.cpp', work / 'correct')
cases = []
for test in info['tests']:
    name = test['name']
    stem = name.rsplit('.', 1)[0]
    if name.endswith('.cpp'):
        fetch(PROBLEM + 'gen/' + name, work / 'gen' / name)
        compile_cpp(work / 'gen' / name, work / 'gen' / stem)
    for i in range(test['number']):
        case = f'{stem}_{i:02d}'  # problem.py casename: generator seed is i.
        if name.endswith('.cpp'):
            data = subprocess.run([str(work / 'gen' / stem), str(i)],
                                  capture_output=True, check=True).stdout
        else:
            fetch(PROBLEM + 'gen/' + case + '.in', work / 'gen' / (case + '.in'))
            data = (work / 'gen' / (case + '.in')).read_bytes()
        assert hashlib.sha256(data).hexdigest() == hashes[case + '.in'], case + '.in'
        (dest / (case + '.in')).write_bytes(data)
        out_bytes = None
        if want_out:
            expected = subprocess.run([str(work / 'correct')], input=data,
                                      capture_output=True, check=True).stdout
            assert hashlib.sha256(expected).hexdigest() == hashes[case + '.out'], case + '.out'
            (dest / (case + '.out')).write_bytes(expected)
            out_bytes = len(expected)
        n, m, k = map(int, data.split()[:3])
        cases.append({'case': case, 'n': n, 'm': m, 'k': k, 'in_bytes': len(data),
                      'out_bytes': out_bytes})
(dest / 'cases.json').write_text(json.dumps(
    {'problems_commit': COMMIT, 'cases': cases}, indent=1) + '\n')
print(f'PASS {len(cases)} official cases: .in' + (' and model .out' if want_out else '')
      + f' match hash.json at {COMMIT}')
