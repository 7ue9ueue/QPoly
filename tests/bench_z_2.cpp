#include <iostream>
#include <cstdint>
#include <concepts>
#include <type_traits>
#include <cassert>
#include <chrono>
#include <vector>
#include <random>
#include <numeric>
#include <iomanip>
#include <algorithm>

// ============================================================================
// Implementation 1: Z class (Extended Euclidean Algorithm for inv)
// ============================================================================
template <std::unsigned_integral T = uint32_t, T P = 998244353>
class Z {
public:
    T value;
    constexpr static T MOD = P;

#ifdef __SIZEOF_INT128__
    using twice_T = std::conditional_t<sizeof(T) == 4, uint64_t, __uint128_t>;
#else
    static_assert(sizeof(T) == 4, "64-bit modular arithmetic requires __uint128_t support");
    using twice_T = uint64_t;
#endif

    constexpr T val() const { return value; }
    constexpr Z() : value(0) {}

    template <std::unsigned_integral U>
    explicit constexpr Z(U v) {
        if (v < MOD) [[likely]] value = v;
        else if (v < MOD + MOD) value = v - MOD;
        else [[unlikely]] value = v % MOD;
    }

    using signed_T = std::make_signed_t<T>;
    static constexpr signed_T signed_P = static_cast<signed_T>(P);

    template <std::signed_integral U>
    explicit constexpr Z(U v) {
        if (v >= 0 && v < signed_P) [[likely]] value = v;
        else if (v < 0 && v >= -signed_P) value = v + MOD;
        else [[unlikely]] {
            auto x = v % signed_P;
            if (x < 0) x += MOD;
            value = x;
        }
    }

    constexpr Z operator-() const {
        Z result(value);
        if (result.value != 0) result.value = MOD - result.value;
        return result;
    }

    constexpr Z& operator+=(const Z& other) {
        value += other.value;
        if (value >= MOD) value -= MOD;
        return *this;
    }

    constexpr Z& operator-=(const Z& other) {
        if (value < other.value) value += MOD;
        value -= other.value;
        return *this;
    }

    constexpr Z& operator*=(const Z& other) {
        value = static_cast<T>((twice_T(value) * other.value) % MOD);
        return *this;
    }

    constexpr Z& operator/=(const Z& other) {
        return *this *= other.inv();
    }

    friend constexpr Z operator+(Z lhs, const Z& rhs) { return lhs += rhs; }
    friend constexpr Z operator-(Z lhs, const Z& rhs) { return lhs -= rhs; }
    friend constexpr Z operator*(Z lhs, const Z& rhs) { return lhs *= rhs; }
    friend constexpr Z operator/(Z lhs, const Z& rhs) { return lhs /= rhs; }

    friend constexpr bool operator==(const Z& lhs, const Z& rhs) { return lhs.val() == rhs.val(); }

    //Extended Euclidean Algorithm
    // constexpr Z inv() const {
    //     assert(value != 0 && "Z: zero has no inverse");
    //     using S = std::make_signed_t<T>;
    //     S a = value, b = MOD, x = 1, y = 0;
    //     while (b) {
    //         S q = a / b;
    //         a -= q * b; std::swap(a, b);
    //         x -= q * y; std::swap(x, y);
    //     }
    //     assert(a == 1 && "Z: requires gcd(value, mod) == 1");
    //     return Z(x);
    // }
    constexpr Z qpow(T b) const {
        Z res(1u), a = *this;
        while (b) {
            if (b & 1) res *= a;
            a *= a;
            b >>= 1;
        }
        return res;
    }

    static constexpr T INV_POW = MOD - 2;
    constexpr Z inv() const {
        assert(value != 0 && "Z: zero has no inverse");
        using wide_S = std::make_signed_t<twice_T>;
        wide_S a = value, b = MOD, x0 = 1, x1 = 0;
        while (b) {
            wide_S q = a / b;
            wide_S a2 = a - q * b; a = b; b = a2;
            wide_S x2 = x0 - q * x1; x0 = x1; x1 = x2;
        }
        assert(a == 1 && "Z: requires gcd(value, mod) == 1");
        if (x0 < 0) x0 += MOD;
        return Z(static_cast<T>(x0));
    }
};

