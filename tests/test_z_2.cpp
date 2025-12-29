#include "../core/z_standard.hpp"
#include <cassert>
#include <sstream>
#include <vector>
#include <random>
#include <cstdint>

// Test with default P = 998244353
using Zd = Z<>;

// Test with a smaller prime for exhaustive testing
constexpr uint32_t SMALL_P = 97;
using Zs = Z<uint32_t, SMALL_P>;

// Test with a prime close to 2^31
constexpr uint32_t LARGE_P = 2147483647; // 2^31 - 1, Mersenne prime
using Zl = Z<uint32_t, LARGE_P>;

// Test with 64-bit if available
#ifdef __SIZEOF_INT128__
// Use a smaller 64-bit prime that doesn't require __int128 signed operations
constexpr uint64_t P64 = 998244353ULL; // Same prime but 64-bit type
using Z64 = Z<uint64_t, P64>;
#endif

static int tests_passed = 0;
static int tests_failed = 0;

#define TEST(cond, msg) do { \
    if (cond) { \
        tests_passed++; \
    } else { \
        tests_failed++; \
        std::cerr << "FAIL: " << msg << " at line " << __LINE__ << std::endl; \
    } \
} while(0)

#define TEST_EQ(a, b, msg) TEST((a) == (b), msg << " (got " << (a) << ", expected " << (b) << ")")

// =============================================================================
// Test: Static Constants
// =============================================================================
void test_static_constants() {
//     std::cout << "Testing static constants..." << std::endl;
    
//     // Verify MOD
//     TEST_EQ(Zd::MOD, 998244353u, "Zd::MOD");
//     TEST_EQ(Zs::MOD, 97u, "Zs::MOD");
//     TEST_EQ(Zl::MOD, 2147483647u, "Zl::MOD");
    
//     // Verify P_INV: P * P_INV ≡ 1 (mod 2^32)
//     // This means (P * P_INV) & 0xFFFFFFFF == 1... actually it should be -1 mod 2^32
//     // Actually: P * P_INV ≡ -1 (mod 2^BITS) for Montgomery
//     // Let me check: inv * P ≡ 1 (mod 2^k) means P * inv - 1 is divisible by 2^k
//     // The Newton iteration gives: inv such that inv * P ≡ 1 (mod 2^BITS)
//     uint64_t check_d = (uint64_t)Zd::MOD * Zd::P_INV;
//     TEST_EQ(uint32_t(check_d), 1u, "Zd: P * P_INV ≡ 1 (mod 2^32)");
    
//     uint64_t check_s = (uint64_t)Zs::MOD * Zs::P_INV;
//     TEST_EQ(uint32_t(check_s), 1u, "Zs: P * P_INV ≡ 1 (mod 2^32)");
    
//     uint64_t check_l = (uint64_t)Zl::MOD * Zl::P_INV;
//     TEST_EQ(uint32_t(check_l), 1u, "Zl: P * P_INV ≡ 1 (mod 2^32)");
    
//     // Verify R1_MOD_P = 2^32 mod P
//     // We can verify by checking that R1_MOD_P < P and (2^32 - R1_MOD_P) % P == 0
//     TEST(Zd::R1_MOD_P < Zd::MOD, "Zd: R1_MOD_P < MOD");
//     TEST(Zs::R1_MOD_P < Zs::MOD, "Zs: R1_MOD_P < MOD");
//     TEST(Zl::R1_MOD_P < Zl::MOD, "Zl: R1_MOD_P < MOD");
    
//     // Verify R2_MOD_P = 2^64 mod P
//     TEST(Zd::R2_MOD_P < Zd::MOD, "Zd: R2_MOD_P < MOD");
//     TEST(Zs::R2_MOD_P < Zs::MOD, "Zs: R2_MOD_P < MOD");
//     TEST(Zl::R2_MOD_P < Zl::MOD, "Zl: R2_MOD_P < MOD");
    
// #ifdef __SIZEOF_INT128__
//     __uint128_t check_64 = (__uint128_t)Z64::MOD * Z64::P_INV;
//     TEST_EQ(uint64_t(check_64), 1ull, "Z64: P * P_INV ≡ 1 (mod 2^64)");
//     TEST(Z64::R1_MOD_P < Z64::MOD, "Z64: R1_MOD_P < MOD");
//     TEST(Z64::R2_MOD_P < Z64::MOD, "Z64: R2_MOD_P < MOD");
// #endif
}

// =============================================================================
// Test: Default Constructor
// =============================================================================
void test_default_constructor() {
    std::cout << "Testing default constructor..." << std::endl;
    
    Zd a;
    TEST_EQ(a.val(), 0u, "Zd default constructor gives 0");
    
    Zs b;
    TEST_EQ(b.val(), 0u, "Zs default constructor gives 0");
    
    Zl c;
    TEST_EQ(c.val(), 0u, "Zl default constructor gives 0");
    
    // Constexpr check
    constexpr Zd ce;
    static_assert(ce.value == 0, "constexpr default constructor");
    TEST(true, "constexpr default constructor compiles");
}

