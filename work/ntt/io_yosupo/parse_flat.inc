// AVX2 two-stage token parser, QPoly exploration 007 (Library Checker continuation).
// Independently written; the two-stage separator-index structure is a common SIMD
// parsing technique (see simdjson), the digit weighting follows the exploration-007
// SSE parser. Contract: `count` unsigned tokens of 1..9 ASCII digits separated by
// one or more bytes <= ' ' (space, newline, CR, tab, or the zero padding after the
// data). `p` points just after the previous token's separator. At least 64
// readable bytes must follow the separator ending the last token (the padded input
// owner guarantees this).
// Stage 1 turns separator bitmasks of consecutive 64-byte blocks into separator
// offsets; a block is scanned only while more tokens are needed than separators
// known, so no block starts past the last token's separator. Stage 2 converts four
// tokens per step from consecutive offsets (each right-aligned in its own 128-bit
// lane by a length-indexed shuffle); unlike parse_gen4.inc, no step waits for the
// previous step's token lengths. Empty tokens (repeated whitespace) are skipped.
namespace qp_parse_flat {
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
    constexpr size_t chunk = 32;  // Blocks per stage-1 pass (2 KiB of input).
    alignas(64) uint32_t pos[chunk * 64 + 64];
    const char* const origin = p - 1;  // Offset 0 is the separator before p.
    size_t have = 1, i = 0, scan = 1;
    pos[0] = 0;
    while (count) {
        if (i) {  // Keep unconsumed offsets, starting with the last used separator.
            for (size_t k = i; k < have; ++k) pos[k - i] = pos[k];
            have -= i, i = 0;
        }
        for (size_t b = 0; b < chunk && count > have - 1; ++b, scan += 64) {
            uint64_t m = separators(origin + scan);
            const size_t found = size_t(__builtin_popcountll(m));
            uint32_t* out = pos + have;
            do {  // Eight unconditional extractions; extra entries are overwritten.
                for (int j = 0; j < 8; ++j) out[j] = uint32_t(scan + _tzcnt_u64(m)), m = _blsr_u64(m);
                out += 8;
            } while (m);
            have += found;
        }
        for (;;) {
            if (count >= 4 && i + 4 < have) {
                const uint32_t s0 = pos[i], s1 = pos[i + 1], s2 = pos[i + 2], s3 = pos[i + 3], s4 = pos[i + 4];
                const unsigned l0 = s1 - s0 - 1, l1 = s2 - s1 - 1, l2 = s3 - s2 - 1, l3 = s4 - s3 - 1;
                if (__builtin_expect(((l0 - 1) | (l1 - 1) | (l2 - 1) | (l3 - 1)) < 16, 1)) {
                    const __m256i zero = _mm256_set1_epi8('0');
                    __m256i v = _mm256_subs_epu8(pair(origin + s0 + 1, origin + s1 + 1), zero);
                    __m256i w = _mm256_subs_epu8(pair(origin + s2 + 1, origin + s3 + 1), zero);
                    v = groups(_mm256_shuffle_epi8(v, pair(right_align.row[l0], right_align.row[l1])));
                    w = groups(_mm256_shuffle_epi8(w, pair(right_align.row[l2], right_align.row[l3])));
                    // Lane 0: tokens 0 and 2, lane 1: tokens 1 and 3, as [high, low] pairs.
                    const __m256i x = _mm256_madd_epi16(_mm256_packus_epi32(v, w), _mm256_set1_epi32(0x00012710));
                    const __m256i values = _mm256_add_epi32(_mm256_mullo_epi32(x, _mm256_set1_epi32(100000000)),
                                                            _mm256_srli_epi64(x, 32));
                    const __m256i ordered = _mm256_permutevar8x32_epi32(values, _mm256_setr_epi32(0, 4, 2, 6, 0, 4, 2, 6));
                    _mm_storeu_si128(reinterpret_cast<__m128i*>(dst), _mm256_castsi256_si128(ordered));
                    dst += 4, count -= 4, i += 4;
                    continue;
                }
            } else if (!count || i + 1 >= have) {
                break;
            }
            const unsigned len = pos[i + 1] - pos[i] - 1;  // One token, possibly empty.
            if (len) *dst++ = parse_one(origin + pos[i] + 1, len < 16 ? len : 16), --count;
            ++i;
        }
    }
    return const_cast<char*>(origin) + pos[i] + 1;
}
} // namespace qp_parse_flat