// ============================================================================
// Implementation 2: ModIntBase class (Fermat's Little Theorem for inv)
// ============================================================================
template<class T>
constexpr T power_impl(T a, uint64_t b, T res = T(1u)) {
    for (; b != 0; b /= 2, a *= a) {
        if (b & 1) res *= a;
    }
    return res;
}

template<uint32_t P>
constexpr uint32_t mulMod(uint32_t a, uint32_t b) {
    return uint64_t(a) * b % P;
}

template<std::unsigned_integral U, U P>
struct ModIntBase {
public:
    constexpr ModIntBase() : x(0) {}
    
    template<std::unsigned_integral T>
    constexpr ModIntBase(T x_) : x(x_ % mod()) {}
    
    template<std::signed_integral T>
    constexpr ModIntBase(T x_) {
        using S = std::make_signed_t<U>;
        S v = x_ % S(mod());
        if (v < 0) v += mod();
        x = v;
    }

    constexpr static U mod() { return P; }
    constexpr U val() const { return x; }

    constexpr ModIntBase operator-() const {
        ModIntBase res;
        res.x = (x == 0 ? 0 : mod() - x);
        return res;
    }

    // Fermat's Little Theorem: a^(-1) = a^(p-2) mod p
    constexpr ModIntBase inv() const {
        return power_impl(*this, mod() - 2);
    }

    constexpr ModIntBase& operator*=(const ModIntBase& rhs) & {
        x = mulMod<mod()>(x, rhs.val());
        return *this;
    }

    constexpr ModIntBase& operator+=(const ModIntBase& rhs) & {
        x += rhs.val();
        if (x >= mod()) x -= mod();
        return *this;
    }

    constexpr ModIntBase& operator-=(const ModIntBase& rhs) & {
        x -= rhs.val();
        if (x >= mod()) x += mod();
        return *this;
    }

    constexpr ModIntBase& operator/=(const ModIntBase& rhs) & {
        return *this *= rhs.inv();
    }

    friend constexpr ModIntBase operator*(ModIntBase lhs, const ModIntBase& rhs) { lhs *= rhs; return lhs; }
    friend constexpr ModIntBase operator+(ModIntBase lhs, const ModIntBase& rhs) { lhs += rhs; return lhs; }
    friend constexpr ModIntBase operator-(ModIntBase lhs, const ModIntBase& rhs) { lhs -= rhs; return lhs; }
    friend constexpr ModIntBase operator/(ModIntBase lhs, const ModIntBase& rhs) { lhs /= rhs; return lhs; }

    friend constexpr bool operator==(const ModIntBase& lhs, const ModIntBase& rhs) {
        return lhs.val() == rhs.val();
    }

private:
    U x;
};

// ============================================================================
// Benchmark utilities
// ============================================================================
using Clock = std::chrono::high_resolution_clock;

template<typename F>
double benchmark_ns(F&& func, int iterations) {
    auto start = Clock::now();
    for (int i = 0; i < iterations; ++i) {
        func();
    }
    auto end = Clock::now();
    return std::chrono::duration<double, std::nano>(end - start).count() / iterations;
}

// Prevent compiler from optimizing away the result
template<typename T>
void do_not_optimize(T const& value) {
    asm volatile("" : : "r,m"(value) : "memory");
}

template<typename T>
void do_not_optimize(T& value) {
    asm volatile("" : "+r,m"(value) : : "memory");
}