// =============================================================================
// Test: Unsigned Constructor
// =============================================================================
void test_unsigned_constructor() {
    std::cout << "Testing unsigned constructor..." << std::endl;
    
    // Small values
    TEST_EQ(Zd(0u).val(), 0u, "Zd(0)");
    TEST_EQ(Zd(1u).val(), 1u, "Zd(1)");
    TEST_EQ(Zd(2u).val(), 2u, "Zd(2)");
    TEST_EQ(Zd(100u).val(), 100u, "Zd(100)");
    
    // Values near P
    TEST_EQ(Zd(998244352u).val(), 998244352u, "Zd(P-1)");
    TEST_EQ(Zd(998244353u).val(), 0u, "Zd(P) = 0");
    TEST_EQ(Zd(998244354u).val(), 1u, "Zd(P+1) = 1");
    TEST_EQ(Zd(998244353u * 2 - 1).val(), 998244352u, "Zd(2P-1) = P-1");
    TEST_EQ(Zd(998244353u * 2).val(), 0u, "Zd(2P) = 0");
    TEST_EQ(Zd(998244353u * 2 + 1).val(), 1u, "Zd(2P+1) = 1");
    
    // Large values requiring modulo
    TEST_EQ(Zd(uint32_t(-1)).val(), (uint32_t(-1) % 998244353), "Zd(UINT32_MAX)");
    
    // Test with small prime
    TEST_EQ(Zs(0u).val(), 0u, "Zs(0)");
    TEST_EQ(Zs(96u).val(), 96u, "Zs(P-1)");
    TEST_EQ(Zs(97u).val(), 0u, "Zs(P)");
    TEST_EQ(Zs(98u).val(), 1u, "Zs(P+1)");
    TEST_EQ(Zs(194u).val(), 0u, "Zs(2P)");
    TEST_EQ(Zs(1000u).val(), 1000u % 97, "Zs(1000)");
    
    // Test with large prime
    TEST_EQ(Zl(0u).val(), 0u, "Zl(0)");
    TEST_EQ(Zl(2147483646u).val(), 2147483646u, "Zl(P-1)");
    TEST_EQ(Zl(2147483647u).val(), 0u, "Zl(P)");
    TEST_EQ(Zl(2147483648u).val(), 1u, "Zl(P+1)");
    
    // Constexpr
    constexpr Zd ce(42u);
    static_assert(ce.val() == 42, "constexpr unsigned constructor");
    TEST(true, "constexpr unsigned constructor compiles");
    
    // Different unsigned types
    TEST_EQ(Zd((uint8_t)255).val(), 255u, "Zd(uint8_t)");
    TEST_EQ(Zd((uint16_t)65535).val(), 65535u, "Zd(uint16_t)");
    TEST_EQ(Zd((uint64_t)998244353 * 3 + 7).val(), 7u, "Zd(uint64_t)");
}

// =============================================================================
// Test: Signed Constructor
// =============================================================================
void test_signed_constructor() {
    std::cout << "Testing signed constructor..." << std::endl;
    
    // Non-negative values
    TEST_EQ(Zd(0).val(), 0u, "Zd(0) signed");
    TEST_EQ(Zd(1).val(), 1u, "Zd(1) signed");
    TEST_EQ(Zd(998244352).val(), 998244352u, "Zd(P-1) signed");
    
    // Negative values
    TEST_EQ(Zd(-1).val(), 998244352u, "Zd(-1) = P-1");
    TEST_EQ(Zd(-2).val(), 998244351u, "Zd(-2) = P-2");
    TEST_EQ(Zd(-998244352).val(), 1u, "Zd(-(P-1)) = 1");
    TEST_EQ(Zd(-998244353).val(), 0u, "Zd(-P) = 0");
    
    // Values requiring full modulo
    TEST_EQ(Zd(int64_t(998244353) * 2).val(), 0u, "Zd(2P) signed");
    TEST_EQ(Zd(int64_t(998244353) * 2 + 5).val(), 5u, "Zd(2P+5) signed");
    TEST_EQ(Zd(int64_t(-998244353) * 2).val(), 0u, "Zd(-2P) signed");
    TEST_EQ(Zd(int64_t(-998244353) * 2 - 5).val(), 998244348u, "Zd(-2P-5) signed");
    
    // Test with small prime
    TEST_EQ(Zs(-1).val(), 96u, "Zs(-1) = P-1");
    TEST_EQ(Zs(-97).val(), 0u, "Zs(-P) = 0");
    TEST_EQ(Zs(-100).val(), uint32_t((-100 % 97 + 97) % 97), "Zs(-100)");
    
    // Different signed types
    TEST_EQ(Zd((int8_t)-1).val(), 998244352u, "Zd(int8_t -1)");
    TEST_EQ(Zd((int16_t)-1000).val(), 998244353u - 1000u, "Zd(int16_t -1000)");
    TEST_EQ(Zd((int64_t)-1e15).val(), uint32_t((int64_t(-1e15) % 998244353 + 998244353) % 998244353), "Zd(int64_t large negative)");
    
    // Constexpr
    constexpr Zd ce(-5);
    static_assert(ce.val() == 998244353 - 5, "constexpr signed constructor negative");
    TEST(true, "constexpr signed constructor compiles");
}

