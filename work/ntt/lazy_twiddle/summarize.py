#!/usr/bin/env python3
"""Summarize one job/process at a time; do not pool unrelated CPU samples."""
import csv, statistics, sys
from collections import defaultdict
from pathlib import Path
for file in sys.argv[1:]:
    lines=Path(file).read_text().splitlines()
    start=lines.index('variant,mode,log2,repeat,microseconds,checksum')
    groups=defaultdict(list)
    checksums=defaultdict(set)
    for row in csv.DictReader(lines[start:]):
        key=(int(row['log2']),row['mode'],row['variant'])
        groups[key].append(float(row['microseconds']))
        checksums[key[:2]].add(row['checksum'])
    assert all(len(v)==1 for v in checksums.values()), 'Benchmark output checksum mismatch'
    assert all(len(v)==9 for v in groups.values()), 'Incomplete timing repetitions'
    variants={key[2] for key in groups}
    assert len(groups)==len(variants)*7*2, 'Incomplete size/mode coverage'
    print('\nSource:',file)
    print('log2,mode,variant,n,median_ms,min_ms,max_ms,speedup_vs_v91')
    for (lg,mode,name), values in sorted(groups.items()):
        med=statistics.median(values)
        base=statistics.median(groups[lg,mode,'v91'])
        print(f'{lg},{mode},{name},{len(values)},{med/1000:.4f},{min(values)/1000:.4f},{max(values)/1000:.4f},{base/med:.4f}')
