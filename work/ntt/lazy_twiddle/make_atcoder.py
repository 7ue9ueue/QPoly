#!/usr/bin/env python3
"""Emit a standalone comparison: user's baseline, previous candidate, new own kernels.
No study/fast_ntt*.cpp or third-party NTT implementation is embedded.
"""
from pathlib import Path
import re,hashlib
root=Path(__file__).resolve().parents[3];here=Path(__file__).resolve().parent
def strip(s):return re.sub(r'^#include.*\n|^#pragma.*\n','',s,flags=re.M)
base=(root/'cp/ntt_ver0.91.cpp').read_text().split('namespace KACTL')[0]
base=base[:base.index('struct TimingStats')]+base[base.index('[[gnu::always_inline]]'):]
base=re.sub(r'^.*(?:auto (?:start|end)_|auto start =|auto end =|g_timing\.).*\n','',base,flags=re.M)
base=strip(base)
base+='\nvoid invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh){if(fresh||s==0)reset_roots(r,ir,s);run_test_logic(n,(v8i*)a,(v8i*)b,r,ir,s);}\n'
previous=strip((root/'work/ntt/simd_explore/candidates/direct8_identity.cpp').read_text())
headers=(root/'work/ntt/simd_explore/common.hpp').read_text().replace('#pragma once\n','').replace('#include <sys/mman.h>\n','').replace('#include <bit>\n','')
result='''// Paste this entire file into an AtCoder C++17-or-later Custom Test.
// Empty input runs through 2^20 with five repetitions, fresh roots.
// Optional input: 20 9 2  (max log2, repetitions, mode: 0 fresh / 1 reuse / 2 both).
// Requires x86-64 AVX2/BMI. No external files. Heap-owned aligned storage.
// Independently written candidate kernels; no fast-reference source embedded.
// Baseline source: cp/ntt_ver0.91.cpp, historical commit 31ba0a6 (profiling removed).
// Previous candidate: exploration 002, native-tested commit 7722004.
'''+headers+'''
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi")
#endif
'''
result+='namespace v91 {\n'+base+'}\n'+previous+'\n'+strip((here/'kernel.hpp').read_text())
selected={'lazy_tile256':(True,False,1,256),'lazy_fixed256':(True,False,3,256)}
for name,args in selected.items():
    params=','.join(str(x).lower() for x in args)
    result+=f'\nnamespace {name} {{ void invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh) {{qpoly_lazy::Kernel<{params}>::run(n,a,b,r,ir,s,fresh);}} }}\n'
names=['v91','direct8_identity']+list(selected)
result+='\nconst Entry entries[] = {\n'+''.join(f'{{"{name}",{name}::invoke}},\n' for name in names)+'};\n'
result+=(here/'atcoder_driver.inc').read_text()
out=root/'work/ntt/atcoder_ntt_compare.cpp';out.write_text(result)
print(out.relative_to(root),hashlib.sha256(out.read_bytes()).hexdigest())