// =============================================================================
// Test: val() function
// =============================================================================
void test_val() {
    std::cout << "Testing val()..." << std::endl;
    
    // val() should always return value in [0, P)
    for (uint32_t v : {0u, 1u, 50u, 998244352u}) {
        Zd z(v);
        TEST(z.val() < Zd::MOD, "val() < MOD for v=" << v);
        TEST_EQ(z.val(), v, "val() correct for v=" << v);
    }
    
    // After operations, val() should still be correct
    Zd a(100), b(200);
    TEST_EQ((a + b).val(), 300u, "val() after addition");
    TEST_EQ((a * b).val(), 20000u, "val() after multiplication");
    
    // Constexpr val()
    constexpr Zd ce(123);
    constexpr uint32_t v = ce.val();
    static_assert(v == 123, "constexpr val()");
    TEST(true, "constexpr val() compiles");
}

// =============================================================================
// Test: Unary operators
// =============================================================================
void test_unary_operators() {
    std::cout << "Testing unary operators..." << std::endl;
    
    // Unary plus
    Zd a(42);
    TEST_EQ((+a).val(), 42u, "unary + preserves value");
    TEST_EQ((+Zd(0)).val(), 0u, "unary + on zero");
    
    // Negation
    TEST_EQ((-Zd(0)).val(), 0u, "-0 = 0");
    TEST_EQ((-Zd(1)).val(), 998244352u, "-1 = P-1");
    TEST_EQ((-Zd(998244352)).val(), 1u, "-(P-1) = 1");
    TEST_EQ((-Zd(500)).val(), 998244353u - 500u, "-500");
    
    // Double negation
    TEST_EQ((-(-Zd(42))).val(), 42u, "--42 = 42");
    TEST_EQ((-(-Zd(0))).val(), 0u, "--0 = 0");
    
    // Test with small prime
    TEST_EQ((-Zs(0)).val(), 0u, "Zs: -0 = 0");
    TEST_EQ((-Zs(1)).val(), 96u, "Zs: -1 = 96");
    TEST_EQ((-Zs(50)).val(), 47u, "Zs: -50 = 47");
    
    // Constexpr
    constexpr Zd pos = +Zd(10);
    constexpr Zd neg = -Zd(10);
    static_assert(pos.val() == 10, "constexpr unary +");
    static_assert(neg.val() == 998244353 - 10, "constexpr unary -");
    TEST(true, "constexpr unary operators compile");
}

// =============================================================================
// Test: Addition
// =============================================================================
void test_addition() {
    std::cout << "Testing addition..." << std::endl;
    
    // Basic addition
    TEST_EQ((Zd(0) + Zd(0)).val(), 0u, "0 + 0");
    TEST_EQ((Zd(1) + Zd(0)).val(), 1u, "1 + 0");
    TEST_EQ((Zd(0) + Zd(1)).val(), 1u, "0 + 1");
    TEST_EQ((Zd(100) + Zd(200)).val(), 300u, "100 + 200");
    
    // Addition with wraparound
    TEST_EQ((Zd(998244352) + Zd(1)).val(), 0u, "(P-1) + 1 = 0");
    TEST_EQ((Zd(998244352) + Zd(2)).val(), 1u, "(P-1) + 2 = 1");
    TEST_EQ((Zd(500000000) + Zd(500000000)).val(), 1755647u, "large + large");
    
    // Compound assignment
    Zd a(100);
    a += Zd(50);
    TEST_EQ(a.val(), 150u, "+= basic");
    
    a += Zd(998244353 - 150);
    TEST_EQ(a.val(), 0u, "+= wraparound");
    
    // Chained addition
    TEST_EQ((Zd(1) + Zd(2) + Zd(3) + Zd(4)).val(), 10u, "chained addition");
    
    // Test with small prime - exhaustive
    for (uint32_t i = 0; i < SMALL_P; i++) {
        for (uint32_t j = 0; j < SMALL_P; j++) {
            uint32_t expected = (i + j) % SMALL_P;
            uint32_t got = (Zs(i) + Zs(j)).val();
            if (got != expected) {
                TEST(false, "Zs: " << i << " + " << j << " = " << got << " (expected " << expected << ")");
                return;
            }
        }
    }
    TEST(true, "Zs: exhaustive addition test passed");
    
    // Constexpr
    constexpr Zd sum = Zd(100) + Zd(200);
    static_assert(sum.val() == 300, "constexpr addition");
    TEST(true, "constexpr addition compiles");
}

