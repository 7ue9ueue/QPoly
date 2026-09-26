// Cache-local paired traversal of the existing radix-4 butterflies.
// k is the global block number at this level, so the original root layout applies.
void visit(v8i* a, v8i* b, int nv, int k, const u32* rt, const u32* irt) {
    if (nv == 1) {
        a[0] = dit8(_mm256_mont_mul_pointwise(dif8(a[0], k, rt), dif8(b[0], k, rt)), k, irt);
        return;
    }
    if (__builtin_ctz(nv) & 1) {
        // This branch only occurs at the root; subsequent levels are radix 4.
        int h=nv/2;
        v8i w=_mm256_set1_epi32(rt[k]), wi=_mm256_set1_epi32(rt[k]*M_INV);
        butterfly_dif_radix2(a,a+h,h,w,wi);
        butterfly_dif_radix2(b,b+h,h,w,wi);
        visit(a,b,h,2*k,rt,irt); visit(a+h,b+h,h,2*k+1,rt,irt);
        w=_mm256_set1_epi32(irt[k]); wi=_mm256_set1_epi32(irt[k]*M_INV);
        butterfly_dit_radix2(a,a+h,h,w,wi);
        return;
    }
    int h=nv/4;
    v8i x=_mm256_set1_epi32(rt[k]),y=_mm256_set1_epi32(rt[2*k]),z=_mm256_set1_epi32(rt[2*k+1]);
    v8i xi=_mm256_set1_epi32(rt[k]*M_INV),yi=_mm256_set1_epi32(rt[2*k]*M_INV),zi=_mm256_set1_epi32(rt[2*k+1]*M_INV);
    butterfly_dif_radix4(a,a+h,a+2*h,a+3*h,h,x,y,z,xi,yi,zi);
    butterfly_dif_radix4(b,b+h,b+2*h,b+3*h,h,x,y,z,xi,yi,zi);
    for(int t=0;t<4;++t) visit(a+t*h,b+t*h,h,4*k+t,rt,irt);
    x=_mm256_set1_epi32(irt[k]); y=_mm256_set1_epi32(irt[2*k]); z=_mm256_set1_epi32(irt[2*k+1]);
    xi=_mm256_set1_epi32(irt[k]*M_INV); yi=_mm256_set1_epi32(irt[2*k]*M_INV); zi=_mm256_set1_epi32(irt[2*k+1]*M_INV);
    butterfly_dit_radix4(a,a+h,a+2*h,a+3*h,h,x,y,z,xi,yi,zi);
}
void run_recursive(int n,v8i*a,v8i*b,u32*rt,u32*irt,int&rs) {
    get_root_mont(rt,irt,rs,n/2);
    visit(a,b,n/8,0,rt,irt);
    u32 scale=to_mont(to_mont(inv_mod(n)));
    v8i w=_mm256_set1_epi32(scale),wi=_mm256_set1_epi32(scale*M_INV);
    for(int j=0;j<n/8;++j) a[j]=_mm256_mod(_mm256_mont_mul_fixed(a[j],w,wi));
}
