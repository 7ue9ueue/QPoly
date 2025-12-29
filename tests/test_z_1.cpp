#include <iostream>
#include <bit>
#include <cassert>
#include <random>
#include <vector>
#include <sstream>
#include <cstdint>
#include <type_traits>
#include"fast_modint.hpp"

// ============================================================================
// Z class (your implementation)
// ============================================================================

// template <std::unsigned_integral T = uint32_t, T P = 998244353>
// class Z {
// public:
//     T mont_value;
//     constexpr static T mod() {return P;}

// #ifdef __SIZEOF_INT128__
//     using T_P = std::conditional_t<sizeof(T) == 4, uint64_t, __uint128_t>;
// #else
//     static_assert(sizeof(T) == 4, "64-bit modular arithmetic requires __uint128_t support");
//     using T_P = uint64_t;
// #endif
    
//     // Montgomery Multiplication
//     static constexpr int BITS = 8 * sizeof(T);
//     static constexpr int BITS_LOG = __builtin_ctz(BITS);

//     static constexpr T compute_p_inv() {
//         T inv = 1;
//         for (int i = 0; i < BITS_LOG; i++) {
//             inv *= 2 - mod() * inv;
//         }
//         return inv;
//     }
//     static constexpr T P_INV = compute_p_inv();
    
//     static constexpr T compute_r1_mod_p () {
//         T x = ((T(1) << (BITS - 1)) % P);
//         if (x + x >= P) return x + x - P;
//         else return x + x;
//     }
//     static constexpr T R1_MOD_P = compute_r1_mod_p();

//     static constexpr T compute_r2_mod_p () {
//         T x = ((T_P(1) << (BITS + BITS - 1)) % P);
//         if (x + x >= P) return x + x - P;
//         else return x + x;
//     }
//     static constexpr T R2_MOD_P = compute_r2_mod_p();

//     // in range [0, 2P)
//     constexpr T mont_reduce(T_P x) const {
//         T q = T(x) * P_INV;
//         T m = (T_P(q) * mod()) >> BITS;
//         T y = (x >> BITS) + mod() - m;
//         return y < mod() ? y : y - mod();
//     }

//     constexpr T mont_mul(T x, T y) const {
//         return static_cast<T>(mont_reduce(static_cast<T_P>(x) * y));
//     }
    
//     constexpr T val() const {
//         return mont_reduce(mont_value);
//     }

//     constexpr Z() : mont_value(0) {}
//     template <std::unsigned_integral U>
//     explicit constexpr Z(U v) {
//         if (v < mod()) {
//             mont_value = mont_mul(v, R2_MOD_P);
//         }
//         else if (v < mod() + mod()) {
//             mont_value = mont_mul(v - static_cast<std::make_signed_t<T>>(mod()), R2_MOD_P);
//         }
//         else {
//             mont_value = mont_mul(v % static_cast<std::make_signed_t<T>>(mod()), R2_MOD_P);
//         }
//     }
//     template <std::signed_integral U>
//     explicit constexpr Z(U v) {
//         if (v >= 0 && static_cast<T>(v) < mod()) {
//             mont_value = mont_mul(v, R2_MOD_P);
//         } 
//         else if (v < 0 && v > -static_cast<std::make_signed_t<T>>(mod())) {
//             mont_value = mont_mul(v + mod(), R2_MOD_P);
//         } 
//         else {
//             auto x = v % static_cast<std::make_signed_t<T>>(mod());
//             if (x < 0) x += mod();
//             mont_value = mont_mul(x, R2_MOD_P);
//         }
//     }

//     constexpr Z operator-() const {
//         Z result;
//         result.mont_value = mont_value;
//         if (result.val() != 0) result.mont_value = mod() + - result.mont_value; 
//         return result;
//     }
//     constexpr Z operator+() const {
//         return *this;
//     }

//     constexpr Z& operator+=(const Z& other) {
//         mont_value += other.mont_value;
//         if (mont_value >= mod()) mont_value -= mod();
//         return *this;
//     }
//     constexpr Z& operator-=(const Z& other) {
//         if (mont_value < other.mont_value) mont_value += mod();
//         mont_value -= other.mont_value;
//         return *this;
//     }

//     constexpr Z& operator++() {
//         mont_value += R1_MOD_P;
//         if (mont_value >= mod()) mont_value -= mod();
//         return *this;
//     }
//     constexpr Z operator++(int) {
//         Z result = *this;
//         ++*this;
//         return result;
//     }
//     constexpr Z& operator--() {
//         mont_value += mod() - R1_MOD_P;
//         if (mont_value >= mod()) mont_value -= mod();
//         return *this;
//     }
//     constexpr Z operator--(int) {
//         Z result = *this;
//         --*this;
//         return result;
//     }

//     constexpr Z& operator*=(const Z& other) {
//         mont_value = mont_mul(mont_value, other.mont_value);
//         return *this;
//     }

//     constexpr Z& operator/=(const Z& other) {
//         assert(other.mont_value != 0 && "Z: division by zero");
//         return *this *= other.inv();
//     }