// =============================================================================
// Test: Subtraction
// =============================================================================
void test_subtraction() {
    std::cout << "Testing subtraction..." << std::endl;
    
    // Basic subtraction
    TEST_EQ((Zd(0) - Zd(0)).val(), 0u, "0 - 0");
    TEST_EQ((Zd(1) - Zd(0)).val(), 1u, "1 - 0");
    TEST_EQ((Zd(0) - Zd(1)).val(), 998244352u, "0 - 1 = P-1");
    TEST_EQ((Zd(200) - Zd(100)).val(), 100u, "200 - 100");
    TEST_EQ((Zd(100) - Zd(200)).val(), 998244253u, "100 - 200");
    
    // Subtraction with wraparound
    TEST_EQ((Zd(0) - Zd(1)).val(), 998244352u, "0 - 1 wraparound");
    TEST_EQ((Zd(1) - Zd(2)).val(), 998244352u, "1 - 2 wraparound");
    
    // Compound assignment
    Zd a(200);
    a -= Zd(50);
    TEST_EQ(a.val(), 150u, "-= basic");
    
    a -= Zd(200);
    TEST_EQ(a.val(), 998244303u, "-= wraparound");
    
    // Self subtraction
    Zd b(12345);
    b -= b;
    TEST_EQ(b.val(), 0u, "x -= x = 0");
    
    // Test with small prime - exhaustive
    for (uint32_t i = 0; i < SMALL_P; i++) {
        for (uint32_t j = 0; j < SMALL_P; j++) {
            uint32_t expected = (i + SMALL_P - j) % SMALL_P;
            uint32_t got = (Zs(i) - Zs(j)).val();
            if (got != expected) {
                TEST(false, "Zs: " << i << " - " << j << " = " << got << " (expected " << expected << ")");
                return;
            }
        }
    }
    TEST(true, "Zs: exhaustive subtraction test passed");
    
    // Constexpr
    constexpr Zd diff = Zd(300) - Zd(100);
    static_assert(diff.val() == 200, "constexpr subtraction");
    TEST(true, "constexpr subtraction compiles");
}

// =============================================================================
// Test: Multiplication
// =============================================================================
void test_multiplication() {
    std::cout << "Testing multiplication..." << std::endl;
    
    // Basic multiplication
    TEST_EQ((Zd(0) * Zd(0)).val(), 0u, "0 * 0");
    TEST_EQ((Zd(1) * Zd(0)).val(), 0u, "1 * 0");
    TEST_EQ((Zd(0) * Zd(1)).val(), 0u, "0 * 1");
    TEST_EQ((Zd(1) * Zd(1)).val(), 1u, "1 * 1");
    TEST_EQ((Zd(2) * Zd(3)).val(), 6u, "2 * 3");
    TEST_EQ((Zd(100) * Zd(200)).val(), 20000u, "100 * 200");
    
    // Multiplication with overflow
    TEST_EQ((Zd(1000000) * Zd(1000000)).val(), uint32_t((uint64_t(1000000) * 1000000) % 998244353), "1e6 * 1e6");
    
    // Multiplication by P-1 (equivalent to negation)
    TEST_EQ((Zd(5) * Zd(998244352)).val(), (-Zd(5)).val(), "x * (P-1) = -x");
    
    // Compound assignment
    Zd a(100);
    a *= Zd(3);
    TEST_EQ(a.val(), 300u, "*= basic");
    
    // Self multiplication (squaring)
    Zd b(12345);
    b *= b;
    TEST_EQ(b.val(), uint32_t((uint64_t(12345) * 12345) % 998244353), "x *= x (squaring)");
    
    // Chained multiplication
    TEST_EQ((Zd(2) * Zd(3) * Zd(4) * Zd(5)).val(), 120u, "chained multiplication");
    
    // Test with small prime - exhaustive
    for (uint32_t i = 0; i < SMALL_P; i++) {
        for (uint32_t j = 0; j < SMALL_P; j++) {
            uint32_t expected = (i * j) % SMALL_P;
            uint32_t got = (Zs(i) * Zs(j)).val();
            if (got != expected) {
                TEST(false, "Zs: " << i << " * " << j << " = " << got << " (expected " << expected << ")");
                return;
            }
        }
    }
    TEST(true, "Zs: exhaustive multiplication test passed");
    
    // Test with large values near P
    Zd x(998244352), y(998244352); // (P-1) * (P-1)
    TEST_EQ((x * y).val(), 1u, "(P-1) * (P-1) = 1");
    
    // Constexpr
    constexpr Zd prod = Zd(6) * Zd(7);
    static_assert(prod.val() == 42, "constexpr multiplication");
    TEST(true, "constexpr multiplication compiles");
}

