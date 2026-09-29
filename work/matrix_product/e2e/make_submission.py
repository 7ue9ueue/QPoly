#!/usr/bin/env python3
"""Flatten a matrix_product program into one judge-ready C++ file.

usage: make_submission.py MAIN.cpp OUT.cpp [-DNAME=VALUE ...] [--asm-only KERNEL] [--header FILE]
Local #include "..." lines are inlined recursively (each file once; '#pragma once' dropped);
-D options become #define lines at the top (variant selection). System includes stay.
--asm-only KERNEL replaces asm_kernels.hpp by a generated header holding only that kernel and
its tail (gen_asm.py --only). --header FILE puts FILE's text first (deliverable comment).
"""
import pathlib
import re
import sys

main, out = pathlib.Path(sys.argv[1]).resolve(), pathlib.Path(sys.argv[2])
args = sys.argv[3:]
defines = [a[2:] for a in args if a.startswith('-D')]
asm_only = args[args.index('--asm-only') + 1] if '--asm-only' in args else None
header = pathlib.Path(args[args.index('--header') + 1]).read_text() if '--header' in args else ''
seen = set()
replacement = {}
if asm_only:
    import subprocess
    import tempfile
    tmp = pathlib.Path(tempfile.mkdtemp()) / 'asm_one.hpp'
    gen = main.parent.parent / 'gen_asm.py'
    subprocess.run([sys.executable, str(gen), '--only', asm_only, '--out', str(tmp)], check=True, capture_output=True)
    text = tmp.read_text().replace('#include "simd.hpp"', '')
    replacement[(main.parent.parent / 'asm_kernels.hpp').resolve()] = text


def inline(path):
    path = path.resolve()
    if path in seen:
        return ''
    seen.add(path)
    text = []
    source = replacement.get(path, None)
    for line in (source if source is not None else path.read_text()).splitlines():
        m = re.match(r'\s*#\s*include\s+"([^"]+)"', line)
        if m:
            text.append(inline(path.parent / m.group(1)))
        elif re.match(r'\s*#\s*pragma\s+once', line):
            continue
        else:
            text.append(line)
    return '\n'.join(text)


head = []
for d in defines:
    name, _, value = d.partition('=')
    head.append(f'#define {name} {value}'.rstrip())
out.write_text(header + '\n'.join(head + [inline(main)]) + '\n')
print(out, len(out.read_text().splitlines()), 'lines')
