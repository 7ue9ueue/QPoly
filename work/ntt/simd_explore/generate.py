#!/usr/bin/env python3
"""Extract local historical kernels, then generate focused experimental variants.

Starting revision 31ba0a6; study snapshots were untracked at experiment start.
No external source code is downloaded. See README.md for provenance/assumptions.
"""
from pathlib import Path
import re
import hashlib

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
OUT = ROOT / 'build/simd_explore'
OUT.mkdir(parents=True, exist_ok=True)

def clean(s):
    return re.sub(r'^#include.*\n|^#pragma GCC.*\n', '', s, flags=re.M)

def source(path, end):
    p = ROOT / path
    s = p.read_text()
    print(path, hashlib.sha256(p.read_bytes()).hexdigest())
    return clean(s[:s.index(end)])

v91 = source('cp/ntt_ver0.91.cpp', 'namespace KACTL')
# Remove profiling only; retain the arithmetic and scheduling of the historical kernel.
v91 = v91[:v91.index('struct TimingStats')] + v91[v91.index('[[gnu::always_inline]]'):]
v91 = re.sub(r'^.*(?:auto (?:start|end)_|auto start =|auto end =|g_timing\.).*\n', '', v91, flags=re.M)
base = source('kactl_bench.cpp', 'namespace KACTL')
record2 = source('study/fast_ntt_v2.cpp', 'struct auto_timer')
# Portable spelling in an unused allocation-size helper (libc++ has no std::__lg).
record2 = record2.replace('std::__lg(x-1)', '(std::bit_width(x-1)-1)')
record3 = source('study/fast_ntt_v3.cpp', '#include <sys/mman.h>')

def function_body(s, name):
    start = s.index('{', s.index(name+'('))
    level = 1
    end = start + 1
    while level:
        level += (s[end] == '{') - (s[end] == '}')
        end += 1
    return s[start+1:end-1]

def codelet(direction, sizes):
    bodies = []
    for size in sizes:
        body = function_body(base, f'butterfly_{direction}_size{size}')
        # Preserve root-shuffle constants outside the original loop.
        prefix = body[:body.index('for (')]
        loop = body[body.index('{', body.index('for ('))+1:body.rfind('}')]
        loop = loop.replace('v8i v_f = f[j];', '').replace('f[j] =', 'v_f =')
        loop = re.sub(r'\bk\b', 'j', loop)
        bodies.append('{'+prefix+loop+'}')
    roots = 'rt' if direction == 'dif' else 'irt'
    return f'inline v8i {direction}8(v8i v_f, int j, const uint32_t* {roots}) {{\n'+ '\n'.join(bodies)+'\nreturn v_f;\n}\n'

codelets = codelet('dif', [4,2,1]) + codelet('dit', [1,2,4])
fwd = '\n'.join('    butterfly_dif_size%d(f, n8, rt);'%i for i in [4,2,1])
inv = '\n'.join('    butterfly_dit_size%d(f, n8, irt);'%i for i in [1,2,4])
assert fwd in base and inv in base
fused = base.replace('void dif_ntt(', codelets+'\nvoid dif_ntt(', 1)
fused = fused.replace(fwd, '    for (int j=0; j<n8; ++j) f[j] = dif8(f[j], j, rt);')
fused = fused.replace(inv, '    for (int j=0; j<n8; ++j) f[j] = dit8(f[j], j, irt);')
pipe = fused.replace('    for (int j=0; j<n8; ++j) f[j] = dif8(f[j], j, rt);', '')
pipe = pipe.replace('    for (int j=0; j<n8; ++j) f[j] = dit8(f[j], j, irt);', '')
pipe = pipe.replace('A[i] = _mm256_mont_mul_pointwise(A[i], B[i]);', 'A[i] = dit8(_mm256_mont_mul_pointwise(dif8(A[i], i, roots), dif8(B[i], i, roots)), i, inv_roots);')
half = pipe.replace('root_size, L);', 'root_size, L / 2);')

variants = {'v91': v91, 'kactl_simd': base, 'fused8': fused, 'pipeline8': pipe, 'halfroots': half}
variants['recursive'] = half + (HERE / 'recursive.inc').read_text()
# The odd-log outer radix-2 stage uses root[0] == Montgomery(1).
trivial = half.replace('butterfly_dif_radix2(f + j, f + j + h8, h8, v_rt, v_rt_inv);',
    'for(int p=0;p<h8;++p) { v8i u=f[j+p], v=f[j+h8+p]; f[j+p]=_mm256_add_mod(u,v); f[j+h8+p]=_mm256_sub_mod(u,v); }')
