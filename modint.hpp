template <std::unsigned_integral T = uint32_t, T P = 998244353>
class Z {
    static_assert(P > 1, "Modulus must be greater than 1");
    T value;

public:
    constexpr static T mod() {return P;}
    constexpr T val() const {return value;}
    constexpr Z() : value(0) {}
    template <std::unsigned_integral U>
    constexpr Z(U v) {
        if (v < mod()) value = v;
        else if (v < mod() + mod()) value = v - mod();
        else value = v % mod();
    }

    template <std::signed_integral U>
    constexpr Z(U v) {
        if (v >= 0 && static_cast<T>(v) < mod()) {
            value = v;
        } else if (v < 0 && v > -static_cast<std::make_signed_t<T>>(mod())) {
            value = v + mod();
        } else {
            auto x = v % static_cast<std::make_signed_t<T>>(mod());
            if (x < 0) x += mod();
            value = x;
        }
    }

    // Unary operators
    constexpr Z operator-() const {
        Z res;
        res.value = value ? mod() - value : 0;
        return res;
    }
    constexpr Z operator+() const {
        return *this;
    }

    // Increment/Decrement
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

    // Compound assignment operators
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
    constexpr Z& operator*=(const Z& other);
    constexpr Z& operator/=(const Z& other);

    // Binary arithmetic operators
    friend constexpr Z operator+(Z lhs, const Z& rhs) { return lhs += rhs; }
    friend constexpr Z operator-(Z lhs, const Z& rhs) { return lhs -= rhs; }
    friend constexpr Z operator*(Z lhs, const Z& rhs) { return lhs *= rhs; }
    friend constexpr Z operator/(Z lhs, const Z& rhs) { return lhs /= rhs; }

    // Stream operators
    friend std::istream& operator>>(std::istream& is, Z& a) {int64_t x; is >> x; a = Z(x); return is;}
    friend std::ostream& operator<<(std::ostream& os, const Z& a) {return os << a.value;}

    // orderinggs
    friend constexpr bool operator==(const ModIntBase &lhs, const ModIntBase &rhs) {return lhs.val() == rhs.val();}
    friend constexpr std::strong_ordering operator<=>(const ModIntBase &lhs, const ModIntBase &rhs) {return lhs.val() <=> rhs.val();}

    constexpr Z inv() const {

    }
    constexpr Z pow(uint64_t b) const {

    }
};