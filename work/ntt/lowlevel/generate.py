#!/usr/bin/env python3
"""Focused source transformations of our frozen 329dd66 kernel. No reference copying."""
from pathlib import Path
import subprocess,sys,hashlib,json
from extra_transforms import specialize_small,prepack,asm_pair,prepack_shoup,shoup_regular_cursor
root=Path(__file__).resolve().parents[3];here=Path(__file__).resolve().parent
out=root/'build/lowlevel';out.mkdir(parents=True,exist_ok=True)
subprocess.run([sys.executable,str(root/'work/ntt/lazy_twiddle/generate.py')],check=True,stdout=subprocess.DEVNULL)
# Clean generated files so retired variants cannot be accidentally linked.
for p in out.glob('*.cpp'):p.unlink()
for p in out.glob('*.o'):p.unlink()
controls=['v91','study_v2','lazy_inc_fused','lazy_hybrid_fused']
for name in controls:(out/(name+'.cpp')).write_text((root/'build/lazy_twiddle'/(name+'.cpp')).read_text())
base=(here/'starting_kernel.hpp').read_text()
fixed_start=base.index('struct Fixed {');fixed_end=base.index('// r[k]',fixed_start)
fixed_mullo='''struct Fixed {
    V w,wi;
    explicit Fixed(U x):w(splat(x)),wi(splat(x*NI)){}
    explicit Fixed(V x):Fixed(U(_mm256_extract_epi32(x,0))){}
    inline V operator()(V x) const {
        V q=_mm256_mullo_epi32(x,wi);
        V e=_mm256_add_epi64(_mm256_mul_epu32(x,w),_mm256_mul_epu32(q,splat(P)));
        V o=_mm256_add_epi64(_mm256_mul_epu32(odd(x),w),_mm256_mul_epu32(odd(q),splat(P)));
        return _mm256_or_si256(odd(e),o);
    }
};
'''
fixed_shoup='''// w is supplied in Montgomery form. Convert the fixed operand once, retaining
// the existing transform/leaf representation. For x<2^32 and b<P, residue<2P.
struct Fixed {
    V w,wp;
    explicit Fixed(U x) {U b=muls(x,1);w=splat(b);wp=splat(U((W(b)<<32)/P));}
    explicit Fixed(V x):Fixed(U(_mm256_extract_epi32(x,0))){}
    inline V operator()(V x) const {
        V qe=odd(_mm256_mul_epu32(x,wp));
        V qo=_mm256_mul_epu32(odd(x),wp);
        V q=_mm256_blend_epi32(qe,qo,0xaa);
        return minus(_mm256_mullo_epi32(x,w),_mm256_mullo_epi32(q,splat(P)));
    }
};
'''
def asm_accum():
    # Eight accumulators never leave YMM registers during the counted dot loop.
    ops=[f'vpxor %%ymm{i}, %%ymm{i}, %%ymm{i}' for i in range(8)]
    ops+=['mov $8, %[count]','1:']
    for t in range(4):
        ops += [f'vmovdqu {64*t}(%[win]), %%ymm8',f'vpbroadcastd {32*t}(%[coef]), %%ymm9',
                'vpmuludq %%ymm9, %%ymm8, %%ymm10','vpsrlq $32, %%ymm8, %%ymm11',
                f'vpaddq %%ymm10, %%ymm{2*t}, %%ymm{2*t}',
                'vpmuludq %%ymm9, %%ymm11, %%ymm10',f'vpaddq %%ymm10, %%ymm{2*t+1}, %%ymm{2*t+1}']
    ops += ['sub $4, %[win]','add $4, %[coef]','dec %[count]','jnz 1b']
    for t in range(4):ops += [f'vmovdqu %%ymm{2*t}, {32*t}(%[ep])',f'vmovdqu %%ymm{2*t+1}, {32*t}(%[op])']
    strings='\n'.join('        '+json.dumps(s+'\n\t') for s in ops)
    return '''    static_assert(Batch==4);
    const U* wp=window[0]+8;const U* cp=coeff[0];int count;
    // AT&T syntax; all modified pointers are early-clobber read/write operands.
    // All accessed memory and clobbered registers are declared to the compiler.
    asm volatile(
'''+strings+'''
        : [win] "+&r"(wp), [coef] "+&r"(cp), [count] "=&r"(count)
        : [ep] "r"(e), [op] "r"(o)
        : "cc","memory",'''+','.join('"ymm'+str(i)+'"' for i in range(12))+''');
'''

