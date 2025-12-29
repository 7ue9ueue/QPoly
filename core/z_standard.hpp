#include <iostream>
#include <cstdint>
#include <concepts>
#include <type_traits>
#include <cassert>

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

    constexpr T val() const {
        return value;
    }

    constexpr Z() : value(0) {}

    template <std::unsigned_integral U>
    explicit constexpr Z(U v) {
        if (v < MOD) {
            value = v;
        }
        else if (v < MOD + MOD) {
            value = v - MOD;
        }
        else {
            value = v % MOD;
        }
    }

    using signed_T = std::make_signed_t<T>;
    static constexpr signed_T signed_P = static_cast<signed_T>(P);

    template <std::signed_integral U>
    explicit constexpr Z(U v) {
        if (v >= 0 && v < signed_P) {
            value = v;
        } 
        else if (v < 0 && v >= -signed_P) {
            value = v + MOD;
        } 
        else {
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
    constexpr Z operator+() const {
        return *this;
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

    constexpr Z& operator++() {
        ++value;
        if (value == MOD) value = 0;
        return *this;
    }
    constexpr Z operator++(int) {
        Z result = *this;
        ++*this;
        return result;
    }
    constexpr Z& operator--() {
        if (value == 0) value = MOD;
        --value;
        return *this;
    }
    constexpr Z operator--(int) {
        Z result = *this;
        --*this;
        return result;
    }

    constexpr Z& operator*=(const Z& other) {
        value = static_cast<T>((twice_T(value) * other.value) % MOD);
        return *this;
    }

    constexpr Z& operator/=(const Z& other) {
        assert(other.value != 0 && "Z: division by zero");
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
        assert(value != 0 && "Z: zero has no inverse");
        using S = std::make_signed_t<T>;
        S a = value, b = MOD, x = 1, y = 0;
        while (b) {
            S q = a / b;
            a -= q * b; std::swap(a, b);
            x -= q * y; std::swap(x, y);
        }
        assert(a == 1 && "Z: requires gcd(value, mod) == 1");
        return Z(x);
    }

    constexpr Z pow(uint64_t b) const {
        Z res(1), a = *this;
        while (b) {
            if (b & 1) res *= a;
            a *= a;
            b >>= 1;
        }
        return res;
    }
};