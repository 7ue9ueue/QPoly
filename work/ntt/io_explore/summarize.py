#!/usr/bin/env python3
"""Summarize medians/spread by job, CPU and workload, retaining raw CSVs."""
from pathlib import Path
import csv
import json
import statistics
import sys

root=Path(sys.argv[1])
summary=[]
for meta_file in sorted(root.rglob('metadata.json')):
    meta=json.loads(meta_file.read_text())
    if '-fsanitize=address,undefined' in meta['flags']:continue
    job=meta_file.parent
    cpu=next((x.split(':',1)[1].strip() for x in meta.get('cpuinfo','').splitlines()
              if x.startswith('model name')),meta['execution'])
    for filename in ['micro.csv','end-to-end.csv']:
        path=job/filename
        if not path.exists():continue
        grouped={}
        for row in csv.DictReader(path.open()):
            key=(row.get('kind','end-to-end'),row['pattern'],row['n'],row.get('m',''),row['variant'])
            grouped.setdefault(key,[]).append(float(row['milliseconds']))
        for (kind,pattern,n,m,name),values in grouped.items():
            base=grouped[(kind,pattern,n,m,'baseline')]
            median=statistics.median(values)
            summary.append({'job':str(job.relative_to(root)),'cpu':cpu,'kind':kind,'pattern':pattern,
                'n':n,'m':m,'variant':name,'median_ms':f'{median:.6f}',
                'min_ms':f'{min(values):.6f}','max_ms':f'{max(values):.6f}',
                'baseline_over_candidate':f'{statistics.median(base)/median:.6f}'})
if not summary:raise SystemExit('No timing results found')
with (root/'summary.csv').open('w') as f:
    w=csv.DictWriter(f,fieldnames=list(summary[0]));w.writeheader();w.writerows(summary)
for row in summary:
    if (row['kind']=='end-to-end' and row['pattern']=='uniform_max') or (
        row['kind']!='end-to-end' and row['pattern']=='uniform' and row['n']=='1048576'):
        print(','.join(row.values()))
