#!/usr/bin/env python3
"""Independent continuation of ll_inline_h14; previous baseline stays frozen."""
from pathlib import Path
import hashlib,os,json
root=Path(__file__).resolve().parents[3];here=Path(__file__).resolve().parent
out=root/'build/h14_explore';out.mkdir(parents=True,exist_ok=True)
base=(here/'baseline.hpp').read_text()
def own(s,name):
    if name in ['h14_noautozero','h14_splitacc_nozero']:
        s=s.replace('U window[Batch][16],coeff[Batch][8];','U window[Batch][16] __attribute__((uninitialized)),coeff[Batch][8] __attribute__((uninitialized));')
        s=s.replace('V e[Batch],o[Batch];','V e[Batch] __attribute__((uninitialized)),o[Batch] __attribute__((uninitialized));')
    if name=='h14_oddshuffle':
        s=s.replace('inline V odd(V x) { return _mm256_srli_epi64(x,32); }','inline V odd(V x) { return _mm256_shuffle_epi32(x,0xf5); }')
        # odd() is also used to zero high words during Montgomery packing; retain
        # logical shifts there. Only replace the operand extraction in Fixed.
        s=base.replace('_mm256_mul_epu32(odd(x),w)','_mm256_mul_epu32(_mm256_shuffle_epi32(x,0xf5),w)').replace('_mm256_mul_epu32(odd(x),wi)','_mm256_mul_epu32(_mm256_shuffle_epi32(x,0xf5),wi)')
    if name in ['h14_splitacc','h14_splitacc_nozero']:
        # Two interleaved accumulation chains per leaf expose more ILP; final
        # combined sums keep the same 8-product bound. May exceed register budget.
        s=s.replace('V e[Batch],o[Batch];','V e[Batch],o[Batch];')
        s=s.replace('    auto step =', '    V e2[Batch]{},o2[Batch]{};\n    auto step =')
        old='''            e[t]=_mm256_add_epi64(e[t],_mm256_mul_epu32(x,y));
            o[t]=_mm256_add_epi64(o[t],_mm256_mul_epu32(odd(x),y));'''
        new='''            if(i&1){e2[t]=_mm256_add_epi64(e2[t],_mm256_mul_epu32(x,y));o2[t]=_mm256_add_epi64(o2[t],_mm256_mul_epu32(odd(x),y));}
            else{e[t]=_mm256_add_epi64(e[t],_mm256_mul_epu32(x,y));o[t]=_mm256_add_epi64(o[t],_mm256_mul_epu32(odd(x),y));}'''
        assert old in s;s=s.replace(old,new)
        s=s.replace('a[t]=low(reduce(e[t],o[t]));','a[t]=low(reduce(_mm256_add_epi64(e[t],e2[t]),_mm256_add_epi64(o[t],o2[t])));')
    return s
configs={
 'll_inline_h14': ('own',None,'true,false,2,256,4,2,true'),
 'h14_noautozero':('own','h14_noautozero','true,false,2,256,4,2,true'),
 'h14_oddshuffle':('own','h14_oddshuffle','true,false,2,256,4,2,true'),
 'h14_splitacc':('own','h14_splitacc','true,false,2,256,4,2,true'),
 'h14_splitacc_nozero':('own','h14_splitacc_nozero','true,false,2,256,4,2,true'),
 'h14_leaf1':('own',None,'true,false,2,256,4,1,true'),
 'h14_tile64':('own',None,'true,false,2,64,4,2,true'),
 'h14_tile1024':('own',None,'true,false,2,1024,4,2,true'),
}
# Other agents add modules only; variant registration is explicit below.
if (here/'asm_transforms.py').exists():
    from asm_transforms import transform as asm_transform,VARIANTS as asm_names
    for name in asm_names:configs[name]=('asm',name,'true,false,2,256,4,2,true')
if (here/'stage_transforms.py').exists():
    from stage_transforms import transform as stage_transform,VARIANTS as stage_names
    for name in stage_names:configs[name]=('stage',name,'true,false,2,256,4,2,true')
from radix_asm_transforms import transform as radix_transform,VARIANTS as radix_names
from pairmul_transforms import transform as pairmul_transform,VARIANTS as pairmul_names
from inverse_asm_transforms import transform as inverse_transform,VARIANTS as inverse_names
from forward_transforms import transform as forward_transform,VARIANTS as forward_names
from multiply_transforms import transform as multiply_transform,VARIANTS as multiply_names
from karatsuba_transforms import transform as karatsuba_transform,VARIANTS as karatsuba_names
for name in radix_names:configs[name]=('radix',name,'true,false,2,256,4,2,true')
for name in pairmul_names:configs[name]=('pairmul',name,'true,false,2,256,4,2,true')
for kind,names in [('inverse',inverse_names),('forward',forward_names),('multiply',multiply_names),('karatsuba',karatsuba_names)]:
    for name in names:configs[name]=(kind,name,'true,false,2,256,4,2,true')
for name in ['asm_inverse_pair_large','asm_both_pair','asm_both_pair_large']:
    configs[name]=('inverse_combo',name,'true,false,2,256,4,2,true')
for name in ['h14_mullo_fixed','h14_mullo_bottom']:
    configs[name]=('multiply_combo',name,'true,false,2,256,4,2,true')
