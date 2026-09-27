// AVX2 decimal formatter, register-extraction version (QPoly exploration 007,
// Library Checker continuation). Same arithmetic and output contract as
// format_avx2.inc, but digit words and leading digits leave the vector unit via
// extracts instead of a stack round trip (a wide store followed by narrow reloads
// may miss store-to-load forwarding), and the cursor advances by one addition per
// value. Values < 10^9; up to 7 bytes past the logical end; 96 bytes of room per
// eight-value block and 16 per scalar tail value. `format_scalar` is the SWAR
// scalar formatter on its own, kept for comparison.
namespace qp_format2 {
__attribute__((always_inline)) inline uint64_t eight_digits(uint32_t b) {
    uint64_t x = (b / 10000) | (uint64_t(b % 10000) << 32);
    const uint64_t hundreds = ((x * 10486) >> 20) & 0x0000007F0000007FULL;
    x = hundreds | ((x - hundreds * 100) << 16);
    const uint64_t tens = ((x * 103) >> 10) & 0x000F000F000F000FULL;
    return (tens | ((x - tens * 10) << 8)) | 0x3030303030303030ULL;
}
__attribute__((always_inline)) inline char* emit(char* p, uint32_t lead, uint64_t digits) {
    const unsigned zeros = unsigned(__builtin_ctzll((digits ^ 0x3030303030303030ULL) | (uint64_t(1) << 56))) >> 3;
    const unsigned has_lead = lead != 0;
    const unsigned skip = has_lead ? 0 : zeros;
    const uint16_t head = uint16_t(' ' | ((lead + '0') << 8));
    const uint64_t shifted = digits >> (8 * skip);
    std::memcpy(p, &head, 2);
    std::memcpy(p + 1 + has_lead, &shifted, 8);
    return p + (9 + has_lead - skip);
}
__attribute__((always_inline)) inline char* emit_scalar(char* p, uint32_t v) {
    const uint32_t lead = v / 100000000u;
    return emit(p, lead, eight_digits(v - lead * 100000000u));
}
template <class Sink>
__attribute__((noinline)) char* format_scalar(Sink& sink, char* p, char* end, const uint32_t* src, size_t count) {
    for (size_t i = 0; i < count; ++i) {
        if (__builtin_expect(end - p < 16, 0)) p = sink.flush(p);
        p = emit_scalar(p, src[i]);
    }
    return p;
}
template <class Sink>
__attribute__((noinline)) char* format_values(Sink& sink, char* p, char* end, const uint32_t* src, size_t count) {
    size_t i = 0;
    for (; i + 8 <= count; i += 8) {
        if (__builtin_expect(end - p < 96, 0)) p = sink.flush(p);
        const __m256i v = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(src + i));
        const __m256i m8 = _mm256_set1_epi64x(1441151881);  // floor(v/10^8) = v*m8 >> 57
        const __m256i lead = _mm256_or_si256(_mm256_srli_epi64(_mm256_mul_epu32(v, m8), 57),
            _mm256_slli_epi64(_mm256_srli_epi64(_mm256_mul_epu32(_mm256_srli_epi64(v, 32), m8), 57), 32));
        const __m256i rest = _mm256_sub_epi32(v, _mm256_mullo_epi32(lead, _mm256_set1_epi32(100000000)));
        const __m256i m4 = _mm256_set1_epi64x(3518437209u);  // floor(r/10^4) = r*m4 >> 45
        const __m256i high = _mm256_or_si256(_mm256_srli_epi64(_mm256_mul_epu32(rest, m4), 45),
            _mm256_slli_epi64(_mm256_srli_epi64(_mm256_mul_epu32(_mm256_srli_epi64(rest, 32), m4), 45), 32));
        const __m256i low = _mm256_sub_epi32(rest, _mm256_madd_epi16(high, _mm256_set1_epi32(10000)));
        const __m256i groups = _mm256_packus_epi32(high, low);
        const __m256i hundreds = _mm256_srli_epi16(_mm256_mulhi_epu16(groups, _mm256_set1_epi16(5243)), 3);
        const __m256i units = _mm256_sub_epi16(groups, _mm256_mullo_epi16(hundreds, _mm256_set1_epi16(100)));
        __m256i t0 = _mm256_unpacklo_epi16(hundreds, units), t1 = _mm256_unpackhi_epi16(hundreds, units);
        const __m256i ten = _mm256_set1_epi16(10), m10 = _mm256_set1_epi16(6554);
        const __m256i q0 = _mm256_mulhi_epu16(t0, m10), q1 = _mm256_mulhi_epu16(t1, m10);
        t0 = _mm256_or_si256(q0, _mm256_slli_epi16(_mm256_sub_epi16(t0, _mm256_mullo_epi16(q0, ten)), 8));
        t1 = _mm256_or_si256(q1, _mm256_slli_epi16(_mm256_sub_epi16(t1, _mm256_mullo_epi16(q1, ten)), 8));
        const __m256i ascii = _mm256_set1_epi8('0');
        const __m256i s01 = _mm256_or_si256(_mm256_unpacklo_epi32(t0, t1), ascii);  // v0 v1 | v4 v5
        const __m256i s23 = _mm256_or_si256(_mm256_unpackhi_epi32(t0, t1), ascii);  // v2 v3 | v6 v7
        const __m128i a = _mm256_castsi256_si128(s01), b = _mm256_extracti128_si256(s01, 1);
        const __m128i c = _mm256_castsi256_si128(s23), d = _mm256_extracti128_si256(s23, 1);
        // Leading digits as bytes: lane 0 gives v0..v3, lane 1 gives v4..v7.
        const __m256i lead8 = _mm256_packus_epi16(_mm256_packus_epi32(lead, lead), _mm256_setzero_si256());
        const uint64_t leads = uint32_t(_mm_cvtsi128_si32(_mm256_castsi256_si128(lead8)))
            | uint64_t(uint32_t(_mm_cvtsi128_si32(_mm256_extracti128_si256(lead8, 1)))) << 32;
        p = emit(p, uint32_t(leads & 255), uint64_t(_mm_cvtsi128_si64(a)));
        p = emit(p, uint32_t(leads >> 8 & 255), uint64_t(_mm_extract_epi64(a, 1)));
        p = emit(p, uint32_t(leads >> 16 & 255), uint64_t(_mm_cvtsi128_si64(c)));
        p = emit(p, uint32_t(leads >> 24 & 255), uint64_t(_mm_extract_epi64(c, 1)));
        p = emit(p, uint32_t(leads >> 32 & 255), uint64_t(_mm_cvtsi128_si64(b)));
        p = emit(p, uint32_t(leads >> 40 & 255), uint64_t(_mm_extract_epi64(b, 1)));
        p = emit(p, uint32_t(leads >> 48 & 255), uint64_t(_mm_cvtsi128_si64(d)));
        p = emit(p, uint32_t(leads >> 56), uint64_t(_mm_extract_epi64(d, 1)));
    }
    for (; i < count; ++i) {
        if (__builtin_expect(end - p < 16, 0)) p = sink.flush(p);
        p = emit_scalar(p, src[i]);
    }
    return p;
}
} // namespace qp_format2