//     friend constexpr Z operator+(Z lhs, const Z& rhs) { return lhs += rhs; }
//     friend constexpr Z operator-(Z lhs, const Z& rhs) { return lhs -= rhs; }
//     friend constexpr Z operator*(Z lhs, const Z& rhs) { return lhs *= rhs; }
//     friend constexpr Z operator/(Z lhs, const Z& rhs) { return lhs /= rhs; }

//     friend std::istream& operator>>(std::istream& is, Z& a) {int64_t x; is >> x; a = Z(x); return is;}
//     friend std::ostream& operator<<(std::ostream& os, const Z& a) {return os << a.val();}

//     friend constexpr bool operator==(const Z &lhs, const Z &rhs) {return lhs.val() == rhs.val();}
//     friend constexpr std::strong_ordering operator<=>(const Z &lhs, const Z &rhs) {return lhs.val() <=> rhs.val();}

//     constexpr Z inv() const {
//         assert(val() != 0 && "Z: zero has no inverse");
//         using S = std::make_signed_t<T_P>;
//         S a = val(), b = mod(), x = 1, y = 0;
//         while (b) {
//             S q = a / b;
//             a -= q * b; std::swap(a, b);
//             x -= q * y; std::swap(x, y);
//         }
//         assert(a == 1 && "Z: requires gcd(value, mod) == 1");
//         return Z(x);
//     }
// };

// ============================================================================
// Test utilities
// ============================================================================

static int tests_passed = 0;
static int tests_failed = 0;

#define TEST(name) void test_##name()
#define RUN_TEST(name) do { \
    std::cout << "Running " << #name << "... "; \
    try { \
        test_##name(); \
        std::cout << "PASSED\n"; \
        tests_passed++; \
    } catch (const std::exception& e) { \
        std::cout << "FAILED: " << e.what() << "\n"; \
        tests_failed++; \
    } \
} while(0)

#define ASSERT_EQ(a, b) do { \
    auto _a = (a); auto _b = (b); \
    if (_a != _b) { \
        std::ostringstream oss; \
        oss << "Assertion failed: " << #a << " == " << #b \
            << " (got " << _a << " vs " << _b << ")"; \
        throw std::runtime_error(oss.str()); \
    } \
} while(0)

#define ASSERT_TRUE(cond) do { \
    if (!(cond)) { \
        throw std::runtime_error("Assertion failed: " #cond); \
    } \
} while(0)

// Reference implementation for comparison (simple, no Montgomery)
template <typename T, T P>
T ref_add(T a, T b) { return (a + b) % P; }

template <typename T, T P>
T ref_sub(T a, T b) { return (a + P - b) % P; }

template <typename T, T P>
T ref_mul(T a, T b) { 
    using T_P = std::conditional_t<sizeof(T) == 4, uint64_t, __uint128_t>;
    return static_cast<T>((static_cast<T_P>(a) * b) % P); 
}

template <typename T, T P>
T ref_neg(T a) { return a == 0 ? 0 : P - a; }

template <typename T, T P>
T ref_pow(T base, uint64_t exp) {
    T result = 1;
    while (exp > 0) {
        if (exp & 1) result = ref_mul<T, P>(result, base);
        base = ref_mul<T, P>(base, base);
        exp >>= 1;
    }
    return result;
}

template <typename T, T P>
T ref_inv(T a) {
    return ref_pow<T, P>(a, P - 2);  // Fermat's little theorem for prime P
}

// ============================================================================
// Test: Montgomery constants verification
// ============================================================================

TEST(montgomery_constants) {
    using Z998 = Z<uint32_t, 998244353>;
    constexpr uint32_t P = 998244353;
    constexpr uint64_t R = 1ULL << 32;
    
    // Verify P_INV: P * P_INV ≡ 1 (mod R)
    uint64_t product = static_cast<uint64_t>(P) * Z998::P_INV;
    ASSERT_EQ(static_cast<uint32_t>(product), 1u);
    
    // Verify R1_MOD_P: R mod P
    ASSERT_EQ(Z998::R1_MOD_P, static_cast<uint32_t>(R % P));
    
    // Verify R2_MOD_P: R^2 mod P
    __uint128_t R2 = static_cast<__uint128_t>(R) * R;
    ASSERT_EQ(Z998::R2_MOD_P, static_cast<uint32_t>(R2 % P));
}

TEST(montgomery_constants_other_primes) {
    // Test with a different prime
    using Z1e9_7 = Z<uint32_t, 1000000007>;
    constexpr uint32_t P = 1000000007;
    constexpr uint64_t R = 1ULL << 32;
    
    uint64_t product = static_cast<uint64_t>(P) * Z1e9_7::P_INV;
    ASSERT_EQ(static_cast<uint32_t>(product), 1u);
    ASSERT_EQ(Z1e9_7::R1_MOD_P, static_cast<uint32_t>(R % P));
    
    __uint128_t R2 = static_cast<__uint128_t>(R) * R;
    ASSERT_EQ(Z1e9_7::R2_MOD_P, static_cast<uint32_t>(R2 % P));
}

