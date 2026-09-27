# Rounds 2-4, executed inside variants.py (shares its helpers, VARIANTS, PHASES).
# Parser/formatter code comes verbatim from the .inc files the unit test compiles.
INC = {name: (here / name).read_text() for name in
       ('parse_quad.inc', 'parse_gen4.inc', 'parse_flat.inc', 'format_avx2.inc', 'format_avx2x.inc')}
MAIN = 'int main() {'
READS = ('    for (unsigned i = 0; i < n; ++i) a[i] = read_sse_short(input_cursor);\n'
         '    for (unsigned i = 0; i < m; ++i) b[i] = read_sse_short(input_cursor);\n')
WRITES = '    for (unsigned i = 0; i < count; ++i) write_mod998(out, output_cursor, output_end, a[i]);\n'


def parser(inc, ns):
    def transform(s):
        s = sub(s, MAIN, INC[inc] + MAIN)
        return sub(s, READS, f'    input_cursor = {ns}::parse_tokens(input_cursor, a, n);\n'
                             f'    input_cursor = {ns}::parse_tokens(input_cursor, b, m);\n')
    return transform


def formatter(inc, call):
    def transform(s):
        if INC[inc] not in s:
            s = sub(s, MAIN, INC[inc] + MAIN)
        return sub(s, WRITES, f'    output_cursor = {call}(out, output_cursor, output_end, a, count);\n')
    return transform


def arena(s):
    """Not I/O: a and b from one prefaulted, THP-hinted 2 MiB-aligned mapping."""
    s = sub(s, 'alignas(32) static uint32_t a[max_transform], b[max_transform];', '''static uint32_t *a, *b;
// Not I/O: transform storage as in yosupo_convolution_shoup.cpp's arena: one
// 2 MiB-aligned zeroed mapping with a transparent-huge-page hint, populated before
// parsing (MADV_POPULATE_WRITE, else touched), avoiding per-page first-touch faults.
static uint32_t* arena(size_t words) {
    constexpr size_t huge = size_t(2) << 20;
    const size_t bytes = (words * 4 + huge - 1) & ~(huge - 1);
    char* raw = static_cast<char*>(mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    if (raw == MAP_FAILED) std::exit(1);
    char* p = reinterpret_cast<char*>((reinterpret_cast<uintptr_t>(raw) + huge - 1) & ~uintptr_t(huge - 1));
#ifdef MADV_HUGEPAGE
    madvise(p, bytes, MADV_HUGEPAGE);
#endif
#ifndef MADV_POPULATE_WRITE
#define MADV_POPULATE_WRITE 23
#endif
    if (madvise(p, bytes, MADV_POPULATE_WRITE) != 0)
        for (size_t i = 0; i < bytes; i += 4096) static_cast<volatile char*>(p)[i] = 0;
    return reinterpret_cast<uint32_t*>(p);
}''')
    return sub(s, CHECK, CHECK + TRANSFORM_LENGTH + '      a = arena(2 * size_t(len)); b = a + len; }\n')


def falloc(s):
    """Pre-allocate the output file's tmpfs pages in one call (size unchanged)."""
    s = sub(s, '#include <unistd.h>\n', '#include <unistd.h>\n#include <fcntl.h>\n')
    return sub(s, '    const unsigned count = n + m - 1;\n', '    const unsigned count = n + m - 1;\n'
               '    (void)::fallocate(1, FALLOC_FL_KEEP_SIZE, 0, off_t(count) * 10 + 16);\n')


QUAD = parser('parse_quad.inc', 'qp_parse')
GEN4 = parser('parse_gen4.inc', 'qp_parse4')
FLAT = parser('parse_flat.inc', 'qp_parse_flat')
AVX = formatter('format_avx2.inc', 'qp_format::format_values')
AVX_X = formatter('format_avx2x.inc', 'qp_format2::format_values')
SWAR = formatter('format_avx2x.inc', 'qp_format2::format_scalar')
OB64 = out_buffer('1u << 16')
IO = [QUAD, AVX, OB64]
VARIANTS.update({
    'sse_short_ob16k': ('sse_short', [out_buffer('1u << 14')]),
    'sse_short_ob32k': ('sse_short', [out_buffer('1u << 15')]),
    'pquad': ('sse_short', [QUAD]),
    'favx': ('sse_short', [AVX]),
    'favx_ob64k': ('sse_short', [AVX, OB64]),
    'io_all': ('sse_short', IO),
    'io_all_prefault': ('sse_short', IO + [prefault]),
    'io_all_thp': ('sse_short', IO + [huge_pages]),
    # Round 3.
    'sse_short_arena': ('sse_short', [arena]),
    'arena_ob64k': ('sse_short', [arena, OB64]),
    'g4_arena_ob64k': ('sse_short', [arena, OB64, GEN4]),
    'g4_fx2_arena_ob64k': ('sse_short', [arena, OB64, GEN4, AVX_X]),
    'g4_swar_arena_ob64k': ('sse_short', [arena, OB64, GEN4, SWAR]),
    'shoup': ('shoup', []),
    'shoup_ob64k': ('shoup', [OB64]),
    'shoup_g4_ob64k': ('shoup', [OB64, GEN4]),
    'shoup_g4_fx2_ob64k': ('shoup', [OB64, GEN4, AVX_X]),
    'shoup_g4_swar_ob64k': ('shoup', [OB64, GEN4, SWAR]),
    # Round 4.
    'fl_arena_ob64k': ('sse_short', [arena, OB64, FLAT]),
    'fl_arena_ob64k_falloc': ('sse_short', [arena, OB64, FLAT, falloc]),
    'shoup_fl_ob64k': ('shoup', [OB64, FLAT]),
    'shoup_fl_ob64k_falloc': ('shoup', [OB64, FLAT, falloc]),
})
# Exact submission files written by make_deliverables.py, timed as delivered.
for key, file, origin in (('final_asm', 'yosupo_convolution_asm_radix4_pair_large_fixed_avx2_io.cpp', 'sse_short'),
                          ('final_shoup', 'yosupo_convolution_shoup_avx2_io.cpp', 'shoup')):
    path = root / 'work/ntt' / file
    if path.exists():
        text[key] = path.read_text()
        assert kernel(text[key]) == kernel(text[origin]), key
        VARIANTS[key] = (key, [])
# final_shoup must differ from shoup_fl_ob64k only in header comment lines 14-17.
if 'final_shoup' in text:
    twin = text['shoup']
    for transform in VARIANTS['shoup_fl_ob64k'][1]:
        twin = transform(twin)
    mine, theirs = text['final_shoup'].splitlines(), twin.splitlines()
    assert len(mine) == len(theirs) and all(a == b or 13 <= i <= 16 and a.startswith('//')
                                            and b.startswith('//') for i, (a, b) in enumerate(zip(mine, theirs)))
PHASES += ['io_all', 'io_all_thp', 'sse_short_arena', 'g4_arena_ob64k', 'g4_fx2_arena_ob64k',
           'fl_arena_ob64k', 'fl_arena_ob64k_falloc']
