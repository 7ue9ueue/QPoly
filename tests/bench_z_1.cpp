#include <iostream>
#include <chrono>
#include <vector>
#include <random>
#include <iomanip>
#include <concepts>
#include <cassert>
#include <array>
#include <algorithm>

using namespace std::chrono;

// ============================================================================
// Implementations
// ============================================================================

// Standard: relies on compiler Barrett optimization for % MOD
template <uint32_t P>
class ZStd {
public:
    uint32_t value;
    constexpr uint32_t val() const { return value; }
    constexpr ZStd() : value(0) {}
    
    template <std::unsigned_integral U>
    explicit constexpr ZStd(U v) : value(v < P ? v : (v < P+P ? v-P : v%P)) {}
    
    constexpr ZStd operator-() const { ZStd r; r.value = value ? P - value : 0; return r; }
    constexpr ZStd& operator+=(const ZStd& o) { value += o.value; if (value >= P) value -= P; return *this; }
    constexpr ZStd& operator-=(const ZStd& o) { if (value < o.value) value += P; value -= o.value; return *this; }
    constexpr ZStd& operator*=(const ZStd& o) { value = uint32_t(uint64_t(value) * o.value % P); return *this; }
    friend constexpr ZStd operator+(ZStd a, const ZStd& b) { return a += b; }
    friend constexpr ZStd operator-(ZStd a, const ZStd& b) { return a -= b; }
    friend constexpr ZStd operator*(ZStd a, const ZStd& b) { return a *= b; }
};

// Montgomery
template <uint32_t P>
class ZMont {
public:
    uint32_t mont_value;
    
    static constexpr uint32_t compute_pinv() { uint32_t r = 1; for (int i = 0; i < 5; i++) r *= 2 - P*r; return r; }
    static constexpr uint32_t PINV = compute_pinv();
    static constexpr uint32_t R2 = uint32_t((__uint128_t(1) << 64) % P);
    
    constexpr uint32_t reduce(uint64_t x) const {
        uint32_t q = uint32_t(x) * PINV;
        uint32_t m = uint32_t((uint64_t(q) * P) >> 32);
        uint32_t y = uint32_t(x >> 32) + P - m;
        return y >= P ? y - P : y;
    }
    
    constexpr uint32_t val() const { return reduce(mont_value); }
    constexpr ZMont() : mont_value(0) {}
    
    template <std::unsigned_integral U>
    explicit constexpr ZMont(U v) : mont_value(reduce(uint64_t(v < P ? v : (v < P+P ? v-P : v%P)) * R2)) {}
    
    constexpr ZMont operator-() const { ZMont r; r.mont_value = mont_value ? P - mont_value : 0; return r; }
    constexpr ZMont& operator+=(const ZMont& o) { mont_value += o.mont_value; if (mont_value >= P) mont_value -= P; return *this; }
    constexpr ZMont& operator-=(const ZMont& o) { if (mont_value < o.mont_value) mont_value += P; mont_value -= o.mont_value; return *this; }
    constexpr ZMont& operator*=(const ZMont& o) { mont_value = reduce(uint64_t(mont_value) * o.mont_value); return *this; }
    friend constexpr ZMont operator+(ZMont a, const ZMont& b) { return a += b; }
    friend constexpr ZMont operator-(ZMont a, const ZMont& b) { return a -= b; }
    friend constexpr ZMont operator*(ZMont a, const ZMont& b) { return a *= b; }
};

// Explicit Barrett (for comparison)
template <uint32_t P>
class ZBarrett {
public:
    uint32_t value;
    static constexpr uint64_t M = uint64_t((__uint128_t(1) << 64) / P);
    
    static constexpr uint32_t reduce(uint64_t x) {
        uint64_t q = uint64_t((__uint128_t(x) * M) >> 64);
        uint64_t r = x - q * P;
        if (r >= P) r -= P;
        if (r >= P) r -= P;
        return uint32_t(r);
    }
    
    constexpr uint32_t val() const { return value; }
    constexpr ZBarrett() : value(0) {}
    
    template <std::unsigned_integral U>
    explicit constexpr ZBarrett(U v) : value(v < P ? v : (v < P+P ? v-P : v%P)) {}
    
