// Exploration 014: the exploration-011 fixed-width formatter qp_fixed::blocks3 (io_large/fmt_bcd.inc)
// as GCC inline assembly with every constant a memory operand. Written for this exploration.
//
// Why: GCC 15.2 (judge flags) compiles blocks3<4> to ~390 instructions per 32 values, ~100 of them
// overhead: 59 stack spills/reloads and 24 instructions rematerializing threshold constants inside
// the loop (movl / vmovd / vpbroadcastd), because the ~25 constants and four interleaved blocks do
// not fit in 16 ymm registers (asm_probe.cpp, run 37700082427). At ~3.5 instructions per cycle that
// is the measured ~28 cycles per 8 values. Here one 8-value block is 76 instructions: loads of x and
// of four constants kept in registers (blend masks K1..K3, spaces), the arithmetic of blocks3, and
// 8 stores. Blocks are independent; the out-of-order core overlaps consecutive ones.
//
// Arithmetic (identical to blocks3, see fmt_bcd.inc): q = x / 10^4 and a = x / 10^8 by vpmuludq
// with ceil(2^45 / 10^4) and ceil(2^56 / 10^8); c = x - 10^4 q, b = q - 10^4 a; each 4-digit part
// to a BCD dword [units, tens, hundreds, thousands] by 16-bit SWAR (y / 100 = mulhi(y, 5243) >> 3,
// hl = y + 65436 h, t = mulhi(hl, 6554), g = hl + 246 t); blanks from signed compares, here in
// "digit present" form x > 10^k - 1 (constant as the memory operand), merged bytewise with vpblendvb;
// the 9th digit a and the field's trailing space come from one dword a + 0x20000030 (or spaces).
// Layout: S1 = [b0 c0 b1 c1 | b4 c4 b5 c5], S2 = [b2 c2 b3 c3 | b6 c6 b7 c7]; one vpshufb per
// pair of fields plus one for the 9th digit / separator; 16-byte stores at 0, 10, ..., 70.
//
// Contract (as blocks3): values < 10^9. block8() reads 8 values (32 bytes) and writes p[0..85]:
// the 80 field bytes plus 6 bytes the next block (or the caller) overwrites; stores in increasing
// address order.
#pragma once
#include <cstdint>

