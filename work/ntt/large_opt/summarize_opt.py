#!/usr/bin/env python3
"""Exploration 014 e2e summary: per variant, medians over the large cases (max_random_00, fft_killer_00,
max_ans_zero_00, all_same_00) of wall, user and sys ms, and for probe builds the in-process phases
(map, parse, ntt, out ms); usage: summarize_opt.py DIR."""
import csv, statistics, sys, collections
from pathlib import Path
d = Path(sys.argv[1])
big = {'max_random_00', 'fft_killer_00', 'max_ans_zero_00', 'all_same_00'}
for f in sorted(d.glob('timing-*.csv')):
    rows = list(csv.DictReader(open(f)))
    agg = collections.defaultdict(lambda: collections.defaultdict(list))
    for r in rows:
        if r['case'] not in big:
            continue
        a = agg[r['variant']]
        a['wall'].append(int(r['wall_ns']) / 1e6); a['user'].append(int(r['user_us']) / 1e3); a['sys'].append(int(r['sys_us']) / 1e3)
        if int(r['main_ns']) == -1:
            for k, col in (('map', 'mapped_ns'), ('parse', 'parsed_ns'), ('ntt', 'ntt_ns'), ('out', 'written_ns')):
                a[k].append(int(r[col]) / 1e6)
    print(f'== {f.name}: medians over {sorted(big)} (ms)')
    print('variant,wall,user,sys,map,parse,ntt,out')
    for v in sorted(agg):
        a = agg[v]
        med = lambda k: f'{statistics.median(a[k]):.1f}' if a[k] else ''
        print(','.join([v] + [med(k) for k in ('wall', 'user', 'sys', 'map', 'parse', 'ntt', 'out')]))
