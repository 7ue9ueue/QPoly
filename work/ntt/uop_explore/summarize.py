#!/usr/bin/env python3
"""Summarize round-7 timing CSVs: per job/profile, median of per-round medians.

usage: summarize.py <run-dir> [log2=20] [baseline=h14]
Prints ms and time relative to the baseline (lower is better) for each entry.
"""
import csv, sys, statistics, re
from pathlib import Path

run = Path(sys.argv[1]); lg = sys.argv[2] if len(sys.argv) > 2 else '20'
base = sys.argv[3] if len(sys.argv) > 3 else 'h14'
rows = []
for job in sorted(p for p in run.iterdir() if p.is_dir()):
    env = (job / 'environment.txt').read_text() if (job / 'environment.txt').exists() else ''
    m = re.search(r'Model name:\s*(.+)', env); cpu = m.group(1).strip() if m else '?'
    comp = 'clang' if 'clang' in env.lower() else 'gcc'
    for prof in ['lc', 'znver3', 'native', 'avx2']:
        med = {}
        for f in sorted(job.glob(f'time-{prof}-*.csv')):
            for r in csv.reader(l for l in f.read_text().splitlines() if l and not l.startswith('#')):
                if r[0] in ('fresh', 'reuse') and r[1] == lg:
                    med.setdefault(r[2], []).append(float(r[3]))
        if not med: continue
        agg = {k: statistics.median(v) for k, v in med.items()}
        rows.append((job.name, cpu, comp, prof, agg))
names = []
for *_, agg in rows:
    for k in agg:
        if k not in names: names.append(k)
print(f'log2={lg}; cells: median ms (time / {base})')
hdr = ['job', 'cpu', 'cc', 'prof'] + names
print(' | '.join(hdr))
for job, cpu, comp, prof, agg in rows:
    b = agg.get(base)
    cells = [f'{agg[n]:.3f} ({agg[n]/b:.3f})' if n in agg and b else '-' for n in names]
    print(' | '.join([job, cpu[:24], comp, prof] + cells))
