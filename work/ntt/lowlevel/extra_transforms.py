"""Second-round transformations, kept separate from the frozen starting kernel."""
def specialize_small(s, sizes=(1,)):
    start=s.index('        Twiddle t=twiddle<Inv>(h,k);')
    end=s.index('\n    inline void leaves',start)
    body=s[start:end]
    assert body.endswith('    }')
    body=body[:-5]
    branches=''
    for h in sizes:
        b=body.replace('twiddle<Inv>(h,k)',f'twiddle<Inv>({h},k)').replace('(a,h,t)',f'(a,{h},t)').replace('(b,h,t)',f'(b,{h},t)')
        branches+=f'        if(h=={h}){{\n'+b+'\n            return;\n        }\n'
    return s[:start]+branches+s[start:]

def prepack(s):
    # Each table element becomes one 64-bit word: Montgomery root + low correction.
    # Uses exactly twice the old hybrid scratch and preserves root_size units.
    start=s.index('    static void tables(');end=s.index('    template<bool Inv>',start)
    s=s[:start]+'''    static void tables(int count,U* r,U* ir,int& size,bool fresh) {
        auto put=[](U* dst,int i,U x){dst[2*i]=x;dst[2*i+1]=x*NI;};
        if(fresh||size==0){put(r,0,ONE);put(ir,0,ONE);size=1;}
        for(int h=size;h<count;h*=2){
            int level=__builtin_ctz(unsigned(h));
            for(int j=0;j<h;++j){put(r,h+j,muls(r[2*j],constants.q[level]));put(ir,h+j,muls(ir[2*j],constants.iq[level]));}
        }
        size=std::max(size,count);
    }
'''+s[end:]
    s=s.replace('explicit Fixed(V x):w(x),wi(_mm256_mul_epu32(x,splat(NI))){}','explicit Fixed(V x):w(x),wi(_mm256_mul_epu32(x,splat(NI))){}\n    Fixed(V value,V correction):w(value),wi(correction){}')
    s=s.replace('struct Twiddle { Fixed x,y,z;', 'struct Twiddle { Fixed x,y,z; Twiddle(V a,V b,V c,int):x(a,odd(a)),y(b,odd(b)),z(c,odd(c)){}')
    old='const U* r=Inv?irt:rt;U x=r[k],y=r[2*k],z=Twist?muls(x,y):r[2*k+1];\n            return Twiddle(splat(x),splat(y),splat(z));'
    new='const U* r=Inv?irt:rt; auto fetch=[&](int i){return _mm256_broadcastq_epi64(_mm_loadl_epi64((const __m128i*)(r+2*i)));};\n            return Twiddle(fetch(k),fetch(2*k),fetch(2*k+1),0);'
    assert old in s;s=s.replace(old,new)
    return s

def asm_pair(s):
    # Schedule two leaves together using four temporaries beyond the accumulators.
    start=s.index('    static_assert(Batch==4);');end=s.index('    for(int t=0;t<Batch;++t)a[t]',start)
    import json
    ops=[f'vpxor %%ymm{i}, %%ymm{i}, %%ymm{i}' for i in range(8)]
    ops+=['mov $8, %[count]','.p2align 5','1:']
    for t in (0,2):
        ops += [f'vmovdqu {64*t}(%[win]), %%ymm8',f'vmovdqu {64*(t+1)}(%[win]), %%ymm9',f'vpbroadcastd {32*t}(%[coef]), %%ymm10',f'vpbroadcastd {32*(t+1)}(%[coef]), %%ymm11',
                'vpmuludq %%ymm10, %%ymm8, %%ymm12','vpmuludq %%ymm11, %%ymm9, %%ymm13',
                'vpsrlq $32, %%ymm8, %%ymm8','vpsrlq $32, %%ymm9, %%ymm9',
                'vpmuludq %%ymm10, %%ymm8, %%ymm14','vpmuludq %%ymm11, %%ymm9, %%ymm15',
                f'vpaddq %%ymm12, %%ymm{2*t}, %%ymm{2*t}',f'vpaddq %%ymm13, %%ymm{2*t+2}, %%ymm{2*t+2}',
                f'vpaddq %%ymm14, %%ymm{2*t+1}, %%ymm{2*t+1}',f'vpaddq %%ymm15, %%ymm{2*t+3}, %%ymm{2*t+3}']
    ops += ['sub $4, %[win]','add $4, %[coef]','dec %[count]','jnz 1b']
    for t in range(4):ops += [f'vmovdqu %%ymm{2*t}, {32*t}(%[ep])',f'vmovdqu %%ymm{2*t+1}, {32*t}(%[op])']
    block='''    static_assert(Batch==4);
    const U* wp=window[0]+8;const U* cp=coeff[0];int count;
    asm volatile(
'''+ '\n'.join('        '+json.dumps(x+'\n\t') for x in ops)+'''
        : [win] "+&r"(wp), [coef] "+&r"(cp), [count] "=&r"(count)
        : [ep] "r"(e), [op] "r"(o)
        : "cc","memory",'''+','.join('"ymm'+str(i)+'"' for i in range(16))+''');
'''
    return s[:start]+block+s[end:]

def prepack_shoup(s):
    start=s.index('    static void tables(');end=s.index('    template<bool Inv>',start)
    s=s[:start]+'''    static void tables(int count,U* r,U* ir,int& size,bool fresh) {
        auto put=[](U* dst,int i,U x){dst[2*i]=x;dst[2*i+1]=U((W(x)<<32)/P);};
        if(fresh||size==0){put(r,0,1);put(ir,0,1);size=1;}
        for(int h=size;h<count;h*=2){
            int level=__builtin_ctz(unsigned(h));
            for(int j=0;j<h;++j){put(r,h+j,muls(r[2*j],constants.q[level]));put(ir,h+j,muls(ir[2*j],constants.iq[level]));}
        }
        size=std::max(size,count);
    }
'''+s[end:]
    s=s.replace('V w,wp;','V w,wp;\n    Fixed(V value,V quotient):w(_mm256_shuffle_epi32(value,0xa0)),wp(_mm256_shuffle_epi32(quotient,0xa0)){}')
    s=s.replace('struct Twiddle { Fixed x,y,z;', 'struct Twiddle { Fixed x,y,z; Twiddle(V a,V b,V c,int):x(a,odd(a)),y(b,odd(b)),z(c,odd(c)){}')
    old='const U* r=Inv?irt:rt;U x=r[k],y=r[2*k],z=Twist?muls(x,y):r[2*k+1];\n            return Twiddle(splat(x),splat(y),splat(z));'
    new='const U* r=Inv?irt:rt; auto fetch=[&](int i){return _mm256_broadcastq_epi64(_mm_loadl_epi64((const __m128i*)(r+2*i)));};\n            return Twiddle(fetch(k),fetch(2*k),fetch(2*k+1),0);'
    assert old in s;return s.replace(old,new)

def shoup_regular_cursor(s):
    s=s.replace('explicit Fixed(V x):Fixed(U(_mm256_extract_epi32(x,0))){}',
                'explicit Fixed(V x){U b=U(_mm256_extract_epi32(x,0));w=splat(b);wp=splat(U((W(b)<<32)/P));}')
    s=s.replace('_mm256_setr_epi64x(ONE,ONE,Twist?ONE:constants.q[0],ONE)',
                '_mm256_setr_epi64x(1,1,Twist?1:muls(constants.q[0],1),1)')
    s=s.replace('_mm256_setr_epi64x(ONE,ONE,Twist?ONE:constants.iq[0],ONE)',
                '_mm256_setr_epi64x(1,1,Twist?1:muls(constants.iq[0],1),1)')
    return s
