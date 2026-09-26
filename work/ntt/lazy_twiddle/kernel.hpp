#pragma once
#include <immintrin.h>
#include <cstdint>
#include <algorithm>
#include <cassert>

// Independently written continuation of QPoly's Montgomery / partial-NTT work.
// Starting point: kactl_bench.cpp and simd_explore/direct8.inc, commit 1e5a80f.
// No study/reference implementation is included in or copied into this kernel.
namespace qpoly_lazy {
using U=uint32_t; using W=uint64_t; using V=__m256i;
constexpr U P=998244353, P2=2*P, NI=998244351, R2=932051910;
constexpr U muls(U a,U b) {
    W x=W(a)*b; U c=U(x)*NI; U z=(x+W(c)*P)>>32;
    return z>=P?z-P:z;
}
constexpr U power(U a,U e) { U r=1; for(;e;e>>=1,a=W(a)*a%P) if(e&1)r=W(r)*a%P;return r; }
constexpr U mont(U a) { return muls(a,R2); }
constexpr U ONE=mont(1);
inline V splat(U x) { return _mm256_set1_epi32(x); }
inline V plus(V x,V y) { return _mm256_add_epi32(x,y); }
inline V minus(V x,V y) { return _mm256_sub_epi32(x,y); }
inline V shrink(V x,U p) { return _mm256_min_epu32(x,minus(x,splat(p))); }
inline V low(V x) { return shrink(x,P2); }
inline V canonical(V x) { return shrink(low(x),P); }
inline V diff(V x,V y) { return minus(plus(x,splat(P2)),y); }
inline V odd(V x) { return _mm256_srli_epi64(x,32); }
// As in the user's Montgomery kernel, operate on even/odd lanes independently.
inline V reduce(V e,V o) {
    V m=splat(NI),p=splat(P);
    e=_mm256_add_epi64(e,_mm256_mul_epu32(_mm256_mul_epu32(e,m),p));
    o=_mm256_add_epi64(o,_mm256_mul_epu32(_mm256_mul_epu32(o,m),p));
    return _mm256_or_si256(odd(e),o);
}
struct Fixed {
    V w,wi;
    explicit Fixed(U x):w(splat(x)),wi(splat(x*NI)){}
    explicit Fixed(V x):w(x),wi(_mm256_mul_epu32(x,splat(NI))){}
    // x<4P, w<P => x*w + correction < 2^64 and result <2P.
    inline V operator()(V x) const {
        V e=_mm256_mul_epu32(x,w),o=_mm256_mul_epu32(odd(x),w);
        e=_mm256_add_epi64(e,_mm256_mul_epu32(_mm256_mul_epu32(x,wi),splat(P)));
        o=_mm256_add_epi64(o,_mm256_mul_epu32(_mm256_mul_epu32(odd(x),wi),splat(P)));
        return _mm256_or_si256(odd(e),o);
    }
};

// r[k] = product(q[b] for each set bit b of k), q[b]=3^((P-1)/2^(b+2)).
// Incrementing k clears t low bits and sets bit t; delta=q[t]/prod(q[0:t]).
// The radix-4 group uses x=r[k], y=r[2k], z=I*y (or x*y for twisted inputs).
struct Constants {
    U q[22]{},iq[22]{},step[22]{},istep[22]{},even_step[21]{},ieven_step[21]{};
    alignas(32) W rates[2][2][21][4]{};
    alignas(32) W fixed_rates[2][2][21][4]{};
    constexpr Constants() {
        q[21]=mont(power(3,(P-1)>>23)); iq[21]=mont(power(power(3,(P-1)>>23),P-2));
        for(int j=20;j>=0;--j) {q[j]=muls(q[j+1],q[j+1]);iq[j]=muls(iq[j+1],iq[j+1]);}
        U a=ONE,b=ONE,c=ONE,d=ONE;
        for(int j=0;j<22;++j) {
            step[j]=muls(q[j],a);istep[j]=muls(iq[j],b);
            a=muls(a,iq[j]);b=muls(b,q[j]);
            if(j<21) {
                even_step[j]=muls(q[j+1],c);ieven_step[j]=muls(iq[j+1],d);
                c=muls(c,iq[j+1]);d=muls(d,q[j+1]);
                for(int inverse=0;inverse<2;++inverse) for(int twist=0;twist<2;++twist) {
                    U x=inverse?istep[j]:step[j], y=inverse?ieven_step[j]:even_step[j];
                    rates[inverse][twist][j][0]=x; rates[inverse][twist][j][1]=y;
                    rates[inverse][twist][j][2]=twist?muls(x,y):y;rates[inverse][twist][j][3]=ONE;
                    for(int lane=0;lane<4;++lane) {
                        U value=U(rates[inverse][twist][j][lane]);
                        fixed_rates[inverse][twist][j][lane]=W(value)|(W(value*NI)<<32);
                    }
                }
            }
        }
    }
};
inline constexpr Constants constants{};
inline V packed_mul(V x,V y) {
    V t=_mm256_mul_epu32(x,y);
    V c=_mm256_mul_epu32(_mm256_mul_epu32(t,splat(NI)),splat(P));
    return shrink(_mm256_srli_epi64(_mm256_add_epi64(t,c),32),P);
}
inline V packed_mul_fixed(V x,V rate) {
    V product=_mm256_mul_epu32(x,rate);
    V correction=_mm256_mul_epu32(_mm256_mul_epu32(x,odd(rate)),splat(P));
    return shrink(_mm256_srli_epi64(_mm256_add_epi64(product,correction),32),P);
}
struct Twiddle { Fixed x,y,z; Twiddle(V a,V b,V c):x(a),y(b),z(c){} };

// Lazy=false is an ablation that keeps all butterfly values below 2P.
// Lazy=true: forward loads/stores <4P, inverse loads/stores <2P.
// Twist=true distributes w,w^2,w^3 onto inputs to expose independent multiplies.
template<bool Lazy,bool Twist,bool Identity,bool Inverse>
inline void radix4(V* f,int h,const Twiddle& t) {
    const Fixed imag(Inverse?constants.iq[0]:constants.q[0]);
    for(int j=0;j<h;++j) {
        V a=f[j],b=f[j+h],c=f[j+2*h],d=f[j+3*h];
        V o0,o1,o2,o3;
        if constexpr(!Inverse) {
            if constexpr(Lazy) a=low(a);
            if constexpr(Twist) {
                if constexpr(Identity) {if constexpr(Lazy) {b=low(b);c=low(c);d=low(d);}}
                else {b=t.y(b);c=t.x(c);d=t.z(d);}
                V ac=low(plus(a,c)), amc=low(diff(a,c));
                V bd=low(plus(b,d)), bmd=imag(Lazy?diff(b,d):low(diff(b,d)));
                o0=plus(ac,bd);o1=diff(ac,bd);o2=plus(amc,bmd);o3=diff(amc,bmd);
            } else {
                if constexpr(Lazy) b=low(b);
                if constexpr(Identity) {if constexpr(Lazy) {c=low(c);d=low(d);}}
                else {c=t.x(c);d=t.x(d);}
                V ac=low(plus(a,c)), amc=low(diff(a,c));
                V bd=plus(b,d), bmd=diff(b,d);
                if constexpr(!Lazy) {bd=low(bd);bmd=low(bmd);}
                if constexpr(Identity) bd=low(bd); else bd=t.y(bd);
                bmd=t.z(bmd);
                o0=plus(ac,bd);o1=diff(ac,bd);o2=plus(amc,bmd);o3=diff(amc,bmd);
            }
            if constexpr(!Lazy) {o0=low(o0);o1=low(o1);o2=low(o2);o3=low(o3);}
        } else {
            V ab=low(plus(a,b)),cd=low(plus(c,d));
            V amb=diff(a,b),cmd=diff(c,d);
            if constexpr(!Lazy) {amb=low(amb);cmd=low(cmd);}
            if constexpr(Twist) {
                amb=low(amb);cmd=imag(cmd);
                o0=low(plus(ab,cd));o1=plus(amb,cmd);o2=diff(ab,cd);o3=diff(amb,cmd);
                if constexpr(!Lazy) {o1=low(o1);o2=low(o2);o3=low(o3);}
                if constexpr(Identity) {o1=low(o1);o2=low(o2);o3=low(o3);}
                else {o1=t.y(o1);o2=t.x(o2);o3=t.z(o3);}
            } else {
                if constexpr(Identity) amb=low(amb);else amb=t.y(amb);
                cmd=t.z(cmd);
                o0=low(plus(ab,cd));o1=low(plus(amb,cmd));o2=diff(ab,cd);o3=diff(amb,cmd);
                if constexpr(!Lazy) {o2=low(o2);o3=low(o3);}
                if constexpr(Identity) {o2=low(o2);o3=low(o3);}else {o2=t.x(o2);o3=t.x(o3);}
            }
        }
        f[j]=o0;f[j+h]=o1;f[j+2*h]=o2;f[j+3*h]=o3;
    }
}

// Own direct8 method from exploration 002, with explicit incoming [0,4P) handling.
// Sum bound: 8*(P-1)^2+(2^32-1)*P <2^64. Reduce output <3P to <2P.
template<int Batch>
inline void leaf(V* a,V* b,const U* weights) {
    alignas(32) U window[Batch][16],coeff[Batch][8];
    V e[Batch],o[Batch];
    for(int t=0;t<Batch;++t) {
        V x=canonical(a[t]); Fixed w(weights[t]);
        _mm256_store_si256((V*)window[t],shrink(w(x),P));
        _mm256_store_si256((V*)(window[t]+8),x);
        _mm256_store_si256((V*)coeff[t],canonical(b[t]));
        e[t]=o[t]=_mm256_setzero_si256();
    }
    for(int i=0;i<8;++i) for(int t=0;t<Batch;++t) {
        V x=_mm256_loadu_si256((V*)(window[t]+8-i)),y=splat(coeff[t][i]);
        e[t]=_mm256_add_epi64(e[t],_mm256_mul_epu32(x,y));
        o[t]=_mm256_add_epi64(o[t],_mm256_mul_epu32(odd(x),y));
    }
    for(int t=0;t<Batch;++t)a[t]=low(reduce(e[t],o[t]));
}

// RootMode=0: O(N) root tables. RootMode=1: packed incremental per-stage cursors,
// and a scalar cursor for batches of four leaf factors. Tile is in AVX2 vectors.
template<bool Lazy,bool Twist,int RootMode,int Tile,int LeafBatch=4>
struct Kernel {
    U *rt,*irt;
    V forward[12],inverse[12]; U leaf_cursor=ONE;
    Kernel(U* r,U* ir):rt(r),irt(ir) {
        for(int i=0;i<12;++i) {
            forward[i]=_mm256_setr_epi64x(ONE,ONE,Twist?ONE:constants.q[0],ONE);
            inverse[i]=_mm256_setr_epi64x(ONE,ONE,Twist?ONE:constants.iq[0],ONE);
        }
    }
    static void tables(int count,U* r,U* ir,int& size,bool fresh) {
        if(fresh||size==0) {r[0]=ir[0]=ONE;size=1;}
        for(int h=size;h<count;h*=2) {
            int s=__builtin_ctz(unsigned(h)); Fixed a(constants.q[s]),b(constants.iq[s]);
            if(h>=8) for(int j=0;j<h;j+=8) {
                _mm256_store_si256((V*)(r+h+j),shrink(a(_mm256_load_si256((V*)(r+j))),P));
                _mm256_store_si256((V*)(ir+h+j),shrink(b(_mm256_load_si256((V*)(ir+j))),P));
            } else for(int j=0;j<h;++j) {r[h+j]=muls(r[j],constants.q[s]);ir[h+j]=muls(ir[j],constants.iq[s]);}
        }
        size=std::max(size,count);
    }
    template<bool Inv>
    inline Twiddle twiddle(int h,int k) {
        if constexpr(RootMode==0 || RootMode==2) {
            const U* r=Inv?irt:rt;U x=r[k],y=r[2*k],z=Twist?muls(x,y):r[2*k+1];
            return Twiddle(splat(x),splat(y),splat(z));
        } else {
            int level=__builtin_ctz(unsigned(h))/2;
            V& cursor=Inv?inverse[level]:forward[level]; V current=cursor;
            int carry=__builtin_ctz(~unsigned(k));
            if constexpr(RootMode==3) {
                V step=_mm256_load_si256((const V*)constants.fixed_rates[Inv][Twist][carry]);
                cursor=packed_mul_fixed(current,step);
            } else {
                V step=_mm256_load_si256((const V*)constants.rates[Inv][Twist][carry]);
                cursor=packed_mul(current,step);
            }
            return Twiddle(_mm256_permute4x64_epi64(current,0x00),_mm256_permute4x64_epi64(current,0x55),_mm256_permute4x64_epi64(current,0xaa));
        }
    }
    template<bool Inv>
    inline void group(V* a,V* b,int h,int k) {
        Twiddle t=twiddle<Inv>(h,k);
        if(k==0) {
            radix4<Lazy,Twist,true,Inv>(a,h,t);
            if constexpr(!Inv)radix4<Lazy,Twist,true,false>(b,h,t);
        } else {
            radix4<Lazy,Twist,false,Inv>(a,h,t);
            if constexpr(!Inv)radix4<Lazy,Twist,false,false>(b,h,t);
        }
    }
    inline void leaves(V* a,V* b,int nv,int first) {
        for(int j=0;j<nv;j+=4) {
            U w[4];
            if constexpr(RootMode==0)for(int t=0;t<4;++t)w[t]=muls(rt[first+j+t],rt[first+j+t]);
            else {
                w[0]=leaf_cursor;w[1]=P-w[0];w[2]=muls(w[0],constants.q[0]);w[3]=P-w[2];
                int carry=__builtin_ctz(~unsigned((first+j)/4));
                leaf_cursor=muls(leaf_cursor,constants.even_step[carry]);
            }
            if constexpr(LeafBatch==2) {leaf<2>(a+j,b+j,w);leaf<2>(a+j+2,b+j+2,w+2);}
            else leaf<4>(a+j,b+j,w);
        }
    }
    void visit(V* a,V* b,int nv,int k) {
        if(nv<=Tile) {
            for(int h=nv/4;h;h/=4)for(int j=0;j<nv;j+=4*h)group<false>(a+j,b+j,h,k*(nv/(4*h))+j/(4*h));
            leaves(a,b,nv,k*nv);
            for(int h=1;h<nv;h*=4)for(int j=0;j<nv;j+=4*h)group<true>(a+j,nullptr,h,k*(nv/(4*h))+j/(4*h));
        } else {
            int h=nv/4;group<false>(a,b,h,k);
            for(int t=0;t<4;++t)visit(a+t*h,b+t*h,h,4*k+t);
            group<true>(a,nullptr,h,k);
        }
    }
    static void run(int n,U* aa,U* bb,U* r,U* ir,int& size,bool fresh) {
        assert(n>=64 && n<=(1<<22) && (n&(n-1))==0);
        if constexpr(RootMode==0 || RootMode==2)tables(n/(RootMode==2?16:8),r,ir,size,fresh);
        Kernel job(r,ir);V* a=(V*)aa;V* b=(V*)bb;int nv=n/8;
        if(__builtin_ctz(unsigned(nv))&1) {
            int h=nv/2;
            for(int i=0;i<h;++i) {
                V x=a[i],y=a[i+h];a[i]=low(plus(x,y));a[i+h]=low(diff(x,y));
                x=b[i];y=b[i+h];b[i]=low(plus(x,y));b[i+h]=low(diff(x,y));
            }
            job.visit(a,b,h,0);job.visit(a+h,b+h,h,1);
            for(int i=0;i<h;++i) {V x=a[i],y=a[i+h];a[i]=low(plus(x,y));a[i+h]=low(diff(x,y));}
        } else job.visit(a,b,nv,0);
        Fixed scale(mont(mont(power(nv,P-2))));
        for(int i=0;i<nv;++i)a[i]=shrink(scale(a[i]),P);
    }
};
}
