// Multi-stream token parser, round 3 of the design (QPoly exploration 011): qp_parse_ms2 with a
// leaner step and an optional second group of four streams. Written for this exploration; digit
// weighting follows the exploration-007 parsers (qp_parse_flat).
//
// Changes from qp_parse_ms2 (same algorithm, same contract):
// - Right-align controls come from unaligned 16-byte loads out of one 80-byte ramp,
//   control(l) = load(ramp + 16 + l): ramp = [-128 x 32, 0..15, -128 x 32], so byte j of the control
//   is j - (16 - l) for j >= 16 - l and negative (zero output) below; lengths outside 1..16 put a
//   negative byte at position 15, which the chunk's flag vector catches as before. The index is
//   the byte length itself (no shift) and all index arithmetic is 64-bit, which lets the compiler
//   fold constants into addresses.
// - K = 8 runs two groups of four streams per step (16 tokens), hiding more of the
//   load -> compare -> movemask -> bit scan -> add chain of each stream.
#pragma once
#include <immintrin.h>
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <cstring>

namespace qp_parse_ms3 {
struct Ramp { alignas(64) int8_t b[80]; };
constexpr Ramp make_ramp() {
    Ramp r{};
    for (int k = 0; k < 80; ++k) r.b[k] = int8_t(k >= 32 && k < 48 ? k - 32 : -128);
    return r;
}
inline constexpr Ramp ramp = make_ramp();

// Right-align control for a token of length l, -1 <= l <= 31 (as ramp + 16 + l).
__attribute__((always_inline)) inline __m128i control(const int8_t* at) {
    return _mm_loadu_si128(reinterpret_cast<const __m128i*>(at));
}
__attribute__((always_inline)) inline char* snap(char* q) {
    const __m256i x = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(q));
    return q + size_t(_tzcnt_u32(uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), x))))) + 1;
}
// Two tokens at s -> dwords [first: g0..g3 | second: g0..g3] (4-digit groups), s advanced.
__attribute__((always_inline)) inline __m256i two(char*& s, __m256i& flags) {
    const __m256i y = _mm256_loadu_si256(reinterpret_cast<const __m256i*>(s));
    // Bits 31..63 set: byte 31 counts as a separator (never reached by valid tokens: two tokens of
    // <= 9 digits end by byte 19), so t1 <= 31 and t2 <= 32 whatever the input, and 64-bit bit
    // scans need no zero extension.
    const uint64_t m = uint32_t(_mm256_movemask_epi8(_mm256_cmpgt_epi8(_mm256_set1_epi8(' ' + 1), y))) | 0xFFFFFFFF80000000ull;
    const size_t t1 = _tzcnt_u64(m), t2 = _tzcnt_u64(_blsr_u64(m));   // t2 > t1; lengths t1, t2 - t1 - 1
    const __m256i w = _mm256_inserti128_si256(y, _mm_loadu_si128(reinterpret_cast<const __m128i*>(s + t1 + 1)), 1);
    s += t2 + 1;
    const __m256i r = _mm256_inserti128_si256(_mm256_castsi128_si256(control(ramp.b + 16 + t1)),
                                              control(ramp.b + 15 + (t2 - t1)), 1);
    flags = _mm256_or_si256(flags, r);
    const __m256i d = _mm256_shuffle_epi8(_mm256_subs_epu8(w, _mm256_set1_epi8('0')), r);
    return _mm256_madd_epi16(_mm256_maddubs_epi16(d, _mm256_set1_epi16(0x010a)), _mm256_set1_epi32(0x00010064));
}
// One token at s (drain).
__attribute__((always_inline)) inline uint32_t one(char*& s, __m256i& flags) {
    const __m128i w = _mm_loadu_si128(reinterpret_cast<const __m128i*>(s));
    const size_t t = _tzcnt_u32(uint32_t(_mm_movemask_epi8(_mm_cmpgt_epi8(_mm_set1_epi8(' ' + 1), w))));
    const __m128i r = control(ramp.b + 16 + t);
    flags = _mm256_or_si256(flags, _mm256_castsi128_si256(r));
    s += t + 1;
    __m128i x = _mm_shuffle_epi8(_mm_subs_epu8(w, _mm_set1_epi8('0')), r);
    x = _mm_madd_epi16(_mm_maddubs_epi16(x, _mm_set1_epi16(0x010a)), _mm_set1_epi32(0x00010064));
    x = _mm_madd_epi16(_mm_packus_epi32(x, x), _mm_set1_epi32(0x00012710));
    const uint64_t both = uint64_t(_mm_cvtsi128_si64(x));
    return uint32_t(both) * 100000000u + uint32_t(both >> 32);
}
// Four streams, one step: stores two values per stream at o[k] + j.
__attribute__((always_inline)) inline void group4(char*& sa, char*& sb, char*& sc, char*& sd, __m256i& flags,
                                                  uint32_t* oa, uint32_t* ob, uint32_t* oc, uint32_t* od) {
    const __m256i gA = two(sa, flags), gB = two(sb, flags), gC = two(sc, flags), gD = two(sd, flags);
    const __m256i k = _mm256_set1_epi32(0x00012710);
    const __m256 xAB = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gA, gB), k));   // [A1h A1l B1h B1l | A2h ..]
    const __m256 xCD = _mm256_castsi256_ps(_mm256_madd_epi16(_mm256_packus_epi32(gC, gD), k));
    const __m256i hi = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0x88));   // [A1h B1h C1h D1h | A2h ..]
    const __m256i lo = _mm256_castps_si256(_mm256_shuffle_ps(xAB, xCD, 0xDD));
    const __m256i v = _mm256_add_epi32(_mm256_mullo_epi32(hi, _mm256_set1_epi32(100000000)), lo);
    const __m256i q = _mm256_permutevar8x32_epi32(v, _mm256_setr_epi32(0, 4, 1, 5, 2, 6, 3, 7));   // [A1 A2 B1 B2 | C1 C2 D1 D2]
    const __m128i qa = _mm256_castsi256_si128(q), qc = _mm256_extracti128_si256(q, 1);
    _mm_storel_epi64(reinterpret_cast<__m128i*>(oa), qa);
    _mm_storeh_pd(reinterpret_cast<double*>(ob), _mm_castsi128_pd(qa));
    _mm_storel_epi64(reinterpret_cast<__m128i*>(oc), qc);
    _mm_storeh_pd(reinterpret_cast<double*>(od), _mm_castsi128_pd(qc));
}

