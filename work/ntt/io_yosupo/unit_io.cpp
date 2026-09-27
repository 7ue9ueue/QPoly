// Direct checks of every parser/formatter .inc against snprintf/strtoul.
// Guard pages sit exactly 64 bytes after parser input and 8 bytes after the
// formatter's logical buffer end, so any read/write beyond the contracts faults.
// Exits non-zero on the first mismatch.
#include <immintrin.h>
#include <sys/mman.h>
#include <unistd.h>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>
#include <string>
#include <vector>
#include "parse_quad.inc"
#include "format_avx2.inc"
#include "parse_gen4.inc"
#include "format_avx2x.inc"
#include "parse_flat.inc"

static void require(bool ok, const char* what, size_t detail) {
    if (!ok) { std::fprintf(stderr, "FAIL %s %zu\n", what, detail); std::exit(1); }
}
// Region whose last `tail` bytes before a PROT_NONE page are usable.
static char* guarded(size_t bytes, size_t tail_room) {
    const size_t page = size_t(sysconf(_SC_PAGESIZE)), span = (bytes + tail_room + page - 1) / page * page;
    char* base = static_cast<char*>(mmap(nullptr, span + page, PROT_READ | PROT_WRITE,
                                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    require(base != MAP_FAILED && mprotect(base + span, page, PROT_NONE) == 0, "mmap", bytes);
    return base + span - bytes - tail_room;
}
static size_t format_checks, parse_checks;

struct Sink {
    std::string out;
    char* begin;
    char* flush(char* p) { out.append(begin, p); return begin; }
};
using Format = char* (*)(Sink&, char*, char*, const uint32_t*, size_t);
static const Format formats[] = {qp_format::format_values<Sink>, qp_format2::format_values<Sink>,
                                 qp_format2::format_scalar<Sink>};
using Parse = char* (*)(char*, uint32_t*, size_t);
static const Parse parsers[] = {qp_parse::parse_tokens, qp_parse4::parse_tokens, qp_parse_flat::parse_tokens};
static void check_format(const std::vector<uint32_t>& values, size_t buffer) {
  for (Format format : formats) {
    std::string want;
    char tmp[16];
    for (uint32_t v : values) { std::snprintf(tmp, sizeof tmp, " %u", v); want += tmp; }
    // Logical end is 8 bytes before the guard page: overhang is at most 7 bytes.
    char* start = guarded(buffer, 8);
    Sink sink{{}, start};
    char* p = format(sink, start, start + buffer, values.data(), values.size());
    sink.flush(p);
    require(sink.out == want, "format", values.size());
    format_checks += values.size();
  }
}
static void check_parse(const std::vector<uint32_t>& values, std::mt19937_64& rng, int style, bool split) {
    std::string text = "\n";
    for (size_t i = 0; i < values.size(); ++i) {
        text += std::to_string(values[i]);
        const int r = int(rng() % 100);
        if (style == 0 || r < 90) text += ' ';
        else if (r < 95) text += '\n';
        else if (r < 97) text += "\r\n";
        else if (r < 99) text += "  ";
        else text += "\t ";
    }
    if (rng() % 2) text.pop_back();  // Sometimes no final separator: zero padding ends it.
    char* data = guarded(text.size(), 64);
    std::memcpy(data, text.data(), text.size());
    std::memset(data + text.size(), 0, 64);
  for (Parse parse : parsers) {
    std::vector<uint32_t> got(values.size() + 1, 0xFFFFFFFFu);
    const size_t first = split ? values.size() / 2 : values.size();
    char* p = parse(data + 1, got.data(), first);
    p = parse(p, got.data() + first, values.size() - first);
    for (size_t i = 0; i < values.size(); ++i) require(got[i] == values[i], "parse value", i);
    require(got[values.size()] == 0xFFFFFFFFu, "parse overrun", values.size());
    // Independent strtoul re-read confirms the text and the returned position.
    const char* q = data + 1;
    for (size_t i = 0; i < values.size(); ++i) {
        char* e;
        require(std::strtoul(q, &e, 10) == values[i], "strtoul", i);
        q = e + 1;
    }
    require(p == q, "parse position", values.size());
    parse_checks += values.size();
  }
}

int main() {
    std::mt19937_64 rng(20260927);
    const uint32_t P = 998244353;
    std::vector<uint32_t> all;
    for (uint32_t v = 0; v <= 2000000; ++v) all.push_back(v);
    for (uint32_t p10 = 1; p10 <= 100000000; p10 *= 10)
        for (uint32_t k = 1; k <= 9; ++k)
            for (int d = -2; d <= 2; ++d)
                if (int64_t(k) * p10 + d >= 0) all.push_back(uint32_t(int64_t(k) * p10 + d));
    for (uint32_t v : {999999999u, P - 1, P - 2, 100000000u, 99999999u, 0u}) all.push_back(v);
    for (int i = 0; i < 1000000; ++i) all.push_back(uint32_t(rng() % P));
    for (int i = 0; i < 1000000; ++i) {
        uint32_t limit = 1;
        for (int d = int(rng() % 9) + 1; d; --d) limit *= 10;
        all.push_back(uint32_t(rng() % limit));
    }
    // Formatter: whole set with a small buffer (many flushes), every tail length,
    // and every source alignment modulo 8.
    check_format(all, 4096);
    check_format(all, 97);
    for (size_t len = 0; len <= 40; ++len)
        for (size_t offset = 0; offset < 8; ++offset)
            check_format(std::vector<uint32_t>(all.end() - 64 + offset, all.end() - 64 + offset + len), 96 + 16);
    // Parser: single-space layout (quad path), mixed whitespace, split calls, short counts.
    for (int style = 0; style < 2; ++style) {
        check_parse(all, rng, style, false);
        check_parse(all, rng, style, true);
    }
    std::vector<uint32_t> nines(4096);
    for (auto& v : nines) v = 100000000u + uint32_t(rng() % (P - 100000000u));
    for (size_t len : {size_t(300), size_t(1000), size_t(4000)})
        for (int style = 0; style < 2; ++style) {
            std::vector<uint32_t> s(all.begin() + 2000000, all.begin() + 2000000 + len);
            check_parse(s, rng, style, true);
        }
    for (size_t len = 0; len <= 64; ++len)
        for (int style = 0; style < 2; ++style)
            for (int split = 0; split < 2; ++split) {
                std::vector<uint32_t> s(nines.begin(), nines.begin() + len);
                if (len > 5 && style) s[len / 2] = uint32_t(rng() % 1000);
                check_parse(s, rng, style, split);
            }
    std::printf("PASS unit I/O: %zu formatted values, %zu parsed values\n", format_checks, parse_checks);
}
