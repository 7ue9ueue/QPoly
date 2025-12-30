#include<emmintrin.h>
#include<iostream>
#include<vector>
using namespace std;
using vi = vector<int>;

vi vector_add_baseline(const vi& a, const vi& b, int n) {
    vi c(n);
    for (int i=0;i<n;i++) {
        c[i] = a[i] + b[i];
    }
    return c;
}

typedef __m128i v4i;
vi vector_add_SIMD(const vi& a, const vi& b, int n) {
    vi result(n);
    int i = 0;
    for (;i+4<=n;i+=4) {
        v4i va = _mm_loadu_si128((v4i)(&a[i]));
        v4i vb = _mm_loadu_si128((v4i)(&b[i]));
        v4i vsum = _mm_add_epi32(va, vb);
        _mm_storeu_si128((v4i((&result[i]), vsum);
    }
    for (;i<n;i++) {
        result[i] = a[i] + b[i];
    }
    return result;
}

vi vector_add_SIMD(const vi& a, const vi& b, int n) {
    vi result(n);
    int i = 0;
    
    for (; i + 16 <= n; i += 16) {
        v4i va0 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&a[i]));
        v4i vb0 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&b[i]));
        v4i va1 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&a[i+4]));
        v4i vb1 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&b[i+4]));
        v4i va2 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&a[i+8]));
        v4i vb2 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&b[i+8]));
        v4i va3 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&a[i+12]));
        v4i vb3 = _mm_loadu_si128(reinterpret_cast<const v4i*>(&b[i+12]));
        
        v4i vsum0 = _mm_add_epi32(va0, vb0);
        v4i vsum1 = _mm_add_epi32(va1, vb1);
        v4i vsum2 = _mm_add_epi32(va2, vb2);
        v4i vsum3 = _mm_add_epi32(va3, vb3);
        
        _mm_storeu_si128(reinterpret_cast<v4i*>(&result[i]), vsum0);
        _mm_storeu_si128(reinterpret_cast<v4i*>(&result[i+4]), vsum1);
        _mm_storeu_si128(reinterpret_cast<v4i*>(&result[i+8]), vsum2);
        _mm_storeu_si128(reinterpret_cast<v4i*>(&result[i+12]), vsum3);
    }
    return result;
}

int main() {

}
/*
Average Speedup: 1.06
*/