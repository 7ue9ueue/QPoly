#!/usr/bin/env python3
"""Build the next self-contained comparison, retaining an exact h14 control."""
from pathlib import Path
import os,sys,subprocess,re,hashlib
root=Path(__file__).resolve().parents[3];here=Path(__file__).resolve().parent
selected=sys.argv[1:] or ['h14_fixed_tile','asm_radix4_pair_large_fixed','h14_mont_mullo','h14_mullo_fixed','h14_mullo_bottom','h14_karatsuba_shared']
env=os.environ.copy();env['SELECT_VARIANTS']=','.join(selected)
subprocess.run([sys.executable,str(here/'generate.py')],env=env,check=True,stdout=subprocess.DEVNULL)
headers=(root/'work/ntt/simd_explore/common.hpp').read_text().replace('#pragma once\n','').replace('#include <sys/mman.h>\n','').replace('#include <bit>\n','')
s='''// Self-contained h14 continuation. C++17 or later, x86-64 AVX2/BMI.
// Empty input: max_log2=20, five repetitions, fresh roots.
// Optional: 20 10 0 (maximum log2, repetitions, mode 0=fresh/1=reuse/2=both).
// Baseline: ll_inline_h14, original tested source 50908bb.
// Independently written kernels; no study/reference NTT source is included.
'''+headers+'#include <cpuid.h>\n'
s+='''#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi")
#endif
'''
names=['ll_inline_h14','v91']+selected
for name in names:
 src=(root/'build/h14_explore'/(name+'.cpp')).read_text()
 # Generated source only has a short pragma prologue plus ordinary includes.
 src=re.sub(r'#if defined\(__GNUC__\).*?#endif\n','',src,flags=re.S,count=1)
 src=re.sub(r'^#include.*\n|^#pragma once.*\n','',src,flags=re.M)
 s+=src+'\n'
s+='const Entry entries[]={\n'+''.join(f'{{"{n}",{n}::invoke}},\n' for n in names)+'};\n'
s+='''void print_cpu(){
    unsigned r[4];char brand[49]{};
    if(__get_cpuid_max(0x80000000,nullptr)>=0x80000004){
        for(unsigned i=0;i<3;++i){__cpuid(0x80000002+i,r[0],r[1],r[2],r[3]);std::memcpy(brand+16*i,r,16);}
        std::cout<<"CPU: "<<brand<<'\\n';
    }else std::cout<<"CPU: brand unavailable\\n";
    if(__get_cpuid_max(0,nullptr)>=7){__cpuid_count(7,0,r[0],r[1],r[2],r[3]);std::cout<<"CPU feature bits: avx2="<<((r[1]>>5)&1)<<" bmi1="<<((r[1]>>3)&1)<<" avx512f="<<((r[1]>>16)&1)<<'\\n';}
    std::cout<<"Comparison baseline: ll_inline_h14; instruction sources use AVX2/BMI.\\n";
}
'''
driver=(root/'work/ntt/lazy_twiddle/atcoder_driver.inc').read_text().replace('speedup_vs_v91','speedup_vs_h14').replace('    comparison::correctness(max_log);','    print_cpu();\n    comparison::correctness(max_log);')
s=s.replace('Comparison baseline: ll_inline_h14;', 'Suite: h14-20260927. Comparison baseline: ll_inline_h14;')
s+=driver
s='\n'.join(x.rstrip() for x in s.splitlines())+'\n'
p=root/'work/ntt/atcoder_ntt_h14_compare.cpp';p.write_text(s)
print(hashlib.sha256(p.read_bytes()).hexdigest(),p.relative_to(root))
