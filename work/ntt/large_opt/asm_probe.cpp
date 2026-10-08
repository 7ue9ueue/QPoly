// Exploration 014: assembly probe. Compile with the judge's command plus -S to inspect the code GCC
// 15.2 generates for the deliverable's parser step loop and formatter block (not a program).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "../conv_large/io007.hpp"
#include "../io_large/parse_ms2.inc"
#include "../io_large/fmt_bcd.inc"
char* probe_parse(char* p, uint32_t* dst, size_t n) { return qp_parse_ms2::parse_tokens<131072, qp_parse_flat::parse_tokens>(p, dst, n); }
void probe_format(const uint32_t* a, char* c, size_t count) {
    for (size_t i = 0; i + 32 <= count; i += 32, c += 320) qp_fixed::blocks3<4>(a + i, c);
}
#include "parse_ms4.inc"
#include "fmt_asm.inc"
char* probe_parse4(char* p, uint32_t* dst, size_t n) { return qp_parse_ms4::parse_tokens<65536, 1088, qp_parse_flat::parse_tokens>(p, dst, n); }
void probe_format_asm(const uint32_t* a, char* c, size_t count) {
    for (size_t i = 0; i + 32 <= count; i += 32, c += 320) qp_fmt_asm::blocks<4>(a + i, c);
}
#include "parse_ms4p.inc"
char* probe_parse4p(char* p, uint32_t* dst, size_t n) { return qp_parse_ms4p::parse_tokens<65536, 1088, qp_parse_flat::parse_tokens>(p, dst, n); }
char* probe_parse4pd(char* p, uint32_t* dst, size_t n) { return qp_parse_ms4p::parse_tokens<65536, 1088, qp_parse_flat::parse_tokens, true>(p, dst, n); }
