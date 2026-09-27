#!/usr/bin/env python3
"""Summarize one job directory (or a tree of them); usage: summarize.py DIR."""
from pathlib import Path
import csv
import json
import math
import statistics
import sys

root = Path(sys.argv[1])
median = statistics.median
lines = []


def emit(text=''):
    lines.append(text)


for job in sorted({p.parent for p in root.rglob('timing-cold.csv')} | {p.parent for p in root.rglob('phases.csv')}):
    env = (job / 'environment.txt').read_text() if (job / 'environment.txt').exists() else ''
    cpu = next((l.split(':', 1)[1].strip() for l in env.splitlines() if l.startswith('Model name')), '?')
    thp = [l for l in env.splitlines() if l.startswith('thp ')]
    cases = {c['case']: c for c in json.loads((job / 'cases.json').read_text())['cases']}
    full = {name for name, c in cases.items() if c['n'] == c['m'] == 1 << 19}
    emit(f'## {job.relative_to(root.parent)} | {cpu} | {"; ".join(thp)}')
    for mode in ('timing-cold', 'timing-warm'):
        path = job / (mode + '.csv')
        if not path.exists():
            continue
        runs = {}
        for row in csv.DictReader(path.open()):
            runs.setdefault((row['case'], row['variant']), []).append(row)
        variants = sorted({v for _, v in runs}, key=lambda v: (v != 'base', v != 'sse_short', v))
        med = {k: median(int(r['wall_ns']) for r in rows) / 1e6 for k, rows in runs.items()}
        emit(f'\n### {mode}: medians over {len(next(iter(runs.values())))} runs per case; '
             f'"full" = {len(full)} cases with N=M=2^19')
        emit('variant | full mean ms | full max ms | geo ratio vs base (all large) | '
             'vs sse_short (full) | user ms | sys ms | minflt')
        for v in variants:
            f_meds = [med[(c, v)] for c in full if (c, v) in med]
            ratio = math.exp(statistics.mean(math.log(med[(c, v)] / med[(c, 'base')])
                                             for c, vv in med if vv == v))
            rs = math.exp(statistics.mean(math.log(med[(c, v)] / med[(c, 'sse_short')])
                                          for c in full if (c, 'sse_short') in med))
            rows = [r for c in full for r in runs.get((c, v), [])]
            emit(f'{v} | {statistics.mean(f_meds):.3f} | {max(f_meds):.3f} | {ratio:.4f} | {rs:.4f} | '
                 f'{median(int(r["user_us"]) for r in rows) / 1e3:.2f} | '
                 f'{median(int(r["sys_us"]) for r in rows) / 1e3:.2f} | '
                 f'{median(int(r["minflt"]) for r in rows):.0f}')
        emit('\ncase | ' + ' | '.join(variants))
        for c in sorted({c for c, _ in runs}):
            vals = [runs[(c, v)] for v in variants]
            emit(c + ' | ' + ' | '.join(
                f'{median(int(r["wall_ns"]) for r in rs) / 1e6:.3f} '
                f'[{min(int(r["wall_ns"]) for r in rs) / 1e6:.2f}-{max(int(r["wall_ns"]) for r in rs) / 1e6:.2f}]'
                for rs in vals))
    path = job / 'phases.csv'
    if path.exists():
        emit('\n### phase medians (ms) over full-size cases, instrumented builds')
        emit('build | spawn->main | map | parse | ntt | format | write() | exit | total')
        by = {}
        for row in csv.DictReader(path.open()):
            if row['case'] in full:
                by.setdefault(row['variant'], []).append(row)
        for v, rows in sorted(by.items()):
            def ph(f):
                return median(f(r) for r in rows) / 1e6
            g = lambda r, k: int(r[k])
            emit(f'{v} | {ph(lambda r: g(r, "main_ns")):.3f} | '
                 f'{ph(lambda r: g(r, "mapped_ns") - g(r, "main_ns")):.3f} | '
                 f'{ph(lambda r: g(r, "parsed_ns") - g(r, "mapped_ns")):.3f} | '
                 f'{ph(lambda r: g(r, "ntt_ns") - g(r, "parsed_ns")):.3f} | '
                 f'{ph(lambda r: g(r, "written_ns") - g(r, "ntt_ns") - g(r, "write_syscall_ns")):.3f} | '
                 f'{ph(lambda r: g(r, "write_syscall_ns")):.3f} | '
                 f'{ph(lambda r: g(r, "wall_ns") - g(r, "written_ns")):.3f} | '
                 f'{ph(lambda r: g(r, "wall_ns")):.3f}')
    path = job / 'replica.csv'
    if path.exists():
        emit('\n### judge replica (docker per run, ~1 ms cgroup poll)')
        by = {}
        for row in csv.DictReader(path.open()):
            by.setdefault((row['case'], row['variant']), []).append(float(row['polled_ms']))
        for (c, v), xs in sorted(by.items()):
            emit(f'{c} {v}: median {median(xs):.2f} ms, min {min(xs):.2f}, max {max(xs):.2f}, '
                 f'rounded {sorted(round(x) for x in xs)}')
    emit()
text = '\n'.join(lines)
(root / 'summary.md').write_text(text + '\n')
print(text)
