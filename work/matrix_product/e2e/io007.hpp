// Exploration-007 I/O for Library Checker (QPoly), copied verbatim from
// work/ntt/yosupo_convolution_shoup_avx2_io.cpp (SHA256 07ed513b..., the "fastest I/O of
// exploration 007": padded mmap input, two-stage AVX2 parser qp_parse_flat, table writer with a
// 64 KiB output buffer). Input/output code originally adapted from QgQ's submission 393435,
// https://judge.yosupo.jp/submission/393435 (2026-08-14; no license notice displayed); the
// two-stage parser is QPoly's own (work/ntt/io_yosupo/parse_flat.inc).
// Only write_sep() at the end is new: write_mod998 with a caller-chosen separator byte.
#pragma once
#include <immintrin.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#include <array>
#include <cerrno>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Selected uint32 I/O from QgQ's submission 393435; see attribution above.
namespace fastio_unsafe_impl {
using u32 = uint32_t;
struct input {
    char* cursor_ = nullptr;
    char* allocated_ = nullptr;
    void* mapping_ = MAP_FAILED;
    size_t mapping_size_ = 0;
    input() {
        struct stat info{};
        if (::fstat(0, &info) == 0 && S_ISREG(info.st_mode) && info.st_size > 0) {
            const off_t current = ::lseek(0, 0, SEEK_CUR);
            const size_t file_size = size_t(info.st_size);
            const size_t page_size = size_t(::sysconf(_SC_PAGESIZE));
            const size_t rounded_size = (file_size + page_size - 1) / page_size * page_size;
            const size_t reserved_size = rounded_size + page_size;
            char* region = static_cast<char*>(::mmap(nullptr, reserved_size, PROT_NONE,
                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
            if (region != MAP_FAILED) {
                void* file_mapping = ::mmap(region, rounded_size, PROT_READ,
                    MAP_PRIVATE | MAP_FIXED, 0, 0);
                void* zero_page = file_mapping == MAP_FAILED ? MAP_FAILED : ::mmap(
                    region + rounded_size, page_size, PROT_READ,
                    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
                if (file_mapping != MAP_FAILED && zero_page != MAP_FAILED) {
                    const size_t offset = current > 0 ? std::min(size_t(current), file_size) : 0;
                    cursor_ = region + offset;
                    mapping_ = region;
                    mapping_size_ = reserved_size;
                    return;
                }
                ::munmap(region, reserved_size);
            }
        }
        size_t capacity = 1u << 20, size = 0;
        char* buffer = static_cast<char*>(std::malloc(capacity + 64));
        if (!buffer) std::abort();
        for (;;) {
            if (size == capacity) {
                capacity *= 2;
                char* grown = static_cast<char*>(std::realloc(buffer, capacity + 64));
                if (!grown) std::abort();
                buffer = grown;
            }
            const size_t count = std::fread(buffer + size, 1, capacity - size, stdin);
            size += count;
            if (count == 0) {
                if (std::ferror(stdin)) std::abort();
                break;
            }
        }
        std::memset(buffer + size, 0, 64);
        cursor_ = allocated_ = buffer;
    }
    ~input() {
        if (mapping_ != MAP_FAILED) ::munmap(mapping_, mapping_size_);
        std::free(allocated_);
    }
    input(const input&) = delete;
    input& operator=(const input&) = delete;
    char* cursor() const noexcept { return cursor_; }
};

constexpr auto make_padded_groups() {
    std::array<u32, 10000> table{};
    for (unsigned value = 0; value < 10000; ++value) {
        table[value] = ('0' + value / 1000) | (('0' + value / 100 % 10) << 8)
                    | (('0' + value / 10 % 10) << 16) | (('0' + value % 10) << 24);
    }
    return table;
}
inline constexpr auto padded_groups = make_padded_groups();
struct output {
    alignas(64) std::array<char, 1u << 16> buffer_;
    bool first_flush_ = true;
    char* begin() noexcept { return buffer_.data(); }
    char* end() noexcept { return buffer_.data() + buffer_.size(); }
    __attribute__((noinline)) char* flush(char* cursor) noexcept {
        size_t remaining = size_t(cursor - buffer_.data());
        const char* data = buffer_.data();
        if (first_flush_ && remaining != 0) {
            ++data;
            --remaining;
            first_flush_ = false;
        }
        while (remaining != 0) {
            const ssize_t count = ::write(1, data, remaining);
            if (count > 0) {
                data += count;
                remaining -= size_t(count);
            } else if (count < 0 && errno == EINTR) continue;
            else std::abort();
        }
        return buffer_.data();
    }
    void finish(char* cursor) noexcept {
        if (cursor != buffer_.data() || !first_flush_) *cursor++ = '\n';
        (void)flush(cursor);
    }
};
__attribute__((always_inline)) inline void emit_leading(char*& cursor, u32 value) noexcept {
    const unsigned skip = 3u - unsigned(value >= 10) - unsigned(value >= 100) - unsigned(value >= 1000);
    const u32 group = padded_groups[value] >> (skip * 8);
    std::memcpy(cursor, &group, sizeof(group));
    cursor += 4 - skip;
}
__attribute__((always_inline)) inline void emit_padded(char*& cursor, u32 value) noexcept {
    const u32 group = padded_groups[value];
    std::memcpy(cursor, &group, sizeof(group));
    cursor += sizeof(group);
}
__attribute__((always_inline)) inline void emit_u32_unchecked(char*& cursor, u32 value) noexcept {
    if (value >= 100000000U) {
        emit_leading(cursor, value / 100000000U);
        emit_padded(cursor, value / 10000U % 10000);
        emit_padded(cursor, value % 10000);
    } else if (value >= 10000U) {
        emit_leading(cursor, value / 10000U);
        emit_padded(cursor, value % 10000);
    } else emit_leading(cursor, value);
}
} // namespace fastio_unsafe_impl

constexpr auto make_mod998_pair_digits() {
    std::array<uint8_t, 1 << 14> table{};
    // std::array::fill is not constexpr until C++20.
    for (auto& x : table) x = 255;
    for (unsigned a = 0; a < 10; ++a)
        for (unsigned b = 0; b < 10; ++b)
            table[('0' + a) | (('0' + b) << 8)] = a * 10 + b;
    return table;
}
inline constexpr auto mod998_pair_digits = make_mod998_pair_digits();
__attribute__((always_inline)) inline uint32_t digit_pair(const char* p) noexcept {
    uint16_t pair;
    std::memcpy(&pair, p, sizeof(pair));
    return mod998_pair_digits[pair];
}
// Valid unsigned decimal input only. ASCII digits/whitespace/zero padding keep
// each two-byte table index below 2^14. At least 9 readable bytes follow cursor.
__attribute__((always_inline)) inline uint32_t read_mod998_u32(char*& cursor) noexcept {
    while (*cursor != 0 && *cursor <= ' ') ++cursor;
    const auto q0 = digit_pair(cursor + 1), q1 = digit_pair(cursor + 3);
    const auto q2 = digit_pair(cursor + 5), q3 = digit_pair(cursor + 7);
    if (__builtin_expect((q0 | q1 | q2 | q3) < 128, 1)) {
        uint32_t value = static_cast<unsigned char>(cursor[0]) - '0';
        value = value * 100 + q0;
        value = value * 100 + q1;
        value = value * 100 + q2;
        value = value * 100 + q3;
        cursor += 10;
        return value;
    }
    uint32_t value = static_cast<unsigned char>(*cursor++) - '0';
    for (unsigned i = 0; i < 4; ++i) {
        const auto pair = digit_pair(cursor);
        if (pair > 99) break;
        value = value * 100 + pair;
        cursor += 2;
    }
    if (*cursor > ' ') value = value * 10 + unsigned(*cursor++ & 15);
    ++cursor;
    return value;
}
__attribute__((always_inline)) inline void write_mod998(
    fastio_unsafe_impl::output& sink, char*& cursor, char* end, uint32_t value) noexcept {
    if (__builtin_expect(end - cursor < 16, 0)) cursor = sink.flush(cursor);
    *cursor++ = ' ';
    if (value >= 100000000U) {
        const uint32_t high = value / 100000000U;
        *cursor++ = char('0' + high);
        value -= high * 100000000U;
        fastio_unsafe_impl::emit_padded(cursor, value / 10000U);
        fastio_unsafe_impl::emit_padded(cursor, value % 10000U);
    } else fastio_unsafe_impl::emit_u32_unchecked(cursor, value);
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
__attribute__((always_inline)) inline uint32_t read_sse_short(char*& p) {
    while (*p && *p <= ' ') ++p;
    if (p[1] <= ' ') {
        uint32_t value=uint32_t(p[0]-'0');
        p+=2;
        return value;
    }
    return read_sse(p);
}

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

// write_mod998 with the separator written before the value (' ' within a row, '\n' before
// the first value of every row but the first; the output class drops the very first byte).
__attribute__((always_inline)) inline void write_sep(
    fastio_unsafe_impl::output& sink, char*& cursor, char* end, uint32_t value, char sep) noexcept {
    if (__builtin_expect(end - cursor < 16, 0)) cursor = sink.flush(cursor);
    *cursor++ = sep;
    if (value >= 100000000U) {
        const uint32_t high = value / 100000000U;
        *cursor++ = char('0' + high);
        value -= high * 100000000U;
        fastio_unsafe_impl::emit_padded(cursor, value / 10000U);
        fastio_unsafe_impl::emit_padded(cursor, value % 10000U);
    } else fastio_unsafe_impl::emit_u32_unchecked(cursor, value);
}