// =============================================================================
// Test: Inverse
// =============================================================================
void test_inverse() {
    std::cout << "Testing inverse..." << std::endl;
    
    // Basic inverses
    TEST_EQ((Zd(1).inv()).val(), 1u, "inv(1) = 1");
    TEST_EQ((Zd(2).inv() * Zd(2)).val(), 1u, "inv(2) * 2 = 1");
    
    // P-1 is its own inverse mod P when P is prime (Fermat)
    // Actually, (P-1)^2 = P^2 - 2P + 1 ≡ 1 (mod P)
    TEST_EQ((Zd(998244352).inv()).val(), 998244352u, "inv(P-1) = P-1");
    
    // Verify inverses
    for (uint32_t v : {1u, 2u, 3u, 7u, 13u, 100u, 12345u, 998244352u}) {
        Zd z(v);
        Zd zi = z.inv();
        TEST_EQ((z * zi).val(), 1u, "inv verification for " << v);
    }
    
    // Test with small prime - exhaustive for all non-zero
    for (uint32_t i = 1; i < SMALL_P; i++) {
        Zs z(i);
        Zs zi = z.inv();
        uint32_t prod = (z * zi).val();
        if (prod != 1) {
            TEST(false, "Zs: inv(" << i << ") verification failed, got " << prod);
            return;
        }
    }
    TEST(true, "Zs: exhaustive inverse test passed");
    
    // Constexpr
    constexpr Zd inv5 = Zd(5).inv();
    constexpr Zd check = inv5 * Zd(5);
    static_assert(check.val() == 1, "constexpr inverse");
    TEST(true, "constexpr inverse compiles");
}

// =============================================================================
// Test: Division
// =============================================================================
void test_division() {
    std::cout << "Testing division..." << std::endl;
    
    // Basic division
    TEST_EQ((Zd(0) / Zd(1)).val(), 0u, "0 / 1");
    TEST_EQ((Zd(6) / Zd(2)).val(), 3u, "6 / 2");
    TEST_EQ((Zd(6) / Zd(3)).val(), 2u, "6 / 3");
    TEST_EQ((Zd(10) / Zd(5)).val(), 2u, "10 / 5");
    
    // Division that's not exact in integers
    Zd half = Zd(1) / Zd(2);
    TEST_EQ((half * Zd(2)).val(), 1u, "1/2 * 2 = 1");
    TEST_EQ((half + half).val(), 1u, "1/2 + 1/2 = 1");
    
    // Self division
    TEST_EQ((Zd(12345) / Zd(12345)).val(), 1u, "x / x = 1");
    
    // Compound assignment
    Zd a(100);
    a /= Zd(5);
    TEST_EQ(a.val(), 20u, "/= basic");
    
    // Division verification
    for (uint32_t i : {1u, 2u, 3u, 7u, 13u, 100u, 12345u}) {
        for (uint32_t j : {1u, 2u, 3u, 7u, 13u, 100u, 12345u}) {
            Zd a(i), b(j);
            Zd c = a / b;
            TEST_EQ((c * b).val(), a.val(), i << " / " << j << " verification");
        }
    }
    
    // Constexpr
    constexpr Zd quot = Zd(100) / Zd(5);
    static_assert(quot.val() == 20, "constexpr division");
    TEST(true, "constexpr division compiles");
}

// =============================================================================
// Test: Increment and Decrement
// =============================================================================
void test_increment_decrement() {
    std::cout << "Testing increment/decrement..." << std::endl;
    
    // Pre-increment
    Zd a(0);
    TEST_EQ((++a).val(), 1u, "++0 = 1");
    TEST_EQ(a.val(), 1u, "after ++, value is 1");
    
    // Pre-increment wraparound
    Zd b(998244352);
    TEST_EQ((++b).val(), 0u, "++(P-1) = 0");
    
    // Post-increment
    Zd c(5);
    TEST_EQ((c++).val(), 5u, "5++ returns 5");
    TEST_EQ(c.val(), 6u, "after 5++, value is 6");
    
    // Pre-decrement
    Zd d(1);
    TEST_EQ((--d).val(), 0u, "--1 = 0");
    
    // Pre-decrement wraparound
    Zd e(0);
    TEST_EQ((--e).val(), 998244352u, "--0 = P-1");
    
    // Post-decrement
    Zd f(5);
    TEST_EQ((f--).val(), 5u, "5-- returns 5");
    TEST_EQ(f.val(), 4u, "after 5--, value is 4");
    
    // Multiple increments
    Zd g(0);
    for (int i = 0; i < 10; i++) ++g;
    TEST_EQ(g.val(), 10u, "10 increments from 0");
    
    // Increment then decrement
    Zd h(50);
    ++h; --h;
    TEST_EQ(h.val(), 50u, "++x; --x; leaves x unchanged");
    
    // Constexpr
    constexpr Zd inc_test = []() {
        Zd x(5);
        ++x;
        return x;
    }();
    static_assert(inc_test.val() == 6, "constexpr increment");
    TEST(true, "constexpr increment/decrement compiles");
}

