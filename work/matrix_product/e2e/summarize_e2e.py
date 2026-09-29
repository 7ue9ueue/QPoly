#!/usr/bin/env python3
"""Summarize run_e2e.sh results: summarize_e2e.py RESULTS_DIR.
Per timing CSV: per case and variant the median/min/max wall ms; the per-variant maximum over
cases of the median (the judge reports the maximum case); phase medians from phase builds."""
import collections
import csv
import pathlib
import statistics
import sys

root = pathlib.Path(sys.argv[1])
for f in sorted(root.glob('timing-*.csv')):
    rows = list(csv.DictReader(open(f)))
    by = collections.defaultdict(list)
    for r in rows:
        by[(r['case'], r['variant'])].append(int(r['wall_ns']) / 1e6)
    cases = sorted({c for c, _ in by})
    variants = sorted({v for _, v in by})
    print(f'\n## {f.name}: median wall ms (min-max)\n')
    print('| variant | ' + ' | '.join(cases) + ' | max median |')
    print('|---|' + '---:|' * (len(cases) + 1))
    for v in variants:
        cells, meds = [], []
        for c in cases:
            x = sorted(by.get((c, v), []))
            if x:
                m = statistics.median(x)
                meds.append(m)
                cells.append(f'{m:.2f} ({x[0]:.1f}-{x[-1]:.1f})')
            else:
                cells.append('-')
        print(f'| {v} | ' + ' | '.join(cells) + f' | {max(meds):.2f} |')
p = root / 'phases.csv'
if p.exists():
    rows = list(csv.DictReader(open(p)))
    ph = collections.defaultdict(lambda: collections.defaultdict(list))
    for r in rows:
        for item in r['stderr'].split(';'):
            item = item.strip()
            if item:
                name, ms = item.split()
                ph[r['variant']][name].append(float(ms))
        ph[r['variant']]['wall'].append(int(r['wall_ns']) / 1e6)
    print('\n## phases (max_random cases), median ms\n')
    for v, d in sorted(ph.items()):
        print(f'{v}: ' + ', '.join(f'{k} {statistics.median(x):.2f}' for k, x in d.items()))
