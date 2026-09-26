// Independent fixed-multiply checks cover the full lazy input range, including
// values above INT32_MAX and products close to the reduction boundaries.
template<class F> void check_fixed(const char* name) {
    constexpr uint32_t p=998244353;
    auto powmod=[](uint64_t a,uint32_t e){uint64_t r=1;for(;e;e>>=1,a=a*a%p)if(e&1)r=r*a%p;return r;};
    uint64_t rinv=powmod((uint64_t(1)<<32)%p,p-2);
    std::mt19937 rng(731991);
    const uint32_t edges[]={0,1,p-1,p,p+1,2*p-1,2*p,2*p+1,3*p-1,3*p,4*p-2,4*p-1,0x7fffffff,0x80000000};
    const uint32_t factors[]={0,1,2,p-2,p-1};
    alignas(32) uint32_t x[8],y[8];
    for(int k=0;k<32768;++k){
        uint32_t w=k<5?factors[k]:rng()%p;F f(w);
        for(int batch=0;batch<3;++batch){
            for(int lane=0;lane<8;++lane)x[lane]=batch<2?edges[(8*batch+lane)%14]:rng()%(4*p);
            _mm256_store_si256((__m256i*)y,f(_mm256_load_si256((__m256i*)x)));
            for(int lane=0;lane<8;++lane){
                uint32_t want=(uint64_t(x[lane])*w%p)*rinv%p;
                if(y[lane]>=2*p||y[lane]%p!=want){std::cerr<<"FAIL fixed "<<name<<" x="<<x[lane]<<" w="<<w<<" got="<<y[lane]<<" want="<<want<<'\n';std::exit(1);}
            }
        }
    }
    std::cout<<"PASS full lazy range "<<name<<" 786432 lanes\n";
}
int main(){check_fixed<arith_mullo::Fixed>("montgomery-mullo");check_fixed<arith_shoup::Fixed>("shoup");check_fixed<arith_wide::Fixed>("shoup-wide");}
