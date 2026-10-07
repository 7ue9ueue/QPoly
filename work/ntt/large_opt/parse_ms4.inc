// Exploration 014: four tokens per stream step (qp_parse_ms4). Written for this exploration; the
// token windowing, digit weighting, combine and validation follow the exploration-011 parser
// qp_parse_ms2 (parse_ms2.inc), whose two() is the two-token version of four() below.
//
// Why: ablations of the ms2 step loop (bench_opt ablate, run 37700082427) show the per-stream scan
// chain (load -> compare -> movemask -> tzcnt/blsr -> advance) alone costs ~63% of the step on Zen 3
// (0.78 of 1.24 ns/token on EPYC 7763), with cached and DRAM-resident text equally fast, and the
// four 8-byte stores another ~14%. ms2 pays one chain round trip per two tokens. Here each stream
// step scans 64 bytes and takes four tokens: tokens of <= 9 digits plus a separator take <= 10 bytes,
// so tokens 1-3 always end in the first 32 bytes and the chain is load -> compare -> movemask ->
// blsr x3 -> or (high half's mask, computed in parallel) -> tzcnt -> advance, once per four tokens.
// Values are stored as one 16-byte store per stream (four consecutive values) instead of two
// 8-byte stores per two tokens.
//
// Step layout (stream X, tokens X1..X4 at s): windows [X1 | X2] and [X3 | X4] (each token
// left-aligned in its 16-byte lane, then right-aligned by a length-indexed shuffle row), reduced
// with maddubs/madd to 4-digit groups; the exploration-011 combine turns (A12, B12, C12, D12) into
// [A1 A2 B1 B2 | C1 C2 D1 D2] and (A34, ...) into [A3 A4 B3 B4 | C3 C4 D3 D4]; unpacklo/hi_epi64
// give [A1..A4 | C1..C4] and [B1..B4 | D1..D4].
//
// Validation as in ms2: a shuffle row whose byte 15 is negative marks a length outside 1..16 (two
// adjacent separators, or fewer than four separators in 64 bytes); rows are ORed into a flag
// vector checked once per chunk with the stream end positions; flagged chunks are re-parsed by
// Tail (qp_parse_flat), which accepts any whitespace.
//
// Contract: as qp_parse_ms2 (tokens of 1..9 digits separated by bytes <= ' '; at least 64 readable
// bytes after the last token's separator). A step advances a stream by at most 65 bytes and reads
// at most 80 bytes past the stream position, so steps run while every stream has >= 65 bytes left.
#pragma once
#include <immintrin.h>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include "../io_large/parse_ms2.inc"

namespace qp_parse_ms4 {
// Row i right-aligns a token of length i - 1 (0 <= i <= 65); lengths outside 1..16 give an all-zero
// row with byte 15 negative (flag).
struct Rows { alignas(16) int8_t row[66][16]; };
constexpr Rows make_rows() {
    Rows t{};
    for (int i = 0; i <= 65; ++i) {
        const int l = i - 1;
        for (int j = 0; j < 16; ++j) t.row[i][j] = int8_t(l >= 1 && l <= 16 && j >= 16 - l ? j - (16 - l) : -128);
    }
    return t;
}
inline constexpr Rows rows = make_rows();
__attribute__((always_inline)) inline const __m128i* row(uint32_t i) { return reinterpret_cast<const __m128i*>(rows.row[i]); }

// Four tokens at s: 4-digit groups of [X1 | X2] and [X3 | X4].
__attribute__((always_inline)) inline void four(char*& s, __m256i& flags, __m256i& g12, __m256i& g34) {
    const __m256i lim = _mm256_set1_epi8(' ' + 1);
    const __m256i y0 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s));
    const __m256i y1 = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s + 32));
    const uint32_t m0 = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(lim, y0)));
    const uint64_t m1 = uint64_t(uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(lim, y1)))) << 32;
    const uint32_t t1 = _tzcnt_u32(m0);
    const uint32_t r1 = _blsr_u32(m0), t2 = _tzcnt_u32(r1);
    const uint32_t r2 = _blsr_u32(r1), t3 = _tzcnt_u32(r2);
    const uint32_t t4 = uint32_t(_tzcnt_u64(uint64_t(_blsr_u32(r2)) | m1));   // 64 if fewer than four separators
    const __m256i w12 = _mm256_inserti128_si256(y0, _mm_loadu_si128(reinterpret_cast<const __m128i*>(s + t1 + 1)), 1);
    const __m256i w34 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_loadu_si128(reinterpret_cast<const __m128i*>(s + t2 + 1))),
                                                _mm_loadu_si128(reinterpret_cast<const __m128i*>(s + t3 + 1)), 1);
    const __m256i r12 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(row(t1 + 1))), _mm_load_si128(row(t2 - t1)), 1);
    const __m256i r34 = _mm256_inserti128_si256(_mm256_castsi128_si256(_mm_load_si128(row(t3 - t2))), _mm_load_si128(row(t4 - t3)), 1);
    flags = _mm256_or_si256(flags, _mm256_or_si256(r12, r34));
    s += t4 + 1;
    const __m256i zero = _mm256_set1_epi8('0'), k1 = _mm256_set1_epi16(0x010a), k2 = _mm256_set1_epi32(0x00010064);
    g12 = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_shuffle_epi8(_mm256_subs_epu8(w12, zero), r12), k1), k2);
    g34 = _mm256_madd_epi16(_mm256_maddubs_epi16(_mm256_shuffle_epi8(_mm256_subs_epu8(w34, zero), r34), k1), k2);
}
// Exploration-011 combine: 4-digit groups of [X1 | X2] for X = A..D -> [A1 A2 B1 B2 | C1 C2 D1 D2].
__attribute__((always_inline)) inline __m256i combine(__m256i gA, __m256i gB, __m256i gC, __m256i gD) {
    const __m256i k = _mm256_set1_epi32(0x00012710);
    const __m256 xAB = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gA, gB), k));
    const __m256 xCD = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gC, gD), k));
    const __m256i hi = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0x88));
    const __m256i lo = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0xDD));
    const __m256i v = _mm256_add_epi32(_mm256_mullo_epi32(hi, _mm256_set1_epi32(100000000)), lo);
    return _mm256_permutevar8x32_epi32(v, _mm256_setr_epi32(0, 4, 1, 5, 2, 6, 3, 7));
}

