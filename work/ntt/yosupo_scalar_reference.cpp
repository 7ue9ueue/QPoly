// Independent ordinary-modulo radix-2 oracle from the existing h14 comparison.
// Validation helper only; not part of the submission.
#include <algorithm>
#include <cstdint>
#include <iostream>
#include <vector>
using U=uint32_t; using A=std::vector<U>; constexpr U P=998244353;
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

int main(){std::ios::sync_with_stdio(false);std::cin.tie(nullptr);
int n,m;std::cin>>n>>m; int size=1;while(size<n+m-1)size*=2;
A a(size),b(size);for(int i=0;i<n;++i)std::cin>>a[i];for(int i=0;i<m;++i)std::cin>>b[i];
a=reference(a,b);for(int i=0;i<n+m-1;++i)std::cout<<a[i]<<' ';}