// ============================================================================
// Test: Default constructor
// ============================================================================

TEST(default_constructor) {
    Z<> a;
    ASSERT_EQ(a.val(), 0u);
    ASSERT_EQ(a.mont_value, 0u);
}

// ============================================================================
// Test: Constructors with various integral types
// ============================================================================

TEST(constructor_unsigned_small) {
    // Values in [0, P)
    for (uint32_t v : {0u, 1u, 2u, 100u, 998244352u}) {
        Z<> a(v);
        ASSERT_EQ(a.val(), v);
    }
}

TEST(constructor_unsigned_medium) {
    // Values in [P, 2P)
    constexpr uint32_t P = 998244353;
    for (uint32_t offset : {0u, 1u, 100u, P - 1}) {
        uint32_t v = P + offset;
        Z<> a(v);
        ASSERT_EQ(a.val(), offset);
    }
}

TEST(constructor_unsigned_large) {
    // Values >= 2P
    constexpr uint32_t P = 998244353;
    Z<> a(2u * P);
    ASSERT_EQ(a.val(), 0u);
    
    Z<> b(2u * P + 1);
    ASSERT_EQ(a.val(), 0u);
    
    Z<> c(3u * P + 123);
    ASSERT_EQ(c.val(), 123u);
    
    // Large 64-bit value
    uint64_t big = 10000000000000ULL;
    Z<> d(big);
    ASSERT_EQ(d.val(), static_cast<uint32_t>(big % P));
}

TEST(constructor_signed_positive) {
    // Positive signed values
    for (int32_t v : {0, 1, 2, 100, 998244352}) {
        Z<> a(v);
        ASSERT_EQ(a.val(), static_cast<uint32_t>(v));
    }
    
    // Large positive signed
    int64_t big = 5000000000LL;
    Z<> b(big);
    ASSERT_EQ(b.val(), static_cast<uint32_t>(big % 998244353));
}

TEST(constructor_signed_negative_small) {
    // Negative values in (-P, 0)
    constexpr uint32_t P = 998244353;
    
    Z<> a(-1);
    ASSERT_EQ(a.val(), P - 1);
    
    Z<> b(-2);
    ASSERT_EQ(b.val(), P - 2);
    
    Z<> c(static_cast<int32_t>(-998244352));
    ASSERT_EQ(c.val(), 1u);
}

TEST(constructor_signed_negative_large) {
    // Negative values <= -P
    constexpr int64_t P = 998244353;
    
    Z<> a(-P);
    ASSERT_EQ(a.val(), 0u);
    
    Z<> b(-P - 1);
    ASSERT_EQ(b.val(), static_cast<uint32_t>(P - 1));
    
    Z<> c(-2 * P);
    ASSERT_EQ(c.val(), 0u);
    
    Z<> d(-2 * P - 100);
    ASSERT_EQ(d.val(), static_cast<uint32_t>(P - 100));
    
    // Very negative
    int64_t very_neg = -10000000000LL;
    Z<> e(very_neg);
    int64_t expected = very_neg % P;
    if (expected < 0) expected += P;
    ASSERT_EQ(e.val(), static_cast<uint32_t>(expected));
}

TEST(constructor_various_types) {
    // Test different integral types
    Z<> a(static_cast<uint8_t>(42));
    ASSERT_EQ(a.val(), 42u);
    
    Z<> b(static_cast<int8_t>(-42));
    ASSERT_EQ(b.val(), 998244353u - 42);
    
    Z<> c(static_cast<uint16_t>(65535));
    ASSERT_EQ(c.val(), 65535u);
    
    Z<> d(static_cast<int16_t>(-32768));
    ASSERT_EQ(d.val(), 998244353u - 32768);
    
    Z<> e(static_cast<size_t>(12345678901234ULL));
    ASSERT_EQ(e.val(), static_cast<uint32_t>(12345678901234ULL % 998244353));
}

// ============================================================================
// Test: val() correctness
// ============================================================================

TEST(val_roundtrip) {
    std::mt19937_64 rng(12345);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 10000; i++) {
        uint32_t v = rng() % P;
        Z<> a(v);
        ASSERT_EQ(a.val(), v);
    }
}

// ============================================================================
// Test: Unary operators
// ============================================================================

TEST(unary_plus) {
    for (uint32_t v : {0u, 1u, 100u, 998244352u}) {
        Z<> a(v);
        Z<> b = +a;
        ASSERT_EQ(b.val(), v);
    }
}

TEST(unary_minus) {
    constexpr uint32_t P = 998244353;
    
    // -0 = 0
    Z<> a(0u);
    ASSERT_EQ((-a).val(), 0u);
    
    // -1 = P-1
    Z<> b(1u);
    ASSERT_EQ((-b).val(), P - 1);
    
    // -(P-1) = 1
    Z<> c(P - 1);
    ASSERT_EQ((-c).val(), 1u);
    
    // Double negation
    for (uint32_t v : {0u, 1u, 100u, 500000000u, P - 1}) {
        Z<> x(v);
        ASSERT_EQ((-(-x)).val(), v);
    }
}