// ============================================================================
// Main benchmark
// ============================================================================
int main() {
    using Z_t = Z<uint32_t, 998244353>;
    using M_t = ModIntBase<uint32_t, 998244353>;
    
    constexpr int WARMUP = 1000;
    constexpr int TRIALS = 10;
    constexpr int OPS_PER_TRIAL = 100000;
    
    std::mt19937_64 rng(42);
    std::uniform_int_distribution<uint32_t> dist(1, 998244352);
    
    // Generate test data
    std::vector<uint32_t> test_values(OPS_PER_TRIAL);
    for (auto& v : test_values) v = dist(rng);
    
    std::vector<uint32_t> divisors(OPS_PER_TRIAL);
    for (auto& v : divisors) v = dist(rng);
    
    std::cout << "============================================================\n";
    std::cout << "Modular Integer Benchmark: Z (ExtGCD) vs ModIntBase (Fermat)\n";
    std::cout << "============================================================\n";
    std::cout << "MOD = 998244353, Operations per trial = " << OPS_PER_TRIAL << "\n";
    std::cout << "Trials = " << TRIALS << ", Warmup iterations = " << WARMUP << "\n\n";
    
    // ========================================================================
    // Benchmark 1: Pure inv() calls
    // ========================================================================
    std::cout << "--- Benchmark 1: inv() function ---\n";
    
    // Warmup
    for (int i = 0; i < WARMUP; ++i) {
        Z_t z(test_values[i % OPS_PER_TRIAL]);
        do_not_optimize(z.inv());
        M_t m(test_values[i % OPS_PER_TRIAL]);
        do_not_optimize(m.inv());
    }
    
    std::vector<double> z_inv_times, m_inv_times;
    
    for (int trial = 0; trial < TRIALS; ++trial) {
        // Z inv
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 0; i < OPS_PER_TRIAL; ++i) {
                Z_t z(test_values[i]);
                auto inv = z.inv();
                checksum += inv.val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            z_inv_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
        
        // ModIntBase inv
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 0; i < OPS_PER_TRIAL; ++i) {
                M_t m(test_values[i]);
                auto inv = m.inv();
                checksum += inv.val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            m_inv_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
    }
    
    double z_inv_avg = std::accumulate(z_inv_times.begin(), z_inv_times.end(), 0.0) / TRIALS;
    double m_inv_avg = std::accumulate(m_inv_times.begin(), m_inv_times.end(), 0.0) / TRIALS;
    
    std::sort(z_inv_times.begin(), z_inv_times.end());
    std::sort(m_inv_times.begin(), m_inv_times.end());
    double z_inv_med = z_inv_times[TRIALS / 2];
    double m_inv_med = m_inv_times[TRIALS / 2];
    
    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Z (ExtGCD):      avg = " << z_inv_avg << " ms, median = " << z_inv_med << " ms\n";
    std::cout << "ModIntBase (Fermat): avg = " << m_inv_avg << " ms, median = " << m_inv_med << " ms\n";
    std::cout << "Speedup (avg): " << std::setprecision(2) << m_inv_avg / z_inv_avg << "x (Z faster if > 1)\n";
    std::cout << "Per-op (avg): Z = " << std::setprecision(1) << (z_inv_avg * 1e6 / OPS_PER_TRIAL) 
              << " ns, M = " << (m_inv_avg * 1e6 / OPS_PER_TRIAL) << " ns\n\n";
    
    // ========================================================================
    // Benchmark 2: Division operator (a / b)
    // ========================================================================
    std::cout << "--- Benchmark 2: Division operator (a / b) ---\n";
    
    std::vector<double> z_div_times, m_div_times;
    
    for (int trial = 0; trial < TRIALS; ++trial) {
        // Z division
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 0; i < OPS_PER_TRIAL; ++i) {
                Z_t a(test_values[i]);
                Z_t b(divisors[i]);
                auto result = a / b;
                checksum += result.val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            z_div_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
        
        // ModIntBase division
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 0; i < OPS_PER_TRIAL; ++i) {
                M_t a(test_values[i]);
                M_t b(divisors[i]);
                auto result = a / b;
                checksum += result.val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            m_div_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
    }
    
    double z_div_avg = std::accumulate(z_div_times.begin(), z_div_times.end(), 0.0) / TRIALS;
    double m_div_avg = std::accumulate(m_div_times.begin(), m_div_times.end(), 0.0) / TRIALS;
    
    std::sort(z_div_times.begin(), z_div_times.end());
    std::sort(m_div_times.begin(), m_div_times.end());
    double z_div_med = z_div_times[TRIALS / 2];
    double m_div_med = m_div_times[TRIALS / 2];
    
    std::cout << "Z (ExtGCD):      avg = " << std::setprecision(3) << z_div_avg << " ms, median = " << z_div_med << " ms\n";
    std::cout << "ModIntBase (Fermat): avg = " << m_div_avg << " ms, median = " << m_div_med << " ms\n";
    std::cout << "Speedup (avg): " << std::setprecision(2) << m_div_avg / z_div_avg << "x (Z faster if > 1)\n";
    std::cout << "Per-op (avg): Z = " << std::setprecision(1) << (z_div_avg * 1e6 / OPS_PER_TRIAL) 
              << " ns, M = " << (m_div_avg * 1e6 / OPS_PER_TRIAL) << " ns\n\n";
    
    // ========================================================================
    // Benchmark 3: Mixed operations (realistic usage pattern)
    // ========================================================================
    std::cout << "--- Benchmark 3: Mixed ops (add, mul, div in 4:4:1 ratio) ---\n";
    
    std::vector<double> z_mix_times, m_mix_times;
    
    for (int trial = 0; trial < TRIALS; ++trial) {
        // Z mixed
        {
            Z_t acc(1u);
            auto start = Clock::now();
            for (int i = 0; i < OPS_PER_TRIAL; ++i) {
                Z_t v(test_values[i]);
                int op = i % 9;
                if (op < 4) acc += v;
                else if (op < 8) acc *= v;
                else acc /= Z_t(divisors[i]);
            }
            auto end = Clock::now();
            do_not_optimize(acc);
            z_mix_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
        
        // ModIntBase mixed
        {
            M_t acc(1u);
            auto start = Clock::now();
            for (int i = 0; i < OPS_PER_TRIAL; ++i) {
                M_t v(test_values[i]);
                int op = i % 9;
                if (op < 4) acc += v;
                else if (op < 8) acc *= v;
                else acc /= M_t(divisors[i]);
            }
            auto end = Clock::now();
            do_not_optimize(acc);
            m_mix_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
    }
    
    double z_mix_avg = std::accumulate(z_mix_times.begin(), z_mix_times.end(), 0.0) / TRIALS;
    double m_mix_avg = std::accumulate(m_mix_times.begin(), m_mix_times.end(), 0.0) / TRIALS;
    
    std::cout << "Z (ExtGCD):      avg = " << std::setprecision(3) << z_mix_avg << " ms\n";
    std::cout << "ModIntBase (Fermat): avg = " << m_mix_avg << " ms\n";
    std::cout << "Speedup (avg): " << std::setprecision(2) << m_mix_avg / z_mix_avg << "x (Z faster if > 1)\n\n";
    
    // ========================================================================
    // Benchmark 4: Batch inverse (common in NTT preprocessing)
    // ========================================================================
    std::cout << "--- Benchmark 4: Consecutive inverses (factorial style) ---\n";
    
    std::vector<double> z_batch_times, m_batch_times;
    
    for (int trial = 0; trial < TRIALS; ++trial) {
        // Z batch
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 1; i <= OPS_PER_TRIAL; ++i) {
                Z_t z(static_cast<uint32_t>(i));
                checksum += z.inv().val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            z_batch_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
        
        // ModIntBase batch
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 1; i <= OPS_PER_TRIAL; ++i) {
                M_t m(static_cast<uint32_t>(i));
                checksum += m.inv().val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            m_batch_times.push_back(std::chrono::duration<double, std::milli>(end - start).count());
        }
    }
    
    double z_batch_avg = std::accumulate(z_batch_times.begin(), z_batch_times.end(), 0.0) / TRIALS;
    double m_batch_avg = std::accumulate(m_batch_times.begin(), m_batch_times.end(), 0.0) / TRIALS;
    
    std::cout << "Z (ExtGCD):      avg = " << std::setprecision(3) << z_batch_avg << " ms\n";
    std::cout << "ModIntBase (Fermat): avg = " << m_batch_avg << " ms\n";
    std::cout << "Speedup (avg): " << std::setprecision(2) << m_batch_avg / z_batch_avg << "x (Z faster if > 1)\n\n";
    
    // ========================================================================
    // Benchmark 5: Small value inverses (1-1000, common case)
    // ========================================================================
    std::cout << "--- Benchmark 5: Small value inverses (1-1000) ---\n";
    
    constexpr int SMALL_ITERS = 1000;
    std::vector<double> z_small_times, m_small_times;
    
    for (int trial = 0; trial < TRIALS * 10; ++trial) {  // More trials for accuracy
        // Z small
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 1; i <= SMALL_ITERS; ++i) {
                Z_t z(static_cast<uint32_t>(i));
                checksum += z.inv().val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            z_small_times.push_back(std::chrono::duration<double, std::micro>(end - start).count());
        }
        
        // ModIntBase small
        {
            auto start = Clock::now();
            uint64_t checksum = 0;
            for (int i = 1; i <= SMALL_ITERS; ++i) {
                M_t m(static_cast<uint32_t>(i));
                checksum += m.inv().val();
            }
            auto end = Clock::now();
            do_not_optimize(checksum);
            m_small_times.push_back(std::chrono::duration<double, std::micro>(end - start).count());
        }
    }
    
    double z_small_avg = std::accumulate(z_small_times.begin(), z_small_times.end(), 0.0) / (TRIALS * 10);
    double m_small_avg = std::accumulate(m_small_times.begin(), m_small_times.end(), 0.0) / (TRIALS * 10);
    
    std::cout << "Z (ExtGCD):      avg = " << std::setprecision(2) << z_small_avg << " µs\n";
    std::cout << "ModIntBase (Fermat): avg = " << m_small_avg << " µs\n";
    std::cout << "Speedup (avg): " << m_small_avg / z_small_avg << "x (Z faster if > 1)\n\n";
    
    // ========================================================================
    // Correctness verification
    // ========================================================================
    std::cout << "--- Correctness Verification ---\n";
    bool correct = true;
    for (int i = 0; i < 10000; ++i) {
        uint32_t v = dist(rng);
        Z_t z(v);
        M_t m(v);
        if (z.inv().val() != m.inv().val()) {
            std::cout << "MISMATCH at v=" << v << ": Z=" << z.inv().val() 
                      << ", M=" << m.inv().val() << "\n";
            correct = false;
            break;
        }
        // Verify it's actually the inverse
        if ((Z_t(v) * z.inv()).val() != 1) {
            std::cout << "Z inverse incorrect at v=" << v << "\n";
            correct = false;
            break;
        }
    }
    if (correct) std::cout << "All inverses match and are correct!\n\n";
    
    // ========================================================================
    // Summary
    // ========================================================================
    std::cout << "============================================================\n";
    std::cout << "Summary:\n";
    std::cout << "============================================================\n";
    std::cout << "Z uses Extended Euclidean Algorithm: O(log P) divisions\n";
    std::cout << "ModIntBase uses Fermat's Little Theorem: O(log P) multiplications\n\n";
    std::cout << "ExtGCD has fewer iterations but uses division (higher latency).\n";
    std::cout << "Fermat uses ~30 squarings + ~15 muls but mul is cheaper than div.\n";
    std::cout << "For small values, ExtGCD terminates faster (fewer iterations).\n";
    
    return 0;
}
/*
============================================================
Modular Integer Benchmark: Z (ExtGCD) vs ModIntBase (Fermat)
============================================================
MOD = 998244353, Operations per trial = 100000
Trials = 10, Warmup iterations = 1000

--- Benchmark 1: inv() function ---
Z (ExtGCD):      avg = 34.599 ms, median = 34.250 ms
ModIntBase (Fermat): avg = 54.068 ms, median = 54.117 ms
Speedup (avg): 1.56x (Z faster if > 1)
Per-op (avg): Z = 346.0 ns, M = 540.7 ns

--- Benchmark 2: Division operator (a / b) ---
Z (ExtGCD):      avg = 35.663 ms, median = 35.727 ms
ModIntBase (Fermat): avg = 56.776 ms, median = 56.944 ms
Speedup (avg): 1.59x (Z faster if > 1)
Per-op (avg): Z = 356.6 ns, M = 567.8 ns

--- Benchmark 3: Mixed ops (add, mul, div in 4:4:1 ratio) ---
Z (ExtGCD):      avg = 6.028 ms
ModIntBase (Fermat): avg = 8.598 ms
Speedup (avg): 1.43x (Z faster if > 1)

--- Benchmark 4: Consecutive inverses (factorial style) ---
Z (ExtGCD):      avg = 21.101 ms
ModIntBase (Fermat): avg = 54.032 ms
Speedup (avg): 2.56x (Z faster if > 1)

--- Benchmark 5: Small value inverses (1-1000) ---
Z (ExtGCD):      avg = 147.67 µs
ModIntBase (Fermat): avg = 538.40 µs
Speedup (avg): 3.65x (Z faster if > 1)
*/