"""Montgomery instruction-selection ablations, retaining the exact representation.

No reference kernel is used. mullo computes eight low correction words with one
vpmulld, replacing two vpmuludq. Instruction count is not a throughput guarantee.
shiftmod uses P=2^30-2^26-2^23+1 to exchange multiply pressure for ALU work.
"""
VARIANTS=('h14_mont_mullo','h14_mont_shiftmod')

def transform(s,name):
    assert name in VARIANTS
    start=s.index('    inline V operator()(V x) const {')
    end=s.index('\n    }',start)+len('\n    }')
    if name=='h14_mont_mullo':
        # The vector constructor originally retains unused high product halves.
        # Replicate its low correction word into both 32-bit lanes of each pair.
        old='wi(_mm256_mul_epu32(x,splat(NI)))'
        assert s.count(old)==1
        s=s.replace(old,'wi(_mm256_shuffle_epi32(_mm256_mul_epu32(x,splat(NI)),0xa0))')
        start=s.index('    inline V operator()(V x) const {');end=s.index('\n    }',start)+len('\n    }')
        new='''    inline V operator()(V x) const {
        V e=_mm256_mul_epu32(x,w),o=_mm256_mul_epu32(odd(x),w);
        V q=_mm256_mullo_epi32(x,wi);
        e=_mm256_add_epi64(e,_mm256_mul_epu32(q,splat(P)));
        o=_mm256_add_epi64(o,_mm256_mul_epu32(odd(q),splat(P)));
        return _mm256_or_si256(odd(e),o);
    }'''
    else:
        new='''    inline V operator()(V x) const {
        auto times_mod=[](V q){
            q=_mm256_and_si256(q,_mm256_set1_epi64x(UINT32_MAX));
            V r=_mm256_sub_epi64(_mm256_slli_epi64(q,30),_mm256_slli_epi64(q,26));
            r=_mm256_sub_epi64(r,_mm256_slli_epi64(q,23));
            return _mm256_add_epi64(r,q);
        };
        V e=_mm256_mul_epu32(x,w),o=_mm256_mul_epu32(odd(x),w);
        e=_mm256_add_epi64(e,times_mod(_mm256_mul_epu32(x,wi)));
        o=_mm256_add_epi64(o,times_mod(_mm256_mul_epu32(odd(x),wi)));
        return _mm256_or_si256(odd(e),o);
    }'''
    return s[:start]+new+s[end:]