TEST(unary_minus_random) {
    std::mt19937_64 rng(54321);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 10000; i++) {
        uint32_t v = rng() % P;
        Z<> a(v);
        uint32_t expected = ref_neg<uint32_t, P>(v);
        ASSERT_EQ((-a).val(), expected);
    }
}

// ============================================================================
// Test: Addition
// ============================================================================

TEST(addition_basic) {
    // 0 + 0 = 0
    Z<> a(0u), b(0u);
    ASSERT_EQ((a + b).val(), 0u);
    
    // 0 + x = x
    Z<> c(12345u);
    ASSERT_EQ((a + c).val(), 12345u);
    ASSERT_EQ((c + a).val(), 12345u);
    
    // Simple addition
    Z<> d(100u), e(200u);
    ASSERT_EQ((d + e).val(), 300u);
}

TEST(addition_wraparound) {
    constexpr uint32_t P = 998244353;
    
    // (P-1) + 1 = 0
    Z<> a(P - 1), b(1u);
    ASSERT_EQ((a + b).val(), 0u);
    
    // (P-1) + (P-1) = P-2
    Z<> c(P - 1);
    ASSERT_EQ((c + c).val(), P - 2);
    
    // Large values that wrap
    Z<> d(P / 2), e(P / 2 + 100);
    ASSERT_EQ((d + e).val(), 100u - 1);  // (P/2 + P/2 + 100) mod P
}

TEST(addition_random) {
    std::mt19937_64 rng(11111);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 10000; i++) {
        uint32_t v1 = rng() % P;
        uint32_t v2 = rng() % P;
        Z<> a(v1), b(v2);
        uint32_t expected = ref_add<uint32_t, P>(v1, v2);
        ASSERT_EQ((a + b).val(), expected);
    }
}

TEST(addition_compound) {
    Z<> a(100u);
    a += Z<>(200u);
    ASSERT_EQ(a.val(), 300u);
    
    a += Z<>(998244353u - 300);  // Add to get 0
    ASSERT_EQ(a.val(), 0u);
}

// ============================================================================
// Test: Subtraction
// ============================================================================

TEST(subtraction_basic) {
    // 0 - 0 = 0
    Z<> a(0u), b(0u);
    ASSERT_EQ((a - b).val(), 0u);
    
    // x - 0 = x
    Z<> c(12345u);
    ASSERT_EQ((c - a).val(), 12345u);
    
    // x - x = 0
    ASSERT_EQ((c - c).val(), 0u);
    
    // Simple subtraction
    Z<> d(300u), e(200u);
    ASSERT_EQ((d - e).val(), 100u);
}

TEST(subtraction_wraparound) {
    constexpr uint32_t P = 998244353;
    
    // 0 - 1 = P-1
    Z<> a(0u), b(1u);
    ASSERT_EQ((a - b).val(), P - 1);
    
    // 1 - 2 = P-1
    Z<> c(1u), d(2u);
    ASSERT_EQ((c - d).val(), P - 1);
    
    // Small - Large
    Z<> e(100u), f(P - 1);
    ASSERT_EQ((e - f).val(), 101u);
}

TEST(subtraction_random) {
    std::mt19937_64 rng(22222);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 10000; i++) {
        uint32_t v1 = rng() % P;
        uint32_t v2 = rng() % P;
        Z<> a(v1), b(v2);
        uint32_t expected = ref_sub<uint32_t, P>(v1, v2);
        ASSERT_EQ((a - b).val(), expected);
    }
}

TEST(subtraction_compound) {
    constexpr uint32_t P = 998244353;
    Z<> a(100u);
    a -= Z<>(50u);
    ASSERT_EQ(a.val(), 50u);
    
    a -= Z<>(100u);  // Underflow
    ASSERT_EQ(a.val(), P - 50);
}

// ============================================================================
// Test: Increment / Decrement
// ============================================================================

TEST(increment_prefix) {
    Z<> a(0u);
    Z<>& ref = ++a;
    ASSERT_EQ(a.val(), 1u);
    ASSERT_TRUE(&ref == &a);  // Returns reference to self
    
    Z<> b(998244352u);  // P-1
    ++b;
    ASSERT_EQ(b.val(), 0u);  // Wraps
}

TEST(increment_postfix) {
    Z<> a(0u);
    Z<> old = a++;
    ASSERT_EQ(old.val(), 0u);
    ASSERT_EQ(a.val(), 1u);
    
    Z<> b(998244352u);
    old = b++;
    ASSERT_EQ(old.val(), 998244352u);
    ASSERT_EQ(b.val(), 0u);
}

TEST(decrement_prefix) {
    Z<> a(1u);
    Z<>& ref = --a;
    ASSERT_EQ(a.val(), 0u);
    ASSERT_TRUE(&ref == &a);
    
    Z<> b(0u);
    --b;
    ASSERT_EQ(b.val(), 998244352u);  // Wraps to P-1
}

