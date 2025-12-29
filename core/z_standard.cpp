#include <iostream>
#include <cassert>
#include <limits>

template <std::unsigned_integral T = uint32_t, T P = 998244353>
class Z {
public:
    T value;

    constexpr static T mod() {return P;}
    constexpr T val() const {return value;}
    
    constexpr Z() : value(0) {}
    template <std::unsigned_integral U>
    explicit constexpr Z(U v) {
        if (v < mod()) {
            value = v;
        }
        else if (v < mod() + mod()) {
            value = v - mod();
        }
        else {
            value = v % mod();
        }
    }
    template <std::signed_integral U>
    explicit constexpr Z(U v) {
        if (v >= 0 && static_cast<T>(v) < mod()) {
            value = v;
        } 
        else if (v < 0 && v > -static_cast<std::make_signed_t<T>>(mod())) {
            value = v + mod();
        } 
        else {
            auto x = v % static_cast<std::make_signed_t<T>>(mod());
            if (x < 0) x += mod();
            value = x;
        }
    }

    constexpr Z operator-() const {
        Z result(value);
        if (result.val() != 0) result.value = mod() - result.value; 
        return result;
    }

    constexpr Z operator+() const {
        return *this;
    }

    constexpr Z& operator++() {
        if (++value >= mod()) value -= mod();
        return *this;
    }
    constexpr Z operator++(int) {
        Z result = *this;
        ++*this;
        return result;
    }
    constexpr Z& operator--() {
        if (value == 0) value = mod();
        --value;
        return *this;
    }
    constexpr Z operator--(int) {
        Z result = *this;
        --*this;
        return result;
    }

    constexpr Z& operator+=(const Z& other) {
        value += other.value;
        if (value >= mod()) value -= mod();
        return *this;
    }
    constexpr Z& operator-=(const Z& other) {
        if (value < other.value) value += mod();
        value -= other.value;
        return *this;
    }

    constexpr Z& operator*=(const Z& other) {
        if constexpr (sizeof(T) <= 4) {
            value = static_cast<T>(static_cast<uint64_t>(value) * other.value % mod());
        } else {
            value = static_cast<T>(static_cast<__uint128_t>(value) * other.value % mod());
        }
        return *this;
    }

    // constexpr Z& operator*=(const Z& other) {
    //     if constexpr (sizeof(T) <= 4) {
    //         constexpr uint64_t m = static_cast<uint64_t>((__uint128_t(1) << 64) / P);
    //         uint64_t x = static_cast<uint64_t>(value) * other.value;
    //         uint64_t q = static_cast<uint64_t>((__uint128_t(x) * m) >> 64);
    //         uint64_t r = x - q * P;
    //         if (r >= P) r -= P;
    //         if (r >= P) r -= P;
    //         value = static_cast<T>(r);
    //     } else {
    //         value = static_cast<T>(static_cast<__uint128_t>(value) * other.value % mod());
    //     }
    //     return *this;
    // }

    constexpr Z& operator/=(const Z& other) {
        assert(other.value != 0 && "Z: division by zero");
        return *this *= other.inv();
    }

    friend constexpr Z operator+(Z lhs, const Z& rhs) { return lhs += rhs; }
    friend constexpr Z operator-(Z lhs, const Z& rhs) { return lhs -= rhs; }
    friend constexpr Z operator*(Z lhs, const Z& rhs) { return lhs *= rhs; }
    friend constexpr Z operator/(Z lhs, const Z& rhs) { return lhs /= rhs; }

    friend std::istream& operator>>(std::istream& is, Z& a) {int64_t x; is >> x; a = Z(x); return is;}
    friend std::ostream& operator<<(std::ostream& os, const Z& a) {return os << a.value;}

    friend constexpr bool operator==(const Z &lhs, const Z &rhs) {return lhs.val() == rhs.val();}
    friend constexpr std::strong_ordering operator<=>(const Z &lhs, const Z &rhs) {return lhs.val() <=> rhs.val();}

    constexpr Z inv() const {
        assert(value != 0 && "Z: zero has no inverse");
        using S = std::make_signed_t<T>;
        S a = value, b = mod(), x = 1, y = 0;
        while (b) {
            S q = a / b;
            a -= q * b; std::swap(a, b);
            x -= q * y; std::swap(x, y);
        }
        assert(a == 1 && "Z: requires gcd(value, mod) == 1");
        return Z(x);
    }

    constexpr Z pow(uint64_t b) const {
        Z res, a = *this;
        res.value = 1;
        while (b) {
            if (b & 1) res *= a;
            a *= a;
            b >>= 1;
        }
        return res;
    }
};