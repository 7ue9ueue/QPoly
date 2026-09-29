// Strassen-Winograd recursion over a recursive-quadrant block layout (exploration 013).
//
// Layout: a padded R x C matrix at depth d is stored as its four (R/2 x C/2) quadrants
// [Q00, Q01, Q10, Q11], each contiguous and recursively laid out at depth d-1; at depth 0
// a block is stored in the leaf's own layout (Leaf::Layout decides how element (r, c)
// maps to an offset). Element-wise additions therefore never care about the layout.
//
// Schedule (written for this exploration; Winograd's 7-product / 15-addition variant):
//   S1 = A21 + A22, S2 = S1 - A11, S3 = A11 - A21, S4 = A12 - S2,
//   T1 = B12 - B11, T2 = B22 - T1, T3 = B22 - B12, T4 = T2 - B21,
//   P1 = A11 B11, P2 = A12 B21, P3 = S4 B22, P4 = A22 T4, P5 = S1 T1, P6 = S2 T2, P7 = S3 T3,
//   C11 = P1 + P2, U2 = P1 + P6, U3 = U2 + P7, C22 = U3 + P5, C12 = U2 + P5 + P3, C21 = U3 - P4.
// Three temporaries per level (X: n*m/4 for S, Y: m*k/4 for T, Z: n*k/4 for products); the
// C quadrants hold products and partial sums:
//   X=S3 Y=T3 C21=P7 | X=S1 Y=T1 C22=P5 | X=S2 Y=T2 C12=P6 | X=S4 Z=P3 | C11=P1 |
//   C12+=C11 (U2) | C21+=C12 (U3) | C12+=C22 (U4) | C22+=C21 (U7=C22) | C12+=Z (C12) |
//   Y=T4 Z=P4 | C21-=Z (C21) | Z=P2 | C11+=Z (C11).
// OpsAB::add/sub act on A- and B-side blocks (S, T), OpsC::add/sub on C-side blocks (products
// and partial sums): add(x, y, z, len) computes z = x + y, sub(x, y, z, len) computes z = x - y
// element-wise in the representation used by the leaf; z may alias x or y.
#pragma once
#include <cstddef>
#include <cstdint>

namespace mp {

template <class Leaf, class OpsAB, class OpsC = OpsAB>
struct StrassenWinograd {
    using E = typename Leaf::E;
    // a: n x m, b: m x k, c: n x k in recursive layout at the given depth. work must hold
    // workspace(n, m, k, depth) elements.
    static std::size_t workspace(std::size_t n, std::size_t m, std::size_t k, int depth) {
        std::size_t total = 0;
        for (int d = depth; d > 0; --d) {
            n /= 2, m /= 2, k /= 2;
            total += n * m + m * k + n * k;
        }
        return total;
    }
    static void multiply(const E* a, const E* b, E* c, std::size_t n, std::size_t m, std::size_t k, int depth, E* work) {
        if (depth == 0) {
            Leaf::multiply(a, b, c, n, m, k);
            return;
        }
        n /= 2, m /= 2, k /= 2;
        const std::size_t sa = n * m, sb = m * k, sc = n * k;
        const E *a11 = a, *a12 = a + sa, *a21 = a + 2 * sa, *a22 = a + 3 * sa;
        const E *b11 = b, *b12 = b + sb, *b21 = b + 2 * sb, *b22 = b + 3 * sb;
        E *c11 = c, *c12 = c + sc, *c21 = c + 2 * sc, *c22 = c + 3 * sc;
        E *x = work, *y = x + sa, *z = y + sb, *next = z + sc;
        OpsAB::sub(a11, a21, x, sa);  // S3
        OpsAB::sub(b22, b12, y, sb);  // T3
        multiply(x, y, c21, n, m, k, depth - 1, next);  // P7
        OpsAB::add(a21, a22, x, sa);  // S1
        OpsAB::sub(b12, b11, y, sb);  // T1
        multiply(x, y, c22, n, m, k, depth - 1, next);  // P5
        OpsAB::sub(x, a11, x, sa);    // S2 = S1 - A11
        OpsAB::sub(b22, y, y, sb);    // T2 = B22 - T1
        multiply(x, y, c12, n, m, k, depth - 1, next);  // P6
        OpsAB::sub(a12, x, x, sa);    // S4 = A12 - S2
        multiply(x, b22, z, n, m, k, depth - 1, next);  // P3
        multiply(a11, b11, c11, n, m, k, depth - 1, next);  // P1
        OpsC::add(c11, c12, c12, sc);  // U2 = P1 + P6
        OpsC::add(c12, c21, c21, sc);  // U3 = U2 + P7
        OpsC::add(c12, c22, c12, sc);  // U4 = U2 + P5
        OpsC::add(c21, c22, c22, sc);  // C22 = U3 + P5
        OpsC::add(c12, z, c12, sc);    // C12 = U4 + P3
        OpsAB::sub(y, b21, y, sb);      // T4 = T2 - B21
        multiply(a22, y, z, n, m, k, depth - 1, next);  // P4
        OpsC::sub(c21, z, c21, sc);    // C21 = U3 - P4
        multiply(a12, b21, z, n, m, k, depth - 1, next);  // P2
        OpsC::add(c11, z, c11, sc);    // C11 = P1 + P2
    }
};

// Visit every leaf block of an R x C matrix stored in recursive layout at the given depth:
// f(block_pointer, row0, col0, rows, cols) for leaf blocks of size (R >> depth) x (C >> depth).
template <class E, class F>
void for_each_leaf(E* base, std::size_t rows, std::size_t cols, int depth, F&& f, std::size_t r0 = 0, std::size_t c0 = 0) {
    if (depth == 0) {
        f(base, r0, c0, rows, cols);
        return;
    }
    const std::size_t hr = rows / 2, hc = cols / 2, q = hr * hc;
    for_each_leaf(base, hr, hc, depth - 1, f, r0, c0);
    for_each_leaf(base + q, hr, hc, depth - 1, f, r0, c0 + hc);
    for_each_leaf(base + 2 * q, hr, hc, depth - 1, f, r0 + hr, c0);
    for_each_leaf(base + 3 * q, hr, hc, depth - 1, f, r0 + hr, c0 + hc);
}

}  // namespace mp