template<int K, size_t CH, char* (*Tail)(char*, uint32_t*, size_t)>
__attribute__((noinline)) char* parse_tokens(char* p, uint32_t* dst, size_t count) {
    static_assert(K == 4 || K == 8, "streams come in groups of four");
    // A step advances a stream by >= 2 bytes and emits 2 values (empty tokens included), so a
    // stream of <= SUB + 33 bytes emits <= SUB + 33 values; stream 0 writes into dst (which has
    // room for count > SUB + 33 values), streams 1.. into static regions.
    constexpr size_t SUB = CH / K, CAP = SUB + 64;
    alignas(64) static uint32_t region[K - 1][CAP];
    while (count > CH / 2 + 64) {   // a chunk holds at most (CH + 33) / 2 tokens, all of this array
        char* s[K]; char* e[K];
        s[0] = p;
        for (int k = 1; k < K; ++k) s[k] = e[k - 1] = snap(p + k * SUB);
        e[K - 1] = snap(p + CH);
        uint32_t* o[K];
        o[0] = dst;
        for (int k = 1; k < K; ++k) o[k] = region[k - 1];
        __m256i flags = _mm256_setzero_si256();
        size_t j = 0;   // values per stream so far (two per step)
        for (;;) {
            ptrdiff_t left = e[0] - s[0];
            for (int k = 1; k < K; ++k) left = std::min(left, e[k] - s[k]);
            size_t steps = size_t(left) / 33;
            if (!steps) break;
            do {
                group4(s[0], s[1], s[2], s[3], flags, o[0] + j, o[1] + j, o[2] + j, o[3] + j);
                if constexpr (K == 8) group4(s[4], s[5], s[6], s[7], flags, o[4] + j, o[5] + j, o[6] + j, o[7] + j);
                j += 2;
            } while (--steps);
        }
        size_t n[K];
        bool bad = false;
        for (int k = 0; k < K; ++k) {
            n[k] = j;
            while (s[k] < e[k] && n[k] < CAP) o[k][n[k]++] = one(s[k], flags);
            bad |= s[k] != e[k];
        }
        bad |= (uint32_t(_mm256_movemask_epi8(flags)) & 0x80008000u) != 0;
        if (__builtin_expect(bad, 0)) {   // robust path: tokens in [p, e) = token bytes after a separator (or at p)
            size_t total = 0;
            for (char* q = p; q < e[K - 1]; ++q) total += size_t(*q > ' ' && (q == p || q[-1] <= ' '));
            Tail(p, dst, total);
            dst += total; count -= total; p = e[K - 1];
            continue;
        }
        size_t total = n[0];
        for (int k = 1; k < K; ++k) { std::memcpy(dst + total, o[k], n[k] * sizeof(uint32_t)); total += n[k]; }
        dst += total; count -= total; p = e[K - 1];
    }
    return Tail(p, dst, count);
}
}  // namespace qp_parse_ms3
