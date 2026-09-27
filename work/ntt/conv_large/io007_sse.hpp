// Exploration-007 I/O, extracted verbatim (lines 2592-2867) from
// work/ntt/yosupo_convolution_asm_shoup_io_sse.cpp (branch claude/ntt-asm-explore 1e64289, SHA256 c8d2d7ed1c2aa86d...).
// Includes QgQ's submission 393435 mapping/table writer (https://judge.yosupo.jp/submission/393435)
// and the exploration-007 per-token SSE parser read_sse_short (sse_short_lut8). Do not edit: regenerate with make_io007.sh.
#pragma once
#include <immintrin.h>
#include <array>
#include <cerrno>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
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
    alignas(64) std::array<char, 1u << 19> buffer_;
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
__attribute__((always_inline)) inline uint32_t read_sse_short(char*& p) {
    while (*p && *p <= ' ') ++p;
    if (p[1] <= ' ') {
        uint32_t value=uint32_t(p[0]-'0');
        p+=2;
        return value;
    }
    return read_sse(p);
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


// Pre-faulted 2 MiB-aligned zeroed words (huge pages when the kernel allows them).
static uint32_t* arena(size_t words) {
    constexpr size_t huge = size_t(2) << 20;
    const size_t bytes = (words * 4 + huge - 1) & ~(huge - 1);
    char* raw = static_cast<char*>(mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    if (raw == MAP_FAILED) std::exit(1);
    char* p = reinterpret_cast<char*>((reinterpret_cast<uintptr_t>(raw) + huge - 1) & ~uintptr_t(huge - 1));
#if defined(MADV_HUGEPAGE) && !defined(QPOLY_NO_HUGEPAGE)
    madvise(p, bytes, MADV_HUGEPAGE);
#endif
    bool populated = false;
#ifdef MADV_POPULATE_WRITE
    populated = madvise(p, bytes, MADV_POPULATE_WRITE) == 0;
#endif
    if (!populated) for (size_t i = 0; i < bytes; i += 4096) static_cast<volatile char*>(p)[i] = 0;
    return reinterpret_cast<uint32_t*>(p);
}

