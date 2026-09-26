#include "common.hpp"
#include "registry.hpp"
using U = uint32_t;
using V = std::vector<U>;
constexpr U P = 998244353;
U power(U a, U e) { U r=1; for(;e;e>>=1,a=uint64_t(a)*a%P) if(e&1) r=uint64_t(r)*a%P; return r; }
// Independent ordinary radix-2 NTT with explicit bit reversal and % reduction.
void reference_ntt(V& a, bool inv) {
    int n=a.size();
    for(int i=1,j=0;i<n;++i) { int b=n/2; for(;j&b;b>>=1) j^=b; j^=b; if(i<j) std::swap(a[i],a[j]); }
    for(int len=2;len<=n;len*=2) {
        U w=power(3,(P-1)/len); if(inv) w=power(w,P-2);
        for(int i=0;i<n;i+=len) { U x=1; for(int j=0;j<len/2;++j) {
            U u=a[i+j],v=uint64_t(a[i+j+len/2])*x%P;
            a[i+j]=(u+v)%P; a[i+j+len/2]=(u+P-v)%P; x=uint64_t(x)*w%P;
        } }
    }
    if(inv) { U z=power(n,P-2); for(auto& x:a) x=uint64_t(x)*z%P; }
}
V reference(V a,V b) { reference_ntt(a,false); reference_ntt(b,false); for(size_t i=0;i<a.size();++i) a[i]=uint64_t(a[i])*b[i]%P; reference_ntt(a,true); return a; }
V brute(const V& a,const V& b) { V c(a.size()); for(size_t i=0;i<a.size();++i) for(size_t j=0;j<b.size();++j) c[(i+j)%a.size()]=(c[(i+j)%a.size()]+uint64_t(a[i])*b[j])%P; return c; }
struct Buffer {
    U* p; size_t n;
    explicit Buffer(size_t n):p((U*)_mm_malloc((n+16)*4,64)),n(n) { if(!p) throw std::bad_alloc(); std::fill(p,p+n+16,0); guard(); }
    ~Buffer() { _mm_free(p); }
    Buffer(const Buffer&)=delete;
    void guard() { std::fill(p+n,p+n+16,0xa5a5a5a5); }
    bool intact() const { return std::all_of(p+n,p+n+16,[](U x){return x==0xa5a5a5a5;}); }
};
[[noreturn]] void fail(const char* name,int n,size_t i,U got,U want) { std::cerr<<"FAIL "<<name<<" n="<<n<<" i="<<i<<" got="<<got<<" want="<<want<<std::endl; std::exit(1); }
volatile uint64_t checksum=0;
void check(const Entry& e, const V& x, const V& y, const V& want, Buffer& a,Buffer& b,Buffer& r,Buffer& ir,int& rs,bool fresh) {
    int n=x.size(); std::copy(x.begin(),x.end(),a.p); std::copy(y.begin(),y.end(),b.p);
    e.fn(n,a.p,b.p,r.p,ir.p,rs,fresh);
    for(int i=0;i<n;++i) if(a.p[i]%P!=want[i]) fail(e.name,n,i,a.p[i],want[i]);
    if(!a.intact()||!b.intact()||!r.intact()||!ir.intact()) fail(e.name,n,n,0,1);
}
int main(int argc,char**argv) {
    bool only_check=argc>1 && std::string(argv[1])=="--check";
    std::cout<<std::unitbuf;
    std::mt19937 rng(0xC0FFEE);
    // Every power through the largest timed size, odd/even log sizes, and boundaries.
    for(int lg=6;lg<=22;++lg) {
        int n=1<<lg; Buffer a(n),b(n),r(n),ir(n);
        for(int pattern=0;pattern<(lg<=10?6:1);++pattern) {
            V x(n),y(n);
            for(int i=0;i<n;++i) {
                x[i]=rng()%P; y[i]=rng()%P;
                if(pattern==1) x[i]=y[i]=P-1;
                if(pattern==2) x[i]=0;
                if(pattern==3) x[i]=(i==n-1),y[i]=(i==1?P-1:0);
                if(pattern==4) x[i]=i&1?P-1:0,y[i]=i&1?1:P-1;
                if(pattern==5) x[i]=y[i]=1;
            }
            V want=reference(x,y);
            if(n<=256 && want!=brute(x,y)) fail("scalar-vs-brute",n,0,0,1);
            for(const auto&e:entries) { int rs=0; check(e,x,y,want,a,b,r,ir,rs,true); check(e,x,y,want,a,b,r,ir,rs,false); }
        }
        std::cout<<"PASS log2="<<lg<<" all variants fresh/repeated\n";
    }
    // Reuse growing tables and then shrink the requested length.
    for(const auto&e:entries) {
        Buffer a(8192),b(8192),r(8192),ir(8192); int rs=0;
        for(int n:{64,256,128,8192,512,4096,64}) {
            V x(n),y(n); for(auto&v:x)v=rng()%P; for(auto&v:y)v=rng()%P;
            check(e,x,y,reference(x,y),a,b,r,ir,rs,false);
        }
    }
    std::cout<<"PASS changing sizes\n";
    // Maximum-range products at scale, plus an impulse crossing the cyclic boundary.
    for(int lg:{16,20,22}) {
        int n=1<<lg; Buffer a(n),b(n),r(n),ir(n);
        V x(n,P-1),y(n,P-1),want(n,U(n)%P);
        for(const auto&e:entries) { int rs=0; check(e,x,y,want,a,b,r,ir,rs,true); }
        std::fill(x.begin(),x.end(),0); x[n-1]=P-1;
        for(int i=0;i<n;++i)y[i]=rng()%P;
        for(int i=0;i<n;++i)want[i]=(P-y[(i+1)%n])%P;
        for(const auto&e:entries) { int rs=0; check(e,x,y,want,a,b,r,ir,rs,true); }
    }
    std::cout<<"PASS large coefficient boundaries\n";
    if(only_check) return 0;
    std::cout<<"variant,mode,log2,repeat,microseconds,checksum\n";
    for(int lg:{12,16,18,19,20,21,22}) {
        int n=1<<lg; Buffer a(n),b(n),r(n),ir(n); V x(n),y(n);
        for(auto&v:x)v=rng()%P; for(auto&v:y)v=rng()%P;
        for(bool fresh:{true,false}) {
            constexpr int count=sizeof(entries)/sizeof(entries[0]);
            for(int rep=-2;rep<9;++rep) {
                // Rotating/reversing order keeps identical inputs and reduces order bias.
                for(int q=0;q<count;++q) {
                    int idx=(q+(rep+2)*3)%count; if(rep&1) idx=count-1-idx;
                    const auto&e=entries[idx]; int rs=0;
                    // Reused-root mode primes the exact implementation before timing.
                    if(!fresh) { std::copy(x.begin(),x.end(),a.p);std::copy(y.begin(),y.end(),b.p);e.fn(n,a.p,b.p,r.p,ir.p,rs,true); }
                    std::copy(x.begin(),x.end(),a.p); std::copy(y.begin(),y.end(),b.p);
                    auto t=std::chrono::steady_clock::now();
                    e.fn(n,a.p,b.p,r.p,ir.p,rs,fresh);
                    auto end=std::chrono::steady_clock::now();
                    uint64_t sum=0;for(int i=0;i<n;++i) sum=sum*31+a.p[i]%P;checksum=sum;
                    if(rep>=0) std::cout<<e.name<<','<<(fresh?"fresh":"reuse")<<','<<lg<<','<<rep<<','<<std::chrono::duration<double,std::micro>(end-t).count()<<','<<sum<<'\n';
                }
            }
        }
    }
}
