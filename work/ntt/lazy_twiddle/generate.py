#!/usr/bin/env python3
"""Benchmark controls from previous experiment, plus independently written kernels."""
from pathlib import Path
import subprocess,sys,hashlib
root=Path(__file__).resolve().parents[3]
out=root/'build/lazy_twiddle';out.mkdir(parents=True,exist_ok=True)
# Controls only: no reference text enters kernel.hpp or the eventual AtCoder file.
subprocess.run([sys.executable,str(root/'work/ntt/simd_explore/generate.py')],check=True)
names=['v91','direct8_identity','recursive_identity2','study_v2']
for name in names:
    src=root/'build/simd_explore'/f'{name}.cpp'
    (out/src.name).write_text(src.read_text())
configs={
    'strict_table': (False,False,0,1<<20),
    'lazy_table': (True,False,0,1<<20),
    'twist_table': (True,True,0,1<<20),
    'lazy_incremental': (True,False,1,1<<20),
    'twist_incremental': (True,True,1,1<<20),
    'lazy_tile256': (True,False,1,256),
    'twist_tile256': (True,True,1,256),
    'twist_tile1024': (True,True,1,1024),
    'twist_recursive': (True,True,1,4),
    'lazy_leaf_incremental': (True,False,2,256),
    'lazy_tile64': (True,False,1,64),
    'lazy_tile1024': (True,False,1,1024),
    'lazy_fixed256': (True,False,3,256),
    'lazy_fixed64': (True,False,3,64),
    'lazy_fixed1024': (True,False,3,1024),
    'lazy_fixed_batch2': (True,False,3,256,2),
    'lazy_hybrid_counted': (True,False,2,256,4,1),
    'lazy_hybrid_unroll2': (True,False,2,256,4,2),
    'lazy_inc_counted': (True,False,1,256,4,1),
    'lazy_inc_unroll2': (True,False,1,256,4,2),
    'lazy_hybrid_counted2': (True,False,2,256,2,1),
    'lazy_inc_fused': (True,False,1,256,4,1,True),
    'lazy_hybrid_fused': (True,False,2,256,4,2,True),
}
for name,args in configs.items():
    params=','.join(str(x).lower() for x in args)
    (out/(name+'.cpp')).write_text('#include "common.hpp"\n#include "kernel.hpp"\nnamespace '+name+' {\nvoid invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh) { qpoly_lazy::Kernel<'+params+'>::run(n,a,b,r,ir,s,fresh); }\n}\n')
    names.append(name)
(out/'registry.hpp').write_text('\n'.join(f'namespace {n} {{ void invoke(int,uint32_t*,uint32_t*,uint32_t*,uint32_t*,int&,bool); }}' for n in names)+'\ninline const Entry entries[] = {\n'+''.join(f'{{"{n}",{n}::invoke}},\n' for n in names)+'};\n')
for p in sorted((root/'work/ntt/lazy_twiddle').glob('*')):
    if p.is_file(): print(hashlib.sha256(p.read_bytes()).hexdigest(),p.relative_to(root))