TEST(decrement_postfix) {
    Z<> a(1u);
    Z<> old = a--;
    ASSERT_EQ(old.val(), 1u);
    ASSERT_EQ(a.val(), 0u);
    
    Z<> b(0u);
    old = b--;
    ASSERT_EQ(old.val(), 0u);
    ASSERT_EQ(b.val(), 998244352u);
}

TEST(increment_decrement_sequence) {
    Z<> a(500u);
    for (int i = 0; i < 1000; i++) ++a;
    ASSERT_EQ(a.val(), 1500u);
    for (int i = 0; i < 1000; i++) --a;
    ASSERT_EQ(a.val(), 500u);
    
    // Crossing zero
    Z<> b(5u);
    for (int i = 0; i < 10; i++) --b;
    ASSERT_EQ(b.val(), 998244353u - 5);
}

// ============================================================================
// Test: Multiplication
// ============================================================================

TEST(multiplication_basic) {
    // 0 * x = 0
    Z<> zero(0u), x(12345u);
    ASSERT_EQ((zero * x).val(), 0u);
    ASSERT_EQ((x * zero).val(), 0u);
    
    // 1 * x = x
    Z<> one(1u);
    ASSERT_EQ((one * x).val(), 12345u);
    ASSERT_EQ((x * one).val(), 12345u);
    
    // Simple multiplication
    Z<> a(100u), b(200u);
    ASSERT_EQ((a * b).val(), 20000u);
}

TEST(multiplication_large) {
    constexpr uint32_t P = 998244353;
    
    // (P-1) * (P-1) = 1
    Z<> a(P - 1);
    ASSERT_EQ((a * a).val(), 1u);
    
    // Large products that overflow 32 bits
    Z<> b(1000000u), c(1000000u);
    uint64_t expected = (1000000ULL * 1000000) % P;
    ASSERT_EQ((b * c).val(), static_cast<uint32_t>(expected));
}

TEST(multiplication_random) {
    std::mt19937_64 rng(33333);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 10000; i++) {
        uint32_t v1 = rng() % P;
        uint32_t v2 = rng() % P;
        Z<> a(v1), b(v2);
        uint32_t expected = ref_mul<uint32_t, P>(v1, v2);
        ASSERT_EQ((a * b).val(), expected);
    }
}

TEST(multiplication_compound) {
    Z<> a(100u);
    a *= Z<>(3u);
    ASSERT_EQ(a.val(), 300u);
    
    a *= Z<>(0u);
    ASSERT_EQ(a.val(), 0u);
}

TEST(multiplication_associativity) {
    std::mt19937_64 rng(44444);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 1000; i++) {
        uint32_t v1 = rng() % P;
        uint32_t v2 = rng() % P;
        uint32_t v3 = rng() % P;
        Z<> a(v1), b(v2), c(v3);
        
        // (a * b) * c = a * (b * c)
        ASSERT_EQ(((a * b) * c).val(), (a * (b * c)).val());
    }
}

TEST(multiplication_commutativity) {
    std::mt19937_64 rng(55555);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 1000; i++) {
        uint32_t v1 = rng() % P;
        uint32_t v2 = rng() % P;
        Z<> a(v1), b(v2);
        
        ASSERT_EQ((a * b).val(), (b * a).val());
    }
}

TEST(multiplication_distributivity) {
    std::mt19937_64 rng(66666);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 1000; i++) {
        uint32_t v1 = rng() % P;
        uint32_t v2 = rng() % P;
        uint32_t v3 = rng() % P;
        Z<> a(v1), b(v2), c(v3);
        
        // a * (b + c) = a * b + a * c
        ASSERT_EQ((a * (b + c)).val(), (a * b + a * c).val());
    }
}

// ============================================================================
// Test: Modular inverse
// ============================================================================

TEST(inverse_basic) {
    constexpr uint32_t P = 998244353;
    
    // inv(1) = 1
    Z<> one(1u);
    ASSERT_EQ(one.inv().val(), 1u);
    
    // inv(P-1) = P-1 (since (P-1)^2 = 1 mod P)
    Z<> pm1(P - 1);
    ASSERT_EQ(pm1.inv().val(), P - 1);
    
    // inv(2) check
    Z<> two(2u);
    Z<> inv2 = two.inv();
    ASSERT_EQ((two * inv2).val(), 1u);
}

TEST(inverse_correctness) {
    std::mt19937_64 rng(77777);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 1000; i++) {
        uint32_t v = rng() % (P - 1) + 1;  // [1, P-1]
        Z<> a(v);
        Z<> inv_a = a.inv();
        
        // a * inv(a) = 1
        ASSERT_EQ((a * inv_a).val(), 1u);
        
        // Compare with Fermat's little theorem
        uint32_t expected = ref_inv<uint32_t, P>(v);
        ASSERT_EQ(inv_a.val(), expected);
    }
}