trivial = trivial.replace('butterfly_dit_radix2(f + j, f + j + i8, i8, v_irt, v_irt_inv);',
    'for(int p=0;p<i8;++p) { v8i u=f[j+p], v=f[j+i8+p]; f[j+p]=_mm256_add_mod(u,v); f[j+i8+p]=_mm256_sub_mod(u,v); }')
variants['trivial_top'] = trivial
for batch in [1,4]:
    direct = trivial.replace('void dif_ntt(', (HERE / 'direct8.inc').read_text()+'\nvoid dif_ntt(', 1)
    direct = direct.replace('root_size, L / 2);', 'root_size, L / 8);')
    direct = direct.replace('inv_mod(n)', 'inv_mod(n / 8)')
    old = 'for (int i = 0; i < L8; ++i) {\n        A[i] = dit8(_mm256_mont_mul_pointwise(dif8(A[i], i, roots), dif8(B[i], i, roots)), i, inv_roots);\n    }'
    assert old in direct
    direct = direct.replace(old, f'for(int i=0;i<L8;i+={batch}) direct8<{batch}>(A+i,B+i,i,roots);')
    variants[f'direct8_b{batch}'] = direct
recursive_direct = (HERE / 'recursive.inc').read_text()
recursive_direct = recursive_direct.replace('a[0] = dit8(_mm256_mont_mul_pointwise(dif8(a[0], k, rt), dif8(b[0], k, rt)), k, irt);', 'direct8<1>(a,b,k,rt);')
recursive_direct = recursive_direct.replace('for(int t=0;t<4;++t) visit(a+t*h,b+t*h,h,4*k+t,rt,irt);', 'if(h==1) direct8<4>(a,b,4*k,rt); else for(int t=0;t<4;++t) visit(a+t*h,b+t*h,h,4*k+t,rt,irt);')
recursive_direct = recursive_direct.replace('rs,n/2', 'rs,n/8').replace('inv_mod(n)', 'inv_mod(n/8)')
variants['recursive_direct8'] = half + (HERE / 'direct8.inc').read_text() + recursive_direct

# Copy the local fast-reference algorithms into generated translation units.
variants['study_v2'] = record2
variants['study_v3'] = record3
# Vary the reference's cache traversal threshold, expressed in 8-coefficient vectors.
for threshold in [4,8,10]:
    variants[f'study_v2_t{threshold}'] = record2.replace('_lg_iter_thresold=6', f'_lg_iter_thresold={threshold}')

for name, src in variants.items():
    if name.startswith('study_v2'):
        setup = 'inline constexpr NTT_interal::NTT32_info plan(998244353);'
        call = 'plan._vec_dif((I256*)a,n/8); plan._vec_dif((I256*)b,n/8); plan._vec_cvdt8((I256*)a,(I256*)b,n/8); plan._vec_dit((I256*)a,n/8);'
        # The original global RNG is unrelated to NTT and nondeterministic.
        src = re.sub(r'^std::mt19937_64 rng.*\n', '', src, flags=re.M)
    elif name == 'study_v3':
        setup = 'static const NTT plan(998244353);'
        call = 'plan.convolve_cyclic(__builtin_ctz(n),a,b);'
    else:
        setup = ''
        func = 'run_test_logic' if name == 'v91' else ('run_recursive' if name.startswith('recursive') else 'run_simd_convolution')
        call = f'if(fresh || rs==0) reset_roots(r,ir,rs); {func}(n,(v8i*)a,(v8i*)b,r,ir,rs);'
    wrapper = f'\n{setup}\nvoid invoke(int n, uint32_t* a, uint32_t* b, uint32_t* r, uint32_t* ir, int& rs, bool fresh) {{ {call} }}\n'
    (OUT / (name+'.cpp')).write_text('#include "common.hpp"\nnamespace '+name+' {\n'+src+wrapper+'}\n')

(OUT / 'registry.hpp').write_text('\n'.join(f'namespace {n} {{ void invoke(int,uint32_t*,uint32_t*,uint32_t*,uint32_t*,int&,bool); }}' for n in variants)+'\ninline const Entry entries[] = {\n'+ ''.join(f'{{"{n}", {n}::invoke}},\n' for n in variants)+'};\n')
