#!/usr/bin/env python3
"""Summarize run_e2e.sh results: per-case medians and phase breakdowns; usage: summarize_e2e.py DIR."""
import csv
import statistics
import sys
from collections import defaultdict
from pathlib import Path

d = Path(sys.argv[1])
for f in sorted(d.glob('timing-*.csv')):
    rows = list(csv.DictReader(open(f)))
    wall = defaultdict(list)
    for r in rows:
        wall[(r['case'], r['variant'])].append(int(r['wall_ns']) / 1e6)
    cases = sorted({c for c, _ in wall})
    variants = sorted({v for _, v in wall})
    print(f'== {f.name}: median wall ms (min-max), per case')
    print('case,' + ','.join(variants))
    worst = defaultdict(float)
    for c in cases:
        cells = []
        for v in variants:
            s = sorted(wall[(c, v)])
            med = statistics.median(s)
            worst[v] = max(worst[v], med)
            cells.append(f'{med:.1f} ({s[0]:.1f}-{s[-1]:.1f})')
        print(c + ',' + ','.join(cells))
    print('max_over_cases,' + ','.join(f'{worst[v]:.1f}' for v in variants))
for f in sorted(d.glob('phases-*.csv')):
    rows = list(csv.DictReader(open(f)))
    ph = defaultdict(list)
    for r in rows:
        m = [int(r[k]) for k in ('main_ns', 'mapped_ns', 'parsed_ns', 'ntt_ns', 'written_ns')]
        if not all(m):
            continue
        end = int(r['wall_ns'])
        parts = [m[0], m[1] - m[0], m[2] - m[1], m[3] - m[2], m[4] - m[3], end - m[4]]
        ph[(r['case'], r['variant'])].append([p / 1e6 for p in parts] + [int(r['minflt'])])
    print(f'== {f.name}: median ms spawn->main, map, parse(+arena), ntt, format+write, exit; minor faults')
    for key in sorted(ph):
        cols = list(zip(*ph[key]))
        print(key[0] + ',' + key[1] + ',' + ','.join(f'{statistics.median(c):.1f}' for c in cols))
