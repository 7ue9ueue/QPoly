#!/usr/bin/env python3
"""Same-job correctness and timing. Local results are explicitly Rosetta only."""
from pathlib import Path
import hashlib
import json
import os
import platform
import random
import subprocess
import sys
import tempfile
import time

root=Path(__file__).resolve().parents[3]
os.chdir(root)
build=Path('build/io_explore')
dest=Path(os.getenv('RESULT_DIR','notes/results/ntt-io-local'))
dest.mkdir(parents=True,exist_ok=True)
sanitize=os.getenv('SANITIZE')=='1'
local=platform.system()=='Darwin'
subprocess.run([sys.executable,'work/ntt/io_explore/generate.py'],check=True,stdout=(dest/'generated-hashes.json').open('w'))
names=list(json.loads((build/'manifest.json').read_text()))
cxx='clang++' if local else os.getenv('CXX','g++')
flags=['-std=c++17','-O2','-mavx2','-mbmi','-Ibuild/io_explore']
if local:
    sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
    flags+=['-arch','x86_64','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1']
else:
    assert platform.machine()=='x86_64' and 'avx2' in Path('/proc/cpuinfo').read_text()
if sanitize:flags+=['-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
meta={'execution':'Rosetta, not native x64' if local else 'native x86_64 Linux',
      'compiler':subprocess.check_output([cxx,'--version'],text=True),
      'flags':flags,'revision':os.getenv('GITHUB_SHA') or subprocess.check_output(['git','rev-parse','HEAD'],text=True).strip(),
      'source_hashes':{str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in
          [*Path('work/ntt/io_explore').glob('*'),Path('work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed_io393435.cpp')]
          if p.is_file()}}
if not local:meta['cpuinfo']=Path('/proc/cpuinfo').read_text().split('\n\n')[0]
(dest/'metadata.json').write_text(json.dumps(meta,indent=2)+'\n')
commands=(dest/'commands.txt').open('w')
def compile(src,out):
    cmd=[cxx,*flags,str(src),'-o',str(out)]
    commands.write(' '.join(cmd)+'\n');commands.flush()
    subprocess.run(cmd,check=True)
compile('work/ntt/io_explore/bench.cpp',build/'bench')
with (dest/'micro.csv').open('w') as output,(dest/'micro-checks.txt').open('w') as errors:
    subprocess.run([str(build/'bench')]+(['--check'] if sanitize else []),stdout=output,stderr=errors,check=True)
print((dest/'micro-checks.txt').read_text(),flush=True)
if os.getenv('MICRO_ONLY')=='1':sys.exit(0)
compile('work/ntt/yosupo_scalar_reference.cpp',build/'reference')
for name in names:
    compile(build/(name+'.cpp'),build/name)
    with (dest/(name+'-checks.txt')).open('w') as log:
        subprocess.run([sys.executable,'work/ntt/verify_yosupo_convolution.py',str(build/name),str(build/'reference')]
            +([] if name=='baseline' else ['--quick']),stdout=log,stderr=subprocess.STDOUT,check=True)
    print(name+': '+(dest/(name+'-checks.txt')).read_text().strip(),flush=True)
# Full-size independent oracle for baseline; exact output equality for every candidate.
rng=random.Random(20260927)
with (dest/'end-to-end.csv').open('w') as raw:
    raw.write('pattern,n,m,variant,iteration,milliseconds\n')
    with tempfile.TemporaryDirectory(dir=build) as tmp:
        tmp=Path(tmp)
        for pattern,n,m in [('uniform_max',1<<19,1<<19),('zero_max',1<<19,1<<19),('mixed_small',513,510)]:
            vals=[0 if pattern=='zero_max' else rng.randrange(998244353) for _ in range(n+m)]
            data=(f'{n} {m}\n'+' '.join(map(str,vals[:n]))+'\n'+' '.join(map(str,vals[n:]))+'\n').encode()
            source=tmp/'input';source.write_bytes(data)
            expected=subprocess.run([str(build/'reference')],input=data,capture_output=True,check=True).stdout.split()
            expected=b' '.join(expected)+b'\n'
            for rep in range(-2,1 if sanitize else 9):
                order=names[rep%len(names):]+names[:rep%len(names)]
                if rep%2:order=order[::-1]
                for name in order:
                    with source.open('rb') as inp,(tmp/'output').open('wb') as out:
                        begin=time.perf_counter_ns()
                        subprocess.run([str(build/name)],stdin=inp,stdout=out,check=True)
                        elapsed=(time.perf_counter_ns()-begin)/1e6
                    assert (tmp/'output').read_bytes()==expected, (name,pattern)
                    if rep>=0:raw.write(f'{pattern},{n},{m},{name},{rep},{elapsed:.6f}\n');raw.flush()
            print('PASS full-size exact output: '+pattern,flush=True)
commands.close()
