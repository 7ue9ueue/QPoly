#include "checks/asm_baseline.cpp"
#include "checks/asm_radix4_serial.cpp"
#include "checks/asm_radix4_pair.cpp"
#include <random>
#include <cstdio>
#include <cstring>
constexpr uint32_t mod=998244353;
int main(){
 std::mt19937 gen(123); alignas(32) uint32_t input[2048+8],want[2048+8],got[2048+8];size_t checked=0;
 for(int h: {1,4,16,64})for(int rep=0;rep<2048;++rep){
  int n=32*h;
  for(int i=0;i<n+8;++i)input[i]=rep<5?uint64_t(rep)*mod-(rep!=0):gen()%(4*mod);
  uint32_t x=gen()%mod,y=gen()%mod,z=gen()%mod;
  memcpy(want,input,sizeof(input));
  kernel_asm_baseline::Twiddle tw(kernel_asm_baseline::splat(x),kernel_asm_baseline::splat(y),kernel_asm_baseline::splat(z));
  kernel_asm_baseline::radix4<true,false,false,false>((__m256i*)want,h,tw);
  {
  memcpy(got,input,sizeof(input));
  kernel_asm_radix4_serial::Twiddle t(kernel_asm_radix4_serial::splat(x),kernel_asm_radix4_serial::splat(y),kernel_asm_radix4_serial::splat(z));
  kernel_asm_radix4_serial::radix4<true,false,false,false>((__m256i*)got,h,t);
  for(int i=0;i<n+8;++i)if(got[i]!=want[i]||(i<n&&got[i]>=4*mod)){printf("FAIL asm_radix4_serial h=%d rep=%d i=%d got=%u want=%u\n",h,rep,i,got[i],want[i]);return 1;}checked+=n;
  }
  {
  memcpy(got,input,sizeof(input));
  kernel_asm_radix4_pair::Twiddle t(kernel_asm_radix4_pair::splat(x),kernel_asm_radix4_pair::splat(y),kernel_asm_radix4_pair::splat(z));
  kernel_asm_radix4_pair::radix4<true,false,false,false>((__m256i*)got,h,t);
  for(int i=0;i<n+8;++i)if(got[i]!=want[i]||(i<n&&got[i]>=4*mod)){printf("FAIL asm_radix4_pair h=%d rep=%d i=%d got=%u want=%u\n",h,rep,i,got[i],want[i]);return 1;}checked+=n;
  }
 }printf("PASS %zu direct full-lazy-range radix lanes\n",checked);}