def transform(name,changes):
    s=base.replace('namespace qpoly_lazy {','namespace '+name+' {')
    if 'mullo' in changes:s=s[:s.index('struct Fixed {')]+fixed_mullo+s[s.index('// r[k]'):]
    if 'shoup' in changes:s=s[:s.index('struct Fixed {')]+fixed_shoup+s[s.index('// r[k]'):]
    if 'restrict' in changes:
        s=s.replace('V* a,V* b','V* __restrict__ a,V* __restrict__ b').replace('V* f,int h','V* __restrict__ f,int h')
        s=s.replace('U* aa,U* bb,U* r,U* ir','U* __restrict__ aa,U* __restrict__ bb,U* __restrict__ r,U* __restrict__ ir')
    if 'static' in changes:
        s=s.replace('namespace '+name+' {','namespace '+name+' { namespace {')+'\n}\n'
    if 'scratch' in changes:
        s=s.replace('alignas(32) U window','alignas(32) static U window')
    if 'inline' in changes:
        s=s.replace('inline void radix4','__attribute__((always_inline)) inline void radix4')
        s=s.replace('inline void leaf(','__attribute__((always_inline)) inline void leaf(')
        s=s.replace('inline void group(','__attribute__((always_inline)) inline void group(')
    if 'hot' in changes:s=s.replace('void visit(','__attribute__((hot)) void visit(')
    if 'noinline' in changes:s=s.replace('inline void leaf(','__attribute__((noinline)) inline void leaf(')
    if 'nounroll' in changes:s=s.replace('    for(int j=0;j<h;++j) {','    #pragma GCC unroll 1\n    for(int j=0;j<h;++j) {')
    if 'prefetch' in changes:
        s=s.replace('    for(int j=0;j<h;++j) {','    for(int j=0;j<h;++j) {\n        if(j+8<h)for(int p=0;p<4;++p)__builtin_prefetch(f+j+8+p*h,0,3);')
    if 'asm' in changes:
        start=s.index('    auto step =');end=s.index('    for(int t=0;t<Batch;++t)a[t]',start)
        s=s[:start]+asm_accum()+s[end:]
    if 'split' in changes:
        s=s.replace('V e[Batch],o[Batch];','V e[Batch],o[Batch];\n    alignas(32) W expanded[Batch][16];')
        s=s.replace('    auto step =','    for(int t=0;t<Batch;++t)for(int i=0;i<16;++i)expanded[t][i]=window[t][i];\n    auto step =')
        s=s.replace('V x=_mm256_loadu_si256((V*)(window[t]+8-i)),y=splat(coeff[t][i]);','V x=_mm256_loadu_si256((V*)(expanded[t]+8-i)),y=splat(coeff[t][i]);\n            V z=_mm256_loadu_si256((V*)(expanded[t]+9-i));')
        # Expanded consecutive values do NOT give alternating coefficient indices.
        # Use the doubled window with even and odd lanes interleaved via two vectors.
        s=s.replace('V x=_mm256_loadu_si256((V*)(expanded[t]+8-i)),y=splat(coeff[t][i]);\n            V z=_mm256_loadu_si256((V*)(expanded[t]+9-i));',
        'V lo=_mm256_loadu_si256((V*)(expanded[t]+8-i)),hi=_mm256_loadu_si256((V*)(expanded[t]+12-i));\n            V x=_mm256_permute4x64_epi64(_mm256_unpacklo_epi64(lo,hi),0xd8),z=_mm256_permute4x64_epi64(_mm256_unpackhi_epi64(lo,hi),0xd8),y=splat(coeff[t][i]);')
        s=s.replace('_mm256_mul_epu32(odd(x),y));','_mm256_mul_epu32(z,y));')
    if 'asm_pair' in changes:s=asm_pair(s)
    if 'h1' in changes:s=specialize_small(s,(1,))
    if 'h14' in changes:s=specialize_small(s,(1,4))
    if 'prepack' in changes:s=prepack(s)
    if 'prepack_shoup' in changes:s=prepack_shoup(s)
    if 'regular_cursor' in changes:s=shoup_regular_cursor(s)
    if 'mont_leaf' in changes:
        original_fixed=base[fixed_start:fixed_end].replace('Fixed','MontFixed')
        s=s.replace('// r[k]',original_fixed+'// r[k]',1)
        s=s.replace('V x=canonical(a[t]); Fixed w(weights[t]);','V x=canonical(a[t]); MontFixed w(weights[t]);')
    return s
