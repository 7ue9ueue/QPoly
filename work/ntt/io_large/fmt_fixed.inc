// Fixed-width decimal output for values < 10^9 (QPoly exploration 011). Written for this
// exploration; the digit-splitting constants are standard multiply-shift divisions.
//
// Format: every value takes exactly 10 bytes: its decimal digits right-aligned in 9 characters
// (leading zeros replaced by spaces, the units digit always printed) followed by one space.
// Library Checker's convolution checker is testlib wcmp, which compares whitespace-separated
// tokens as strings, so the padding is accepted and every token is the canonical decimal string
// (no leading zeros). Output size is 10 bytes/value (the variable-length writer averages ~9.9
// for random residues); wcmp accepts up to 512 MiB, i.e. > 5 * 10^7 values.
//
// Contract: values < 10^9 (the SIMD paths need x < 2^30 for their exact divisions). eight() reads
// 8 values (unaligned) and writes 86 bytes p[0..85]: the 80-byte block plus 6 bytes that the next
// block (or the caller) overwrites; stores go in increasing address order. blocks<G>() does the
// same for 8G values (80G bytes + 6). one_table() writes p[0..9]. The round-5 formatter
// blocks3<G> (the deliverable's) and the digit-loop reference one() are in fmt_bcd.inc.
#pragma once
#include <immintrin.h>
#include <cstdint>
#include <cstring>
// one() (digit-loop reference) and blocks3<G>:
#include "fmt_bcd.inc"

