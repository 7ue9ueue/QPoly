// AVX2 decimal formatter, QPoly exploration 007 (Library Checker continuation).
// Independently written. Values must be < 10^9. Each value is emitted as ' '
// followed by its digits without leading zeros; the caller's sink drops the very
// first space. Eight values per step: exact reciprocal multiplications split
// v = lead*10^8 + high*10^4 + low, 16-bit reciprocal steps expand the two
// four-digit groups, and each value is stored branch-free with an 8-byte shifted
// digit word. Stores may write up to 7 bytes past the logical end; the caller keeps
// at least 96 bytes of room before each block (16 for the scalar tail).
namespace qp_format {
// Scalar equivalent for tails: b < 10^8 as 8 ASCII digits, most significant first.
__attribute__((always_inline)) inline uint64_t eight_digits(uint32_t b) {
    uint64_t x = (b / 10000) | (uint64_t(b % 10000) << 32);
    const uint64_t hundreds = ((x * 10486) >> 20) & 0x0000007F0000007FULL;
    x = hundreds | ((x - hundreds * 100) << 16);
    const uint64_t tens = ((x * 103) >> 10) & 0x000F000F000F000FULL;
    return (tens | ((x - tens * 10) << 8)) | 0x3030303030303030ULL;
}
__attribute__((always_inline)) inline char* emit(char* p, uint32_t lead, uint64_t digits) {
    // Leading '0' bytes among the first seven of eight digits (the last always prints).
    const unsigned zeros = unsigned(__builtin_ctzll((digits ^ 0x3030303030303030ULL) | (uint64_t(1) << 56))) >> 3;
    const unsigned has_lead = lead != 0;
    const unsigned skip = has_lead ? 0 : zeros;
    const uint16_t head = uint16_t(' ' | ((lead + '0') << 8));
    std::memcpy(p, &head, 2);
    char* q = p + 1 + has_lead;
    const uint64_t shifted = digits >> (8 * skip);
    std::memcpy(q, &shifted, 8);
    return q + 8 - skip;
}
__attribute__((always_inline)) inline char* emit_scalar(char* p, uint32_t v) {
    const uint32_t lead = v / 100000000u;
    return emit(p, lead, eight_digits(v - lead * 100000000u));
}
template <class Sink>
__attribute__((noinline)) char* format_values(Sink& sink, char* p, char* end, const uint32_t* src, size_t count) {
    size_t i = 0;
    for (; i + 8 <= count; i += 8) {
        if (__builtin_expect(end - p < 96, 0)) p = sink.flush(p);
        const __m256i v = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(src + i));
        // floor(v / 10^8) = (v * 1441151881) >> 57, exact for all 32-bit v.
        const __m256i m8 = _mm256_set1_epi64x(1441151881);
        const __m256i lead = _mm256_or_si256(_mm256_srli_epi64(_mm256_mul_epu32(v, m8), 57),
            _mm256_slli_epi64(_mm256_srli_epi64(_mm256_mul_epu32(_mm256_srli_epi64(v, 32), m8), 57), 32));
        const __m256i rest = _mm256_sub_epi32(v, _mm256_mullo_epi32(lead, _mm256_set1_epi32(100000000)));
        // floor(rest / 10^4) = (rest * 3518437209) >> 45, exact for all 32-bit rest.
        const __m256i m4 = _mm256_set1_epi64x(3518437209u);
        const __m256i high = _mm256_or_si256(_mm256_srli_epi64(_mm256_mul_epu32(rest, m4), 45),
            _mm256_slli_epi64(_mm256_srli_epi64(_mm256_mul_epu32(_mm256_srli_epi64(rest, 32), m4), 45), 32));
        const __m256i low = _mm256_sub_epi32(rest, _mm256_madd_epi16(high, _mm256_set1_epi32(10000)));
        // Per 128-bit lane: [high0..3, low0..3] as 16-bit groups (0..9999).
        const __m256i groups = _mm256_packus_epi32(high, low);
        const __m256i hundreds = _mm256_srli_epi16(_mm256_mulhi_epu16(groups, _mm256_set1_epi16(5243)), 3);
        const __m256i units = _mm256_sub_epi16(groups, _mm256_mullo_epi16(hundreds, _mm256_set1_epi16(100)));
        __m256i t0 = _mm256_unpacklo_epi16(hundreds, units), t1 = _mm256_unpackhi_epi16(hundreds, units);
        const __m256i ten = _mm256_set1_epi16(10), m10 = _mm256_set1_epi16(6554);
        const __m256i q0 = _mm256_mulhi_epu16(t0, m10), q1 = _mm256_mulhi_epu16(t1, m10);
        t0 = _mm256_or_si256(q0, _mm256_slli_epi16(_mm256_sub_epi16(t0, _mm256_mullo_epi16(q0, ten)), 8));
        t1 = _mm256_or_si256(q1, _mm256_slli_epi16(_mm256_sub_epi16(t1, _mm256_mullo_epi16(q1, ten)), 8));
        // Eight-digit words: [v0 v1 v4 v5] and [v2 v3 v6 v7].
        const __m256i ascii = _mm256_set1_epi8('0');
        alignas(32) uint64_t digits[8];
        alignas(32) uint32_t leads[8];
        _mm256_store_si256(reinterpret_cast<__m256i*>(digits), _mm256_or_si256(_mm256_unpacklo_epi32(t0, t1), ascii));
        _mm256_store_si256(reinterpret_cast<__m256i*>(digits + 4), _mm256_or_si256(_mm256_unpackhi_epi32(t0, t1), ascii));
        _mm256_store_si256(reinterpret_cast<__m256i*>(leads), lead);
        p = emit(p, leads[0], digits[0]); p = emit(p, leads[1], digits[1]);
        p = emit(p, leads[2], digits[4]); p = emit(p, leads[3], digits[5]);
        p = emit(p, leads[4], digits[2]); p = emit(p, leads[5], digits[3]);
        p = emit(p, leads[6], digits[6]); p = emit(p, leads[7], digits[7]);
    }
    for (; i < count; ++i) {
        if (__builtin_expect(end - p < 16, 0)) p = sink.flush(p);
        p = emit_scalar(p, src[i]);
    }
    return p;
}
} // namespace qp_format
