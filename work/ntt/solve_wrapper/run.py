#!/usr/bin/env python3
"""Native x64 or local Rosetta correctness and paired wrapper measurements."""
import csv, hashlib, os, platform, statistics, subprocess
from pathlib import Path

root = Path(__file__).resolve().parents[3]
os.chdir(root)
out = Path('build/solve_wrapper'); out.mkdir(parents=True, exist_ok=True)
dest = Path(os.environ.get('RESULT_DIR', 'results')); dest.mkdir(parents=True, exist_ok=True)
mac = platform.system() == 'Darwin'
compiler = 'clang++' if mac else os.environ.get('CXX', 'g++')
flags = ['-std=c++17', '-O2', '-mavx2', '-mbmi']
if mac:
    sdk = subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
    flags += ['-O3','-arch','x86_64','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1']
else:
    assert platform.machine() == 'x86_64' and 'avx2' in Path('/proc/cpuinfo').read_text()
    flags += ['-march=skylake']
sanitize = os.environ.get('SANITIZE') == '1'
if sanitize:
    flags += ['-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
cmd = [compiler,*flags,'work/ntt/solve_wrapper/bench.cpp','-o',str(out/'bench')]
(dest/'command.txt').write_text(' '.join(cmd)+'\n')
subprocess.run(cmd,check=True)
metadata = [platform.platform(), subprocess.check_output([compiler,'--version'],text=True),
            os.environ.get('GITHUB_SHA',subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip())]
if not mac: metadata.append(subprocess.check_output(['lscpu'],text=True))
(dest/'environment.txt').write_text('\n'.join(metadata))
paths = sorted(Path('work/ntt/solve_wrapper').glob('*')) + [out/'bench']
(dest/'hashes.txt').write_text(''.join(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+str(p)+'\n' for p in paths if p.is_file()))
with (dest/'correctness.txt').open('w') as f:
    subprocess.run([str(out/'bench'),'--check'],stdout=f,check=True)
print((dest/'correctness.txt').read_text(),flush=True)
if sanitize or os.environ.get('CHECK_ONLY') == '1': raise SystemExit(0)
with (dest/'timings.csv').open('w') as f:
    f.write('name,mode,n,m,rep,us,checksum\n'); f.flush()
    subprocess.run([str(out/'bench'),'--bench'],stdout=f,check=True)
    for n,m in [(1,524288),(100001,370003),(524288,524288)]:
        hashes=set()
        for rep in range(9):
            for j in range(5):
                i=(j+rep)%5 if rep%2==0 else (4-j+rep)%5
                row=subprocess.check_output([str(out/'bench'),'--cold',str(i),str(n),str(m)],text=True).strip().split(',')
                row[4]=str(rep);hashes.add(row[-1]);f.write(','.join(row)+'\n');f.flush()
        assert len(hashes)==1, 'cold outputs differ'
groups={}
for row in csv.DictReader((dest/'timings.csv').open()):
    key=tuple(row[k] for k in ['mode','n','m','name'])
    groups.setdefault(key,[]).append(float(row['us']))
with (dest/'summary.csv').open('w') as f:
    w=csv.writer(f);w.writerow(['mode','n','m','name','median_us','min_us','max_us','speedup'])
    for key,values in groups.items():
        baseline=statistics.median(groups[(*key[:3],'baseline')])
        median=statistics.median(values)
        w.writerow([*key,median,min(values),max(values),baseline/median])
print((dest/'summary.csv').read_text())
