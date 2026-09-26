// Inspired by the partial-transform strategy already present in study/fast_ntt_v2.cpp.
// After the large stages, leaf j represents a product modulo x^8 - rt[j]^2.
// Canonicalize before accumulating: eight products plus the Montgomery correction
// are <= 8*(P-1)^2 + (2^32-1)*P < 2^64 for P=998244353.
// The reduced sum is <3P; a subtraction of 2P restores the outer butterfly range.
template<int Batch>
inline void direct8(v8i* a, v8i* b, int first, const u32* roots) {
    alignas(32) u32 window[Batch][16];
    alignas(32) u32 coeff[Batch][8];
    v8i even[Batch], odd[Batch];
    for(int t=0;t<Batch;++t) {
        u32 w=mont_mul(roots[first+t],roots[first+t]);
        v8i x=_mm256_mod(a[t]);
        v8i wrapped=_mm256_mod(_mm256_mont_mul_fixed(x,_mm256_set1_epi32(w),_mm256_set1_epi32(w*M_INV)));
        _mm256_store_si256((v8i*)window[t],wrapped);
        _mm256_store_si256((v8i*)(window[t]+8),x);
        _mm256_store_si256((v8i*)coeff[t],_mm256_mod(b[t]));
        even[t]=odd[t]=_mm256_setzero_si256();
    }
    for(int i=0;i<8;++i) {
        for(int t=0;t<Batch;++t) {
            v8i x=_mm256_loadu_si256((const v8i*)(window[t]+8-i));
            v8i y=_mm256_set1_epi32(coeff[t][i]);
            even[t]=_mm256_add_epi64(even[t],_mm256_mul_epu32(x,y));
            odd[t]=_mm256_add_epi64(odd[t],_mm256_mul_epu32(lmove(x),y));
        }
    }
    for(int t=0;t<Batch;++t) {
        v8i x=reduce(even[t],odd[t]);
        a[t]=_mm256_min_epu32(x,_mm256_sub_epi32(x,v_wmod));
    }
}
