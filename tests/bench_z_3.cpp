#include <iostream>
#include <cstdint>
#include <concepts>
#include <type_traits>
#include <cassert>
#include <chrono>
#include <random>
#include <vector>
#include <algorithm>
#include <numeric>
#include <iomanip>

// ============================================================================
// Version 1: Extended Euclid with std::swap
// ============================================================================
template <std::unsigned_integral T = uint32_t, T P = 998244353>
class Z_Swap {
public:
    T value;
    constexpr static T MOD = P;

#ifdef __SIZEOF_INT128__
    using wide_T = std::conditional_t<sizeof(T) == 4, uint64_t, __uint128_t>;
#else
    static_assert(sizeof(T) == 4, "64-bit modular arithmetic requires __uint128_t support");
    using wide_T = uint64_t;
#endif

    constexpr T val() const { return value; }
    constexpr Z_Swap() : value(0) {}

    template <std::unsigned_integral U>
    explicit constexpr Z_Swap(U v) {
        if (v < MOD) [[likely]] {
            value = v;
        }
        else if (v < MOD + MOD) {
            value = v - MOD;
        }
        else {
            value = v % MOD;
        }
    }

    // Extended Euclid Algorithm with std::swap
    constexpr Z_Swap inv() const {
        assert(value != 0 && "Z: zero has no inverse");
        using S = std::make_signed_t<wide_T>;
        S a = value, b = MOD, x = 1, y = 0;
        while (b) {
            S q = a / b;
            a -= q * b; std::swap(a, b);
            x -= q * y; std::swap(x, y);
        }
        assert(a == 1 && "Z: requires gcd(value, mod) == 1");
        if (x < 0) x += MOD;
        return Z_Swap(static_cast<T>(x));
    }
};

// ============================================================================
// Version 2: Swapless Extended Euclid Algorithm
// ============================================================================
template <std::unsigned_integral T = uint32_t, T P = 998244353>
class Z_Swapless {
public:
    T value;
    constexpr static T MOD = P;

#ifdef __SIZEOF_INT128__
    using wide_T = std::conditional_t<sizeof(T) == 4, uint64_t, __uint128_t>;
#else
    static_assert(sizeof(T) == 4, "64-bit modular arithmetic requires __uint128_t support");
    using wide_T = uint64_t;
#endif

    constexpr T val() const { return value; }
    constexpr Z_Swapless() : value(0) {}

    template <std::unsigned_integral U>
    explicit constexpr Z_Swapless(U v) {
        if (v < MOD) [[likely]] {
            value = v;
        }
        else if (v < MOD + MOD) {
            value = v - MOD;
        }
        else {
            value = v % MOD;
        }
    }

    // Swapless Extended Euclid Algorithm
    constexpr Z_Swapless inv() const {
        assert(value != 0 && "Z: zero has no inverse");
        using wide_S = std::make_signed_t<wide_T>;
        wide_S a = value, b = MOD, x0 = 1, x1 = 0;
        while (b) {
            wide_S q = a / b;
            wide_S a2 = a - q * b; a = b; b = a2;
            wide_S x2 = x0 - q * x1; x0 = x1; x1 = x2;
        }
        assert(a == 1 && "Z: requires gcd(value, mod) == 1");
        if (x0 < 0) x0 += MOD;
        return Z_Swapless(static_cast<T>(x0));
    }
};

// ============================================================================
// Benchmark Infrastructure
// ============================================================================

struct BenchmarkResult {
    double mean_ns;
    double median_ns;
    double min_ns;
    double max_ns;
    double stddev_ns;
};

template<typename Func>
BenchmarkResult benchmark(const std::string& name, Func&& func, size_t iterations, size_t warmup = 1000) {
    using namespace std::chrono;
    
    // Warmup
    for (size_t i = 0; i < warmup; ++i) {
        func();
    }
    
    // Actual measurements
    std::vector<double> timings;
    timings.reserve(iterations);
    
    for (size_t i = 0; i < iterations; ++i) {
        auto start = high_resolution_clock::now();
        func();
        auto end = high_resolution_clock::now();
        timings.push_back(duration_cast<nanoseconds>(end - start).count());
    }
    
    // Calculate statistics
    std::sort(timings.begin(), timings.end());
    
    double sum = std::accumulate(timings.begin(), timings.end(), 0.0);
    double mean = sum / timings.size();
    
    double median = timings[timings.size() / 2];
    double min = timings.front();
    double max = timings.back();
    
    double sq_sum = 0.0;
    for (auto t : timings) {
        sq_sum += (t - mean) * (t - mean);
    }
    double stddev = std::sqrt(sq_sum / timings.size());
    
    return {mean, median, min, max, stddev};
}

void print_result(const std::string& name, const BenchmarkResult& result) {
    std::cout << std::setw(25) << std::left << name << ": "
              << "mean=" << std::setw(10) << std::fixed << std::setprecision(2) << result.mean_ns << "ns, "
              << "median=" << std::setw(10) << result.median_ns << "ns, "
              << "min=" << std::setw(10) << result.min_ns << "ns, "
              << "max=" << std::setw(10) << result.max_ns << "ns, "
              << "stddev=" << std::setw(10) << result.stddev_ns << "ns\n";
}

// ============================================================================
// Test Scenarios
// ============================================================================

template<typename Z>
void test_random_values(const std::vector<uint32_t>& values, volatile uint32_t& sink) {
    for (auto v : values) {
        if (v == 0) continue;
        Z z(v);
        auto inv = z.inv();
        sink = inv.val();  // Prevent optimization
    }
}

