#include "checks/h14_mont_mullo.cpp"
#include "checks/h14_mont_shiftmod.cpp"
#include <random>
#include <cstdio>
constexpr uint32_t modulus=998244353;
uint32_t powmod(uint32_t a,uint32_t e){uint32_t r=1;for(;e;e>>=1,a=uint64_t(a)*a%modulus)if(e&1)r=uint64_t(r)*a%modulus;return r;}
int main(){
 std::mt19937 rng(971);const uint32_t ri=powmod((uint64_t(1)<<32)%modulus,modulus-2);
 alignas(32) uint32_t x[8],w[8],result[8];size_t checked=0;
 for(int rep=0;rep<65536;++rep){
  for(int i=0;i<8;++i)x[i]=rep<5?uint64_t(rep)*modulus-(rep!=0):rng()%(4*modulus);
  for(int i=0;i<8;i+=2)w[i]=rng()%modulus,w[i+1]=w[i];
  for(int variant=0;variant<2;++variant)for(int scalar=0;scalar<2;++scalar){
   __m256i xv=_mm256_load_si256((__m256i*)x),wv=_mm256_load_si256((__m256i*)w),z;
   if(variant==0){using namespace kernel_h14_mont_mullo;z=scalar?Fixed(w[0])(xv):Fixed(wv)(xv);}
   else {using namespace kernel_h14_mont_shiftmod;z=scalar?Fixed(w[0])(xv):Fixed(wv)(xv);}
   _mm256_store_si256((__m256i*)result,z);
   for(int i=0;i<8;++i){uint32_t want=uint64_t(uint64_t(x[i])*(scalar?w[0]:w[i])%modulus)*ri%modulus;
    if(result[i]>=2*modulus||result[i]%modulus!=want){printf("FAIL multiply variant=%d scalar=%d rep=%d lane=%d\n",variant,scalar,rep,i);return 1;}++checked;}
  }
 }
 printf("PASS %zu Montgomery full-range lanes against ordinary modulo oracle\n",checked);
}