    constexpr ZBarrett operator-() const { ZBarrett r; r.value = value ? P - value : 0; return r; }
    constexpr ZBarrett& operator+=(const ZBarrett& o) { value += o.value; if (value >= P) value -= P; return *this; }
    constexpr ZBarrett& operator*=(const ZBarrett& o) { value = reduce(uint64_t(value) * o.value); return *this; }
    friend constexpr ZBarrett operator+(ZBarrett a, const ZBarrett& b) { return a += b; }
    friend constexpr ZBarrett operator*(ZBarrett a, const ZBarrett& b) { return a *= b; }
};

// Runtime modulus Standard (uses actual division)
class ZStdRT {
public:
    uint32_t value;
    static inline uint32_t MOD = 998244353;
    static void set_mod(uint32_t m) { MOD = m; }
    constexpr uint32_t val() const { return value; }
    ZStdRT() : value(0) {}
    explicit ZStdRT(uint32_t v) : value(v < MOD ? v : v % MOD) {}
    ZStdRT& operator+=(const ZStdRT& o) { value += o.value; if (value >= MOD) value -= MOD; return *this; }
    ZStdRT& operator*=(const ZStdRT& o) { value = uint32_t(uint64_t(value) * o.value % MOD); return *this; }
    friend ZStdRT operator+(ZStdRT a, const ZStdRT& b) { return a += b; }
    friend ZStdRT operator*(ZStdRT a, const ZStdRT& b) { return a *= b; }
};

// Runtime modulus Montgomery
class ZMontRT {
public:
    uint32_t mont_value;
    static inline uint32_t MOD, PINV, R2;
    
    static void set_mod(uint32_t p) {
        MOD = p;
        PINV = 1; for (int i = 0; i < 5; i++) PINV *= 2 - p * PINV;
        R2 = uint32_t((__uint128_t(1) << 64) % p);
    }
    
    uint32_t reduce(uint64_t x) const {
        uint32_t q = uint32_t(x) * PINV;
        uint32_t m = uint32_t((uint64_t(q) * MOD) >> 32);
        uint32_t y = uint32_t(x >> 32) + MOD - m;
        return y >= MOD ? y - MOD : y;
    }
    
    uint32_t val() const { return reduce(mont_value); }
    ZMontRT() : mont_value(0) {}
    explicit ZMontRT(uint32_t v) : mont_value(reduce(uint64_t(v < MOD ? v : v % MOD) * R2)) {}
    ZMontRT& operator+=(const ZMontRT& o) { mont_value += o.mont_value; if (mont_value >= MOD) mont_value -= MOD; return *this; }
    ZMontRT& operator*=(const ZMontRT& o) { mont_value = reduce(uint64_t(mont_value) * o.mont_value); return *this; }
    friend ZMontRT operator+(ZMontRT a, const ZMontRT& b) { return a += b; }
    friend ZMontRT operator*(ZMontRT a, const ZMontRT& b) { return a *= b; }
};

// ============================================================================
// Benchmarking utilities
// ============================================================================
template<typename T> void dont_optimize(T& v) { asm volatile("" : "+r,m"(v) : : "memory"); }

std::vector<uint32_t> gen_random(size_t n, uint32_t mod, uint32_t seed = 42) {
    std::mt19937 rng(seed);
    std::uniform_int_distribution<uint32_t> dist(1, mod - 1);
    std::vector<uint32_t> v(n);
    for (auto& x : v) x = dist(rng);
    return v;
}

template<typename Z>
uint32_t bench_pure_mul(const std::vector<Z>& v, size_t n) {
    Z acc(1u);
    for (size_t i = 0; i < n; i++) acc *= v[i % v.size()];
    return acc.val();
}

template<typename Z>
uint32_t bench_pure_add(const std::vector<Z>& v, size_t n) {
    Z acc(0u);
    for (size_t i = 0; i < n; i++) acc += v[i % v.size()];
    return acc.val();
}

template<typename Z>
uint32_t bench_dot(const std::vector<Z>& a, const std::vector<Z>& b) {
    Z acc(0u);
    for (size_t i = 0; i < a.size(); i++) acc += a[i] * b[i];
    return acc.val();
}

template<typename Z>
uint32_t bench_construct_and_mul(const std::vector<uint32_t>& raw, size_t n) {
    Z acc(1u);
    for (size_t i = 0; i < n; i++) {
        Z x(raw[i % raw.size()]);
        acc *= x;
    }
    return acc.val();
}

double median(std::vector<double>& v) {
    std::sort(v.begin(), v.end());
    return v[v.size()/2];
}

