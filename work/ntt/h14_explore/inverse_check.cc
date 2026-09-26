#include "checks/asm_baseline.cpp"
#include "checks/asm_inverse_serial.cpp"
#include "checks/asm_inverse_pair.cpp"
#include <random>
#include <cstdio>
#include <cstring>
constexpr uint32_t mod=998244353;
uint32_t powmod(uint32_t x,uint32_t n){uint32_t r=1;for(;n;n>>=1,x=uint64_t(x)*x%mod)if(n&1)r=uint64_t(r)*x%mod;return r;}
int main(){
 std::mt19937 gen(123); alignas(32) uint32_t input[2048+8]{},want[2048+8]{},got[2048+8]{},oracle[2048];size_t checked=0;
 uint32_t ri=powmod((uint64_t(1)<<32)%mod,mod-2);
 auto mt=[&](uint32_t v,uint32_t w){return uint64_t(uint64_t(v)*w%mod)*ri%mod;};
 for(int h: {1,4,16,64})for(int rep=0;rep<2048;++rep){
  int n=32*h;
  for(int i=0;i<n+8;++i)input[i]=rep<3?uint64_t(rep)*mod-(rep!=0):gen()%(2*mod);
  uint32_t x=gen()%mod,y=gen()%mod,z=gen()%mod;
  memcpy(want,input,sizeof(input));
  kernel_asm_baseline::Twiddle tw(kernel_asm_baseline::splat(x),kernel_asm_baseline::splat(y),kernel_asm_baseline::splat(z));
  kernel_asm_baseline::radix4<true,false,false,true>((__m256i*)want,h,tw);
  for(int i=0;i<8*h;++i){
   uint32_t a=input[i]%mod,b=input[i+8*h]%mod,c=input[i+16*h]%mod,d=input[i+24*h]%mod;
   uint32_t ab=(a+b)%mod,cd=(c+d)%mod,amb=mt((a+mod-b)%mod,y),cmd=mt((c+mod-d)%mod,z);
   oracle[i]=(ab+cd)%mod;oracle[i+8*h]=(amb+cmd)%mod;oracle[i+16*h]=mt((ab+mod-cd)%mod,x);oracle[i+24*h]=mt((amb+mod-cmd)%mod,x);
  }
  {
  memcpy(got,input,sizeof(input));
  kernel_asm_inverse_serial::Twiddle t(kernel_asm_inverse_serial::splat(x),kernel_asm_inverse_serial::splat(y),kernel_asm_inverse_serial::splat(z));
  kernel_asm_inverse_serial::radix4<true,false,false,true>((__m256i*)got,h,t);
  for(int i=0;i<n+8;++i)if(got[i]!=want[i]||(i<n&&(got[i]>=2*mod||got[i]%mod!=oracle[i]))){printf("FAIL asm_inverse_serial h=%d rep=%d i=%d got=%u want=%u\n",h,rep,i,got[i],want[i]);return 1;}checked+=n;
  }
  {
  memcpy(got,input,sizeof(input));
  kernel_asm_inverse_pair::Twiddle t(kernel_asm_inverse_pair::splat(x),kernel_asm_inverse_pair::splat(y),kernel_asm_inverse_pair::splat(z));
  kernel_asm_inverse_pair::radix4<true,false,false,true>((__m256i*)got,h,t);
  for(int i=0;i<n+8;++i)if(got[i]!=want[i]||(i<n&&(got[i]>=2*mod||got[i]%mod!=oracle[i]))){printf("FAIL asm_inverse_pair h=%d rep=%d i=%d got=%u want=%u\n",h,rep,i,got[i],want[i]);return 1;}checked+=n;
  }
 }printf("PASS %zu direct full-lazy-range inverse lanes\n",checked);}
