#!/usr/bin/env python3
"""Summarize saved native samples, preserving every CPU/job as a separate group."""
from pathlib import Path
import csv,io,statistics,sys

run=Path(sys.argv[1])
output=io.StringIO();w=csv.writer(output)
w.writerow(['job','cpu','mode','log2','variant','median_ms','min_ms','max_ms','speedup_vs_h14'])
for job in sorted(run.glob('h14-[0-9]*')):
    cpu=next(line.split(':',1)[1].strip() for line in (job/'environment.txt').read_text().splitlines() if line.startswith('Model name:'))
    s=(job/'timings.csv').read_text()
    rows=list(csv.DictReader(io.StringIO(s[s.index('variant,'):])))
    groups={}
    for r in rows:
        groups.setdefault((r['mode'],int(r['log2']),r['variant']),[]).append(float(r['microseconds'])/1000)
    for (mode,n,name),samples in sorted(groups.items()):
        assert len(samples)==9,(job,mode,n,name,len(samples))
        median=statistics.median(samples)
        baseline=statistics.median(groups[(mode,n,'ll_inline_h14')])
        w.writerow([job.name,cpu,mode,n,name,*(f'{x:.6f}' for x in [median,min(samples),max(samples),baseline/median])])
(run/'summary.csv').write_text(output.getvalue())
for row in csv.DictReader(io.StringIO(output.getvalue())):
    if row['mode']=='fresh' and row['log2']=='20':
        print(row['job'],row['variant'],row['median_ms'],row['speedup_vs_h14'])