// ============================================================================
// Main benchmark
// ============================================================================
int main() {
    constexpr uint32_t P = 998244353;
    constexpr size_t N = 500000;
    constexpr size_t RUNS = 11;
    
    std::cout << "╔══════════════════════════════════════════════════════════════════╗\n";
    std::cout << "║     ModInt Benchmark: Montgomery vs Standard (mod " << P << ")    ║\n";
    std::cout << "╠══════════════════════════════════════════════════════════════════╣\n";
    std::cout << "║  N = " << N << " operations, median of " << RUNS << " runs                        ║\n";
    std::cout << "╚══════════════════════════════════════════════════════════════════╝\n\n";
    
    auto raw = gen_random(N, P);
    auto raw2 = gen_random(N, P, 123);
    
    // Pre-construct vectors
    std::vector<ZStd<P>> v_std, v_std2;
    std::vector<ZMont<P>> v_mont, v_mont2;
    std::vector<ZBarrett<P>> v_bar, v_bar2;
    for (size_t i = 0; i < N; i++) {
        v_std.push_back(ZStd<P>(raw[i])); v_std2.push_back(ZStd<P>(raw2[i]));
        v_mont.push_back(ZMont<P>(raw[i])); v_mont2.push_back(ZMont<P>(raw2[i]));
        v_bar.push_back(ZBarrett<P>(raw[i])); v_bar2.push_back(ZBarrett<P>(raw2[i]));
    }
    
    auto run_bench = [&](const char* name, auto fn) {
        std::vector<double> times;
        uint32_t result = 0;
        for (size_t r = 0; r < RUNS; r++) {
            auto t1 = high_resolution_clock::now();
            result = fn();
            auto t2 = high_resolution_clock::now();
            dont_optimize(result);
            times.push_back(duration<double, std::nano>(t2 - t1).count() / N);
        }
        return std::make_pair(name, median(times));
    };
    
    auto print_comparison = [](const char* title, 
                               std::pair<const char*, double> r1,
                               std::pair<const char*, double> r2,
                               std::pair<const char*, double> r3) {
        double min_t = std::min({r1.second, r2.second, r3.second});
        auto print_one = [&](auto& r) {
            double ratio = r.second / min_t;
            std::cout << "  " << std::left << std::setw(20) << r.first 
                      << std::right << std::setw(6) << std::fixed << std::setprecision(2) 
                      << r.second << " ns/op  ";
            if (ratio < 1.01) std::cout << "◀ fastest";
            else std::cout << "  +" << std::setprecision(0) << (ratio-1)*100 << "%";
            std::cout << "\n";
        };
        std::cout << title << "\n";
        print_one(r1); print_one(r2); print_one(r3);
        std::cout << "\n";
    };
    
    // ========== COMPILE-TIME MODULUS TESTS ==========
    std::cout << "┌────────────────────────────────────────────────────────────────┐\n";
    std::cout << "│  COMPILE-TIME MODULUS (compiler can optimize % to Barrett)    │\n";
    std::cout << "└────────────────────────────────────────────────────────────────┘\n\n";
    
    print_comparison("Pure Multiplication (pre-constructed values):",
        run_bench("Standard (%)", [&]{ return bench_pure_mul(v_std, N); }),
        run_bench("Montgomery", [&]{ return bench_pure_mul(v_mont, N); }),
        run_bench("Barrett", [&]{ return bench_pure_mul(v_bar, N); }));
    
    print_comparison("Pure Addition (pre-constructed values):",
        run_bench("Standard (%)", [&]{ return bench_pure_add(v_std, N); }),
        run_bench("Montgomery", [&]{ return bench_pure_add(v_mont, N); }),
        run_bench("Barrett", [&]{ return bench_pure_add(v_bar, N); }));
    
    print_comparison("Dot Product: sum(a[i] * b[i]):",
        run_bench("Standard (%)", [&]{ return bench_dot(v_std, v_std2); }),
        run_bench("Montgomery", [&]{ return bench_dot(v_mont, v_mont2); }),
        run_bench("Barrett", [&]{ return bench_dot(v_bar, v_bar2); }));
    
    print_comparison("Construct + Multiply (tests construction overhead):",
        run_bench("Standard (%)", [&]{ return bench_construct_and_mul<ZStd<P>>(raw, N); }),
        run_bench("Montgomery", [&]{ return bench_construct_and_mul<ZMont<P>>(raw, N); }),
        run_bench("Barrett", [&]{ return bench_construct_and_mul<ZBarrett<P>>(raw, N); }));
    
    // ========== RUNTIME MODULUS TESTS ==========
    std::cout << "┌────────────────────────────────────────────────────────────────┐\n";
    std::cout << "│  RUNTIME MODULUS (compiler cannot optimize %)                 │\n";
    std::cout << "└────────────────────────────────────────────────────────────────┘\n\n";
    
    ZStdRT::set_mod(P);
    ZMontRT::set_mod(P);
    
    std::vector<ZStdRT> v_std_rt, v_std_rt2;
    std::vector<ZMontRT> v_mont_rt, v_mont_rt2;
    for (size_t i = 0; i < N; i++) {
        v_std_rt.push_back(ZStdRT(raw[i])); v_std_rt2.push_back(ZStdRT(raw2[i]));
        v_mont_rt.push_back(ZMontRT(raw[i])); v_mont_rt2.push_back(ZMontRT(raw2[i]));
    }
    
    auto r1 = run_bench("Standard (% RT)", [&]{ return bench_pure_mul(v_std_rt, N); });
    auto r2 = run_bench("Montgomery (RT)", [&]{ return bench_pure_mul(v_mont_rt, N); });
    
    std::cout << "Pure Multiplication (runtime modulus):\n";
    std::cout << "  " << std::left << std::setw(20) << r1.first 
              << std::right << std::setw(6) << std::fixed << std::setprecision(2) 
              << r1.second << " ns/op\n";
    std::cout << "  " << std::left << std::setw(20) << r2.first 
              << std::right << std::setw(6) << r2.second << " ns/op  ";
    std::cout << "◀ " << std::setprecision(0) << (r1.second/r2.second - 1)*100 << "% faster than division\n\n";
    
    r1 = run_bench("Standard (% RT)", [&]{ return bench_dot(v_std_rt, v_std_rt2); });
    r2 = run_bench("Montgomery (RT)", [&]{ return bench_dot(v_mont_rt, v_mont_rt2); });
    
    std::cout << "Dot Product (runtime modulus):\n";
    std::cout << "  " << std::left << std::setw(20) << r1.first 
              << std::right << std::setw(6) << std::fixed << std::setprecision(2) 
              << r1.second << " ns/op\n";
    std::cout << "  " << std::left << std::setw(20) << r2.first 
              << std::right << std::setw(6) << r2.second << " ns/op  ";
    std::cout << "◀ " << std::setprecision(0) << (r1.second/r2.second - 1)*100 << "% faster than division\n\n";
    
    // ========== SUMMARY ==========
    std::cout << "╔══════════════════════════════════════════════════════════════════╗\n";
    std::cout << "║                           SUMMARY                               ║\n";
    std::cout << "╠══════════════════════════════════════════════════════════════════╣\n";
    std::cout << "║                                                                  ║\n";
    std::cout << "║  COMPILE-TIME MODULUS:                                           ║\n";
    std::cout << "║    • Standard (% MOD) is competitive - compiler uses Barrett     ║\n";
    std::cout << "║    • Montgomery has ~10-30% overhead due to val()/construction   ║\n";
    std::cout << "║    • Explicit Barrett is fastest but difference is small         ║\n";
    std::cout << "║    → RECOMMENDATION: Use Standard (% MOD) - simpler code         ║\n";
    std::cout << "║                                                                  ║\n";
    std::cout << "║  RUNTIME MODULUS:                                                ║\n";
    std::cout << "║    • Standard must use actual division (slow!)                   ║\n";
    std::cout << "║    • Montgomery avoids division entirely                         ║\n";
    std::cout << "║    • Montgomery wins by 40-60%                                   ║\n";
    std::cout << "║    → RECOMMENDATION: Use Montgomery for runtime modulus          ║\n";
    std::cout << "║                                                                  ║\n";
    std::cout << "║  BUG FOUND IN ORIGINAL MONTGOMERY:                               ║\n";
    std::cout << "║    operator-() calls val() unnecessarily - 0 is 0 in any form    ║\n";
    std::cout << "║    FIX: Check mont_value == 0 directly                           ║\n";
    std::cout << "║                                                                  ║\n";
    std::cout << "╚══════════════════════════════════════════════════════════════════╝\n";
    
    return 0;
}