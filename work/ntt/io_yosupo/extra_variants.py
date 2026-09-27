# Round-2 variants, executed inside variants.py (shares its helpers and VARIANTS).
# Parser/formatter code comes verbatim from the .inc files the unit test compiles.
PARSE = (here / 'parse_quad.inc').read_text()
FORMAT = (here / 'format_avx2.inc').read_text()
TAIL = 'constexpr int max_transform = 1 << 20;'
READS = ('    for (unsigned i = 0; i < n; ++i) a[i] = read_sse_short(input_cursor);\n'
         '    for (unsigned i = 0; i < m; ++i) b[i] = read_sse_short(input_cursor);\n')
WRITES = '    for (unsigned i = 0; i < count; ++i) write_mod998(out, output_cursor, output_end, a[i]);\n'


def avx2_parse(s):
    s = sub(s, TAIL, PARSE + TAIL)
    return sub(s, READS, '    input_cursor = qp_parse::parse_tokens(input_cursor, a, n);\n'
                         '    input_cursor = qp_parse::parse_tokens(input_cursor, b, m);\n')


def avx2_format(s):
    s = sub(s, TAIL, FORMAT + TAIL)
    return sub(s, WRITES, '    output_cursor = qp_format::format_values(out, output_cursor, output_end, a, count);\n')


IO = [avx2_parse, avx2_format, out_buffer('1u << 16')]
VARIANTS.update({
    'sse_short_ob16k': ('sse_short', [out_buffer('1u << 14')]),
    'sse_short_ob32k': ('sse_short', [out_buffer('1u << 15')]),
    'pquad': ('sse_short', [avx2_parse]),
    'favx': ('sse_short', [avx2_format]),
    'favx_ob64k': ('sse_short', [avx2_format, out_buffer('1u << 16')]),
    'io_all': ('sse_short', IO),
    'io_all_prefault': ('sse_short', IO + [prefault]),
    'io_all_thp': ('sse_short', IO + [huge_pages]),
})
PHASES += ['io_all', 'io_all_thp']