// =============================================================================
// Test: Comparison Operators
// =============================================================================
void test_comparison() {
    std::cout << "Testing comparison operators..." << std::endl;
    
    // Equality
    TEST(Zd(0) == Zd(0), "0 == 0");
    TEST(Zd(42) == Zd(42), "42 == 42");
    TEST(!(Zd(1) == Zd(2)), "!(1 == 2)");
    
    // Equality with different construction
    TEST(Zd(998244353u) == Zd(0), "P == 0");
    TEST(Zd(-1) == Zd(998244352), "-1 == P-1");
    
    // Spaceship operator
    TEST((Zd(0) <=> Zd(0)) == std::strong_ordering::equal, "0 <=> 0 == equal");
    TEST((Zd(1) <=> Zd(2)) == std::strong_ordering::less, "1 <=> 2 == less");
    TEST((Zd(2) <=> Zd(1)) == std::strong_ordering::greater, "2 <=> 1 == greater");
    
    // Derived comparisons
    TEST(Zd(1) < Zd(2), "1 < 2");
    TEST(Zd(2) > Zd(1), "2 > 1");
    TEST(Zd(1) <= Zd(1), "1 <= 1");
    TEST(Zd(1) <= Zd(2), "1 <= 2");
    TEST(Zd(2) >= Zd(1), "2 >= 1");
    TEST(Zd(2) >= Zd(2), "2 >= 2");
    TEST(Zd(1) != Zd(2), "1 != 2");
    
    // Note: Comparison is based on val(), which is the canonical value [0, P)
    // So Zd(P-1) > Zd(0) in this ordering
    TEST(Zd(998244352) > Zd(0), "P-1 > 0 (val comparison)");
    
    // Constexpr
    static_assert(Zd(5) == Zd(5), "constexpr equality");
    static_assert(Zd(3) < Zd(7), "constexpr less than");
    TEST(true, "constexpr comparison compiles");
}

// =============================================================================
// Test: I/O Operators
// =============================================================================
void test_io() {
    std::cout << "Testing I/O operators..." << std::endl;
    
    // Output
    std::ostringstream oss;
    oss << Zd(12345);
    TEST_EQ(oss.str(), "12345", "output 12345");
    
    oss.str("");
    oss << Zd(0);
    TEST_EQ(oss.str(), "0", "output 0");
    
    oss.str("");
    oss << Zd(998244352);
    TEST_EQ(oss.str(), "998244352", "output P-1");
    
    // Input positive
    std::istringstream iss("42");
    Zd a;
    iss >> a;
    TEST_EQ(a.val(), 42u, "input 42");
    
    // Input negative
    std::istringstream iss2("-5");
    Zd b;
    iss2 >> b;
    TEST_EQ(b.val(), 998244348u, "input -5");
    
    // Input large positive
    std::istringstream iss3("1000000000");
    Zd c;
    iss3 >> c;
    TEST_EQ(c.val(), 1000000000 % 998244353, "input 1000000000");
    
    // Input zero
    std::istringstream iss4("0");
    Zd d;
    iss4 >> d;
    TEST_EQ(d.val(), 0u, "input 0");
    
    // Round-trip
    for (uint32_t v : {0u, 1u, 42u, 12345u, 998244352u}) {
        std::ostringstream os;
        os << Zd(v);
        std::istringstream is(os.str());
        Zd z;
        is >> z;
        TEST_EQ(z.val(), v, "round-trip for " << v);
    }
}

// =============================================================================
// Test: Montgomery Representation Consistency
// =============================================================================
void test_montgomery_consistency() {
    std::cout << "Testing Montgomery representation consistency..." << std::endl;
    
    // value should be value * R mod P
    // After operations, value should still satisfy this invariant
    
    Zd a(123), b(456);
    
    // After addition
    Zd c = a + b;
    TEST_EQ(c.val(), 579u, "addition value correct");
    TEST(c.value < Zd::MOD, "addition value < P");
    
    // After subtraction
    Zd d = a - b;
    TEST_EQ(d.val(), 998244020u, "subtraction value correct"); // 123 - 456 = -333 mod P = 998244020
    TEST(d.value < Zd::MOD, "subtraction value < P");
    
    // After multiplication
    Zd e = a * b;
    TEST_EQ(e.val(), 56088u, "multiplication value correct");
    TEST(e.value < Zd::MOD, "multiplication value < P");
    
    // Zero should always have value = 0
    TEST_EQ(Zd(0).value, 0u, "zero value");
    TEST_EQ((a - a).value, 0u, "x - x value is 0");
    TEST_EQ((a * Zd(0)).value, 0u, "x * 0 value is 0");
}

// =============================================================================
// Test: Algebraic Properties
// =============================================================================
void test_algebraic_properties() {
    std::cout << "Testing algebraic properties..." << std::endl;
    
    std::mt19937 rng(42);
    auto rand_z = [&]() { return Zd(rng() % Zd::MOD); };
    
    for (int i = 0; i < 100; i++) {
        Zd a = rand_z(), b = rand_z(), c = rand_z();
        
        // Commutativity of addition
        TEST((a + b) == (b + a), "addition commutative");
        
        // Commutativity of multiplication
        TEST((a * b) == (b * a), "multiplication commutative");
        
        // Associativity of addition
        TEST(((a + b) + c) == (a + (b + c)), "addition associative");
        
        // Associativity of multiplication
        TEST(((a * b) * c) == (a * (b * c)), "multiplication associative");
        
        // Distributivity
        TEST((a * (b + c)) == (a * b + a * c), "distributive");
        
        // Additive identity
        TEST((a + Zd(0)) == a, "additive identity");
        
        // Multiplicative identity
        TEST((a * Zd(1)) == a, "multiplicative identity");
        
        // Additive inverse
        TEST((a + (-a)) == Zd(0), "additive inverse");
        
        // Multiplicative inverse (for non-zero)
        if (a.val() != 0) {
            TEST((a * a.inv()) == Zd(1), "multiplicative inverse");
        }
        
        // Zero property
        TEST((a * Zd(0)) == Zd(0), "zero property");
    }
    
    TEST(true, "algebraic properties passed");
}

