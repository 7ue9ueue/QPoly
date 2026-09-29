#!/usr/bin/env python3
"""Summarize downloaded CI artifacts: summarize.py RUN_DIR [BASELINE_VARIANT].

RUN_DIR contains one sub-directory per job (environment.txt, timing.txt). Prints, per CPU
model and size, each variant's median (over that job's repetitions) for every job, the
median across jobs, and the ratio to BASELINE_VARIANT (same job) when given.
"""
import collections
import pathlib
import statistics
import sys

root = pathlib.Path(sys.argv[1])
base = sys.argv[2] if len(sys.argv) > 2 else None
jobs = []
for d in sorted(p for p in root.iterdir() if p.is_dir()):
    env, timing = d / 'environment.txt', d / 'timing.txt'
    if not env.exists() or not timing.exists():
        continue
    cpu = next((l.split(':', 1)[1].strip() for l in env.read_text().splitlines() if l.startswith('cpu:')), '?')
    samples = collections.defaultdict(list)
    for line in timing.read_text().splitlines():
        if line.startswith('CSV,') and not line.startswith('CSV,size'):
            _, size, name, _, ms = line.split(',')
            samples[(size, name)].append(float(ms))
    jobs.append((d.name, cpu, {k: statistics.median(v) for k, v in samples.items()}))

by_cpu = collections.defaultdict(list)
for name, cpu, med in jobs:
    by_cpu[cpu].append((name, med))
for cpu, js in by_cpu.items():
    print(f'\n## {cpu} ({len(js)} job(s): {", ".join(j for j, _ in js)})\n')
    keys = sorted({k for _, med in js for k in med}, key=lambda k: (k[0], k[1]))
    sizes = sorted({k[0] for k in keys}, key=lambda s: -eval(s.replace('x', '*')))
    for size in sizes:
        names = sorted({k[1] for k in keys if k[0] == size})
        rows = []
        for n in names:
            vals = [med.get((size, n)) for _, med in js]
            got = [v for v in vals if v is not None]
            ratio = ''
            if base:
                rs = [med[(size, n)] / med[(size, base)] for _, med in js
                      if (size, n) in med and (size, base) in med]
                ratio = f'{statistics.median(rs):.3f}' if rs else ''
            rows.append((statistics.median(got), n, vals, ratio))
        rows.sort()
        print(f'| {size} | median ms | per job | vs {base or "-"} |\n|---|---:|---|---:|')
        for m, n, vals, ratio in rows:
            per = ' / '.join('-' if v is None else f'{v:.2f}' for v in vals)
            print(f'| {n} | {m:.2f} | {per} | {ratio} |')
        print()
