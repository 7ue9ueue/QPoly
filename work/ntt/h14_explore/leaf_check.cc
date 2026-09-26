#include "checks/asm_leaf_full.cpp"
#include "checks/asm_leaf_pair.cpp"
#include "checks/asm_leaf_inplace.cpp"
#include <random>
#include <cstdio>
#include <cstring>
constexpr uint32_t mod=998244353;
uint32_t powmod(uint32_t x,uint32_t n){uint32_t r=1;for(;n;n>>=1,x=uint64_t(x)*x%mod)if(n&1)r=uint64_t(r)*x%mod;return r;}
int main(){
 std::mt19937 gen(123); constexpr uint64_t R=uint64_t(1)<<32; uint32_t ri=powmod(R%mod,mod-2);
 alignas(32) uint32_t a[32],b[32],x[32],y[32],w[4],want[32];
 for(int rep=0;rep<4096;++rep){
  for(int i=0;i<32;++i){x[i]=rep<5?uint64_t(rep)*mod-(rep!=0):gen()%(4*mod);y[i]=rep<5?uint64_t(rep)*mod-(rep!=0):gen()%(4*mod);}
  for(int t=0;t<4;++t){w[t]=gen()%mod;uint32_t wo=uint64_t(w[t])*ri%mod;
   for(int k=0;k<8;++k){uint32_t acc=0;for(int i=0;i<8;++i){uint32_t term=uint64_t(x[8*t+(k-i+8)%8]%mod)*(y[8*t+i]%mod)%mod;if(i>k)term=uint64_t(term)*wo%mod;acc=(acc+uint64_t(term))%mod;}want[8*t+k]=uint64_t(acc)*ri%mod;}
  }
  memcpy(a,x,sizeof a);memcpy(b,y,sizeof b);
  kernel_asm_leaf_full::leaf<4,2>((__m256i*)a,(__m256i*)b,w);
  for(int i=0;i<32;++i)if(a[i]>=2*mod||a[i]%mod!=want[i]){printf("FAIL asm_leaf_full rep=%d i=%d got=%u want=%u\n",rep,i,a[i],want[i]);return 1;}
  memcpy(a,x,sizeof a);memcpy(b,y,sizeof b);
  kernel_asm_leaf_pair::leaf<4,2>((__m256i*)a,(__m256i*)b,w);
  for(int i=0;i<32;++i)if(a[i]>=2*mod||a[i]%mod!=want[i]){printf("FAIL asm_leaf_pair rep=%d i=%d got=%u want=%u\n",rep,i,a[i],want[i]);return 1;}
  memcpy(a,x,sizeof a);memcpy(b,y,sizeof b);
  kernel_asm_leaf_inplace::leaf<4,2>((__m256i*)a,(__m256i*)b,w);
  for(int i=0;i<32;++i)if(a[i]>=2*mod||a[i]%mod!=want[i]){printf("FAIL asm_leaf_inplace rep=%d i=%d got=%u want=%u\n",rep,i,a[i],want[i]);return 1;}
 }puts("PASS 393216 direct full-lazy-range leaf lanes");}