namespace qp_fixed {
// Scalar branch-free variant with a 4-digit table (baseline for the SIMD version).
struct Groups { uint32_t g[10000]; };
constexpr Groups make_groups() {
    Groups t{};
    for (unsigned v = 0; v < 10000; ++v)
        t.g[v] = ('0' + v / 1000) | (('0' + v / 100 % 10) << 8) | (('0' + v / 10 % 10) << 16) | (('0' + v % 10) << 24);
    return t;
}
inline constexpr Groups groups = make_groups();
struct BlankMasks { uint64_t m[9]; };
constexpr BlankMasks make_blank_masks() {   // m[k]: 0x10 in the low k bytes ('0' ^ ' ' = 0x10)
    BlankMasks t{};
    for (int k = 0; k <= 8; ++k) for (int j = 0; j < k; ++j) t.m[k] |= uint64_t(0x10) << (8 * j);
    return t;
}
inline constexpr BlankMasks blank_masks = make_blank_masks();
__attribute__((always_inline)) inline void one_table(uint32_t x, char* p) {
    const uint32_t q = uint32_t((uint64_t(x) * 3518437209u) >> 45);   // x / 10^4, exact for x < 2^30
    const uint32_t c = x - q * 10000;
    const uint32_t a = uint32_t((uint64_t(q) * 3518437209u) >> 45);   // q / 10^4
    const uint32_t b = q - a * 10000;
    // Field bytes 0..7 = [a, b(4), c(3)], bytes 8..9 = [c's units digit, ' '].
    uint64_t w = uint64_t('0' + a) | (uint64_t(groups.g[b]) << 8) | (uint64_t(groups.g[c]) << 40);
    // Leading '0' characters among bytes 0..7 (byte 8 is never blanked); tzcnt(0) = 64 -> 8.
    const uint64_t nz = w ^ 0x3030303030303030ULL;
    const unsigned k = unsigned(_tzcnt_u64(nz)) >> 3;
    w ^= blank_masks.m[k];
    std::memcpy(p, &w, 8);
    const uint16_t tail = uint16_t(groups.g[c] >> 24) | uint16_t(' ' << 8);
    std::memcpy(p + 8, &tail, 2);
}

// AVX2: 8 values -> 80 bytes. x = a*10^8 + b*10^4 + c; b and c become 16 four-digit groups in
// 16-bit lanes, digits via mulhi/mullo by reciprocal constants; blanks where x < 10^(8-position);
// per 128-bit lane one 10-byte field is assembled and stored with an overlapping 16-byte store.
__attribute__((always_inline)) inline void eight(const uint32_t* src, char* p) {
    const __m256i x = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(src));
    // q = x / 10^4 (exact for x < 2^30: ceil(2^45 / 10^4) * 10^4 - 2^45 = 1168 <= 2^15).
    const __m256i m1 = _mm256_set1_epi64x(3518437209LL);
    const __m256i qe = _mm256_srli_epi64(_mm256_mul_epu32(x, m1), 45);
    const __m256i qo = _mm256_srli_epi64(_mm256_mul_epu32(_mm256_srli_epi64(x, 32), m1), 13);  // q in the high dword
    const __m256i q = _mm256_blend_epi32(qe, qo, 0xAA);
    const __m256i c = _mm256_sub_epi32(x, _mm256_mullo_epi32(q, _mm256_set1_epi32(10000)));
    // a = q / 10^4 < 10: exact in single precision for q < 10^5 (float(1e-4) > 1e-4, and
    // q/10^4 is at least 10^-4 below the next integer; checked exhaustively by the unit test).
    const __m256i a = _mm256_cvttps_epi32(_mm256_mul_ps(_mm256_cvtepi32_ps(q), _mm256_set1_ps(1e-4f)));
    const __m256i b = _mm256_sub_epi32(q, _mm256_mullo_epi32(a, _mm256_set1_epi32(10000)));
    const __m256i v = _mm256_packus_epi32(b, c);                       // per lane: b0..b3 c0..c3
    const __m256i hi = _mm256_srli_epi16(_mm256_mulhi_epu16(v, _mm256_set1_epi16(5243)), 3);   // v / 100
    const __m256i lo = _mm256_sub_epi16(v, _mm256_mullo_epi16(hi, _mm256_set1_epi16(100)));
    const __m256i th = _mm256_srli_epi16(_mm256_mullo_epi16(hi, _mm256_set1_epi16(103)), 10);  // d / 10, d < 100
    const __m256i hu = _mm256_sub_epi16(hi, _mm256_mullo_epi16(th, _mm256_set1_epi16(10)));
    const __m256i te = _mm256_srli_epi16(_mm256_mullo_epi16(lo, _mm256_set1_epi16(103)), 10);
    const __m256i on = _mm256_sub_epi16(lo, _mm256_mullo_epi16(te, _mm256_set1_epi16(10)));
    // Blank masks in the layout of v: b-group digits are positions 1..4, c-group digits 5..8.
    auto lt = [&](int k) __attribute__((always_inline)) { return _mm256_cmpgt_epi32(_mm256_set1_epi32(k), x); };
    const __m256i m_th = _mm256_packs_epi32(lt(10000000), lt(1000));
    const __m256i m_hu = _mm256_packs_epi32(lt(1000000), lt(100));
    const __m256i m_te = _mm256_packs_epi32(lt(100000), lt(10));
    const __m256i m_on = _mm256_packs_epi32(lt(10000), _mm256_setzero_si256());
    const __m256i z16 = _mm256_set1_epi16('0'), s16 = _mm256_set1_epi16(' ');
    auto asc = [&](__m256i d, __m256i m) __attribute__((always_inline)) {
        return _mm256_blendv_epi8(_mm256_add_epi16(d, z16), s16, m);
    };
    const __m256i X = _mm256_packus_epi16(asc(th, m_th), asc(te, m_te));   // th of 8 groups, te of 8 groups
    const __m256i Y = _mm256_packus_epi16(asc(hu, m_hu), asc(on, m_on));   // hu, on
    const __m256i l8 = _mm256_unpacklo_epi8(X, Y);
    const __m256i h8 = _mm256_unpackhi_epi8(X, Y);
    const __m256i R1 = _mm256_unpacklo_epi16(l8, h8);   // b groups, 4 digits each
    const __m256i R2 = _mm256_unpackhi_epi16(l8, h8);   // c groups
    const __m256i S1 = _mm256_unpacklo_epi32(R1, R2);   // lane: [b0 c0 | b1 c1] (values 0,1 / 4,5)
    const __m256i S2 = _mm256_unpackhi_epi32(R1, R2);   // lane: [b2 c2 | b3 c3] (values 2,3 / 6,7)
    // Leading digit (byte 0, blank if x < 10^8) and the separator (byte 3) of each dword.
    const __m256i A = _mm256_or_si256(
        _mm256_blendv_epi8(_mm256_add_epi32(a, _mm256_set1_epi32('0')), _mm256_set1_epi32(' '), lt(100000000)),
        _mm256_set1_epi32(int(uint32_t(' ') << 24)));
    const __m256i dlo = _mm256_setr_epi8(-128, 0, 1, 2, 3, 4, 5, 6, 7, -128, -128, -128, -128, -128, -128, -128,
                                         -128, 0, 1, 2, 3, 4, 5, 6, 7, -128, -128, -128, -128, -128, -128, -128);
    const __m256i dhi = _mm256_add_epi8(dlo, _mm256_setr_epi8(0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0,
                                                             0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0));
    auto actl = [](int k) __attribute__((always_inline)) {
        const char s = char(4 * k), e = char(4 * k + 3), z = char(-128);
        return _mm256_setr_epi8(s, z, z, z, z, z, z, z, z, e, z, z, z, z, z, z, s, z, z, z, z, z, z, z, z, e, z, z, z, z, z, z);
    };
    const __m256i f0 = _mm256_or_si256(_mm256_shuffle_epi8(S1, dlo), _mm256_shuffle_epi8(A, actl(0)));
    const __m256i f1 = _mm256_or_si256(_mm256_shuffle_epi8(S1, dhi), _mm256_shuffle_epi8(A, actl(1)));
    const __m256i f2 = _mm256_or_si256(_mm256_shuffle_epi8(S2, dlo), _mm256_shuffle_epi8(A, actl(2)));
    const __m256i f3 = _mm256_or_si256(_mm256_shuffle_epi8(S2, dhi), _mm256_shuffle_epi8(A, actl(3)));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 0), _mm256_castsi256_si128(f0));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 10), _mm256_castsi256_si128(f1));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 20), _mm256_castsi256_si128(f2));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 30), _mm256_castsi256_si128(f3));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 40), _mm256_extracti128_si256(f0, 1));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 50), _mm256_extracti128_si256(f1, 1));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 60), _mm256_extracti128_si256(f2, 1));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(p + 70), _mm256_extracti128_si256(f3, 1));
}
// Variant 2 (exploration 011 round 2): the same fields, restructured for instruction-level
// parallelism. a = x / 10^8 comes straight from x (vpmuludq, ceil(2^56/10^8) = 720575941,
// exact for x < 2^30) in parallel with q = x / 10^4, instead of from q through float
// conversions on the critical path; G independent 8-value blocks are processed together so
// their dependency chains overlap (G = 1 or 2). Stores stay in increasing address order.
template<int G>
__attribute__((always_inline)) inline void blocks(const uint32_t* src, char* p) {
    const __m256i m1 = _mm256_set1_epi64x(3518437209LL), m8 = _mm256_set1_epi64x(720575941LL);
    const __m256i k4 = _mm256_set1_epi32(10000);
    __m256i x[G], S1[G], S2[G], A[G];
    for (int g = 0; g < G; ++g) x[g] = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(src + 8 * g));
    for (int g = 0; g < G; ++g) {
        const __m256i xo = _mm256_srli_epi64(x[g], 32);
        const __m256i q = _mm256_blend_epi32(_mm256_srli_epi64(_mm256_mul_epu32(x[g], m1), 45),
                                             _mm256_srli_epi64(_mm256_mul_epu32(xo, m1), 13), 0xAA);
        const __m256i a = _mm256_blend_epi32(_mm256_srli_epi64(_mm256_mul_epu32(x[g], m8), 56),
                                             _mm256_srli_epi64(_mm256_mul_epu32(xo, m8), 24), 0xAA);
        const __m256i c = _mm256_sub_epi32(x[g], _mm256_mullo_epi32(q, k4));
        const __m256i b = _mm256_sub_epi32(q, _mm256_mullo_epi32(a, k4));
        const __m256i v = _mm256_packus_epi32(b, c);
        const __m256i hi = _mm256_srli_epi16(_mm256_mulhi_epu16(v, _mm256_set1_epi16(5243)), 3);
        const __m256i lo = _mm256_sub_epi16(v, _mm256_mullo_epi16(hi, _mm256_set1_epi16(100)));
        const __m256i th = _mm256_srli_epi16(_mm256_mullo_epi16(hi, _mm256_set1_epi16(103)), 10);
        const __m256i hu = _mm256_sub_epi16(hi, _mm256_mullo_epi16(th, _mm256_set1_epi16(10)));
        const __m256i te = _mm256_srli_epi16(_mm256_mullo_epi16(lo, _mm256_set1_epi16(103)), 10);
        const __m256i on = _mm256_sub_epi16(lo, _mm256_mullo_epi16(te, _mm256_set1_epi16(10)));
        auto lt = [&](int k) __attribute__((always_inline)) { return _mm256_cmpgt_epi32(_mm256_set1_epi32(k), x[g]); };
        const __m256i z16 = _mm256_set1_epi16('0'), s16 = _mm256_set1_epi16(' ');
        auto asc = [&](__m256i d, __m256i m) __attribute__((always_inline)) {
            return _mm256_blendv_epi8(_mm256_add_epi16(d, z16), s16, m);
        };
        const __m256i X = _mm256_packus_epi16(asc(th, _mm256_packs_epi32(lt(10000000), lt(1000))),
                                              asc(te, _mm256_packs_epi32(lt(100000), lt(10))));
        const __m256i Y = _mm256_packus_epi16(asc(hu, _mm256_packs_epi32(lt(1000000), lt(100))),
                                              asc(on, _mm256_packs_epi32(lt(10000), _mm256_setzero_si256())));
        const __m256i l8 = _mm256_unpacklo_epi8(X, Y), h8 = _mm256_unpackhi_epi8(X, Y);
        const __m256i R1 = _mm256_unpacklo_epi16(l8, h8), R2 = _mm256_unpackhi_epi16(l8, h8);
        S1[g] = _mm256_unpacklo_epi32(R1, R2);
        S2[g] = _mm256_unpackhi_epi32(R1, R2);
        A[g] = _mm256_or_si256(
            _mm256_blendv_epi8(_mm256_add_epi32(a, _mm256_set1_epi32('0')), _mm256_set1_epi32(' '), lt(100000000)),
            _mm256_set1_epi32(int(uint32_t(' ') << 24)));
    }
    const __m256i dlo = _mm256_setr_epi8(-128, 0, 1, 2, 3, 4, 5, 6, 7, -128, -128, -128, -128, -128, -128, -128,
                                         -128, 0, 1, 2, 3, 4, 5, 6, 7, -128, -128, -128, -128, -128, -128, -128);
    const __m256i dhi = _mm256_add_epi8(dlo, _mm256_setr_epi8(0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0,
                                                             0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0));
    auto actl = [](int k) __attribute__((always_inline)) {
        const char s = char(4 * k), e = char(4 * k + 3), z = char(-128);
        return _mm256_setr_epi8(s, z, z, z, z, z, z, z, z, e, z, z, z, z, z, z, s, z, z, z, z, z, z, z, z, e, z, z, z, z, z, z);
    };
    for (int g = 0; g < G; ++g) {
        char* const o = p + 80 * g;
        const __m256i f0 = _mm256_or_si256(_mm256_shuffle_epi8(S1[g], dlo), _mm256_shuffle_epi8(A[g], actl(0)));
        const __m256i f1 = _mm256_or_si256(_mm256_shuffle_epi8(S1[g], dhi), _mm256_shuffle_epi8(A[g], actl(1)));
        const __m256i f2 = _mm256_or_si256(_mm256_shuffle_epi8(S2[g], dlo), _mm256_shuffle_epi8(A[g], actl(2)));
        const __m256i f3 = _mm256_or_si256(_mm256_shuffle_epi8(S2[g], dhi), _mm256_shuffle_epi8(A[g], actl(3)));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 0), _mm256_castsi256_si128(f0));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 10), _mm256_castsi256_si128(f1));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 20), _mm256_castsi256_si128(f2));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 30), _mm256_castsi256_si128(f3));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 40), _mm256_extracti128_si256(f0, 1));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 50), _mm256_extracti128_si256(f1, 1));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 60), _mm256_extracti128_si256(f2, 1));
        _mm_storeu_si128(reinterpret_cast<__m128i*>(o + 70), _mm256_extracti128_si256(f3, 1));
    }
}

}  // namespace qp_fixed
