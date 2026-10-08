// Exploration 014: software-pipelined four-token parser (qp_parse_ms4p). Written for this
// exploration; per-token work and validation are those of qp_parse_ms4 (parse_ms4.inc), split in two.
//
// Why: in ms2/ms4 each step's conversion (windows -> shuffles -> multiply-adds -> combine -> store,
// ~30 cycles of latency) hangs off the same step's scan (load -> compare -> movemask -> tzcnt/blsr,
// ~20 cycles), and with ~115-230 instructions per step the out-of-order window overlaps only one or
// two steps. Here iteration k scans step k+1 of all four streams (the only loop-carried chain:
// stream position -> 64-byte load -> masks -> advance) and converts step k from the positions saved by
// iteration k-1, so the conversion does not wait for the scan.
//
// Contract and validation: as qp_parse_ms4 (tokens of 1..9 digits separated by bytes <= ' '; at least
// 64 readable bytes after the last token's separator); a scan advances a stream by at most 65 bytes
// and reads at most 64 bytes past the stream position; conversions read at most 80 bytes past the
// scanned position.
#pragma once
#include "parse_ms4.inc"

namespace qp_parse_ms4p {
struct Scan { const char* base; uint32_t t1, t2, t3, t4; };

__attribute__((always_inline)) inline void scan(char*& s, Scan& o) {
    const __m256i lim = _mm256_set1_epi8(' ' + 1);
    const uint32_t m0 = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(lim, _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s)))));
    const uint64_t m1 = uint64_t(uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(lim, _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s + 32)))))) << 32;
    const uint32_t r1 = _blsr_u32(m0), r2 = _blsr_u32(r1);
    o.base = s;
    o.t1 = _tzcnt_u32(m0); o.t2 = _tzcnt_u32(r1); o.t3 = _tzcnt_u32(r2);
    o.t4 = uint32_t(_tzcnt_u64(uint64_t(_blsr_u32(r2)) | m1));
    s += o.t4 + 1;
}
__attribute__((always_inline)) inline void convert(const Scan& o, __m256i& flags, __m256i& g12, __m256i& g34) {
    using qp_parse_ms4::row;
    const char* b = o.base;
    const __m256i w12 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(reinterpret_cast<const __m128i*>(b))),
                                                _mm_loadu_si128(reinterpret_cast<const __m128i*>(b + o.t1 + 1)), 1);
    const __m256i w34 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(reinterpret_cast<const __m128i*>(b + o.t2 + 1))),
                                                _mm_loadu_si128(reinterpret_cast<const __m128i*>(b + o.t3 + 1)), 1);
    const __m256i r12 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(row(o.t1 + 1))), _mm_load_si128(row(o.t2 - o.t1)), 1);
    const __m256i r34 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(row(o.t3 - o.t2))), _mm_load_si128(row(o.t4 - o.t3)), 1);
    flags = _mm256_or_si256(flags, _mm256_or_si256(r12, r34));
    const __m256i zero = _mm256_set1_epi8('0'), k1 = _mm256_set1_epi16(0x010a), k2 = _mm256_set1_epi32(0x00010064);
    g12 = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_shuffle_epi8(_mm256_subs_epu8(w12, zero), r12), k1), k2);
    g34 = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_shuffle_epi8(_mm256_subs_epu8(w34, zero), r34), k1), k2);
}
__attribute__((always_inline)) inline void emit(const Scan (&p)[4], __m256i& flags, uint32_t* o0, uint32_t* o1, uint32_t* o2, uint32_t* o3, size_t j) {
    __m256i a12, a34, b12, b34, c12, c34, d12, d34;
    convert(p[0], flags, a12, a34); convert(p[1], flags, b12, b34);
    convert(p[2], flags, c12, c34); convert(p[3], flags, d12, d34);
    const __m256i q12 = qp_parse_ms4::combine(a12, b12, c12, d12), q34 = qp_parse_ms4::combine(a34, b34, c34, d34);
    const __m256i ac = _mm256_unpacklo_epi64(q12, q34), bd = _mm256_unpackhi_epi64(q12, q34);
    _mm_storeu_si128(reinterpret_cast<__m128i*>(o0 + j), _mm256_castsi256_si128(ac));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(o1 + j), _mm256_castsi256_si128(bd));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(o2 + j), _mm256_extracti128_si256(ac, 1));
    _mm_storeu_si128(reinterpret_cast<__m128i*>(o3 + j), _mm256_extracti128_si256(bd, 1));
}

