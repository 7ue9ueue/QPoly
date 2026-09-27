// AVX2 token parser for any 1..9-digit tokens, QPoly exploration 007 (Library
// Checker continuation). Independently written; digit weighting as in the
// exploration-007 SSE parser. Contract: `count` unsigned tokens of 1..9 ASCII
// digits separated by one or more bytes <= ' ' (space, newline, CR, tab, or the
// zero padding after the data). `p` points just after the previous token's
// separator. At least 64 readable bytes must follow the separator ending the last
// token (the padded input owner guarantees this).
// Main step, no digit-count branches: the separator bitmask of the 64 bytes at p
// gives four token lengths; each token is right-aligned in its own 128-bit lane by
// a length-indexed shuffle and all four are converted together. The step is taken
// whenever four tokens with single separators fit in the window, which is always
// true for Library Checker files; otherwise one token is parsed at a time.
namespace qp_parse4 {
struct RightAlign { alignas(16) int8_t row[17][16]; };
constexpr RightAlign make_right_align() {
    RightAlign t{};
    for (int len = 0; len <= 16; ++len)
        for (int j = 0; j < 16; ++j) t.row[len][j] = int8_t(j >= 16 - len ? j - (16 - len) : -128);
    return t;
}
inline constexpr RightAlign right_align = make_right_align();

__attribute__((always_inline)) inline uint64_t separators(const char* p) {
    const __m256i limit = _mm256_set1_epi8(' ' + 1);
    const uint32_t lo = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(limit,
        _mm256_loadu_si256(reinterpret_cast<const __m256i*>(p)))));
    const uint32_t hi = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(limit,
        _mm256_loadu_si256(reinterpret_cast<const __m256i*>(p + 32)))));
    return uint64_t(hi) << 32 | lo;
}
__attribute__((always_inline)) inline __m256i pair(const void* lo, const void* hi) {
    return _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(static_cast<const __m128i*>(lo))),
                                   _mm_loadu_si128(static_cast<const __m128i*>(hi)), 1);
}
// Right-aligned digits (16 per lane) -> per lane u32 [high 8 digits, low 8 digits, ...].
__attribute__((always_inline)) inline __m256i groups(__m256i digits) {
    return _mm256_madd_epi16(_mm256_maddubs_epi16(digits, _mm256_set1_epi16(0x010a)), _mm256_set1_epi32(0x00010064));
}
__attribute__((always_inline)) inline uint32_t parse_one(const char* p, unsigned len) {
    __m128i x = _mm_subs_epu8(_mm_loadu_si128(reinterpret_cast<const __m128i*>(p)), _mm_set1_epi8('0'));
    x = _mm_shuffle_epi8(x, _mm_load_si128(reinterpret_cast<const __m128i*>(right_align.row[len])));
    x = _mm_madd_epi16(_mm_maddubs_epi16(x, _mm_set1_epi16(0x010a)), _mm_set1_epi32(0x00010064));
    x = _mm_madd_epi16(_mm_packus_epi32(x, x), _mm_set1_epi32(0x00012710));
    const uint64_t both = uint64_t(_mm_cvtsi128_si64(x));
    return uint32_t(both) * 100000000u + uint32_t(both >> 32);
}
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    while (count >= 4) {
        uint64_t s = separators(p);
        const unsigned e0 = unsigned(__builtin_ctzll(s | (uint64_t(1) << 63))); s &= s - 1;
        const unsigned e1 = unsigned(__builtin_ctzll(s | (uint64_t(1) << 63))); s &= s - 1;
        const unsigned e2 = unsigned(__builtin_ctzll(s | (uint64_t(1) << 63))); s &= s - 1;
        const unsigned e3 = unsigned(__builtin_ctzll(s | (uint64_t(1) << 63)));
        const unsigned l0 = e0, l1 = e1 - e0 - 1, l2 = e2 - e1 - 1, l3 = e3 - e2 - 1;
        // Lengths 1..16 (zero wraps high) and a real fourth separator in the window.
        if (__builtin_expect(((l0 - 1) | (l1 - 1) | (l2 - 1) | (l3 - 1)) < 16 && s != 0, 1)) {
            const __m256i zero = _mm256_set1_epi8('0');
            __m256i v = _mm256_subs_epu8(pair(p, p + e0 + 1), zero);
            __m256i w = _mm256_subs_epu8(pair(p + e1 + 1, p + e2 + 1), zero);
            v = groups(_mm256_shuffle_epi8(v, pair(right_align.row[l0], right_align.row[l1])));
            w = groups(_mm256_shuffle_epi8(w, pair(right_align.row[l2], right_align.row[l3])));
            // Lane 0: tokens 0 and 2, lane 1: tokens 1 and 3, as [high, low] pairs.
            const __m256i x = _mm256_madd_epi16(_mm256_packus_epi32(v, w), _mm256_set1_epi32(0x00012710));
            const __m256i values = _mm256_add_epi32(_mm256_mullo_epi32(x, _mm256_set1_epi32(100000000)),
                                                    _mm256_srli_epi64(x, 32));
            const __m256i ordered = _mm256_permutevar8x32_epi32(values, _mm256_setr_epi32(0, 4, 2, 6, 0, 4, 2, 6));
            _mm_storeu_si128(reinterpret_cast<__m128i*>(dst), _mm256_castsi256_si128(ordered));
            p += e3 + 1, dst += 4, count -= 4;
            continue;
        }
        while (*p != 0 && uint8_t(*p) <= ' ') ++p;
        const unsigned len = unsigned(__builtin_ctzll(separators(p) | (uint64_t(1) << 16)));
        *dst++ = parse_one(p, len);
        p += len + 1, --count;
    }
    for (; count; --count) {
        while (*p != 0 && uint8_t(*p) <= ' ') ++p;
        const unsigned len = unsigned(__builtin_ctzll(separators(p) | (uint64_t(1) << 16)));
        *dst++ = parse_one(p, len);
        p += len + 1;
    }
    return p;
}
} // namespace qp_parse4
