#!/usr/bin/env python3
"""Generate judge-targeted I/O variants; usage: variants.py OUT_DIR [NAME,...].

Every variant keeps the NTT kernel text byte-identical to judge submission
406388. Timed variants never contain phase instrumentation; `*_phases` builds
add clock marks around the same program for a separate breakdown pass.
"""
from pathlib import Path
import hashlib
import json
import sys

root = Path(__file__).resolve().parents[3]
here = Path(__file__).resolve().parent
out = Path(sys.argv[1]).resolve()
out.mkdir(parents=True, exist_ok=True)
SOURCES = {
    # Exact source of https://judge.yosupo.jp/submission/406388 (QgQ I/O).
    'base': ('work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed_io393435.cpp',
             '1b55ca7f3edf44e8e18b9f62503f5bbb3ec2595267dcf52a302b8a0d966a5899'),
    # Exploration 007 deliverable: SSE parse, byte table, single-digit return.
    'sse_short': ('work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed_io_sse.cpp',
                  'd2d02e0fd47c3c510ae62ddb23a91174c29643dc932f69a9aed912450b598304'),
    # User's Shoup "flip" kernel submission (judge 406400/406401), sse_short I/O,
    # prefaulted THP-hinted arena; prints compute_ms to stderr unless QPOLY_QUIET.
    'shoup': ('work/ntt/yosupo_convolution_shoup.cpp',
              '644e9f3ed8bdf0c008e9415d72426c0c66e8e73baf79283216031a3a7fb2cfe9'),
}
text = {}
for name, (path, digest) in SOURCES.items():
    data = (root / path).read_bytes()
    assert hashlib.sha256(data).hexdigest() == digest, path
    text[name] = data.decode()


def kernel(source):
    if 'namespace qflip {' in source:
        return source[source.index('namespace qflip {'):source.index('}  // namespace qflip')]
    return source[source.index('namespace kernel_asm_radix4_pair_large_fixed'):
                  source.index('// Selected uint32 I/O')]


# Parser/formatter code of sse_short for the in-memory microbenchmark.
(out / 'baseline_io.inc').write_text(text['sse_short'][text['sse_short'].index('// Selected uint32 I/O'):
                                                       text['sse_short'].index('constexpr int max_transform =')])