TEST(inverse_double) {
    std::mt19937_64 rng(88888);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 100; i++) {
        uint32_t v = rng() % (P - 1) + 1;
        Z<> a(v);
        
        // inv(inv(a)) = a
        ASSERT_EQ(a.inv().inv().val(), v);
    }
}

// ============================================================================
// Test: Division
// ============================================================================

TEST(division_basic) {
    // x / 1 = x
    Z<> a(12345u), one(1u);
    ASSERT_EQ((a / one).val(), 12345u);
    
    // 0 / x = 0
    Z<> zero(0u), x(999u);
    ASSERT_EQ((zero / x).val(), 0u);
    
    // x / x = 1
    ASSERT_EQ((a / a).val(), 1u);
}

TEST(division_correctness) {
    std::mt19937_64 rng(99999);
    constexpr uint32_t P = 998244353;
    
    for (int i = 0; i < 1000; i++) {
        uint32_t v1 = rng() % P;
        uint32_t v2 = rng() % (P - 1) + 1;  // Non-zero
        Z<> a(v1), b(v2);
        
        Z<> quotient = a / b;
        
        // (a / b) * b = a
        ASSERT_EQ((quotient * b).val(), v1);
    }
}

TEST(division_compound) {
    Z<> a(1000u);
    a /= Z<>(10u);
    ASSERT_EQ((a * Z<>(10u)).val(), 1000u);
}

// ============================================================================
// Test: Comparison operators
// ============================================================================

TEST(equality) {
    Z<> a(100u), b(100u), c(200u);
    
    ASSERT_TRUE(a == b);
    ASSERT_TRUE(!(a == c));
    ASSERT_TRUE(!(a != b));
    ASSERT_TRUE(a != c);
    
    // Different construction, same value
    Z<> d(-1);  // P-1
    Z<> e(998244352u);
    ASSERT_TRUE(d == e);
}

TEST(ordering) {
    Z<> a(100u), b(200u), c(100u);
    
    ASSERT_TRUE(a < b);
    ASSERT_TRUE(b > a);
    ASSERT_TRUE(a <= b);
    ASSERT_TRUE(a <= c);
    ASSERT_TRUE(b >= a);
    ASSERT_TRUE(a >= c);
    
    // Three-way comparison
    ASSERT_TRUE((a <=> b) == std::strong_ordering::less);
    ASSERT_TRUE((b <=> a) == std::strong_ordering::greater);
    ASSERT_TRUE((a <=> c) == std::strong_ordering::equal);
}

// ============================================================================
// Test: I/O operators
// ============================================================================

TEST(output_stream) {
    Z<> a(12345u);
    std::ostringstream oss;
    oss << a;
    ASSERT_EQ(oss.str(), "12345");
    
    Z<> zero(0u);
    oss.str("");
    oss << zero;
    ASSERT_EQ(oss.str(), "0");
}

TEST(input_stream) {
    // Positive
    std::istringstream iss("12345");
    Z<> a;
    iss >> a;
    ASSERT_EQ(a.val(), 12345u);
    
    // Negative
    std::istringstream iss2("-1");
    Z<> b;
    iss2 >> b;
    ASSERT_EQ(b.val(), 998244352u);
    
    // Large
    std::istringstream iss3("1000000000");
    Z<> c;
    iss3 >> c;
    ASSERT_EQ(c.val(), static_cast<uint32_t>(1000000000LL % 998244353));
}

// ============================================================================
// Test: Constexpr evaluation
// ============================================================================

TEST(constexpr_basic) {
    // These should all be evaluated at compile time
    constexpr Z<> a(100u);
    constexpr Z<> b(200u);
    constexpr Z<> c = a + b;
    static_assert(c.val() == 300u);
    
    constexpr Z<> d = a * b;
    static_assert(d.val() == 20000u);
    
    constexpr Z<> e = -a;
    static_assert(e.val() == 998244353u - 100);
    
    constexpr Z<> f(1u);
    constexpr Z<> g = f.inv();
    static_assert(g.val() == 1u);
    
    // This test passes if it compiles
    ASSERT_TRUE(true);
}

// ============================================================================
// Test: Different moduli
// ============================================================================

TEST(different_moduli) {
    // Prime 1e9+7
    using Z1e9 = Z<uint32_t, 1000000007>;
    Z1e9 a(500000000u), b(600000000u);  // Sum exceeds P
    // 500000000 + 600000000 = 1100000000
    // 1100000000 - 1000000007 = 99999993
    ASSERT_EQ((a + b).val(), 99999993u);
    uint32_t expected_prod = ref_mul<uint32_t, 1000000007>(500000000, 600000000);
    ASSERT_EQ((a * b).val(), expected_prod);
    
    // Small prime
    using Z7 = Z<uint32_t, 7>;
    Z7 c(5u), d(6u);
    ASSERT_EQ((c + d).val(), 4u);
    ASSERT_EQ((c * d).val(), 2u);
    ASSERT_EQ(c.inv().val(), 3u);  // 5 * 3 = 15 = 2*7 + 1
}

