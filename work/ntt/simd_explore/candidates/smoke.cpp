#include "api.hpp"
#include <immintrin.h>
#include <algorithm>
#include <iostream>
#include <random>
#include <vector>
constexpr uint32_t p=998244353;
struct Aligned {
    uint32_t* v;
    explicit Aligned(int n):v((uint32_t*)_mm_malloc(n*4,32)) { if(!v) throw std::bad_alloc(); }
    ~Aligned(){_mm_free(v);}
};
int main() {
    std::mt19937 rng(725);
    for(auto fn:{direct8_identity::invoke,recursive_identity2::invoke}) {
        for(int n:{64,128,256,1024,1<<20}) {
            Aligned a(n),b(n),r(n/8),ir(n/8); int rs=0;
            for(int trial=0;trial<3;++trial) {
                std::vector<uint32_t> x(n),y(n),want(n);
                for(int i=0;i<n;++i) x[i]=n<=256&&trial? rng()%p:p-1,y[i]=n<=256&&trial?rng()%p:p-1;
                if(n<=256) for(int i=0;i<n;++i) for(int j=0;j<n;++j) want[(i+j)%n]=(want[(i+j)%n]+uint64_t(x[i])*y[j])%p;
                else std::fill(want.begin(),want.end(),n);
                std::copy(x.begin(),x.end(),a.v);std::copy(y.begin(),y.end(),b.v);
                fn(n,a.v,b.v,r.v,ir.v,rs,trial==0);
                if(!std::equal(want.begin(),want.end(),a.v)) { std::cerr<<"FAIL n="<<n<<'\n';return 1; }
            }
        }
    }
    std::cout<<"PASS frozen candidates: canonical output, exact N/8 root buffers, fresh/reuse, random brute-force and large maxima\n";
}
