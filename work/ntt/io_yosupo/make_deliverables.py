#!/usr/bin/env python3
"""Write the submission files; usage: make_deliverables.py PARSER FORMATTER.

PARSER: flat|gen4; FORMATTER: table|avx_extract|swar.

Starts from the hash-pinned sources in variants.py, keeps each NTT kernel text
byte-identical, keeps the padded input owner and output sink verbatim, and
replaces the rest of the I/O with the selected .inc code. Dead helpers from the
older parsers/writers are dropped. The confirmation round times these exact files.
"""
from pathlib import Path
import hashlib
import sys

here = Path(__file__).resolve().parent
ntt = here.parent
parser, formatter = sys.argv[1:3]
PARSE_INC, PARSE_NS = {'flat': ('parse_flat.inc', 'qp_parse_flat'), 'gen4': ('parse_gen4.inc', 'qp_parse4')}[parser]
SOURCES = {
    'asm': ('yosupo_convolution_asm_radix4_pair_large_fixed_io_sse.cpp',
            'd2d02e0fd47c3c510ae62ddb23a91174c29643dc932f69a9aed912450b598304'),
    'shoup': ('yosupo_convolution_shoup.cpp',
              '644e9f3ed8bdf0c008e9415d72426c0c66e8e73baf79283216031a3a7fb2cfe9'),
}
OUTPUTS = {'asm': 'yosupo_convolution_asm_radix4_pair_large_fixed_avx2_io.cpp',
           'shoup': 'yosupo_convolution_shoup_avx2_io.cpp'}
FORMAT_CALL = {'avx_extract': 'qp_format2::format_values', 'swar': 'qp_format2::format_scalar'}


def cut(text, start, end):
    i = text.index(start)
    return text[i:text.index(end, i)]


def io_code(src):
    block = cut(src, '// Selected uint32 I/O', '} // namespace fastio_unsafe_impl')
    if formatter != 'table':  # Keep the input owner and output sink only.
        block = (block[:block.index('constexpr auto make_padded_groups()')]
                 + cut(block, 'struct output {', '__attribute__((always_inline)) inline void emit_leading'))
    code = block.replace('// Selected uint32 I/O from QgQ\'s submission 393435; see attribution above.',
                         '// Selected uint32 I/O owner and sink from QgQ\'s submission 393435 (see header).')
    code += '} // namespace fastio_unsafe_impl\n\n' + (here / PARSE_INC).read_text()
    if formatter == 'table':
        code += '\n' + cut(src, '__attribute__((always_inline)) inline void write_mod998(',
                           '\n// Eight-digit SWAR') + '\n'
    else:
        code += '\n' + (here / 'format_avx2x.inc').read_text()
    return code.replace('std::array<char, 1u << 19> buffer_', 'std::array<char, 1u << 16> buffer_')


def output_lines(indent='    '):
    if formatter == 'table':
        return (f'{indent}char* output_cursor = out.begin();\n{indent}char* const output_end = out.end();\n'
                f'{indent}for (unsigned i = 0; i < count; ++i) write_mod998(out, output_cursor, output_end, a[i]);\n')
    return f'{indent}char* const output_cursor = {FORMAT_CALL[formatter]}(out, out.begin(), out.end(), a, count);\n'


PARSE_TEXT = {'flat': 'Two-stage AVX2 parser\n// (separator offsets, then four tokens per step; parse_flat.inc).',
              'gen4': 'AVX2 parser, four tokens per step\n// (parse_gen4.inc).'}[parser]
FORMAT_TEXT = {'table': 'QgQ-style grouped decimal table writer',
               'avx_extract': 'AVX2 eight-value formatter (format_avx2x.inc)',
               'swar': 'branch-free SWAR scalar formatter (format_avx2x.inc)'}[formatter]
IO_HEADER = f'''// I/O (QPoly exploration 007, Library Checker continuation, work/ntt/io_yosupo):
// the input is mapped with a readable zero page after it (read() fallback for
// pipes), adapted from QgQ, https://judge.yosupo.jp/submission/393435 (2026-08-14;
// no license notice was present in the displayed source). {PARSE_TEXT}
// Output uses a 64 KiB buffer and the {FORMAT_TEXT}.
// Valid judge input only: tokens of 1..9 digits separated by whitespace.
'''
HEADER_PARSE = f'''    uint32_t header[2];
    char* input_cursor = {PARSE_NS}::parse_tokens(in.cursor(), header, 2);
    const unsigned n = header[0], m = header[1];
    if (n == 0 || m == 0 || n > (1u << 19) || m > (1u << 19)) return 1;
'''