// ============================================================================
// Test: 64-bit modular arithmetic
// ============================================================================

#ifdef __SIZEOF_INT128__
TEST(uint64_modulus) {
    constexpr uint64_t P = 4611686018427387847ULL;  // A 62-bit prime
    using Z64 = Z<uint64_t, P>;
    
    // Verify constants
    __uint128_t product = static_cast<__uint128_t>(P) * Z64::P_INV;
    ASSERT_EQ(static_cast<uint64_t>(product), 1ULL);
    
    // Basic operations
    Z64 a(1000000000000ULL);
    Z64 b(2000000000000ULL);
    
    uint64_t sum = (1000000000000ULL + 2000000000000ULL) % P;
    ASSERT_EQ((a + b).val(), sum);
    
    __uint128_t prod = static_cast<__uint128_t>(1000000000000ULL) * 2000000000000ULL;
    ASSERT_EQ((a * b).val(), static_cast<uint64_t>(prod % P));
    
    // Note: inv() test skipped for 64-bit due to make_signed<__uint128_t> limitation
    // in the current Z implementation. This would require a custom signed_type trait.
}
#endif

// ============================================================================
// Test: Edge cases and stress tests
// ============================================================================

TEST(edge_values) {
    constexpr uint32_t P = 998244353;
    
    // P-1
    Z<> a(P - 1);
    ASSERT_EQ(a.val(), P - 1);
    ASSERT_EQ((a + Z<>(1u)).val(), 0u);
    ASSERT_EQ((a * a).val(), 1u);
    
    // P (should be 0)
    Z<> b(P);
    ASSERT_EQ(b.val(), 0u);
    
    // P+1 (should be 1)
    Z<> c(P + 1);
    ASSERT_EQ(c.val(), 1u);
}

TEST(stress_random_operations) {
    std::mt19937_64 rng(111222);
    constexpr uint32_t P = 998244353;
    
    for (int trial = 0; trial < 100; trial++) {
        uint32_t v = rng() % P;
        Z<> a(v);
        uint32_t ref = v;
        
        // Random sequence of operations
        for (int op = 0; op < 100; op++) {
            uint32_t operand = rng() % P;
            int choice = rng() % 4;
            
            switch (choice) {
                case 0:  // Add
                    a += Z<>(operand);
                    ref = ref_add<uint32_t, P>(ref, operand);
                    break;
                case 1:  // Subtract
                    a -= Z<>(operand);
                    ref = ref_sub<uint32_t, P>(ref, operand);
                    break;
                case 2:  // Multiply
                    a *= Z<>(operand);
                    ref = ref_mul<uint32_t, P>(ref, operand);
                    break;
                case 3:  // Negate
                    a = -a;
                    ref = ref_neg<uint32_t, P>(ref);
                    break;
            }
            
            ASSERT_EQ(a.val(), ref);
        }
    }
}

TEST(stress_multiplication_chain) {
    constexpr uint32_t P = 998244353;
    Z<> a(2u);
    uint32_t ref = 2;
    
    // Compute 2^1000 mod P
    for (int i = 0; i < 1000; i++) {
        a *= Z<>(2u);
        ref = ref_mul<uint32_t, P>(ref, 2);
    }
    
    ASSERT_EQ(a.val(), ref);
}

TEST(fermat_little_theorem) {
    // a^(P-1) = 1 for a != 0
    std::mt19937_64 rng(333444);
    constexpr uint32_t P = 998244353;
    
    for (int trial = 0; trial < 10; trial++) {
        uint32_t v = rng() % (P - 1) + 1;
        Z<> a(v);
        Z<> result(1u);
        
        // Compute a^(P-1) by repeated squaring
        Z<> base = a;
        uint32_t exp = P - 1;
        while (exp > 0) {
            if (exp & 1) result *= base;
            base *= base;
            exp >>= 1;
        }
        
        ASSERT_EQ(result.val(), 1u);
    }
}

TEST(primitive_root_check) {
    // 3 is a primitive root mod 998244353
    // 3^((P-1)/2) should be P-1 (i.e., -1)
    constexpr uint32_t P = 998244353;
    Z<> g(3u);
    Z<> result(1u);
    
    uint32_t exp = (P - 1) / 2;
    Z<> base = g;
    while (exp > 0) {
        if (exp & 1) result *= base;
        base *= base;
        exp >>= 1;
    }
    
    ASSERT_EQ(result.val(), P - 1);
}

// ============================================================================
// Test: Polynomial evaluation (practical use case)
// ============================================================================

TEST(polynomial_evaluation) {
    // Evaluate P(x) = 1 + 2x + 3x^2 at x = 5
    // P(5) = 1 + 10 + 75 = 86
    Z<> x(5u);
    Z<> result = Z<>(1u) + Z<>(2u) * x + Z<>(3u) * x * x;
    ASSERT_EQ(result.val(), 86u);
    
    // Horner's method: P(x) = 1 + x(2 + 3x)
    result = Z<>(3u);
    result = result * x + Z<>(2u);
    result = result * x + Z<>(1u);
    ASSERT_EQ(result.val(), 86u);
}

