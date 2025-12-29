# QPoly

Modern C++20 polynomial algebra library for competitive programming and symbolic computation.

## Project Goals

1. **Competitive Programming**: SIMD-optimized NTT, power series, fast polynomial operations
2. **Symbolic Integration**: Rational function integration over Q(a) using Hermite + Rothstein-Trager
3. **Modern C++20**: Concepts, constexpr, expression templates, RAII

## Project Structure

```
qpoly/
├── core/
│   ├── modint.hpp           # SIMD Z/pZ
│   ├── frac.hpp             # Exact rationals
│   ├── polynomial.hpp       # Dense univariate
│   └── rational_func.hpp    # P(x)/Q(x)
├── algorithms/
│   ├── ntt.hpp              # NTT multiplication
│   ├── gcd.hpp              # Euclidean + subresultant
│   ├── resultant.hpp
│   ├── multipoint.hpp       # Evaluation + interpolation
│   └── square_free.hpp
├── cp/
│   ├── power_series.hpp     # inv, exp, log, sqrt
│   ├── multipoly.hpp        # Kronecker wrapper
│   └── generating.hpp       # Combinatorial utilities
├── symbolic/
│   ├── hermite.hpp          # Hermite reduction
│   ├── rothstein_trager.hpp # Logarithmic part
│   └── integrate.hpp        # Main integration API
└── qpoly.hpp                # Single include
```

---

## Core Module

### `modint.hpp`

Modular integer with compile-time modulus.

```cpp
template<uint64_t P>
class ModInt;
```

**Implement:**
- Montgomery multiplication (avoid division)
- Branchless add/sub with conditional subtraction
- SIMD batch operations (AVX2: 4 × uint64 parallel)
- Precomputed inverse for division
- `constexpr` construction and basic ops

**Key optimization:** Montgomery form stores `a * R mod P` where `R = 2^64`. Multiplication becomes `(aR)(bR) → abR` without division.

---

### `frac.hpp`

Exact rational arithmetic.

```cpp
template<typename Int = int64_t>
class Frac;
```

**Implement:**
- GCD-based normalization after every operation
- Sign always in numerator
- Handle zero denominator (throw or assert)
- Conversion from integers
- Overflow detection for intermediate results

**Note:** For Level 2 symbolic integration, `Int = __int128` is usually sufficient.

---

### `polynomial.hpp`

Dense univariate polynomial over any ring.

```cpp
template<Ring R>
class Polynomial;
```

**Implement:**
- `std::vector<R>` storage, trailing zeros trimmed
- Arithmetic: `+`, `-`, `*`, scalar ops
- Division with remainder (for Euclidean domains)
- `degree()`, `lead()`, `operator[]`
- `derivative()`, `integral()` (requires `Field R` for integral)
- `evaluate(T x)` — Horner's method
- Expression templates for `a*b + c*d` (optional but impressive)

**Multiplication dispatch:**
```cpp
if constexpr (NTTFriendly<R>) 
    return ntt_multiply(*this, other);
else if constexpr (sizeof(R) <= 8)
    return karatsuba(*this, other);
else
    return naive_multiply(*this, other);
```

---

### `rational_func.hpp`

Rational function P(x)/Q(x).

```cpp
template<Ring R>
class RationalFunc;
```

**Implement:**
- Store `Polynomial<R> num, den`
- Auto-reduce by GCD after construction/operations
- Arithmetic: `+`, `-`, `*`, `/`
- `derivative()` using quotient rule
- `evaluate(T x)`
- `is_proper()` — true if deg(num) < deg(den)

---

## Algorithms Module

### `ntt.hpp`

Number Theoretic Transform for Z/pZ multiplication.

```cpp
template<uint64_t P>
void ntt(std::vector<ModInt<P>>& a, bool inverse);

template<uint64_t P>
Polynomial<ModInt<P>> ntt_multiply(Polynomial<ModInt<P>> a, Polynomial<ModInt<P>> b);
```

**Implement:**
- Cooley-Tukey butterfly (iterative, not recursive)
- Bit-reversal permutation (precomputed table)
- Precomputed roots of unity
- SIMD butterfly: process 4 butterflies per iteration
- Cache-oblivious ordering (optional, significant speedup)

**Common NTT primes:**
- `998244353 = 119 × 2^23 + 1` (primitive root 3)
- `167772161 = 5 × 2^25 + 1`
- `469762049 = 7 × 2^26 + 1`

---

### `gcd.hpp`

Polynomial GCD algorithms.

```cpp
template<EuclideanDomain R>
Polynomial<R> gcd(Polynomial<R> a, Polynomial<R> b);

template<EuclideanDomain R>
std::tuple<Polynomial<R>, Polynomial<R>, Polynomial<R>>
extended_gcd(Polynomial<R> a, Polynomial<R> b);

template<typename Int>
Polynomial<Frac<Int>> subresultant_gcd(Polynomial<Frac<Int>> a, Polynomial<Frac<Int>> b);
```

**Implement:**
- Basic Euclidean GCD
- Extended Euclidean (for Hermite reduction)
- **Subresultant PRS** — critical for Q coefficients, prevents coefficient explosion
- Half-GCD (optional, O(n log² n) vs O(n²))