def make_asm(src):
    head = src[:src.index('#if defined(__GNUC__)')]
    lines = head.splitlines(keepends=True)
    keep = ''.join(l for l in lines[1:9])  # Kernel provenance and contract lines.
    header = ('// Library Checker convolution_mod (https://judge.yosupo.jp/problem/convolution_mod): C++17.\n'
              + keep.replace('// Library Checker convolution_mod: standalone C++17, x86-64 AVX2/BMI.\n', '')
              + '// Memory: A and B share one prefaulted 2 MiB-aligned mapping with a\n'
                '// transparent-huge-page hint (as in yosupo_convolution_shoup.cpp).\n' + IO_HEADER)
    prologue = cut(src, '#if defined(__GNUC__)', 'namespace kernel_asm_radix4_pair_large_fixed')
    kernel = cut(src, 'namespace kernel_asm_radix4_pair_large_fixed', '// Selected uint32 I/O')
    arena = (ntt / SOURCES['shoup'][0]).read_text()
    arena = cut(arena, '// Pre-faulted 2 MiB-aligned zeroed words', '\nint main() {') + '\n'
    main = f'''constexpr int max_transform = 1 << 20;
alignas(32) static uint32_t roots[max_transform / 16], inverse_roots[max_transform / 16];

{arena}
int main() {{
    fastio_unsafe_impl::input in;
    static fastio_unsafe_impl::output out;
{HEADER_PARSE}    const unsigned count = n + m - 1;
    int length = 64;
    while (unsigned(length) < count) length *= 2;
    uint32_t* const a = arena(2 * size_t(length));
    uint32_t* const b = a + length;
    input_cursor = {PARSE_NS}::parse_tokens(input_cursor, a, n);
    {PARSE_NS}::parse_tokens(input_cursor, b, m);
    int root_size = 0;
    asm_radix4_pair_large_fixed::invoke(length, a, b, roots, inverse_roots, root_size, true);
{output_lines()}    out.finish(output_cursor);
}}
'''
    return header + prologue + kernel + io_code(src) + '\n' + main, kernel


def make_shoup(src):
    header = src[:src.index('#if defined(__GNUC__)')]
    i = header.index('// Prints the transform time')
    header = header[:i] + IO_HEADER
    prologue = cut(src, '#if defined(__GNUC__)', '// Selected uint32 I/O').replace('#include <chrono>\n', '')
    kernel = cut(src, 'namespace qflip {', '}  // namespace qflip')
    arena = cut(src, '// Pre-faulted 2 MiB-aligned zeroed words', '\nint main() {') + '\n'
    kernel_call = cut(src, '    qflip::Kernel<', '\n') + '\n'
    main = f'''{arena}
int main() {{
    fastio_unsafe_impl::input in;
    static fastio_unsafe_impl::output out;
{HEADER_PARSE}    const unsigned count = n + m - 1;
    int length = 64;  // kernel minimum
    while (unsigned(length) < count) length *= 2;
    const size_t pad = 16, len = size_t(length) + pad, tab = size_t(length) / 8 + pad;
    uint32_t* const a = arena(2 * len + 2 * tab);
    uint32_t *const b = a + len, *const roots = b + len, *const inverse_roots = roots + tab;
    input_cursor = {PARSE_NS}::parse_tokens(input_cursor, a, n);
    {PARSE_NS}::parse_tokens(input_cursor, b, m);
    int root_size = 0;
{kernel_call}{output_lines()}    out.finish(output_cursor);
    return 0;
}}
'''
    return header + prologue + io_code(src) + '\n' + main, kernel


for key, (name, digest) in SOURCES.items():
    data = (ntt / name).read_bytes()
    assert hashlib.sha256(data).hexdigest() == digest, name
    src = data.decode()
    text, kernel = (make_asm if key == 'asm' else make_shoup)(src)
    assert text.count(kernel) == 1, key
    (ntt / OUTPUTS[key]).write_text(text)
    print(hashlib.sha256(text.encode()).hexdigest(), OUTPUTS[key])
