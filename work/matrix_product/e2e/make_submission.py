#!/usr/bin/env python3
"""Flatten a matrix_product program into one judge-ready C++ file.

usage: make_submission.py MAIN.cpp OUT.cpp [-DNAME=VALUE ...]
Local #include "..." lines are inlined recursively (each file once; '#pragma once' dropped);
-D options become #define lines at the top (variant selection). System includes stay.
"""
import pathlib
import re
import sys

main, out = pathlib.Path(sys.argv[1]).resolve(), pathlib.Path(sys.argv[2])
defines = [a[2:] for a in sys.argv[3:] if a.startswith('-D')]
seen = set()


def inline(path):
    path = path.resolve()
    if path in seen:
        return ''
    seen.add(path)
    text = []
    for line in path.read_text().splitlines():
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
out.write_text('\n'.join(head + [inline(main)]) + '\n')
print(out, len(out.read_text().splitlines()), 'lines')
