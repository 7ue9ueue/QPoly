#!/usr/bin/env python3
from pathlib import Path
import os,sys,subprocess,platform,hashlib,json
root=Path(__file__).resolve().parents[3];os.chdir(root)
out=root/'build/h14_explore';dest=Path(os.getenv('RESULT_DIR','results'));dest.mkdir(parents=True,exist_ok=True)
with (dest/'source-hashes.txt').open('w') as f:subprocess.run([sys.executable,'work/ntt/h14_explore/generate.py'],stdout=f,check=True)
flags=['-std=gnu++23','-O2','-ftrivial-auto-var-init=zero','-mavx2','-mbmi','-Ibuild/h14_explore','-Iwork/ntt/simd_explore']
compiler=os.getenv('CXX','g++');mac=platform.system()=='Darwin'
if mac:
    compiler='clang++';sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
    flags+=['-O3','-funroll-loops','-arch','x86_64','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-Wno-unknown-attributes','-Wno-shift-op-parentheses']
else:
    assert platform.machine()=='x86_64' and 'avx2' in Path('/proc/cpuinfo').read_text()
    flags+=['-march=skylake','-fmodules','-fconstexpr-depth=1024','-fconstexpr-loop-limit=524288','-fconstexpr-ops-limit=2097152','-pthread','-fopenmp','-DATCODER','-DNOMINMAX','-DONLINE_JUDGE']
sanitize=os.getenv('SANITIZE')=='1'
if sanitize:flags+=['-DH14_SANITIZE','-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
with (dest/'flags.txt').open('w') as f:
 for src in sorted(out.glob('*.cpp')):
    cmd=[compiler,*flags,'-c',str(src),'-o',str(src.with_suffix('.o'))]
    f.write(' '.join(cmd)+'\n');f.flush();subprocess.run(cmd,check=True)
subprocess.run([compiler,*flags,str(out/'bench.cc'),*[str(p) for p in sorted(out.glob('*.o'))],'-o',str(out/'bench')],check=True)
with (dest/'generated-hashes.txt').open('w') as f:
 for p in [*sorted(out.glob('*.cpp')),out/'bench.cc',out/'bench']:
    f.write(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+str(p.relative_to(root))+'\n')
(dest/'manifest.json').write_text((out/'manifest.json').read_text())
subprocess.run([compiler,*flags,'work/ntt/h14_explore/leaf_check.cc','-o',str(out/'leaf_check')],check=True)
with (dest/'leaf-checks.txt').open('w') as f:subprocess.run([str(out/'leaf_check')],stdout=f,check=True)
subprocess.run([compiler,*flags,'work/ntt/h14_explore/radix_check.cc','-o',str(out/'radix_check')],check=True)
with (dest/'radix-checks.txt').open('w') as f:subprocess.run([str(out/'radix_check')],stdout=f,check=True)
for name in ['inverse','multiply']:
 subprocess.run([compiler,*flags,f'work/ntt/h14_explore/{name}_check.cc','-o',str(out/f'{name}_check')],check=True)
 with (dest/f'{name}-checks.txt').open('w') as f:subprocess.run([str(out/f'{name}_check')],stdout=f,check=True)
check=sanitize or os.getenv('CHECK_ONLY')=='1'
filename='correctness.txt' if check else 'timings.csv'
with (dest/filename).open('w') as f:subprocess.run([str(out/'bench')]+(['--check'] if check else []),stdout=f,check=True)
print((dest/filename).read_text())

if not check:
 subprocess.run([compiler,*flags,str(out/'profile.cc'),'-o',str(out/'profile')],check=True)
 with (dest/'profile.csv').open('w') as f:subprocess.run([str(out/'profile')],stdout=f,check=True)
