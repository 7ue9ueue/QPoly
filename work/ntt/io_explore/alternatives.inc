// Eight-digit SWAR reduction follows Daniel Lemire's published derivation:
// https://lemire.me/blog/2022/01/21/swar-explained-parsing-eight-digits/
// Only valid ASCII digit/whitespace input, uint32 values <=998244352 is supported.
// Read lookahead is at most 9 bytes, covered by the existing padded input owner.
__attribute__((always_inline)) inline uint32_t parse_eight(uint64_t x) {
    x -= 0x3030303030303030ULL;
    x = x * 10 + (x >> 8);
    constexpr uint64_t mask = 0x000000ff000000ffULL;
    return uint32_t(((x & mask) * 0x000f424000000064ULL
        + ((x >> 16) & mask) * 0x0000271000000001ULL) >> 32);
}
__attribute__((always_inline)) inline uint32_t read_swar(char*& p) {
    while (*p && *p <= ' ') ++p;
    uint64_t word;
    std::memcpy(&word, p + 1, 8);
    // On our valid input alphabet, any separator makes its byte's high bit set.
    if (__builtin_expect(((word - 0x3030303030303030ULL) & 0x8080808080808080ULL) == 0, 1)) {
        uint32_t value = uint32_t(p[0] - '0') * 100000000U + parse_eight(word);
        p += 10;
        return value;
    }
    return read_mod998_u32(p);
}
__attribute__((always_inline)) inline uint32_t read_sse(char*& p) {
    while (*p && *p <= ' ') ++p;
    __m128i digits = _mm_sub_epi8(_mm_loadl_epi64(reinterpret_cast<const __m128i*>(p+1)),
                                 _mm_set1_epi8('0'));
    if (__builtin_expect((_mm_movemask_epi8(digits) & 255) == 0, 1)) {
        __m128i pairs = _mm_maddubs_epi16(digits, _mm_set1_epi16(0x010a));
        __m128i quads = _mm_madd_epi16(pairs, _mm_set1_epi32(0x00010064));
        uint32_t value = uint32_t(p[0]-'0') * 100000000U
            + uint32_t(_mm_cvtsi128_si32(quads)) * 10000U
            + uint32_t(_mm_extract_epi32(quads, 1));
        p += 10;
        return value;
    }
    return read_mod998_u32(p);
}
// Expose independent divisions by constants instead of a remainder dependency.
__attribute__((always_inline)) inline void write_split(
    fastio_unsafe_impl::output& sink, char*& p, char* end, uint32_t x) {
    if (x < 100000000U) { write_mod998(sink, p, end, x); return; }
    if (__builtin_expect(end-p < 16, 0)) p=sink.flush(p);
    const uint32_t q4 = x / 10000U, q8 = x / 100000000U;
    const uint32_t middle = q4 - q8 * 10000U, last = x - q4 * 10000U;
    const uint16_t prefix = uint16_t(' ') | (uint16_t('0' + q8) << 8);
    const uint64_t packed = uint64_t(fastio_unsafe_impl::padded_groups[middle])
        | (uint64_t(fastio_unsafe_impl::padded_groups[last]) << 32);
    std::memcpy(p, &prefix, 2);
    std::memcpy(p+2, &packed, 8);
    p += 10;
}
constexpr auto make_two_digits() {
    std::array<uint16_t, 100> table{};
    for (unsigned i=0;i<100;++i) table[i]=uint16_t('0'+i/10) | (uint16_t('0'+i%10)<<8);
    return table;
}
inline constexpr auto two_digits=make_two_digits();
__attribute__((always_inline)) inline void write_two_digits(
    fastio_unsafe_impl::output& sink, char*& p, char* end, uint32_t x) {
    if (x < 100000000U) { write_mod998(sink, p, end, x); return; }
    if (__builtin_expect(end-p < 16, 0)) p=sink.flush(p);
    const uint32_t q2=x/100U, q4=x/10000U, q6=x/1000000U, q8=x/100000000U;
    const uint16_t prefix=uint16_t(' ') | (uint16_t('0'+q8)<<8);
    const uint64_t packed=uint64_t(two_digits[q6-q8*100U])
        | (uint64_t(two_digits[q4-q6*100U])<<16)
        | (uint64_t(two_digits[q2-q4*100U])<<32)
        | (uint64_t(two_digits[x-q2*100U])<<48);
    std::memcpy(p,&prefix,2); std::memcpy(p+2,&packed,8); p+=10;
}