// DB: scan records double-buffered in a stack array instead of copied between registers each step.
template<size_t SUB, size_t SKEW, char* (*Tail)(char*, uint32_t*, size_t), class Side = qp_parse_ms4::NoSide, bool DB = false>
__attribute__((noinline)) char* parse_side(char* p, uint32_t* dst, size_t count, Side& side) {
    constexpr size_t D = SUB + SKEW, CHB = 4 * D, CAP = D + 64;
    alignas(64) static uint32_t region[3][CAP];
    while (count > CHB / 2 + 64) {
        char* s[4] = {p, qp_parse_ms2::snap(p + D), qp_parse_ms2::snap(p + 2 * D), qp_parse_ms2::snap(p + 3 * D)};
        char* const e[4] = {s[1], s[2], s[3], qp_parse_ms2::snap(p + CHB)};
        uint32_t *const o0 = dst, *const o1 = region[0], *const o2 = region[1], *const o3 = region[2];
        __m256i flags = _mm256_setzero_si256();
        size_t j = 0;
        for (;;) {
            const size_t left = size_t(std::min(std::min(e[0] - s[0], e[1] - s[1]), std::min(e[2] - s[2], e[3] - s[3])));
            size_t steps = left / 65;   // scans this batch; each advances a stream by <= 65 bytes
            if (!steps) break;
            if constexpr (DB) {   // scan records double-buffered in memory (no per-step copies)
                alignas(64) Scan buf[2][4];
                scan(s[0], buf[0][0]); scan(s[1], buf[0][1]); scan(s[2], buf[0][2]); scan(s[3], buf[0][3]);
                size_t cur = 0;
                while (--steps) {
                    side();
                    Scan (&nx)[4] = buf[cur ^ 1];
                    scan(s[0], nx[0]); scan(s[1], nx[1]); scan(s[2], nx[2]); scan(s[3], nx[3]);
                    asm volatile("" ::: "memory");   // keep the records in memory
                    emit(buf[cur], flags, o0, o1, o2, o3, j);
                    j += 4;
                    cur ^= 1;
                }
                emit(buf[cur], flags, o0, o1, o2, o3, j);
                j += 4;
            } else {
                Scan pend[4];
                scan(s[0], pend[0]); scan(s[1], pend[1]); scan(s[2], pend[2]); scan(s[3], pend[3]);
                while (--steps) {
                    side();
                    Scan next[4];
                    scan(s[0], next[0]); scan(s[1], next[1]); scan(s[2], next[2]); scan(s[3], next[3]);
                    emit(pend, flags, o0, o1, o2, o3, j);
                    j += 4;
                    for (int k = 0; k < 4; ++k) pend[k] = next[k];
                }
                emit(pend, flags, o0, o1, o2, o3, j);
                j += 4;
            }
        }
        size_t n0 = j, n1 = j, n2 = j, n3 = j;
        while (s[0] < e[0]) o0[n0++] = qp_parse_ms2::one(s[0], flags);
        while (s[1] < e[1] && n1 < CAP) o1[n1++] = qp_parse_ms2::one(s[1], flags);
        while (s[2] < e[2] && n2 < CAP) o2[n2++] = qp_parse_ms2::one(s[2], flags);
        while (s[3] < e[3] && n3 < CAP) o3[n3++] = qp_parse_ms2::one(s[3], flags);
        const bool bad = (uint32_t(_mm256_movemask_epi8(flags)) & 0x80008000u) | (s[0] != e[0]) | (s[1] != e[1]) | (s[2] != e[2]) | (s[3] != e[3]);
        if (__builtin_expect(bad, 0)) {
            size_t total = 0;
            for (char* q = p; q < e[3]; ++q) total += size_t(*q > ' ' && (q == p || q[-1] <= ' '));
            Tail(p, dst, total);
            dst += total; count -= total; p = e[3];
            continue;
        }
        std::memcpy(dst + n0, o1, n1 * sizeof(uint32_t));
        std::memcpy(dst + n0 + n1, o2, n2 * sizeof(uint32_t));
        std::memcpy(dst + n0 + n1 + n2, o3, n3 * sizeof(uint32_t));
        const size_t total = n0 + n1 + n2 + n3;
        dst += total; count -= total; p = e[3];
    }
    return Tail(p, dst, count);
}
template<size_t SUB, size_t SKEW, char* (*Tail)(char*, uint32_t*, size_t), bool DB = false>
char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    qp_parse_ms4::NoSide none;
    return qp_parse_ms4p::parse_side<SUB, SKEW, Tail, qp_parse_ms4::NoSide, DB>(p, dst, count, none);   // qualified: no ADL
}
}  // namespace qp_parse_ms4p