# Each tuple: root mode, leaf schedule, source changes, optional compiler flags.
configs={
 'll_static':(2,2,['static'],[]),
 'll_scratch':(2,2,['scratch'],[]),
 'll_restrict':(2,2,['restrict'],[]),
 'll_inline':(2,2,['inline'],[]),
 'll_hot':(2,2,['hot'],[]),
 'll_noinline':(2,2,['noinline'],[]),
 'll_nounroll':(2,2,['nounroll'],[]),
 'll_align64':(2,2,[],['-falign-functions=64','-falign-loops=32']),
 'll_tune':(2,2,[],['-mtune=native']),
 'll_prefetch':(2,2,['prefetch'],[]),
 'll_mullo':(2,2,['mullo'],[]),
 'll_shoup':(2,2,['shoup'],[]),
 'll_asm':(2,2,['asm'],[]),
 'll_asm_inc':(1,1,['asm'],[]),
 'll_split':(2,1,['split'],[]),
 'll_shoup_inline':(2,2,['shoup','inline'],[]),
 'll_shoup_inc':(1,1,['shoup','inline'],[]),
 'll_shoup_cursor':(1,1,['shoup','inline','regular_cursor'],[]),
 'll_shoup_montleaf':(2,2,['shoup','inline','mont_leaf'],[]),
 'll_inline_scratch':(2,2,['inline','scratch'],[]),
 'll_inline_inc':(1,1,['inline'],[]),
 'll_inline_h1':(2,2,['inline','h1'],[]),
 'll_inline_h14':(2,2,['inline','h14'],[]),
 'll_shoup_h1':(2,2,['shoup','inline','h1'],[]),
 'll_prepack':(2,2,['prepack','inline'],[]),
 'll_shoup_prepack':(2,2,['shoup','prepack_shoup','inline'],[]),
 'll_asm_pair':(2,2,['asm','asm_pair'],[]),
 'll_asm_pair_inline':(2,2,['asm','asm_pair','inline'],[]),
 'll_asm_shoup':(2,2,['asm','asm_pair','shoup','inline'],[]),
}
names=controls[:]
flags={}
for name,(mode,schedule,changes,options) in configs.items():
    s=transform('kernel_'+name,changes)
    s='#include "common.hpp"\n'+s.replace('#pragma once\n','')
    s+=f'\nnamespace {name} {{void invoke(int n,uint32_t*a,uint32_t*b,uint32_t*r,uint32_t*ir,int&s,bool fresh){{kernel_{name}::Kernel<true,false,{mode},256,4,{schedule},true>::run(n,a,b,r,ir,s,fresh);}}}}\n'
    (out/(name+'.cpp')).write_text(s);names.append(name);flags[name]=options
(out/'flags.json').write_text(json.dumps(flags,indent=2))
(out/'registry.hpp').write_text('\n'.join(f'namespace {n} {{ void invoke(int,uint32_t*,uint32_t*,uint32_t*,uint32_t*,int&,bool); }}' for n in names)+'\ninline const Entry entries[] = {\n'+''.join(f'{{"{n}",{n}::invoke}},\n' for n in names)+'};\n')
for p in sorted(here.glob('*')):
    if p.is_file():print(hashlib.sha256(p.read_bytes()).hexdigest(),p.relative_to(root))
