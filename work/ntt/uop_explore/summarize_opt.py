#!/usr/bin/env python3
"""Pragma-variant table: usage summarize_opt.py <run-dir>. Median ms at 2^20 (fresh)."""
import csv, re, statistics, sys
from pathlib import Path
run = Path(sys.argv[1])
for job in sorted(p for p in run.iterdir() if p.is_dir() and (p / 'environment.txt').exists()):
    cpu = re.search(r'Model name:\s*(.+)', (job / 'environment.txt').read_text())
    variants = {'default': sorted(job.glob('time-lc-*.csv'))}
    for f in sorted(job.glob('opt-*-*.csv')):
        variants.setdefault(f.name.split('-')[1], []).append(f)
    rows = {}
    for v, files in variants.items():
        med = {}
        for f in files:
            for r in csv.reader(l for l in f.read_text().splitlines() if l and not l.startswith('#')):
                if r[0] == 'fresh' and r[1] == '20': med.setdefault(r[2], []).append(float(r[3]))
        rows[v] = {k: statistics.median(x) for k, x in med.items()}
    if len(rows) < 2: continue
    names = [n for n in rows['default'] if all(n in r for r in rows.values())]
    print(f'== {job.name} {cpu.group(1).strip() if cpu else "?"}')
    print('variant'.ljust(12) + ''.join(n.rjust(14) for n in names))
    for v, r in rows.items():
        print(v.ljust(12) + ''.join(f'{r[n]:14.3f}' for n in names))