for name in ['asm_radix4_serial_large','asm_radix4_pair_large','asm_radix4_pair_leaf','asm_radix4_pair_fixed','asm_radix4_pair_large_fixed']:
    configs[name]=('combo',name,'true,false,2,256,4,2,true')
def combined(s,name):
    variant='asm_radix4_serial' if name.startswith('asm_radix4_serial') else 'asm_radix4_pair'
    s=radix_transform(s,variant)
    if 'large' in name:
        s=s.replace('        radix4_forward_asm(f,h,t);\n        return;','        if(h>4){radix4_forward_asm(f,h,t);return;}')
    if name.endswith('_leaf'):s=asm_transform(s,'asm_leaf_inplace')
    if name.endswith('_fixed'):s=stage_transform(s,'h14_fixed_bottom')
    return s
def inverse_combined(s,name):
    s=inverse_transform(s,'asm_inverse_pair')
    if name.startswith('asm_both'):s=radix_transform(s,'asm_radix4_pair')
    if name.endswith('_large'):
        for direction in ['forward','inverse']:
            s=s.replace(f'        radix4_{direction}_asm(f,h,t);\n        return;',f'        if(h>4){{radix4_{direction}_asm(f,h,t);return;}}')
    return s
selected=set(os.environ.get('SELECT_VARIANTS','').split(','))-{''}
assert selected<=set(configs),f'Unknown variants: {selected-set(configs)}'
for p in out.glob('*.cpp'):p.unlink()
for p in out.glob('*.o'):p.unlink()
# Optional baseline controls use only own prior deliverable, never fast reference.
old=(root/'work/ntt/atcoder_ntt_lowlevel_compare.cpp').read_text()
a=old.index('namespace v91 {');b=old.index('namespace direct8_identity',a)
v91=old[a:b]
prolog='#include "common.hpp"\n#if defined(__GNUC__) && !defined(__clang__) && !defined(H14_SANITIZE)\n#pragma GCC optimize("O3,unroll-loops")\n#pragma GCC target("avx2,bmi")\n#endif\n'
(out/'v91.cpp').write_text(prolog+v91)
names=['v91']
for name,(kind,opt,args) in configs.items():
    if selected and name!='ll_inline_h14' and name not in selected:continue
    s=base
    if kind=='own' and opt:s=own(s,opt)
    elif kind=='asm':s=asm_transform(s,opt)
    elif kind=='stage':s=stage_transform(s,opt)
    elif kind=='radix':s=radix_transform(s,opt)
    elif kind=='pairmul':s=pairmul_transform(s,opt)
    elif kind=='combo':s=combined(s,opt)
    elif kind=='inverse':s=inverse_transform(s,opt)
    elif kind=='inverse_combo':s=inverse_combined(s,opt)
    elif kind=='forward':s=forward_transform(s,opt)
    elif kind=='multiply':s=multiply_transform(s,opt)
    elif kind=='karatsuba':s=karatsuba_transform(s,opt)
    elif kind=='multiply_combo':
        s=multiply_transform(s,'h14_mont_mullo')
        s=stage_transform(s,'h14_fixed_bottom' if opt.endswith('_bottom') else 'h14_fixed_tile')
    s=s.replace('#pragma once\n','').replace('namespace qpoly_h14_base {',f'namespace kernel_{name} {{')
    s+=f'\nnamespace {name} {{void invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh){{kernel_{name}::Kernel<{args}>::run(n,a,b,r,ir,s,fresh);}}}}\n'
    (out/(name+'.cpp')).write_text(prolog+s);names.append(name)
checks=out/'checks';checks.mkdir(exist_ok=True)
if (here/'asm_transforms.py').exists():
    for name in asm_names:
        s=asm_transform(base,name).replace('#pragma once\n','').replace('namespace qpoly_h14_base {',f'namespace kernel_{name} {{')
        (checks/(name+'.cpp')).write_text(prolog+s)
for name in ['asm_baseline',*radix_names,*inverse_names,*multiply_names,*karatsuba_names]:
    s=base
    if name in radix_names:s=radix_transform(s,name)
    elif name in inverse_names:s=inverse_transform(s,name)
    elif name in multiply_names:s=multiply_transform(s,name)
    elif name in karatsuba_names:s=karatsuba_transform(s,name)
    s=s.replace('#pragma once\n','').replace('namespace qpoly_h14_base {',f'namespace kernel_{name} {{')
    (checks/(name+'.cpp')).write_text(prolog+s)
(out/'registry.hpp').write_text('\n'.join(f'namespace {n} {{void invoke(int,uint32_t*,uint32_t*,uint32_t*,uint32_t*,int&,bool);}}' for n in names)+'\ninline const Entry entries[]={\n'+''.join(f'{{"{n}",{n}::invoke}},\n' for n in names)+'};\n')
from profile import source as profile_source,DRIVER as profile_driver
(out/'profile.cc').write_text(prolog+base.replace('#pragma once\n','')+profile_source(base)+profile_driver)
(out/'manifest.json').write_text(json.dumps({'variants':names,'configurations':configs},indent=2))
# Canonical equality strengthens the shared reference check for this new suite.
bench=(root/'work/ntt/simd_explore/bench.cpp').read_text().replace('a.p[i]%P!=want[i]','a.p[i]!=want[i]')
(out/'bench.cc').write_text(bench)
for p in sorted(here.glob('*')):
    if p.is_file():print(hashlib.sha256(p.read_bytes()).hexdigest(),p.relative_to(root))
