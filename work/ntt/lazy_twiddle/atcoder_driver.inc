// Self-contained comparison driver. No problem input/output is required.
// Empty stdin: max_log2=20, repetitions=5, mode=0 (fresh).
// Optional stdin: "20 9 2". Mode 0=fresh, 1=reuse, 2=both. max_log2 <=22.
namespace comparison {
using U=uint32_t; using A=std::vector<U>;
constexpr U P=998244353;
struct Aligned {
    U* p;int n;
    explicit Aligned(int size):p((U*)_mm_malloc(size_t(size+16)*4,64)),n(size) {
        if(!p)throw std::bad_alloc();std::fill(p,p+n,0);std::fill(p+n,p+n+16,0xdeadbeef);
    }
    ~Aligned(){_mm_free(p);}
    Aligned(const Aligned&)=delete;
    bool intact()const{return std::all_of(p+n,p+n+16,[](U x){return x==0xdeadbeef;});}
};
U power(U a,U e) {U r=1;for(;e;e>>=1,a=uint64_t(a)*a%P)if(e&1)r=uint64_t(r)*a%P;return r;}
// Independent scalar radix-2 oracle; explicit bit reversal and ordinary %.
void transform(A& a,bool inverse) {
    int n=int(a.size());
    for(int i=1,j=0;i<n;++i){int b=n/2;for(;j&b;b>>=1)j^=b;j^=b;if(i<j)std::swap(a[i],a[j]);}
    for(int len=2;len<=n;len*=2){
        U step=power(3,(P-1)/len);if(inverse)step=power(step,P-2);
        for(int i=0;i<n;i+=len){U w=1;for(int j=0;j<len/2;++j){
            U x=a[i+j],y=uint64_t(a[i+j+len/2])*w%P;
            a[i+j]=(x+y)%P;a[i+j+len/2]=(x+P-y)%P;w=uint64_t(w)*step%P;
        }}
    }
    if(inverse){U w=power(n,P-2);for(U& x:a)x=uint64_t(x)*w%P;}
}
A reference(A a,A b){transform(a,false);transform(b,false);for(size_t i=0;i<a.size();++i)a[i]=uint64_t(a[i])*b[i]%P;transform(a,true);return a;}
A brute(const A&a,const A&b){A c(a.size());for(size_t i=0;i<a.size();++i)for(size_t j=0;j<b.size();++j)c[(i+j)%a.size()]=(c[(i+j)%a.size()]+uint64_t(a[i])*b[j])%P;return c;}
[[noreturn]] void fail(const char*name,int n,int i,U got,U want){
    std::cerr<<"FAIL "<<name<<" n="<<n<<" index="<<i<<" got="<<got<<" expected="<<want<<'\n';std::exit(1);
}
void check(const Entry&e,const A&x,const A&y,const A&want,Aligned&a,Aligned&b,Aligned&r,Aligned&ir,int&rs,bool fresh){
    int n=int(x.size());std::copy(x.begin(),x.end(),a.p);std::copy(y.begin(),y.end(),b.p);
    e.fn(n,a.p,b.p,r.p,ir.p,rs,fresh);
    // Require canonical outputs, not just equivalence modulo P.
    for(int i=0;i<n;++i)if(a.p[i]!=want[i])fail(e.name,n,i,a.p[i],want[i]);
    if(!a.intact()||!b.intact()||!r.intact()||!ir.intact())fail(e.name,n,n,0,1);
}
volatile uint64_t sink=0;
void correctness(int max_log){
    std::mt19937 rng(20260926);
    for(int lg=6;lg<=max_log;++lg){
        int n=1<<lg;Aligned a(n),b(n),r(n),ir(n);
        for(int pattern=0;pattern<(lg<=8?6:1);++pattern){
            A x(n),y(n);for(int i=0;i<n;++i){
                x[i]=rng()%P;y[i]=rng()%P;
                if(pattern==1)x[i]=y[i]=P-1;
                if(pattern==2)x[i]=0;
                if(pattern==3)x[i]=(i==n-1?P-1:0),y[i]=(i==1);
                if(pattern==4)x[i]=i&1?P-1:0,y[i]=i&1?1:P-1;
                if(pattern==5)x[i]=y[i]=1;
            }
            A want=reference(x,y);if(n<=256&&want!=brute(x,y))fail("oracle-vs-brute",n,0,0,1);
            for(const Entry&e:entries){int rs=0;check(e,x,y,want,a,b,r,ir,rs,true);check(e,x,y,want,a,b,r,ir,rs,false);}
        }
        std::cout<<"PASS 2^"<<lg<<" all implementations\n";
    }
    {int n=1<<max_log;Aligned a(n),b(n),r(n),ir(n);A x(n,P-1),y(n,P-1),want(n,n);
     for(const Entry&e:entries){int rs=0;check(e,x,y,want,a,b,r,ir,rs,true);}
     std::fill(x.begin(),x.end(),0);x[n-1]=P-1;
     for(U&v:y)v=rng()%P;for(int i=0;i<n;++i)want[i]=(P-y[(i+1)%n])%P;
     for(const Entry&e:entries){int rs=0;check(e,x,y,want,a,b,r,ir,rs,true);}}
    for(const Entry&e:entries){Aligned a(1024),b(1024),r(1024),ir(1024);int rs=0;
        for(int n:{64,256,128,1024,512,64}){A x(n),y(n);for(U&v:x)v=rng()%P;for(U&v:y)v=rng()%P;check(e,x,y,reference(x,y),a,b,r,ir,rs,false);}}
    std::cout<<"PASS maximum coefficients, wraparound, and changing sizes\n";
}
void benchmark(int max_log,int reps,int mode){
    std::mt19937 rng(42);constexpr int count=sizeof(entries)/sizeof(entries[0]);
    std::cout<<"mode,log2,implementation,median_ms,min_ms,max_ms,speedup_vs_v91\n";
    for(int lg=std::min(12,max_log);lg<=max_log;++lg){
        int n=1<<lg;Aligned a(n),b(n),r(n),ir(n);A x(n),y(n);for(U&v:x)v=rng()%P;for(U&v:y)v=rng()%P;
        for(int reuse=0;reuse<=1;++reuse){if(mode!=2&&reuse!=mode)continue;
            std::vector<double> samples[count];uint64_t expected_hash=0;bool hash_set=false;
            for(int rep=-2;rep<reps;++rep)for(int pos=0;pos<count;++pos){
                int j=(pos+rep+2)%count;if(rep&1)j=count-1-j;const Entry&e=entries[j];int rs=0;
                if(reuse){std::copy(x.begin(),x.end(),a.p);std::copy(y.begin(),y.end(),b.p);e.fn(n,a.p,b.p,r.p,ir.p,rs,true);}
                std::copy(x.begin(),x.end(),a.p);std::copy(y.begin(),y.end(),b.p);
                auto start=std::chrono::steady_clock::now();e.fn(n,a.p,b.p,r.p,ir.p,rs,!reuse);auto end=std::chrono::steady_clock::now();
                uint64_t hash=0;for(int i=0;i<n;++i)hash=hash*31+a.p[i];sink=hash;
                if(hash_set&&hash!=expected_hash)fail(e.name,n,-1,U(hash),U(expected_hash));expected_hash=hash;hash_set=true;
                if(rep>=0)samples[j].push_back(std::chrono::duration<double,std::milli>(end-start).count());
            }
            for(auto&s:samples)std::sort(s.begin(),s.end());
            auto median=[](const std::vector<double>&s){return (s[(s.size()-1)/2]+s[s.size()/2])/2;};
            double baseline=median(samples[0]);
            for(int j=0;j<count;++j){const auto&s=samples[j];std::cout<<(reuse?"reuse":"fresh")<<','<<lg<<','<<entries[j].name<<','<<median(s)<<','<<s.front()<<','<<s.back()<<','<<baseline/median(s)<<'\n';}
        }
    }
}
}
int main(){
    std::ios::sync_with_stdio(false);std::cin.tie(nullptr);std::cout<<std::unitbuf<<std::fixed<<std::setprecision(4);
    int max_log=20,reps=5,mode=0;
    if(std::cin>>max_log){if(!(std::cin>>reps>>mode)){std::cerr<<"Expected: max_log2 repetitions mode\n";return 2;}}
    if(max_log<6||max_log>22||reps<1||reps>25||mode<0||mode>2){std::cerr<<"Require 6<=max_log2<=22, 1<=repetitions<=25, mode in {0,1,2}\n";return 2;}
    std::cout<<"QPoly NTT comparison / modulus 998244353 / cyclic convolution\n"
             <<"Compiler: "<<__VERSION__<<"\nmax_log2="<<max_log<<" repetitions="<<reps<<" mode="<<mode<<'\n'
             <<"Heap allocation and input copies excluded. Full convolution timed.\n"
             <<"fresh regenerates size-dependent roots; reuse primes each implementation. Fixed constexpr metadata is never timed.\n";
    comparison::correctness(max_log);comparison::benchmark(max_log,reps,mode);
    std::cout<<"ALL CHECKS PASSED checksum="<<comparison::sink<<'\n';
}