**Subresultant keeps coefficients O(n·B) instead of O(2^n · B).**

---

### `resultant.hpp`

```cpp
template<Ring R>
R resultant(Polynomial<R> a, Polynomial<R> b);
```

**Implement via subresultant PRS** — the resultant is the last nonzero element, scaled.

**Used by:** Rothstein-Trager

---

### `multipoint.hpp`

Fast multipoint evaluation and interpolation.

```cpp
template<Ring R>
std::vector<R> multipoint_eval(Polynomial<R> p, std::vector<R> points);

template<Ring R>
Polynomial<R> interpolate(std::vector<R> points, std::vector<R> values);
```

**Implement:**
- Subproduct tree for O(n log² n) complexity
- Used by CP for polynomial evaluation at many points

---

### `square_free.hpp`

Square-free factorization (Yun's algorithm).

```cpp
template<Field R>
std::vector<Polynomial<R>> square_free(Polynomial<R> p);
// Returns [p1, p2, p3, ...] where p = p1 · p2² · p3³ · ...
```

**Used by:** Hermite reduction (decompose denominator by multiplicity)

---

## CP Module

### `power_series.hpp`

Formal power series mod x^n using Newton iteration.

```cpp
template<Ring R>
class FormalPowerSeries {
    FormalPowerSeries inverse(size_t n) const;   // Newton: g = g(2 - fg)
    FormalPowerSeries exp(size_t n) const;       // Newton: g = g(1 + f - log g)
    FormalPowerSeries log(size_t n) const;       // log f = ∫ f'/f
    FormalPowerSeries sqrt(size_t n) const;      // Newton: g = (g + f/g)/2
};
```

### `multipoly.hpp`

Multivariate polynomials via Kronecker substitution.

```cpp
template<Ring R, size_t Vars>
class MultiPoly;
// Internally: y = x^B, z = x^(B²), etc.
// Multiplication reduces to univariate NTT
```

### `generating.hpp`

Combinatorial utilities (optional).

---

## Symbolic Module

### Variable Counting Rule

```cpp
// 1 variable (x only) → Level 1, coefficients in Q
// 2 variables (x + 1 parameter) → Level 2, coefficients in Q(a)
// 3+ variables → throw error
```

### `hermite.hpp`

Extract the rational part of the integral.

```cpp
template<typename Int>
struct HermiteResult {
    RationalFunc<Frac<Int>> rational_part;
    RationalFunc<Frac<Int>> remaining;  // Square-free denominator
};

template<typename Int>
HermiteResult<Int> hermite_reduce(RationalFunc<Frac<Int>> f);
```

**Algorithm:** For each repeated factor D^k in denominator, use extended GCD to reduce multiplicity until all factors are simple.

---

### `rothstein_trager.hpp`

Find the logarithmic part.

```cpp
template<typename Int>
struct LogTerm {
    Polynomial<Frac<Int>> argument;   // u(x) in log(u(x))
    /* algebraic number */ coeff;      // c in c·log(u(x))
};

template<typename Int>
std::vector<LogTerm<Int>> rothstein_trager(RationalFunc<Frac<Int>> f);
```

**Algorithm:**
1. Compute R(z) = resultant_x(A - z·D', D)
2. Roots of R(z) are the log coefficients
3. For each root α: u = gcd(A - α·D', D)
4. Result: α · log(u)

---

### `integrate.hpp`

Main API.

```cpp
template<typename Int = __int128>
struct IntegrationResult {
    RationalFunc<Frac<Int>> rational_part;
    std::vector<LogTerm<Int>> log_terms;
    std::string to_string() const;
};

template<typename Int = __int128>
IntegrationResult<Int> integrate(RationalFunc<Frac<Int>> f);
```

**Pipeline:**
```
Input f(x) → check vars ≤ 2 → make proper → Hermite → Rothstein-Trager → Output
```

---

## Development Phases

| Phase | What | Time |
|-------|------|------|
| 1 | Core: ModInt, Frac, Polynomial basics | 2-3 weeks |
| 2 | NTT + SIMD optimization | 2-3 weeks |
| 3 | CP: Power series, Kronecker wrapper | 2 weeks |
| 4 | Algorithms: GCD, subresultant, resultant, square-free | 2-3 weeks |
| 5 | Symbolic: Hermite, Rothstein-Trager, integrate | 3-4 weeks |
| 6 | Polish, benchmarks, documentation | 1-2 weeks |

---

## Testing

```cpp
// Property: GCD divides both
assert(a % gcd(a, b) == 0);

// Property: integral's derivative equals original
assert(derivative(integrate(f)) == f);

// Benchmark: NTT at 2^20
benchmark("ntt_1M", [&]{ return a * b; });
```

---

## References

- Bronstein, *Symbolic Integration I* — Integration algorithms
- von zur Gathen & Gerhard, *Modern Computer Algebra* — Polynomial algorithms
- cp-algorithms.com — NTT, power series

---

## Build

Header-only. C++20 required.

```cpp
#include "qpoly/qpoly.hpp"
```