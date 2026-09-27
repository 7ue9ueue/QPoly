// Fixed-width decimal output for values < 10^9 (QPoly exploration 011), the formatter of the
// exploration-011 deliverable. Written for this exploration; the digit-splitting constants are
// standard multiply-shift divisions. fmt_fixed.inc holds the earlier variants and references.
//
// Format: every value takes exactly 10 bytes: its decimal digits right-aligned in 9 characters
// (leading zeros replaced by spaces, the units digit always printed) followed by one space.
// Library Checker's convolution checker is testlib wcmp, which compares whitespace-separated
// tokens as strings, so the padding is accepted and every token is the canonical decimal string
// (no leading zeros). Output size is 10 bytes/value (the variable-length writer averages ~9.9
// for random residues); wcmp accepts up to 512 MiB, i.e. > 5 * 10^7 values.
//
// Contract: values < 10^9 (x < 2^30 for the exact divisions). blocks3<G>() reads 8G values
// (unaligned) and writes 80G + 6 bytes p[0..80G+5]: the fields plus 6 bytes that the next block
// (or the caller) overwrites; stores go in increasing address order. one() writes p[0..9].
#pragma once
#include <immintrin.h>
#include <cstdint>
#include <cstring>

namespace qp_fixed {
// Scalar reference: digit loop, then blank the leading zeros (positions 0..7).
inline void one(uint32_t x, char* p) {
    char f[10];
    f[9] = ' ';
    for (int i = 8; i >= 0; --i) { f[i] = char('0' + x % 10); x /= 10; }
    for (int i = 0; i < 8 && f[i] == '0'; ++i) f[i] = ' ';
    std::memcpy(p, f, 10);
}

// Round-5 variant of blocks<G>: each 4-digit part y (b = digits 5..8, c = digits 1..4) becomes a
// BCD dword by 32-bit SWAR arithmetic instead of 16-bit digit planes + pack/unpack chain:
//   h = y / 100 (mulhi_epu16), hl = y + h * (2^16 - 100) = [y % 100 | h << 16],
//   t = z / 10 per 16-bit half (mulhi_epu16 6554), g = hl + t * (2^8 - 10) = [z % 10 | t << 8],
// so a dword holds [units, tens, hundreds, thousands] (least significant digit first); the final
// shuffle reverses them. Blank masks come from x < 10^k compares merged bytewise (vpblendvb).
// G independent 8-value blocks are interleaved for instruction-level parallelism.
template<int G>
__attribute__((always_inline)) inline void blocks3(const uint32_t* src, char* p) {
    const __m256i m1 = _mm256_set1_epi64x(3518437209LL), m8 = _mm256_set1_epi64x(720575941LL);
    const __m256i k4 = _mm256_set1_epi32(10000);
    const __m256i K1 = _mm256_set1_epi32(0x0000FF00), K2 = _mm256_set1_epi32(0x00FF0000), K3 = _mm256_set1_epi32(int(0xFF000000u));
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
        auto group = [](__m256i y) __attribute__((always_inline)) {
            const __m256i h = _mm256_srli_epi16(_mm256_mulhi_epu16(y, _mm256_set1_epi16(5243)), 3);
            const __m256i hl = _mm256_add_epi32(y, _mm256_mullo_epi32(h, _mm256_set1_epi32(65436)));
            const __m256i t = _mm256_mulhi_epu16(hl, _mm256_set1_epi16(6554));
            return _mm256_add_epi16(hl, _mm256_mullo_epi16(t, _mm256_set1_epi16(246)));
        };
        auto lt = [&](int k) __attribute__((always_inline)) { return _mm256_cmpgt_epi32(_mm256_set1_epi32(k), x[g]); };
        const __m256i Mb = _mm256_blendv_epi8(_mm256_blendv_epi8(_mm256_blendv_epi8(lt(10000), lt(100000), K1), lt(1000000), K2),
                                              lt(10000000), K3);
        const __m256i Mc = _mm256_blendv_epi8(_mm256_blendv_epi8(_mm256_and_si256(lt(10), K1), lt(100), K2), lt(1000), K3);
        const __m256i z = _mm256_set1_epi8('0'), s = _mm256_set1_epi8(' ');
        const __m256i Gb = _mm256_blendv_epi8(_mm256_add_epi8(group(b), z), s, Mb);
        const __m256i Gc = _mm256_blendv_epi8(_mm256_add_epi8(group(c), z), s, Mc);
        S1[g] = _mm256_unpacklo_epi32(Gb, Gc);   // [b0 c0 b1 c1 | b4 c4 b5 c5]
        S2[g] = _mm256_unpackhi_epi32(Gb, Gc);
        A[g] = _mm256_or_si256(
            _mm256_blendv_epi8(_mm256_add_epi32(a, _mm256_set1_epi32('0')), _mm256_set1_epi32(' '), lt(100000000)),
            _mm256_set1_epi32(int(uint32_t(' ') << 24)));
    }
    const __m256i dlo = _mm256_setr_epi8(-128, 3, 2, 1, 0, 7, 6, 5, 4, -128, -128, -128, -128, -128, -128, -128,
                                         -128, 3, 2, 1, 0, 7, 6, 5, 4, -128, -128, -128, -128, -128, -128, -128);
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
