#define solve solve_baseline
#include "baseline.cpp"
#undef solve
#include <cstring>
#include <chrono>
#include <iostream>
#include <iomanip>
#include <random>
#include <string>
#include <utility>
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC push_options
#pragma GCC optimize("O3,unroll-loops")
#pragma GCC target("avx2,bmi")
#endif
#include "variants.inc"
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC pop_options
#endif
using Vec = std::vector<int>;
using Fn = Vec(*)(Vec,Vec);
struct Entry { const char* name; Fn fn; };
const Entry entries[] = {
    {"baseline",solve_baseline}, {"static_fresh",solve_static_fresh},
    {"static_cached",solve_static_cached}, {"reuse_a",solve_reuse_a},
    {"reuse_both",solve_reuse_both}
};
constexpr uint32_t P = 998244353;
uint32_t power(uint32_t a,uint32_t e) {
    uint32_t r=1;
    for(;e;e>>=1,a=uint64_t(a)*a%P) if(e&1) r=uint64_t(r)*a%P;
    return r;
}
// Independent ordinary-modulo radix-2 reference, explicit bit reversal.
void transform(Vec& a,bool inverse) {
    const int n=a.size();
    for(int i=1,j=0;i<n;++i) {
        int bit=n/2; for(;j&bit;bit>>=1)j^=bit;j^=bit;
        if(i<j)std::swap(a[i],a[j]);
    }
    for(int len=2;len<=n;len*=2) {
        uint32_t step=power(3,(P-1)/len);if(inverse)step=power(step,P-2);
        for(int i=0;i<n;i+=len) {
            uint32_t w=1;
            for(int j=0;j<len/2;++j) {
                uint32_t x=a[i+j],y=uint64_t(a[i+j+len/2])*w%P;
                a[i+j]=(x+y)%P;a[i+j+len/2]=(x+P-y)%P;
                w=uint64_t(w)*step%P;
            }
        }
    }
    if(inverse){auto w=power(n,P-2);for(int& x:a)x=uint64_t(x)*w%P;}
}
Vec reference(Vec a,Vec b) {
    if(a.empty()||b.empty())return {};
    const size_t count=a.size()+b.size()-1;
    if(std::min(a.size(),b.size())<=16 || a.size()*b.size()<=20000) {
        Vec c(count);
        for(size_t i=0;i<a.size();++i)for(size_t j=0;j<b.size();++j)
            c[i+j]=(c[i+j]+uint64_t(a[i])*b[j])%P;
        return c;
    }
    size_t n=1;while(n<count)n*=2;
    a.resize(n);b.resize(n);transform(a,false);transform(b,false);
    for(size_t i=0;i<n;++i)a[i]=uint64_t(a[i])*b[i]%P;
    transform(a,true);a.resize(count);return a;
}
uint64_t checksum(const Vec& a) {
    uint64_t h=0;
    for(int x:a)h=(h^uint32_t(x))*1099511628211ULL;
    return h;
}
std::pair<Vec,Vec> inputs(int n,int m) {
    std::mt19937 rng(20260927+n*31+m);
    Vec a(n),b(m);
    for(int& x:a)x=rng()%P;
    for(int& x:b)x=rng()%P;
    return {std::move(a),std::move(b)};
}
void correctness() {
    unsigned cases=0;
    auto check=[&](const Vec& a,const Vec& b) {
        const auto want=reference(a,b);
        for(const auto& e:entries) {
            // Exercise both ordinary capacities and spare capacity that permits
            // in-place resize. std::vector element alignment may differ by call.
            for(bool reserve:{false,true}) {
                Vec x=a,y=b;
                if(reserve){x.reserve(a.size()+b.size()+16);y.reserve(a.size()+b.size()+24);}
                auto got=e.fn(std::move(x),std::move(y));
                if(got!=want){std::cerr<<"FAIL "<<e.name<<' '<<a.size()<<' '<<b.size()<<'\n';std::exit(1);}
                ++cases;
            }
        }
    };
    check({},{});check({1},{});check({},{1});
    check({1,2,3,4},{5,6,7,8,9});check({10000000},{10000000});
    for(int n:{1,2,8,16,17,31,32,33,63,65,129}) {
        for(int m:{1,2,8,16,17,31,32,33}) {
            auto [a,b]=inputs(n,m);check(a,b);
            check(Vec(n,P-1),Vec(m,P-1));
        }
    }
    for(int direction:{1,-1})for(int k=6;k<=20;++k) {
        const int lg=direction==1?k:26-k;
        const int n=1<<(lg-1);
        for(int delta:{-1,0,1}) {
            if(n+delta>(1<<19))continue;
            auto [a,b]=inputs(n,n+delta);check(a,b);
        }
        check(Vec(33,0),Vec(65,P-1));
    }
    for(int m:{1,8,16,17}) {
        auto [a,b]=inputs(1<<19,m);check(a,b);check(b,a);
    }
    check(Vec(1<<19,P-1),Vec(1<<19,P-1));
    check(Vec(1023,P-1),Vec(513,P-1));check({0},{P-1});
    std::cout<<"PASS "<<cases<<" wrapper cases; all five variants, independent oracle, "
             <<"canonical equality, capacities, boundaries, grow/shrink reuse, max size\n";
}
double timed(const Entry& e, Vec a, Vec b, uint64_t& hash) {
    const auto start=std::chrono::steady_clock::now();
    auto result=e.fn(std::move(a),std::move(b));
    const auto stop=std::chrono::steady_clock::now();
    hash=checksum(result);
    return std::chrono::duration<double,std::micro>(stop-start).count();
}
int main(int argc,char** argv) {
    std::cout<<std::setprecision(10);
    if(argc==1||std::string(argv[1])=="--check"){correctness();return 0;}
    if(std::string(argv[1])=="--cold") {
        const int which=std::stoi(argv[2]),n=std::stoi(argv[3]),m=std::stoi(argv[4]);
        auto [a,b]=inputs(n,m);uint64_t hash;
        const double us=timed(entries[which],std::move(a),std::move(b),hash);
        std::cout<<entries[which].name<<",cold,"<<n<<','<<m<<",0,"<<us<<','<<hash<<'\n';
        return 0;
    }
    // Allocation/copying to reproduce the grader's moved input vectors is outside
    // timing. All work inside solve, including deallocation of its parameters, is
    // timed. Returned result destruction and checksums are outside timing.
    const std::pair<int,int> sizes[]={{1,524288},{8,524288},{16,524288},{17,524288},
        {32,32},{1000,1000},{32768,32768},{131072,131072},{100001,370003},{524288,524288}};
    for(auto [n,m]:sizes) {
        auto [a,b]=inputs(n,m);
        const auto expected=checksum(reference(a,b));
        for(int rep=-2;rep<15;++rep)for(int k=0;k<5;++k) {
            const int index=rep%2==0?(k+rep+10)%5:(4-k+rep+10)%5;
            uint64_t hash;double us=timed(entries[index],a,b,hash);
            if(hash!=expected){std::cerr<<"FAIL timing output\n";return 1;}
            if(rep>=0)std::cout<<entries[index].name<<",reuse,"<<n<<','<<m<<','<<rep<<','<<us<<','<<hash<<'\n';
        }
    }
}
