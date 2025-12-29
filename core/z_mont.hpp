#include <iostream>
#include <cstdint>
#include <concepts>
#include <type_traits>
#include <cassert>

template <std::unsigned_integral T = uint32_t, T P = 998244353>
class Z {
public:
    T mont_value;
    constexpr static T MOD = P;

#ifdef __SIZEOF_INT128__
    using twice_T = std::conditional_t<sizeof(T) == 4, uint64_t, __uint128_t>;
#else
    static_assert(sizeof(T) == 4, "64-bit modular arithmetic requires __uint128_t support");
    using twice_T = uint64_t;
#endif
    
    // Montgomery Multiplication
    static constexpr int BITS = 8 * sizeof(T);
    static constexpr int BITS_LOG = __builtin_ctz(BITS);

    static constexpr T compute_p_inv() {
        T inv = 1;
        for (int i = 0; i < BITS_LOG; i++) {
            inv *= 2 - MOD * inv;
        }
        return inv;
    }
    static constexpr T P_INV = compute_p_inv();
    
    static constexpr T compute_r1_mod_p () {
        T x = ((T(1) << (BITS - 1)) % P);
        if (x + x >= P) return x + x - P;
        else return x + x;
    }
    static constexpr T R1_MOD_P = compute_r1_mod_p();

    static constexpr T compute_r2_mod_p () {
        T x = ((twice_T(1) << (BITS + BITS - 1)) % P);
        if (x + x >= P) return x + x - P;
        else return x + x;
    }
    static constexpr T R2_MOD_P = compute_r2_mod_p();

    // in range [0, P)
    constexpr T mont_reduce(twice_T x) const {
        T q = T(x) * P_INV;
        T m = (twice_T(q) * MOD) >> BITS;
        T y = (x >> BITS) + MOD - m;
        return y < MOD ? y : y - MOD;
    }

    constexpr T mont_mul(T x, T y) const {
        return static_cast<T>(mont_reduce(static_cast<twice_T>(x) * y));
    }
    
    constexpr T val() const {
        return mont_reduce(mont_value);
    }

    constexpr Z() : mont_value(0) {}

    template <std::unsigned_integral U>
    explicit constexpr Z(U v) {
        if (v < P) {
            mont_value = mont_mul(v, R2_MOD_P);
        }
        else if (v < P + P) {
            mont_value = mont_mul(v - P, R2_MOD_P);
        }
        else {
            mont_value = mont_mul(v % P, R2_MOD_P);
        }
    }

    using signed_T = std::make_signed_t<T>;
    static constexpr signed_T signed_P = static_cast<std::make_signed_t<T>>(P);
    
    template <std::signed_integral U>
    explicit constexpr Z(U v) {
        if (v >= 0 && v < signed_P) {
            mont_value = mont_mul(v, R2_MOD_P);
        } 
        else if (v < 0 && v >= -signed_P) {
            mont_value = mont_mul(v + MOD, R2_MOD_P);
        } 
        else {
            auto x = v % signed_P;
            if (x < 0) x += MOD;
            mont_value = mont_mul(x, R2_MOD_P);
        }
    }

    constexpr Z operator-() const {
        Z result;
        result.mont_value = mont_value;
        if (result.val() != 0) result.mont_value = MOD - result.mont_value; 
        return result;
    }
    constexpr Z operator+() const {
        return *this;
    }

    constexpr Z& operator+=(const Z& other) {
        mont_value += other.mont_value;
        if (mont_value >= MOD) mont_value -= MOD;
        return *this;
    }
    constexpr Z& operator-=(const Z& other) {
        if (mont_value < other.mont_value) mont_value += MOD;
        mont_value -= other.mont_value;
        return *this;
    }

    constexpr Z& operator++() {
        mont_value += R1_MOD_P;
        if (mont_value >= MOD) mont_value -= MOD;
        return *this;
    }
    constexpr Z operator++(int) {
        Z result = *this;
        ++*this;
        return result;
    }
    constexpr Z& operator--() {
        mont_value += MOD - R1_MOD_P;
        if (mont_value >= MOD) mont_value -= MOD;
        return *this;
    }
    constexpr Z operator--(int) {
        Z result = *this;
        --*this;
        return result;
    }

    constexpr Z& operator*=(const Z& other) {
        mont_value = mont_mul(mont_value, other.mont_value);
        return *this;
    }

    constexpr Z& operator/=(const Z& other) {
        assert(other.mont_value != 0 && "Z: division by zero");
        return *this *= other.inv();
    }

    friend constexpr Z operator+(Z lhs, const Z& rhs) { return lhs += rhs; }
    friend constexpr Z operator-(Z lhs, const Z& rhs) { return lhs -= rhs; }
    friend constexpr Z operator*(Z lhs, const Z& rhs) { return lhs *= rhs; }
    friend constexpr Z operator/(Z lhs, const Z& rhs) { return lhs /= rhs; }

    friend std::istream& operator>>(std::istream& is, Z& a) {int64_t x; is >> x; a = Z(x); return is;}
    friend std::ostream& operator<<(std::ostream& os, const Z& a) {return os << a.val();}

    friend constexpr bool operator==(const Z &lhs, const Z &rhs) {return lhs.val() == rhs.val();}
    friend constexpr std::strong_ordering operator<=>(const Z &lhs, const Z &rhs) {return lhs.val() <=> rhs.val();}

    constexpr Z inv() const {
        assert(val() != 0 && "Z: zero has no inverse");
        using S = std::make_signed_t<twice_T>;
        S a = val(), b = MOD, x = 1, y = 0;
        while (b) {
            S q = a / b;
            a -= q * b; std::swap(a, b);
            x -= q * y; std::swap(x, y);
        }
        assert(a == 1 && "Z: requires gcd(value, mod) == 1");
        return Z(x);
    }
};