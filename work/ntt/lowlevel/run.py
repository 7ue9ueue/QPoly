#!/usr/bin/env python3
from pathlib import Path
import os,sys,subprocess,platform,json,hashlib
root=Path(__file__).resolve().parents[3];os.chdir(root)
out=root/'build/lowlevel';dest=Path(os.getenv('RESULT_DIR','results'));dest.mkdir(parents=True,exist_ok=True)
with (dest/'source-hashes.txt').open('w') as f:subprocess.run([sys.executable,'work/ntt/lowlevel/generate.py'],stdout=f,check=True)
flags=['-std=c++23','-O3','-mavx2','-mbmi','-funroll-loops','-Ibuild/lowlevel','-Iwork/ntt/simd_explore','-Iwork/ntt/lazy_twiddle']
compiler=os.getenv('CXX','g++')
mac=platform.system()=='Darwin'
if mac:
    compiler='clang++';sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
    flags+=['-arch','x86_64','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-Wno-shift-op-parentheses','-Wno-unknown-attributes']
else:
    assert platform.machine()=='x86_64' and 'avx2' in Path('/proc/cpuinfo').read_text()
sanitize=os.getenv('SANITIZE')=='1'
if sanitize:flags+=['-O1','-g','-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer']
extra=json.loads((out/'flags.json').read_text())
with (dest/'flags.txt').open('w') as f:
    for src in sorted(out.glob('*.cpp')):
        opts=extra.get(src.stem,[])
        if mac:opts=[] # GCC-only switches are native experiments.
        cmd=[compiler,*flags,*opts,'-c',str(src),'-o',str(src.with_suffix('.o'))]
        f.write(' '.join(cmd)+'\n');f.flush();subprocess.run(cmd,check=True)
cmd=[compiler,*flags,'work/ntt/simd_explore/bench.cpp',*[str(p) for p in sorted(out.glob('*.o'))],'-o',str(out/'bench')]
subprocess.run(cmd,check=True)
with (dest/'generated-hashes.txt').open('w') as f:
    for p in [*sorted(out.glob('*.cpp')),out/'bench']:
        f.write(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+str(p.relative_to(root))+'\n')
subprocess.run([compiler,*flags,str(out/'arithmetic_check.cc'),'-o',str(out/'arithmetic_check')],check=True)
with (dest/'arithmetic-checks.txt').open('w') as f:subprocess.run([str(out/'arithmetic_check')],stdout=f,check=True)
check=sanitize or os.getenv('CHECK_ONLY')=='1'
with (dest/('correctness.txt' if check else 'timings.csv')).open('w') as f:
    subprocess.run([str(out/'bench')]+(['--check'] if check else []),stdout=f,check=True)
print((dest/('correctness.txt' if check else 'timings.csv')).read_text())
