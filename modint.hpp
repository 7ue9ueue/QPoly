#include <iostream>
#include <compare>
#include <concepts>

template <std::unsigned_integral T = uint32_t, T P = 998244353>
class Z {
public:
    T value;

    constexpr static T mod() {
        return P;
    }
    
    constexpr T val() const {
        return value;
    }

    constexpr Z() : value(0){}

    template <std::unsigned_integral U>
    constexpr Z(U v) {
        if (v < mod()) value = v;
        else if (v + v < mod()) value = v - mod();
        else value = v % mod();
    }

    template <std::signed_integral U>
    constexpr Z(U v) {
        using S = std::make_signed_t<T>;
        S x = v % S(mod());
        if (x < 0) x += mod();
        value = x;
    }

    constexpr Z operator-() const;
    constexpr Z operator+() const;

    constexpr Z& operator++();
    constexpr Z  operator++(int);
    constexpr Z& operator--();
    constexpr Z  operator--(int);

    constexpr Z& operator+=(const Z& other);
    constexpr Z& operator-=(const Z& other);
    constexpr Z& operator*=(const Z& other);
    constexpr Z& operator/=(const Z& other);

    friend constexpr Z operator+(Z lhs, const Z& rhs) { return lhs += rhs; }
    friend constexpr Z operator-(Z lhs, const Z& rhs) { return lhs -= rhs; }
    friend constexpr Z operator*(Z lhs, const Z& rhs) { return lhs *= rhs; }
    friend constexpr Z operator/(Z lhs, const Z& rhs) { return lhs /= rhs; }

    friend std::istream& operator>>(std::istream& is, Z& a);
    friend std::ostream& operator<<(std::ostream& os, const Z& a);
    
    friend constexpr bool operator==(const Z& lhs, const Z& rhs) = default;
    friend constexpr std::strong_ordering operator<=>(const Z& lhs, const Z& rhs) = default;

    constexpr Z inv() const;
    constexpr Z pow(uint64_t b) const;
};