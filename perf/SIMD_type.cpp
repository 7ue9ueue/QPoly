#include <iostream>

int main() {
#ifdef __aarch64__
    std::cout << "ARM64 (Apple Silicon)\n";
    std::cout << "SIMD: ARM NEON (128-bit)\n";
    
    #ifdef __ARM_NEON
        std::cout << "NEON intrinsics available: YES\n";
    #endif
    
#elif defined(__x86_64__)
    std::cout << "x86-64 (Intel)\n";
    
    #ifdef __AVX2__
        std::cout << "AVX2 available: YES\n";
    #endif
    #ifdef __AVX__
        std::cout << "AVX available: YES\n";
    #endif
    #ifdef __SSE4_2__
        std::cout << "SSE4.2 available: YES\n";
    #endif
#endif
}