template<size_t SUB, size_t SKEW, char* (*Tail)(char*, uint32_t*, size_t)>
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    constexpr size_t D = SUB + SKEW, CHB = 4 * D, CAP = D + 64;
    alignas(64) static uint32_t region[3][CAP];
    while (count > CHB / 2 + 64) {   // a chunk holds at most (CHB + 33) / 2 tokens, all of this array
        char *s0 = p, *s1 = qp_parse_ms2::snap(p + D), *s2 = qp_parse_ms2::snap(p + 2 * D), *s3 = qp_parse_ms2::snap(p + 3 * D);
        char *const e0 = s1, *const e1 = s2, *const e2 = s3, *const e3 = qp_parse_ms2::snap(p + CHB);
        uint32_t *const o0 = dst, *const o1 = region[0], *const o2 = region[1], *const o3 = region[2];
        __m256i flags = _mm256_setzero_si256();
        size_t j = 0;   // values per stream so far (four per step)
        for (;;) {
            const size_t left = size_t(std::min(std::min(e0 - s0, e1 - s1), std::min(e2 - s2, e3 - s3)));
            size_t steps = left / 65;
            if (!steps) break;
            do {
                __m256i a12, a34, b12, b34, c12, c34, d12, d34;
                four(s0, flags, a12, a34); four(s1, flags, b12, b34);
                four(s2, flags, c12, c34); four(s3, flags, d12, d34);
                const __m256i q12 = combine(a12, b12, c12, d12), q34 = combine(a34, b34, c34, d34);
                const __m256i ac = _mm256_unpacklo_epi64(q12, q34), bd = _mm256_unpackhi_epi64(q12, q34);
                _mm_storeu_si128(reinterpret_cast<__m128i*>(o0 + j), _mm256_castsi256_si128(ac));
                _mm_storeu_si128(reinterpret_cast<__m128i*>(o1 + j), _mm256_castsi256_si128(bd));
                _mm_storeu_si128(reinterpret_cast<__m128i*>(o2 + j), _mm256_extracti128_si256(ac, 1));
                _mm_storeu_si128(reinterpret_cast<__m128i*>(o3 + j), _mm256_extracti128_si256(bd, 1));
                j += 4;
            } while (--steps);
        }
        size_t n0 = j, n1 = j, n2 = j, n3 = j;
        while (s0 < e0) o0[n0++] = qp_parse_ms2::one(s0, flags);   // dst holds count > D + 33 values
        while (s1 < e1 && n1 < CAP) o1[n1++] = qp_parse_ms2::one(s1, flags);
        while (s2 < e2 && n2 < CAP) o2[n2++] = qp_parse_ms2::one(s2, flags);
        while (s3 < e3 && n3 < CAP) o3[n3++] = qp_parse_ms2::one(s3, flags);
        const bool bad = (uint32_t(_mm256_movemask_epi8(flags)) & 0x80008000u) | (s0 != e0) | (s1 != e1) | (s2 != e2) | (s3 != e3);
        if (__builtin_expect(bad, 0)) {   // robust path: tokens in [p, e3) = token bytes after a separator (or at p)
            size_t total = 0;
            for (char* q = p; q < e3; ++q) total += size_t(*q > ' ' && (q == p || q[-1] <= ' '));
            Tail(p, dst, total);
            dst += total; count -= total; p = e3;
            continue;
        }
        std::memcpy(dst + n0, o1, n1 * sizeof(uint32_t));
        std::memcpy(dst + n0 + n1, o2, n2 * sizeof(uint32_t));
        std::memcpy(dst + n0 + n1 + n2, o3, n3 * sizeof(uint32_t));
        const size_t total = n0 + n1 + n2 + n3;
        dst += total; count -= total; p = e3;
    }
    return Tail(p, dst, count);
}
}  // namespace qp_parse_ms4
