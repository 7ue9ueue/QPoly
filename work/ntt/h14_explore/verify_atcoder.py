#!/usr/bin/env python3
"""Compile and test the exact deliverable under plain and AtCoder-like flags."""
from pathlib import Path
import os,subprocess,hashlib,json
root=Path(__file__).resolve().parents[3];os.chdir(root)
dest=Path(os.getenv('RESULT_DIR','results'))/'standalone';dest.mkdir(parents=True,exist_ok=True)
src=Path('work/ntt/atcoder_ntt_h14_compare.cpp');build=Path('build/h14_standalone');build.mkdir(parents=True,exist_ok=True)
target=['-O2','-ftrivial-auto-var-init=zero','-fmodules','-fconstexpr-depth=1024','-fconstexpr-loop-limit=524288','-fconstexpr-ops-limit=2097152','-pthread','-fopenmp','-DATCODER','-DNOMINMAX','-DONLINE_JUDGE']
profiles={'plain':['-std=c++17','-O2'],
          'atcoder_like_native':['-std=gnu++23',*target,'-march=native'],
          'avx2_capped':['-std=gnu++23',*target,'-march=skylake']}
hashes={'source':hashlib.sha256(src.read_bytes()).hexdigest(),'binaries':{}}
for name,flags in profiles.items():
    exe=build/name;cmd=['g++',*flags,str(src),'-o',str(exe)]
    (dest/f'{name}-command.txt').write_text(' '.join(cmd)+'\n')
    subprocess.run(cmd,check=True)
    hashes['binaries'][name]=hashlib.sha256(exe.read_bytes()).hexdigest()
    cases=[('default','')] if name=='plain' else [('20-10-2','20 10 2\n')]
    if name=='atcoder_like_native':cases.append(('22-3-2','22 3 2\n'))
    for label,input_ in cases:
        with (dest/f'{name}-{label}.txt').open('w') as out:
            subprocess.run(['/usr/bin/time','-v','-o',str(dest/f'{name}-{label}-resources.txt'),str(exe)],input=input_,text=True,stdout=out,check=True)
(dest/'hashes.json').write_text(json.dumps(hashes,indent=2)+'\n')
