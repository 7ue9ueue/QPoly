"""Coarse phase instrumentation: two clock reads per tile phase, not butterfly."""
def source(base):
 s=base.replace('#pragma once\n','').replace('namespace qpoly_h14_base {','''namespace profile_kernel {
inline uint64_t ns[5]{};
inline auto stamp(){return std::chrono::steady_clock::now();}
inline void finish(int phase,std::chrono::steady_clock::time_point t){ns[phase]+=std::chrono::duration_cast<std::chrono::nanoseconds>(stamp()-t).count();}
''')
 s=s.replace('''        if(nv<=Tile) {
            for(int h=nv/4;''','''        if(nv<=Tile) {
            auto clock=stamp();
            for(int h=nv/4;''')
 s=s.replace('            leaves(a,b,nv,k*nv);','            finish(0,clock);clock=stamp();\n            leaves(a,b,nv,k*nv);\n            finish(1,clock);clock=stamp();')
 s=s.replace('''        } else {
            int h=nv/4;group<false>(a,b,h,k);''','''            finish(2,clock);
        } else {
            auto clock=stamp();int h=nv/4;group<false>(a,b,h,k);finish(0,clock);''')
 s=s.replace('            group<true>(a,nullptr,h,k);','            clock=stamp();group<true>(a,nullptr,h,k);finish(2,clock);')
 s=s.replace('        if constexpr(RootMode==0 || RootMode==2)tables','        auto clock=stamp();\n        if constexpr(RootMode==0 || RootMode==2)tables')
 s=s.replace('        Kernel job(r,ir);','        finish(3,clock);\n        Kernel job(r,ir);')
 s=s.replace('''            int h=nv/2;
            for(int i=0;i<h;++i)''','''            clock=stamp();int h=nv/2;
            for(int i=0;i<h;++i)''')
 s=s.replace('            job.visit(a,b,h,0);job.visit(a+h,b+h,h,1);','            finish(0,clock);job.visit(a,b,h,0);job.visit(a+h,b+h,h,1);clock=stamp();')
 s=s.replace('''                return;
            } else for''','''                finish(4,clock);return;
            } else for''')
 s=s.rstrip();assert s.endswith('}');s=s[:-1]
 s+='''
using K=Kernel<true,false,2,256,4,2,true>;
}
'''
 return s
DRIVER=r'''
int main(){
 using U=uint32_t;constexpr int n=1<<20;
 U*a=(U*)_mm_malloc(n*4,64),*b=(U*)_mm_malloc(n*4,64),*r=(U*)_mm_malloc(n*4,64),*ir=(U*)_mm_malloc(n*4,64);
 if(!a||!b||!r||!ir)return 2;
 std::vector<U>x(n),y(n),want(n);std::mt19937 rng(431);
 for(int i=0;i<n;++i){x[i]=rng()%998244353;y[i]=rng()%998244353;}
 std::copy(x.begin(),x.end(),a);std::copy(y.begin(),y.end(),b);int size=0;
 qpoly_h14_base::Kernel<true,false,2,256,4,2,true>::run(n,a,b,r,ir,size,true);
 std::copy(a,a+n,want.begin());
 std::cout<<"repeat,forward_ns,leaf_ns,inverse_ns,roots_ns,final_ns,total_ns\n";
 for(int rep=-2;rep<5;++rep){
  std::copy(x.begin(),x.end(),a);std::copy(y.begin(),y.end(),b);size=0;
  std::fill(std::begin(profile_kernel::ns),std::end(profile_kernel::ns),0);
  auto start=std::chrono::steady_clock::now();profile_kernel::K::run(n,a,b,r,ir,size,true);auto stop=std::chrono::steady_clock::now();
  if(!std::equal(a,a+n,want.begin())){std::cerr<<"FAIL profile output\n";return 1;}
  if(rep>=0){std::cout<<rep;for(auto t:profile_kernel::ns)std::cout<<','<<t;std::cout<<','<<std::chrono::duration_cast<std::chrono::nanoseconds>(stop-start).count()<<'\n';}
 }
 _mm_free(a);_mm_free(b);_mm_free(r);_mm_free(ir);
}
'''
