#!/usr/bin/env python3
"""Summaries for exploration-009 CI runs.

usage: summarize.py RUN_DIR [SIZES] [--micro]
  RUN_DIR  downloaded run (gcc-N/ and yosupo-N/ job directories)
  SIZES    comma-separated log2 sizes for the timing table (default 19,20,21)
Timing: per job, the median of all pooled samples (3 rounds x reps) of each entry
divided by the same job's `live` median; the last column averages EPYC 7763 jobs.
--micro: per-phase cycles (micro.txt) on EPYC 7763 jobs, best variants first.
Submission jobs: verify and max-input timing lines.
"""
import csv
import glob
import re
import statistics
import sys


def cpu(job):
    m = re.search(r'Model name:\s*(.*)', open(f'{job}/environment.txt').read())
    return m.group(1).split()[2] if m else '?'


def timing(run, sizes):
    for lg in sizes:
        print(f'== 2^{lg} fresh: same-job ratio vs live')
        table, cpus = {}, {}
        for j in sorted(glob.glob(f'{run}/gcc-*')):
            cpus[j] = cpu(j)
            samples = {}
            for f in glob.glob(f'{j}/time-*.csv'):
                for r in csv.DictReader(line for line in open(f) if not line.startswith('#')):
                    if int(r['log2']) == lg:
                        samples.setdefault(r['implementation'], []).extend(float(x) for x in r['samples'].split(';'))
            if 'live' not in samples:
                continue
            base = statistics.median(samples['live'])
            for k, s in samples.items():
                table.setdefault(k, {})[j] = statistics.median(s) / base
            table.setdefault('live ms', {})[j] = base
        js = sorted(j for j in cpus if j in table.get('live ms', {}))
        print(f'{"entry":22s}' + ''.join(f'{cpus[j][:8]:>9s}' for j in js) + '  7763-mean')
        for k, d in table.items():
            z = [d[j] for j in js if cpus[j] == '7763']
            print(f'{k:22s}' + ''.join(f'{d[j]:9.3f}' for j in js) + (f'  {statistics.mean(z):.3f}' if z else ''))


def micro(run):
    rows = {}
    for j in sorted(glob.glob(f'{run}/gcc-*')):
        if cpu(j) != '7763':
            continue
        for line in open(f'{j}/micro.txt'):
            m = re.match(r'(\S+(?: al\d\d)?)\s+(.+?)\s+([\d.]+) cycles/unit', line)
            if m:
                rows.setdefault((m.group(2), m.group(1)), []).append(float(m.group(3)))
    for key in sorted(rows, key=lambda k: (k[0], statistics.median(rows[k]))):
        print(f'{key[0]:28s} {key[1]:16s} ' + ' '.join(f'{x:7.2f}' for x in rows[key]))


def submissions(run):
    for j in sorted(glob.glob(f'{run}/yosupo-*')):
        print(f'== {j} ({cpu(j)})')
        for f in ('verify.txt', 'max-timing.txt'):
            try:
                for line in open(f'{j}/{f}'):
                    if line.startswith('PASS') or 'compute_ms' in line:
                        print(line.rstrip()[:140])
            except FileNotFoundError:
                pass


if __name__ == '__main__':
    run = sys.argv[1]
    args = [a for a in sys.argv[2:] if not a.startswith('--')]
    timing(run, [int(x) for x in (args[0] if args else '19,20,21').split(',')])
    submissions(run)
    if '--micro' in sys.argv:
        micro(run)
