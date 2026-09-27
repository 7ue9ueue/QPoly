// AVX2 token parser, QPoly exploration 007 (Library Checker continuation).
// Independently written; SSE/AVX2 digit weighting as in the exploration-007 parser.
// Contract: `count` unsigned tokens of 1..9 ASCII digits separated by one or more
// bytes <= ' ' (space, newline, CR, tab, or the zero padding after the data).
// `p` points just after the previous token's separator (whitespace is skipped).
// At least 64 readable bytes must follow the separator ending the last token; the
// padded input owner guarantees this (mapped zero page, or 64 zero bytes).
// Fast path: four consecutive 9-digit tokens, each followed by exactly one
// separator (the common Library Checker layout), converted with one AVX2 pass.
// Otherwise one token is right-aligned by a length-indexed shuffle and converted
// without digit-count branches. Returns the byte after the last separator.
namespace qp_parse {
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
__attribute__((always_inline)) inline uint32_t parse_one(const char* p, unsigned len) {
    __m128i x = _mm_subs_epu8(_mm_loadu_si128(reinterpret_cast<const __m128i*>(p)), _mm_set1_epi8('0'));
    x = _mm_shuffle_epi8(x, _mm_load_si128(reinterpret_cast<const __m128i*>(right_align.row[len])));
    x = _mm_maddubs_epi16(x, _mm_setr_epi8(10, 1, 10, 1, 10, 1, 10, 1, 10, 1, 10, 1, 10, 1, 10, 1));
    x = _mm_madd_epi16(x, _mm_setr_epi16(100, 1, 100, 1, 100, 1, 100, 1));
    x = _mm_packus_epi32(x, x);
    x = _mm_madd_epi16(x, _mm_setr_epi16(10000, 1, 10000, 1, 10000, 1, 10000, 1));
    const uint64_t both = uint64_t(_mm_cvtsi128_si64(x));  // [digits 0..7, digits 8..15]
    return uint32_t(both) * 100000000u + uint32_t(both >> 32);
}
// Four 9-digit tokens at p, p+10, p+20, p+30; reads p..p+45.
__attribute__((always_inline)) inline void parse_quad(const char* p, uint32_t* dst) {
    const __m256i zero = _mm256_set1_epi8('0');
    __m256i v = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(
        reinterpret_cast<const __m128i*>(p))), _mm_loadu_si128(reinterpret_cast<const __m128i*>(p + 10)), 1);
    __m256i w = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(
        reinterpret_cast<const __m128i*>(p + 20))), _mm_loadu_si128(reinterpret_cast<const __m128i*>(p + 30)), 1);
    // Per lane: digits d0..d8 in bytes 0..8. Pairs, then [d0..d3, d4..d7, d8, 0].
    const __m256i pairs = _mm256_setr_epi8(10, 1, 10, 1, 10, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0,
                                           10, 1, 10, 1, 10, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0);
    const __m256i quads = _mm256_setr_epi16(100, 1, 100, 1, 1, 0, 0, 0, 100, 1, 100, 1, 1, 0, 0, 0);
    v = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_subs_epu8(v, zero), pairs), quads);
    w = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_subs_epu8(w, zero), pairs), quads);
    // Lane 0 holds tokens 0 and 2, lane 1 tokens 1 and 3: [d0..d7, d8] per token.
    const __m256i x = _mm256_madd_epi16(_mm256_packus_epi32(v, w),
        _mm256_setr_epi16(10000, 1, 1, 0, 10000, 1, 1, 0, 10000, 1, 1, 0, 10000, 1, 1, 0));
    const __m256i values = _mm256_add_epi32(_mm256_add_epi32(_mm256_slli_epi32(x, 3),
        _mm256_slli_epi32(x, 1)), _mm256_srli_epi64(x, 32));
    const __m256i ordered = _mm256_permutevar8x32_epi32(values, _mm256_setr_epi32(0, 4, 2, 6, 0, 4, 2, 6));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(dst), _mm256_castsi256_si128(ordered));
}
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    constexpr uint64_t window = (uint64_t(1) << 40) - 1;
    constexpr uint64_t four_nines = (uint64_t(1) << 9) | (uint64_t(1) << 19) | (uint64_t(1) << 29) | (uint64_t(1) << 39);
    while (count) {
        while (*p != 0 && uint8_t(*p) <= ' ') ++p;
        const uint64_t seps = separators(p);
        if (__builtin_expect(count >= 4 && (seps & window) == four_nines, 1)) {
            parse_quad(p, dst);
            p += 40, dst += 4, count -= 4;
            continue;
        }
        const unsigned len = unsigned(__builtin_ctzll(seps | (uint64_t(1) << 16)));
        *dst++ = parse_one(p, len);
        p += len + 1, --count;
    }
    return p;
}
} // namespace qp_parse