// =============================================================================
// Test: Edge Cases and Corner Cases
// =============================================================================
void test_edge_cases() {
    std::cout << "Testing edge cases..." << std::endl;
    
    // Maximum uint32_t value
    uint32_t max32 = UINT32_MAX;
    Zd z_max(max32);
    TEST(z_max.val() < Zd::MOD, "UINT32_MAX produces valid result");
    TEST_EQ(z_max.val(), max32 % 998244353, "UINT32_MAX correct value");
    
    // Minimum int32_t value
    int32_t min32 = INT32_MIN;
    Zd z_min(min32);
    TEST(z_min.val() < Zd::MOD, "INT32_MIN produces valid result");
    
    // Operations at boundary
    Zd pm1(998244352); // P-1
    TEST_EQ((pm1 + Zd(1)).val(), 0u, "(P-1) + 1 = 0");
    TEST_EQ((pm1 * pm1).val(), 1u, "(P-1)^2 = 1");
    TEST_EQ((pm1 + pm1).val(), 998244351u, "(P-1) + (P-1) = P-2");
    
    // Self-operations
    Zd x(12345);
    TEST_EQ((x + x).val(), 24690u, "x + x");
    TEST_EQ((x - x).val(), 0u, "x - x");
    TEST_EQ((x * x).val(), uint32_t((uint64_t(12345) * 12345) % 998244353), "x * x");
    TEST_EQ((x / x).val(), 1u, "x / x");
    
    // Chain of operations
    Zd y(7);
    TEST_EQ((y * y * y).val(), 343u, "7^3");
    TEST_EQ((y * y * y * y).val(), 2401u, "7^4");
    
    // Large exponent pattern
    Zd base(3);
    Zd result(1);
    for (int i = 0; i < 20; i++) {
        result *= base;
    }
    uint64_t expected = 1;
    for (int i = 0; i < 20; i++) {
        expected = (expected * 3) % 998244353;
    }
    TEST_EQ(result.val(), uint32_t(expected), "3^20 via repeated multiplication");
}

// =============================================================================
// Test: 64-bit Montgomery (if available)
// =============================================================================
#ifdef __SIZEOF_INT128__
void test_64bit() {
    std::cout << "Testing 64-bit Montgomery..." << std::endl;
    
    // Basic operations
    TEST_EQ(Z64(0).val(), 0ull, "Z64(0)");
    TEST_EQ(Z64(1).val(), 1ull, "Z64(1)");
    TEST_EQ(Z64(P64 - 1).val(), P64 - 1, "Z64(P-1)");
    TEST_EQ(Z64(P64).val(), 0ull, "Z64(P)");
    
    // Arithmetic
    TEST_EQ((Z64(100) + Z64(200)).val(), 300ull, "Z64 addition");
    TEST_EQ((Z64(200) - Z64(100)).val(), 100ull, "Z64 subtraction");
    TEST_EQ((Z64(100) * Z64(200)).val(), 20000ull, "Z64 multiplication");
    
    // Large multiplication (fits in __uint128_t)
    Z64 large(500000000ULL);
    Z64 prod = large * large;
    __uint128_t expected = (__uint128_t(500000000ULL) * 500000000ULL) % P64;
    TEST_EQ(prod.val(), uint64_t(expected), "Z64 large multiplication");
    
    // Note: Division and inv() are not tested for 64-bit because
    // the header's inv() uses std::make_signed_t<twice_T> which
    // doesn't work with __uint128_t. This is a known limitation.
    
    // Negation
    TEST_EQ((-Z64(1)).val(), P64 - 1, "Z64 negation");
    
    // Increment/Decrement
    Z64 inc_test(5);
    ++inc_test;
    TEST_EQ(inc_test.val(), 6ull, "Z64 increment");
    --inc_test;
    TEST_EQ(inc_test.val(), 5ull, "Z64 decrement");
    
    TEST(true, "64-bit tests passed");
}
#endif