namespace qp_fmt_asm {
struct alignas(32) Consts { uint32_t v[31][8]; };
constexpr Consts make_consts() {
    Consts c{};
    auto all = [&](int i, uint32_t x) { for (int j = 0; j < 8; ++j) c.v[i][j] = x; };
    auto q64 = [&](int i, uint32_t lo) { for (int j = 0; j < 8; ++j) c.v[i][j] = (j & 1) ? 0u : lo; };
    q64(0, 3518437209u);   // ceil(2^45 / 10^4)
    q64(1, 720575941u);    // ceil(2^56 / 10^8)
    all(2, 10000);
    const uint32_t ge[8] = {9, 99, 999, 9999, 99999, 999999, 9999999, 99999999};
    for (int k = 0; k < 8; ++k) all(3 + k, ge[k]);
    all(11, 0x000000FFu); all(12, 0x0000FF00u); all(13, 0x00FF0000u); all(14, 0xFF000000u);
    all(15, 0x147B147Bu);  // 5243 in each 16-bit half
    all(16, 65436);
    all(17, 0x199A199Au);  // 6554
    all(18, 0x00F600F6u);  // 246
    all(19, 0x30303030u);  // '0' bytes
    all(20, 0x20202020u);  // ' ' bytes
    all(21, 0x20000030u);  // a + '0' in byte 0, ' ' in byte 3
    // vpshufb controls, per 128-bit lane: field bytes 1..4 = b's digits (dword 0, reversed), 5..8 = c's;
    // the 9th-digit controls take byte 4k (digit or space) to field byte 0 and byte 4k+3 (space) to 9.
    auto put = [&](int i, int j, uint32_t byte) { c.v[i][j / 4] |= (byte & 0xFFu) << (8 * (j % 4)); };
    const int dlo[16] = {0x80, 3, 2, 1, 0, 7, 6, 5, 4, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80};
    for (int lane = 0; lane < 2; ++lane) for (int j = 0; j < 16; ++j) {
        put(22, 16 * lane + j, uint32_t(dlo[j]));
        put(23, 16 * lane + j, uint32_t(j >= 1 && j <= 8 ? dlo[j] + 8 : dlo[j]));
        for (int k = 0; k < 4; ++k) put(24 + k, 16 * lane + j, uint32_t(j == 0 ? 4 * k : j == 9 ? 4 * k + 3 : 0x80));
    }
    // Four-store layout: 28 digits of [b_i c_i b_i+1 c_i+1] (both lanes), 29/30 the 9th digits and
    // separators from A dwords (0, 1) / (2, 3) of the lane.
    const int cd_lo[16] = {0x80, 3, 2, 1, 0, 7, 6, 5, 4, 0x80, 0x80, 11, 10, 9, 8, 15};
    const int cd_hi[16] = {14, 13, 12, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80};
    for (int j = 0; j < 16; ++j) {
        put(28, j, uint32_t(cd_lo[j])); put(28, 16 + j, uint32_t(cd_hi[j]));
        for (int q = 0; q < 2; ++q) {   // q = 0: dwords 0, 1; q = 1: dwords 2, 3
            const int base = 8 * q;
            put(29 + q, j, uint32_t(j == 0 ? base : j == 9 ? base + 3 : j == 10 ? base + 4 : 0x80));
            put(29 + q, 16 + j, uint32_t(j == 3 ? base + 7 : 0x80));
        }
    }
    return c;
}
inline constexpr Consts consts = make_consts();

// Constant v[i] is at byte offset 32 i: 0 M1, 32 M8, 64 10^4, 96..320 thresholds 9..99999999, 352..448 K0..K3,
// 480 5243, 512 65436, 544 6554, 576 246, 608 '0', 640 ' ', 672 0x20000030, 704 dlo, 736 dhi, 768..864 9th digit,
// 896 four-store digits, 928 / 960 four-store 9th digits and separators.
#define QFA_CORE(SO)                                                          \
    "vmovdqu " #SO "(%[s]), %%ymm0\n\t"                                            \
    "vpsrlq $32, %%ymm0, %%ymm1\n\t"                                               \
    "vpmuludq 0(%[t]), %%ymm0, %%ymm2\n\t"                                         \
    "vpmuludq 0(%[t]), %%ymm1, %%ymm3\n\t"                                         \
    "vpsrlq $45, %%ymm2, %%ymm2\n\t"                                               \
    "vpsrlq $13, %%ymm3, %%ymm3\n\t"                                               \
    "vpblendd $0xAA, %%ymm3, %%ymm2, %%ymm2\n\t"   /* q = x / 10^4 */              \
    "vpmuludq 32(%[t]), %%ymm0, %%ymm3\n\t"                                        \
    "vpmuludq 32(%[t]), %%ymm1, %%ymm1\n\t"                                        \
    "vpsrlq $56, %%ymm3, %%ymm3\n\t"                                               \
    "vpsrlq $24, %%ymm1, %%ymm1\n\t"                                               \
    "vpblendd $0xAA, %%ymm1, %%ymm3, %%ymm3\n\t"   /* a = x / 10^8 */              \
    "vpmulld 64(%[t]), %%ymm2, %%ymm1\n\t"                                         \
    "vpsubd %%ymm1, %%ymm0, %%ymm4\n\t"            /* c = x - 10^4 q */            \
    "vpmulld 64(%[t]), %%ymm3, %%ymm1\n\t"                                         \
    "vpsubd %%ymm1, %%ymm2, %%ymm5\n\t"            /* b = q - 10^4 a */            \
    "vmovdqa 384(%[t]), %%ymm12\n\t"                                               \
    "vmovdqa 416(%[t]), %%ymm13\n\t"                                               \
    "vmovdqa 448(%[t]), %%ymm14\n\t"                                               \
    "vmovdqa 640(%[t]), %%ymm15\n\t"                                               \
    "vpcmpgtd 192(%[t]), %%ymm0, %%ymm6\n\t"       /* Mb: x > 9999 ... */          \
    "vpcmpgtd 224(%[t]), %%ymm0, %%ymm1\n\t"                                       \
    "vpblendvb %%ymm12, %%ymm1, %%ymm6, %%ymm6\n\t"                                \
    "vpcmpgtd 256(%[t]), %%ymm0, %%ymm1\n\t"                                       \
    "vpblendvb %%ymm13, %%ymm1, %%ymm6, %%ymm6\n\t"                                \
    "vpcmpgtd 288(%[t]), %%ymm0, %%ymm1\n\t"                                       \
    "vpblendvb %%ymm14, %%ymm1, %%ymm6, %%ymm6\n\t"                                \
    "vpcmpgtd 96(%[t]), %%ymm0, %%ymm7\n\t"        /* Mc: units always, x > 9 */   \
    "vpor 352(%[t]), %%ymm7, %%ymm7\n\t"                                           \
    "vpcmpgtd 128(%[t]), %%ymm0, %%ymm1\n\t"                                       \
    "vpblendvb %%ymm13, %%ymm1, %%ymm7, %%ymm7\n\t"                                \
    "vpcmpgtd 160(%[t]), %%ymm0, %%ymm1\n\t"                                       \
    "vpblendvb %%ymm14, %%ymm1, %%ymm7, %%ymm7\n\t"                                \
    "vpcmpgtd 320(%[t]), %%ymm0, %%ymm1\n\t"       /* 9th digit present */         \
    "vpaddd 672(%[t]), %%ymm3, %%ymm3\n\t"                                         \
    "vpblendvb %%ymm1, %%ymm3, %%ymm15, %%ymm3\n\t"                                \
    "vpmulhuw 480(%[t]), %%ymm5, %%ymm1\n\t"       /* b -> BCD dword */            \
    "vpsrlw $3, %%ymm1, %%ymm1\n\t"                                                \
    "vpmulld 512(%[t]), %%ymm1, %%ymm1\n\t"                                        \
    "vpaddd %%ymm5, %%ymm1, %%ymm1\n\t"                                            \
    "vpmulhuw 544(%[t]), %%ymm1, %%ymm2\n\t"                                       \
    "vpmullw 576(%[t]), %%ymm2, %%ymm2\n\t"                                        \
    "vpaddw %%ymm1, %%ymm2, %%ymm5\n\t"                                            \
    "vpaddb 608(%[t]), %%ymm5, %%ymm5\n\t"                                         \
    "vpblendvb %%ymm6, %%ymm5, %%ymm15, %%ymm5\n\t"                                \
    "vpmulhuw 480(%[t]), %%ymm4, %%ymm1\n\t"       /* c -> BCD dword */            \
    "vpsrlw $3, %%ymm1, %%ymm1\n\t"                                                \
    "vpmulld 512(%[t]), %%ymm1, %%ymm1\n\t"                                        \
    "vpaddd %%ymm4, %%ymm1, %%ymm1\n\t"                                            \
    "vpmulhuw 544(%[t]), %%ymm1, %%ymm2\n\t"                                       \
    "vpmullw 576(%[t]), %%ymm2, %%ymm2\n\t"                                        \
    "vpaddw %%ymm1, %%ymm2, %%ymm4\n\t"                                            \
    "vpaddb 608(%[t]), %%ymm4, %%ymm4\n\t"                                         \
    "vpblendvb %%ymm7, %%ymm4, %%ymm15, %%ymm4\n\t"                                \
    "vpunpckldq %%ymm4, %%ymm5, %%ymm1\n\t"        /* S1 */                        \
    "vpunpckhdq %%ymm4, %%ymm5, %%ymm2\n\t"        /* S2 */

#define QFA_LAYOUT8                                                                \
    "vpshufb 704(%[t]), %%ymm1, %%ymm4\n\t"                                        \
    "vpshufb 768(%[t]), %%ymm3, %%ymm5\n\t"                                        \
    "vpor %%ymm5, %%ymm4, %%ymm4\n\t"                                              \
    "vpshufb 736(%[t]), %%ymm1, %%ymm5\n\t"                                        \
    "vpshufb 800(%[t]), %%ymm3, %%ymm6\n\t"                                        \
    "vpor %%ymm6, %%ymm5, %%ymm5\n\t"                                              \
    "vpshufb 704(%[t]), %%ymm2, %%ymm6\n\t"                                        \
    "vpshufb 832(%[t]), %%ymm3, %%ymm7\n\t"                                        \
    "vpor %%ymm7, %%ymm6, %%ymm6\n\t"                                              \
    "vpshufb 736(%[t]), %%ymm2, %%ymm7\n\t"                                        \
    "vpshufb 864(%[t]), %%ymm3, %%ymm8\n\t"                                        \
    "vpor %%ymm8, %%ymm7, %%ymm7\n\t"

#define QFA_COMPUTE(SO) QFA_CORE(SO) QFA_LAYOUT8

#define QFA_STORE(DO)                                                              \
    "vmovdqu %%xmm4, " #DO "(%[d])\n\t"                                            \
    "vmovdqu %%xmm5, (" #DO "+10)(%[d])\n\t"                                       \
    "vmovdqu %%xmm6, (" #DO "+20)(%[d])\n\t"                                       \
    "vmovdqu %%xmm7, (" #DO "+30)(%[d])\n\t"                                       \
    "vextracti128 $1, %%ymm4, (" #DO "+40)(%[d])\n\t"                              \
    "vextracti128 $1, %%ymm5, (" #DO "+50)(%[d])\n\t"                              \
    "vextracti128 $1, %%ymm6, (" #DO "+60)(%[d])\n\t"                              \
    "vextracti128 $1, %%ymm7, (" #DO "+70)(%[d])\n\t"

// Four-store layout (exploration 014 round 7): after QFA_CORE, ymm1 = S1, ymm2 = S2, ymm3 = A.
// Output vector p covers fields 2p and 2p+1 (bytes 20p .. 20p+19) plus 12 scratch bytes: its low
// lane is field 2p and the first 6 bytes of field 2p+1, its high lane the last 4 bytes of field
// 2p+1. Each lane sees a duplicated 128-bit half of S1/S2 (digits of both values) and of A (9th
// digits and separators). Four overlapping 32-byte stores at 0, 20, 40, 60 in increasing order;
// writes p[0..91] (12 scratch bytes after the block).
#define QFA_LAYOUT4STORE(DO)                                                       \
    "vinserti128 $1, %%xmm3, %%ymm3, %%ymm0\n\t"     /* E01 = [A.lo | A.lo] */     \
    "vperm2i128 $0x11, %%ymm3, %%ymm3, %%ymm3\n\t"   /* E45 = [A.hi | A.hi] */     \
    "vinserti128 $1, %%xmm1, %%ymm1, %%ymm4\n\t"     /* values 0, 1 */             \
    "vpshufb 896(%[t]), %%ymm4, %%ymm4\n\t"                                        \
    "vpshufb 928(%[t]), %%ymm0, %%ymm5\n\t"                                        \
    "vpor %%ymm5, %%ymm4, %%ymm4\n\t"                                              \
    "vmovdqu %%ymm4, " #DO "(%[d])\n\t"                                            \
    "vinserti128 $1, %%xmm2, %%ymm2, %%ymm6\n\t"     /* values 2, 3 */             \
    "vpshufb 896(%[t]), %%ymm6, %%ymm6\n\t"                                        \
    "vpshufb 960(%[t]), %%ymm0, %%ymm7\n\t"                                        \
    "vpor %%ymm7, %%ymm6, %%ymm6\n\t"                                              \
    "vmovdqu %%ymm6, (" #DO "+20)(%[d])\n\t"                                       \
    "vperm2i128 $0x11, %%ymm1, %%ymm1, %%ymm4\n\t"   /* values 4, 5 */             \
    "vpshufb 896(%[t]), %%ymm4, %%ymm4\n\t"                                        \
    "vpshufb 928(%[t]), %%ymm3, %%ymm5\n\t"                                        \
    "vpor %%ymm5, %%ymm4, %%ymm4\n\t"                                              \
    "vmovdqu %%ymm4, (" #DO "+40)(%[d])\n\t"                                       \
    "vperm2i128 $0x11, %%ymm2, %%ymm2, %%ymm6\n\t"   /* values 6, 7 */             \
    "vpshufb 896(%[t]), %%ymm6, %%ymm6\n\t"                                        \
    "vpshufb 960(%[t]), %%ymm3, %%ymm7\n\t"                                        \
    "vpor %%ymm7, %%ymm6, %%ymm6\n\t"                                              \
    "vmovdqu %%ymm6, (" #DO "+60)(%[d])\n\t"

#define QFA_BLOCK(SO, DO) QFA_COMPUTE(SO) QFA_STORE(DO)

#define QFA_CLOBBERS "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7", "xmm8", \
                     "xmm12", "xmm13", "xmm14", "xmm15", "memory"

// 8 values -> 80 bytes (+6 scratch).
__attribute__((always_inline)) inline void block8(const uint32_t* src, char* dst) {
    asm volatile(QFA_BLOCK(0, 0) : : [s] "r"(src), [d] "r"(dst), [t] "r"(consts.v) : QFA_CLOBBERS);
}
// 8 values -> 80 bytes (+12 scratch) with four 32-byte stores.
__attribute__((always_inline)) inline void block8_s4(const uint32_t* src, char* dst) {
    asm volatile(QFA_CORE(0) QFA_LAYOUT4STORE(0) : : [s] "r"(src), [d] "r"(dst), [t] "r"(consts.v) : QFA_CLOBBERS);
}
// 16 values -> 160 bytes (+12 scratch) with eight 32-byte stores, one asm statement.
__attribute__((always_inline)) inline void blocks2_s4(const uint32_t* src, char* dst) {
    asm volatile(QFA_CORE(0) QFA_LAYOUT4STORE(0) QFA_CORE(32) QFA_LAYOUT4STORE(80)
                 : : [s] "r"(src), [d] "r"(dst), [t] "r"(consts.v) : QFA_CLOBBERS);
}
// 8G values -> 80G bytes (+6 scratch), G in {1, 2, 4}: one asm statement.
template<int G>
__attribute__((always_inline)) inline void blocks(const uint32_t* src, char* dst) {
    static_assert(G == 1 || G == 2 || G == 4);
    if constexpr (G == 1) {
        asm volatile(QFA_BLOCK(0, 0) : : [s] "r"(src), [d] "r"(dst), [t] "r"(consts.v) : QFA_CLOBBERS);
    } else if constexpr (G == 2) {
        asm volatile(QFA_BLOCK(0, 0) QFA_BLOCK(32, 80) : : [s] "r"(src), [d] "r"(dst), [t] "r"(consts.v) : QFA_CLOBBERS);
    } else {
        asm volatile(QFA_BLOCK(0, 0) QFA_BLOCK(32, 80) QFA_BLOCK(64, 160) QFA_BLOCK(96, 240)
                     : : [s] "r"(src), [d] "r"(dst), [t] "r"(consts.v) : QFA_CLOBBERS);
    }
}
}  // namespace qp_fmt_asm