template<typename Z>
void test_single_value(uint32_t v, volatile uint32_t& sink) {
    Z z(v);
    auto inv = z.inv();
    sink = inv.val();
}

int main() {
    constexpr uint32_t MOD = 998244353;
    constexpr size_t NUM_VALUES = 10000;
    constexpr size_t ITERATIONS = 100;
    constexpr size_t WARMUP = 50;
    
    // Generate random test values
    std::mt19937_64 rng(42);
    std::uniform_int_distribution<uint32_t> dist(1, MOD - 1);
    
    std::vector<uint32_t> random_values(NUM_VALUES);
    for (auto& v : random_values) {
        v = dist(rng);
    }
    
    volatile uint32_t sink = 0;  // Prevent dead code elimination
    
    std::cout << "=============================================================\n";
    std::cout << "Modular Inverse Performance Benchmark\n";
    std::cout << "=============================================================\n";
    std::cout << "MOD = " << MOD << "\n";
    std::cout << "Number of values per test: " << NUM_VALUES << "\n";
    std::cout << "Iterations: " << ITERATIONS << "\n";
    std::cout << "Warmup iterations: " << WARMUP << "\n\n";
    
    // ========================================================================
    // Test 1: Bulk random values
    // ========================================================================
    std::cout << "Test 1: Bulk Random Values (" << NUM_VALUES << " inversions)\n";
    std::cout << "-------------------------------------------------------------\n";
    
    auto result_swap_bulk = benchmark(
        "Z_Swap (bulk)",
        [&]() { test_random_values<Z_Swap<>>(random_values, sink); },
        ITERATIONS,
        WARMUP
    );
    
    auto result_swapless_bulk = benchmark(
        "Z_Swapless (bulk)",
        [&]() { test_random_values<Z_Swapless<>>(random_values, sink); },
        ITERATIONS,
        WARMUP
    );
    
    print_result("Z_Swap (bulk)", result_swap_bulk);
    print_result("Z_Swapless (bulk)", result_swapless_bulk);
    
    double speedup_bulk = result_swap_bulk.mean_ns / result_swapless_bulk.mean_ns;
    std::cout << "\nSpeedup (Swapless/Swap): " << std::fixed << std::setprecision(4) 
              << speedup_bulk << "x\n\n";
    
    // ========================================================================
    // Test 2: Single value repeated (tests best-case cache behavior)
    // ========================================================================
    std::cout << "Test 2: Single Value Repeated (cache-hot scenario)\n";
    std::cout << "-------------------------------------------------------------\n";
    
    constexpr uint32_t test_value = 123456789;
    constexpr size_t SINGLE_ITERATIONS = 100000;
    
    auto result_swap_single = benchmark(
        "Z_Swap (single)",
        [&]() { test_single_value<Z_Swap<>>(test_value, sink); },
        SINGLE_ITERATIONS,
        WARMUP
    );
    
    auto result_swapless_single = benchmark(
        "Z_Swapless (single)",
        [&]() { test_single_value<Z_Swapless<>>(test_value, sink); },
        SINGLE_ITERATIONS,
        WARMUP
    );
    
    print_result("Z_Swap (single)", result_swap_single);
    print_result("Z_Swapless (single)", result_swapless_single);
    
    double speedup_single = result_swap_single.mean_ns / result_swapless_single.mean_ns;
    std::cout << "\nSpeedup (Swapless/Swap): " << std::fixed << std::setprecision(4) 
              << speedup_single << "x\n\n";
    
    // ========================================================================
    // Test 3: Specific challenging values
    // ========================================================================
    std::cout << "Test 3: Specific Challenging Values\n";
    std::cout << "-------------------------------------------------------------\n";
    
    std::vector<uint32_t> challenging_values = {
        2,           // Small value
        MOD - 1,     // Large value
        MOD / 2,     // Mid-range
        1000000007,  // Another common prime (will be reduced)
        87654321,    // Random
    };
    
    for (auto v : challenging_values) {
        if (v >= MOD) v %= MOD;
        if (v == 0) continue;
        
        std::cout << "\nValue: " << v << "\n";
        
        auto r_swap = benchmark(
            "Z_Swap",
            [&]() { test_single_value<Z_Swap<>>(v, sink); },
            50000,
            100
        );
        
        auto r_swapless = benchmark(
            "Z_Swapless",
            [&]() { test_single_value<Z_Swapless<>>(v, sink); },
            50000,
            100
        );
        
        print_result("  Z_Swap", r_swap);
        print_result("  Z_Swapless", r_swapless);
        
        double speedup = r_swap.mean_ns / r_swapless.mean_ns;
        std::cout << "  Speedup: " << std::fixed << std::setprecision(4) << speedup << "x\n";
    }
    
    // ========================================================================
    // Summary
    // ========================================================================
    std::cout << "\n=============================================================\n";
    std::cout << "Summary\n";
    std::cout << "=============================================================\n";
    std::cout << "Overall speedup (bulk test): " << std::setprecision(4) << speedup_bulk << "x\n";
    std::cout << "Single value speedup: " << std::setprecision(4) << speedup_single << "x\n";
    std::cout << "\nNote: Speedup > 1.0 means Swapless is faster\n";
    std::cout << "      Speedup < 1.0 means Swap is faster\n";
    
    return 0;
}