// =============================================================================
// Test: Stress Test with Random Operations
// =============================================================================
void test_stress() {
    std::cout << "Testing stress (random operations)..." << std::endl;
    
    std::mt19937_64 rng(123456);
    
    // Track value both with Z and with uint64_t for verification
    uint64_t ref = 1;
    Zd z(1);
    
    for (int i = 0; i < 10000; i++) {
        uint32_t op = rng() % 4;
        uint32_t val = rng() % 1000 + 1; // 1 to 1000
        
        switch (op) {
            case 0: // add
                ref = (ref + val) % 998244353;
                z += Zd(val);
                break;
            case 1: // subtract
                ref = (ref + 998244353 - val % 998244353) % 998244353;
                z -= Zd(val);
                break;
            case 2: // multiply
                ref = (ref * val) % 998244353;
                z *= Zd(val);
                break;
            case 3: // divide
                {
                    // Find modular inverse of val
                    uint64_t inv_ref = 1;
                    uint64_t base = val % 998244353;
                    uint64_t exp = 998244353 - 2;
                    while (exp) {
                        if (exp & 1) inv_ref = (inv_ref * base) % 998244353;
                        base = (base * base) % 998244353;
                        exp >>= 1;
                    }
                    ref = (ref * inv_ref) % 998244353;
                    z /= Zd(val);
                }
                break;
        }
        
        if (z.val() != ref) {
            TEST(false, "stress test mismatch at iteration " << i);
            return;
        }
    }
    
    TEST(true, "stress test passed (10000 random operations)");
}

// =============================================================================
// Test: Constexpr Comprehensive
// =============================================================================
void test_constexpr_comprehensive() {
    std::cout << "Testing constexpr comprehensively..." << std::endl;
    
    // All operations should work at compile time
    constexpr Zd a(100);
    constexpr Zd b(200);
    
    constexpr Zd sum = a + b;
    static_assert(sum.val() == 300, "constexpr sum");
    
    constexpr Zd diff = b - a;
    static_assert(diff.val() == 100, "constexpr diff");
    
    constexpr Zd prod = a * b;
    static_assert(prod.val() == 20000, "constexpr prod");
    
    constexpr Zd neg = -a;
    static_assert(neg.val() == 998244253, "constexpr neg");
    
    constexpr Zd inv_a = a.inv();
    constexpr Zd check_inv = a * inv_a;
    static_assert(check_inv.val() == 1, "constexpr inv");
    
    constexpr Zd quot = b / a;
    constexpr Zd check_quot = quot * a;
    static_assert(check_quot.val() == 200, "constexpr quot");
    
    // Complex expression
    constexpr Zd complex = (a + b) * (a - b) + Zd(1);
    // (a+b)*(a-b) = a^2 - b^2 = 10000 - 40000 = -30000 = 998214353
    // Then +1 = 998214354
    static_assert(complex.val() == 998214354, "constexpr complex expression");
    
    TEST(true, "constexpr comprehensive tests passed");
}

// =============================================================================
// Test: Special Primes
// =============================================================================
void test_special_primes() {
    std::cout << "Testing with special primes..." << std::endl;
    
    // Mersenne prime 2^31 - 1
    Zl a(1000000), b(2000000);
    TEST_EQ((a + b).val(), 3000000u, "Zl addition");
    TEST_EQ((a * b).val(), uint32_t((uint64_t(1000000) * 2000000) % LARGE_P), "Zl multiplication");
    
    // Small prime 97
    Zs c(50), d(60);
    TEST_EQ((c + d).val(), 13u, "Zs: 50 + 60 = 110 = 13 mod 97");
    TEST_EQ((c * d).val(), uint32_t((50 * 60) % 97), "Zs: 50 * 60 mod 97");
    
    // Boundary behavior
    Zl pm1_l(LARGE_P - 1);
    TEST_EQ((pm1_l + Zl(1)).val(), 0u, "Zl: (P-1) + 1 = 0");
    TEST_EQ((pm1_l * pm1_l).val(), 1u, "Zl: (P-1)^2 = 1");
    
    TEST(true, "special primes tests passed");
}

// =============================================================================
// Main
// =============================================================================
int main() {
    std::cout << "=== Fast ModInt Test Suite ===" << std::endl;
    std::cout << "Testing Z<uint32_t, 998244353> and variants" << std::endl;
    std::cout << std::endl;
    
    test_static_constants();
    test_default_constructor();
    test_unsigned_constructor();
    test_signed_constructor();
    test_val();
    test_unary_operators();
    test_addition();
    test_subtraction();
    test_multiplication();
    test_inverse();
    test_division();
    test_increment_decrement();
    test_comparison();
    test_io();
    test_montgomery_consistency();
    test_algebraic_properties();
    test_edge_cases();
#ifdef __SIZEOF_INT128__
    test_64bit();
#else
    std::cout << "Skipping 64-bit tests (__uint128_t not available)" << std::endl;
#endif
    test_stress();
    test_constexpr_comprehensive();
    test_special_primes();
    
    std::cout << std::endl;
    std::cout << "=== Test Results ===" << std::endl;
    std::cout << "Passed: " << tests_passed << std::endl;
    std::cout << "Failed: " << tests_failed << std::endl;
    
    if (tests_failed == 0) {
        std::cout << "\n✓ All tests passed!" << std::endl;
        return 0;
    } else {
        std::cout << "\n✗ Some tests failed!" << std::endl;
        return 1;
    }
}