TEST(factorial_computation) {
    // Compute n! mod P for small n
    constexpr uint32_t P = 998244353;
    std::vector<uint32_t> expected_factorials = {1, 1, 2, 6, 24, 120, 720, 5040};
    
    Z<> fact(1u);
    ASSERT_EQ(fact.val(), expected_factorials[0]);
    
    for (int i = 1; i < 8; i++) {
        fact *= Z<>(static_cast<uint32_t>(i));
        ASSERT_EQ(fact.val(), expected_factorials[i]);
    }
    
    // Compute 20!
    for (int i = 8; i <= 20; i++) {
        fact *= Z<>(static_cast<uint32_t>(i));
    }
    // Verify 20! mod P by reference
    uint64_t ref_fact = 1;
    for (int i = 1; i <= 20; i++) {
        ref_fact = (ref_fact * i) % P;
    }
    ASSERT_EQ(fact.val(), static_cast<uint32_t>(ref_fact));
}

// ============================================================================
// Test: Combination formula (nCr)
// ============================================================================

TEST(combination_formula) {
    // Compute C(10, 5) = 252
    
    // C(n, r) = n! / (r! * (n-r)!)
    auto factorial = [](int n) {
        Z<> result(1u);
        for (int i = 2; i <= n; i++) {
            result *= Z<>(static_cast<uint32_t>(i));
        }
        return result;
    };
    
    Z<> n_fact = factorial(10);
    Z<> r_fact = factorial(5);
    Z<> nr_fact = factorial(5);
    
    Z<> result = n_fact / (r_fact * nr_fact);
    ASSERT_EQ(result.val(), 252u);
}

// ============================================================================
// Main
// ============================================================================

int main() {
    std::cout << "=== Z<> Modular Integer Class Test Suite ===\n\n";
    
    // Montgomery constants
    RUN_TEST(montgomery_constants);
    RUN_TEST(montgomery_constants_other_primes);
    
    // Constructors
    RUN_TEST(default_constructor);
    RUN_TEST(constructor_unsigned_small);
    RUN_TEST(constructor_unsigned_medium);
    RUN_TEST(constructor_unsigned_large);
    RUN_TEST(constructor_signed_positive);
    RUN_TEST(constructor_signed_negative_small);
    RUN_TEST(constructor_signed_negative_large);
    RUN_TEST(constructor_various_types);
    
    // val()
    RUN_TEST(val_roundtrip);
    
    // Unary operators
    RUN_TEST(unary_plus);
    RUN_TEST(unary_minus);
    RUN_TEST(unary_minus_random);
    
    // Addition
    RUN_TEST(addition_basic);
    RUN_TEST(addition_wraparound);
    RUN_TEST(addition_random);
    RUN_TEST(addition_compound);
    
    // Subtraction
    RUN_TEST(subtraction_basic);
    RUN_TEST(subtraction_wraparound);
    RUN_TEST(subtraction_random);
    RUN_TEST(subtraction_compound);
    
    // Increment/Decrement
    RUN_TEST(increment_prefix);
    RUN_TEST(increment_postfix);
    RUN_TEST(decrement_prefix);
    RUN_TEST(decrement_postfix);
    RUN_TEST(increment_decrement_sequence);
    
    // Multiplication
    RUN_TEST(multiplication_basic);
    RUN_TEST(multiplication_large);
    RUN_TEST(multiplication_random);
    RUN_TEST(multiplication_compound);
    RUN_TEST(multiplication_associativity);
    RUN_TEST(multiplication_commutativity);
    RUN_TEST(multiplication_distributivity);
    
    // Inverse
    RUN_TEST(inverse_basic);
    RUN_TEST(inverse_correctness);
    RUN_TEST(inverse_double);
    
    // Division
    RUN_TEST(division_basic);
    RUN_TEST(division_correctness);
    RUN_TEST(division_compound);
    
    // Comparison
    RUN_TEST(equality);
    RUN_TEST(ordering);
    
    // I/O
    RUN_TEST(output_stream);
    RUN_TEST(input_stream);
    
    // Constexpr
    RUN_TEST(constexpr_basic);
    
    // Different moduli
    RUN_TEST(different_moduli);
    
    // 64-bit
#ifdef __SIZEOF_INT128__
    RUN_TEST(uint64_modulus);
#endif
    
    // Edge cases and stress
    RUN_TEST(edge_values);
    RUN_TEST(stress_random_operations);
    RUN_TEST(stress_multiplication_chain);
    RUN_TEST(fermat_little_theorem);
    RUN_TEST(primitive_root_check);
    
    // Practical use cases
    RUN_TEST(polynomial_evaluation);
    RUN_TEST(factorial_computation);
    RUN_TEST(combination_formula);
    
    std::cout << "\n=== Summary ===\n";
    std::cout << "Passed: " << tests_passed << "\n";
    std::cout << "Failed: " << tests_failed << "\n";
    
    return tests_failed > 0 ? 1 : 0;
}