def sub(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def out_buffer(size):
    return lambda s: sub(s, 'std::array<char, 1u << 19> buffer_', f'std::array<char, {size}> buffer_')


def map_populate(s):
    return sub(s, 'MAP_PRIVATE | MAP_FIXED, 0, 0);', 'MAP_PRIVATE | MAP_FIXED | MAP_POPULATE, 0, 0);')


TRANSFORM_LENGTH = ('    { unsigned c = n + m - 1, len = 64; while (len < c) len *= 2;\n')
CHECK = '    if (n == 0 || m == 0 || n > (1u << 19) || m > (1u << 19)) return 1;\n'


def prefault(s):
    helper = '''// Not I/O: populate transform pages in one call instead of first-touch faults.
// Advisory; kernels before 5.14 reject it and ordinary page faults remain.
#ifndef MADV_POPULATE_WRITE
#define MADV_POPULATE_WRITE 23
#endif
static void populate_words(uint32_t* p, size_t words) {
    const uintptr_t begin = uintptr_t(p) & ~uintptr_t(4095);
    (void)::madvise(reinterpret_cast<void*>(begin), uintptr_t(p + words) - begin, MADV_POPULATE_WRITE);
}
int main() {'''
    s = sub(s, 'int main() {', helper)
    return sub(s, CHECK, CHECK + TRANSFORM_LENGTH + '      populate_words(a, len); populate_words(b, len); }\n')


def huge_pages(s):
    s = sub(s, 'alignas(32) static uint32_t a[max_transform], b[max_transform];', '''static uint32_t *a, *b;
// Not I/O: 2 MiB-aligned transform storage. MADV_HUGEPAGE is effective only when
// transparent huge pages are enabled as "madvise" or "always"; otherwise 4 KiB pages.
static uint32_t* huge_words(size_t words) {
    const size_t huge = size_t(1) << 21, bytes = (words * 4 + huge - 1) & ~(huge - 1);
    char* raw = static_cast<char*>(::mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE,
        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
    if (raw == MAP_FAILED) std::abort();
    char* aligned = reinterpret_cast<char*>((uintptr_t(raw) + huge - 1) & ~(huge - 1));
    (void)::madvise(aligned, bytes, MADV_HUGEPAGE);
    return reinterpret_cast<uint32_t*>(aligned);
}''')
    return sub(s, CHECK, CHECK + TRANSFORM_LENGTH + '      a = huge_words(len); b = huge_words(len); }\n')


VARIANTS = {
    'base': ('base', []),
    'sse_short': ('sse_short', []),
    'sse_short_ob64k': ('sse_short', [out_buffer('1u << 16')]),
    'sse_short_ob128k': ('sse_short', [out_buffer('1u << 17')]),
    'sse_short_ob256k': ('sse_short', [out_buffer('1u << 18')]),
    'sse_short_inpop': ('sse_short', [map_populate]),
    'sse_short_prefault': ('sse_short', [prefault]),
    'sse_short_thp': ('sse_short', [huge_pages]),
}
PHASES = ['base', 'sse_short', 'sse_short_prefault']
extra = here / 'extra_variants.py'
if extra.exists():  # Later rounds register parser/formatter variants here.
    exec(compile(extra.read_text(), str(extra), 'exec'))


def phases(s):
    """Clock marks: main entry, input mapped, parsed, NTT done, output written."""
    s = sub(s, '\nnamespace kernel_asm_radix4_pair_large_fixed {', '''
#include <time.h>
static long long qp_marks[5], qp_write_ns;
static inline long long qp_now() {
    timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec * 1000000000LL + t.tv_nsec;
}
namespace kernel_asm_radix4_pair_large_fixed {''')
    s = sub(s, 'const ssize_t count = ::write(1, data, remaining);',
            'const long long qp_w = qp_now(); const ssize_t count = ::write(1, data, remaining); '
            'qp_write_ns += qp_now() - qp_w;')
    s = sub(s, 'int main() {\n', 'int main() {\n    qp_marks[0] = qp_now();\n')
    s = sub(s, '    fastio_unsafe_impl::input in;\n',
            '    fastio_unsafe_impl::input in;\n    qp_marks[1] = qp_now();\n')
    s = sub(s, '    const unsigned count = n + m - 1;\n',
            '    qp_marks[2] = qp_now();\n    const unsigned count = n + m - 1;\n')
    s = sub(s, 'root_size, true);\n', 'root_size, true);\n    qp_marks[3] = qp_now();\n')
    return sub(s, '    out.finish(output_cursor);\n', '''    out.finish(output_cursor);
    qp_marks[4] = qp_now();
    dprintf(2, "QP %lld %lld %lld %lld %lld %lld\\n", qp_marks[0], qp_marks[1], qp_marks[2],
            qp_marks[3], qp_marks[4], qp_write_ns);
''')


selected = sys.argv[2].split(',') if len(sys.argv) > 2 else list(VARIANTS)
manifest = {}
for name in selected:
    source_name, transforms = VARIANTS[name]
    source = text[source_name]
    for transform in transforms:
        source = transform(source)
    assert kernel(source) == kernel(text[source_name]), name
    builds = {name: source}
    if name in PHASES:
        builds[name + '_phases'] = phases(source)
    for build, body in builds.items():
        (out / (build + '.cpp')).write_text(body)
        manifest[build] = hashlib.sha256(body.encode()).hexdigest()
(out / 'manifest.json').write_text(json.dumps(manifest, indent=1) + '\n')
print(json.dumps(manifest, indent=1))
