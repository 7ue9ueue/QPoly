#!/usr/bin/env python3
"""Single-file continuation; only own kernels and original user's baselines."""
from pathlib import Path
import re,sys,subprocess,hashlib
root=Path(__file__).resolve().parents[3]
# Preserve the verified prior deliverable. Its prefix has all required headers,
# baseline, direct8 and lazy candidate definitions, with no study-reference NTT.
previous=(root/'work/ntt/atcoder_ntt_compare.cpp').read_text()
prefix=previous[:previous.index('const Entry entries[] = {')]
selected=sys.argv[1:] or ['ll_inline_h14','ll_shoup_cursor','ll_shoup_prepack','ll_shoup_wide_cursor']
subprocess.run([sys.executable,str(root/'work/ntt/lowlevel/generate.py')],check=True,stdout=subprocess.DEVNULL)
for name in selected:
    src=(root/'build/lowlevel'/(name+'.cpp')).read_text()
    assert name.startswith('ll_')
    prefix+='\n'+re.sub(r'^#include.*\n|^#pragma once.*\n','',src,flags=re.M)
names=['v91','lazy_inc_fused','lazy_hybrid_fused']+selected
prefix+='\nconst Entry entries[] = {\n'+''.join(f'{{"{n}",{n}::invoke}},\n' for n in names)+'};\n'
prefix+=(root/'work/ntt/lazy_twiddle/atcoder_driver.inc').read_text()
prefix='// Low-level follow-up comparison; original verified comparison preserved separately.\n'+prefix
prefix='\n'.join(line.rstrip() for line in prefix.splitlines())+'\n'
out=root/'work/ntt/atcoder_ntt_lowlevel_compare.cpp';out.write_text(prefix)
print(hashlib.sha256(out.read_bytes()).hexdigest(),out.relative_to(root))
