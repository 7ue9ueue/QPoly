"""Independent even/odd Karatsuba direct8 leaf experiment.

For y=x*x and y^4=w, compute E=Ae*Be, O=Ao*Bo, M=(Ae+Ao)*(Be+Bo)
in the weighted cyclic-four ring. Then C_even=E+y*O, C_odd=M-E-O.
Two unrelated leaves occupy the two 128-bit halves of each AVX2 register.
"""

VARIANTS = ("h14_karatsuba_pair", "h14_karatsuba_shared")


def _implementation(shared: bool) -> str:
    steps = []
    for i in range(4):
        steps.append(f"""    {{
        V x=_mm256_inserti128_si256(
            _mm256_castsi128_si256(_mm_loadu_si128((const __m128i*)(window[0]+{4-i}))),
            _mm_loadu_si128((const __m128i*)(window[1]+{4-i})),1);
        V y=_mm256_shuffle_epi32(b,{i*0x55});
        e=_mm256_add_epi64(e,_mm256_mul_epu32(x,y));
        o=_mm256_add_epi64(o,_mm256_mul_epu32(odd(x),y));
    }}""")
    products = """        V e=shrink(cyclic4_pair(ae,be,weight),P);
        V o=shrink(cyclic4_pair(ao,bo,weight),P);
        V m=cyclic4_pair(shrink(plus(ae,ao),P),shrink(plus(be,bo),P),weight);
"""
    if shared:
        products = """        const Fixed wrapweight(weight);
        V wae=shrink(wrapweight(ae),P),wao=shrink(wrapweight(ao),P);
        V e=shrink(cyclic4_pair(ae,be,wae),P);
        V o=shrink(cyclic4_pair(ao,bo,wao),P);
        V m=cyclic4_pair(shrink(plus(ae,ao),P),shrink(plus(be,bo),P),shrink(plus(wae,wao),P));
"""
    code = """// Each 128-bit half is an independent canonical length-four polynomial.
// All 16 scalar products per polynomial are accumulated before Montgomery REDC.
// 4*(P-1)^2+(2^32-1)*P < 2*P*2^32, so each result is below 2P.
__attribute__((always_inline)) inline V cyclic4_pair(V a,V b,V weight) {
    alignas(32) U window[2][8];
    V weighted=shrink(Fixed(weight)(a),P);
    _mm_store_si128((__m128i*)window[0],_mm256_castsi256_si128(weighted));
    _mm_store_si128((__m128i*)(window[0]+4),_mm256_castsi256_si128(a));
    _mm_store_si128((__m128i*)window[1],_mm256_extracti128_si256(weighted,1));
    _mm_store_si128((__m128i*)(window[1]+4),_mm256_extracti128_si256(a,1));
    V e=_mm256_setzero_si256(),o=e;
""" + "\n".join(steps) + """
    return reduce(e,o);
}

template<int Batch,int Schedule=0>
__attribute__((always_inline)) inline void leaf(V* a,V* b,const U* weights) {
    static_assert(Batch==4,"Karatsuba leaf batches four independent products");
    const V separate=_mm256_setr_epi32(0,2,4,6,1,3,5,7);
    for(int t=0;t<Batch;t+=2) {
        V ax=_mm256_permutevar8x32_epi32(canonical(a[t]),separate);
        V ay=_mm256_permutevar8x32_epi32(canonical(a[t+1]),separate);
        V bx=_mm256_permutevar8x32_epi32(canonical(b[t]),separate);
        V by=_mm256_permutevar8x32_epi32(canonical(b[t+1]),separate);
        V ae=_mm256_permute2x128_si256(ax,ay,0x20);
        V ao=_mm256_permute2x128_si256(ax,ay,0x31);
        V be=_mm256_permute2x128_si256(bx,by,0x20);
        V bo=_mm256_permute2x128_si256(bx,by,0x31);
        V weight=_mm256_inserti128_si256(
            _mm256_castsi128_si256(_mm_set1_epi32(weights[t])),
            _mm_set1_epi32(weights[t+1]),1);
""" + products + """        // e/o are canonical; m is below 2P. Both recombinations stay <4P.
        V cross=low(minus(minus(plus(m,splat(P2)),e),o));
        V rotated=_mm256_shuffle_epi32(o,0x93); // o3,o0,o1,o2 in each half
        V wrap=Fixed(weight)(rotated);
        rotated=_mm256_blend_epi32(rotated,wrap,0x11);
        V even=low(plus(e,rotated));
        V lo=_mm256_unpacklo_epi32(even,cross);
        V hi=_mm256_unpackhi_epi32(even,cross);
        a[t]=_mm256_permute2x128_si256(lo,hi,0x20);
        a[t+1]=_mm256_permute2x128_si256(lo,hi,0x31);
    }
}

"""
    if shared:
        code = code.replace("V cyclic4_pair(V a,V b,V weight)", "V cyclic4_pair(V a,V b,V weighted)")
        code = code.replace("    V weighted=shrink(Fixed(weight)(a),P);\n", "")
        code = code.replace("        V wrap=Fixed(weight)(rotated);", "        V wrap=packed_mul(rotated,weight); // Only lanes 0 and 4 will be used.")
    return code


def transform(source: str, variant: str) -> str:
    if variant not in VARIANTS:
        raise ValueError(variant)
    start = source.index("template<int Batch,int Schedule=0>\n")
    end = source.index("// RootMode=0:", start)
    return source[:start] + _implementation(variant == "h14_karatsuba_shared") + source[end:]
