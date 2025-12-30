#include <sys/sysctl.h>
#include <iostream>

void print_cache_sizes_macos() {
    size_t size;
    uint64_t cache_size;
    
    // L1 Data Cache
    size = sizeof(cache_size);
    sysctlbyname("hw.l1dcachesize", &cache_size, &size, nullptr, 0);
    std::cout << "L1 Data Cache: " << cache_size << " bytes\n";
    
    // L1 Instruction Cache
    size = sizeof(cache_size);
    sysctlbyname("hw.l1icachesize", &cache_size, &size, nullptr, 0);
    std::cout << "L1 Instruction Cache: " << cache_size << " bytes\n";
    
    // L2 Cache
    size = sizeof(cache_size);
    sysctlbyname("hw.l2cachesize", &cache_size, &size, nullptr, 0);
    std::cout << "L2 Cache: " << cache_size << " bytes\n";
    
    // L3 Cache
    size = sizeof(cache_size);
    sysctlbyname("hw.l3cachesize", &cache_size, &size, nullptr, 0);
    std::cout << "L3 Cache: " << cache_size << " bytes\n";
}

int main () {
    print_cache_sizes_macos();
}