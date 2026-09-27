#!/usr/bin/env python3
"""Generate a Library Checker convolution_mod submission with the asm kernel.

Starts from work/ntt/yosupo_convolution_shoup.cpp (the exploration-008 deliverable,
kernel of submission 406403) and replaces only its kernel region (flip.hpp verbatim)
by kernels/qasm.hpp with the selected generated variants inlined; I/O, memory arena
and main() are unchanged apart from the kernel configuration.

usage: make_yosupo_asm.py --fwd 11 --inv 71 --leaf 5 --minh 4 [--bottom 3] [--out PATH]
       [--io sse|393435] [--quiet]
--io 393435 swaps in the input parser used before exploration 007 (QgQ submission 393435
as adapted in work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed_io393435.cpp,
SHA256 1b55ca7f...); output formatting is identical in both. --quiet prints compute_ms
to stderr only when compiled with -DQPOLY_TIMING (submission-ready default).
"""
import argparse
import hashlib
import re
from pathlib import Path

here = Path(__file__).resolve().parent
root = here.parents[2]


def blocks(text):
    """Generated function blocks: {name: text} for 'QA_AI void name(' ... '}' at column 0,
    including the preceding '// name:' comment line."""
    out = {}
    for m in re.finditer(r'(// (\w+):[^\n]*\n)?QA_AI void (\w+)\(.*?\n}\n', text, re.S):
        out[m.group(3)] = m.group(0)
    return out


def trimmed(fwd, inv, leaf, bottom, top=0, ident=0, scale=0, fwd4=0):
    bfly = (here / 'kernels/asm_bfly.inc').read_text()
    leafs = (here / 'kernels/asm_leaf.inc').read_text()
    bot = (here / 'kernels/asm_bottom.inc').read_text()
    fb, lb, bb = blocks(bfly), blocks(leafs), blocks(bot)
    # generated variant names from the dispatcher case lines
    case = lambda text, fn, v: re.search(rf'QA_AI void {fn}\(.*?case {v}: (\w+)\(', text, re.S).group(1)
    L = ['// Selected generated assembly (work/ntt/asm_explore/gen_asm.py output, trimmed).']
    names = {}
    ab = bool(re.search(rf'constexpr bool asm_is_ab\(int v\).*?case {fwd}:', bfly, re.S)) if fwd else False
    if fwd:
        names['fwd'] = case(bfly, 'fwd2_asm' if ab else 'fwd_asm', fwd)
        L.append(fb[names['fwd']])
    if inv:
        names['inv'] = case(bfly, 'inv_asm', inv)
        L.append(fb[names['inv']])
    step = lambda kind, v: int(re.search(rf'case {kind * 1000 + v}: return (\d+);', bfly).group(1)) if v else 1
    ab4 = bool(re.search(rf'constexpr bool asm_is_ab\(int v\).*?case {fwd4}:', bfly, re.S)) if fwd4 else False
    if fwd4:
        names['fwd4'] = case(bfly, 'fwd2_asm' if ab4 else 'fwd_asm', fwd4)
        L.append(fb[names['fwd4']])
    L.append(f'#define ASM_FWD_IDS " {fwd} {fwd4} "\n#define ASM_INV_IDS " {inv} "')
    L.append('constexpr int asm_step(int kind, int v) { return kind == 0 ? '
             f'(v == {fwd} ? {step(0, fwd)} : v == {fwd4 or -1} ? {step(0, fwd4)} : 1) : (v == {inv} ? {step(1, inv)} : 1); }}')
    L.append(f'constexpr bool asm_has(int kind, int v) {{ return kind == 0 ? (v == {fwd} || v == {fwd4 or -1}) : v == {inv}; }}')
    L.append(f'constexpr bool asm_is_ab(int v) {{ return {"true" if ab else "false"} && v == {fwd} || {"true" if ab4 else "false"} && v == {fwd4 or -1}; }}')
    single = [(v, names[k]) for k, v, is_ab in (('fwd', fwd, ab), ('fwd4', fwd4, ab4)) if v and not is_ab]
    pair = [(v, names[k]) for k, v, is_ab in (('fwd', fwd, ab), ('fwd4', fwd4, ab4)) if v and is_ab]
    L.append('QA_AI void fwd_asm(int v, V* f, long h, const U* px, const U* py) { '
             + ''.join(f'if (v == {v}) {{ {n}(f, h, px, py); return; }} ' for v, n in single) + '__builtin_unreachable(); }')
    L.append('QA_AI void inv_asm(int, V* f, long h, const U* px, const U* py) { '
             + (f'{names["inv"]}(f, h, px, py); ' if inv else '__builtin_unreachable(); ') + '}')
    L.append('QA_AI void fwd2_asm(int v, V* a, V* b, long h, const U* px, const U* py) { '
             + ''.join(f'if (v == {v}) {{ {n}(a, b, h, px, py); return; }} ' for v, n in pair)
             + 'fwd_asm(v, a, h, px, py); fwd_asm(v, b, h, px, py); }')
    if leaf >= 2:
        L.append(lb[f'leaf_mac_asm{leaf}'])
        L.append(f'QA_AI void leaf_mac_asm(int, V* a, const void* L) {{ leaf_mac_asm{leaf}(a, L); }}')
    else:
        L.append('QA_AI void leaf_mac_asm(int, V*, const void*) { __builtin_unreachable(); }')
    L.append('#define ASM_LEAF_MAX 8')
    args = {'s1': 'an, bn, Ln, px, py, lw', 's2': 'ac, Lc, ipx, ipy',
            's12': 'an, bn, Ln, px, py, lw, ac, Lc, ipx, ipy'}
    for part, a in args.items():
        decl = ', '.join(f'const void* {x.strip()}' for x in a.split(','))
        if bottom:
            L.append(bb[f'bottom{bottom}_{part}'])
            L.append(f'QA_AI void bottom_{part}(int, {decl}) {{ bottom{bottom}_{part}({a}); }}')
        else:
            L.append(f'QA_AI void bottom_{part}(int, {decl}) {{ __builtin_unreachable(); }}')
    if top:
        L.append(fb[f'fwd_src{top}'])
        L.append(f'QA_AI void fwd_src_asm(int, V* f, const V* src, long h, const U* px, const U* py) '
                 f'{{ fwd_src{top}(f, src, h, px, py); }}')
        st = re.search(rf'constexpr int asm_src_step\(int v\).*?case {top}: return (\d+);', bfly).group(1)
        L.append(f'constexpr int asm_src_step(int) {{ return {st}; }}')
    else:
        L.append('QA_AI void fwd_src_asm(int, V*, const V*, long, const U*, const U*) { __builtin_unreachable(); }')
        L.append('constexpr int asm_src_step(int) { return 1; }')
    for kind, v in (('fid', ident), ('iid', ident), ('scale', scale)):
        if v:
            L.append(fb[f'{kind}_asm{v}'])
            st = re.search(rf'constexpr int {kind}_step\(int v\).*?case {v}: return (\d+);', bfly).group(1)
            L.append(f'QA_AI void {kind}_asm(int, V* f, long h, const U* px, const U* py) {{ {kind}_asm{v}(f, h, px, py); }}')
            L.append(f'constexpr int {kind}_step(int) {{ return {st}; }}')
        else:
            L.append(f'QA_AI void {kind}_asm(int, V*, long, const U*, const U*) {{ __builtin_unreachable(); }}')
            L.append(f'constexpr int {kind}_step(int) {{ return 0; }}')
    L.append(f'#define ASM_BOTTOM_IDS " {bottom} "')
    L.append(f'constexpr bool asm_bottom_has(int v) {{ return v == {bottom}; }}')
    return '\n'.join(L) + '\n'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--fwd', type=int, required=True)
    ap.add_argument('--inv', type=int, required=True)
    ap.add_argument('--leaf', type=int, default=0)
    ap.add_argument('--minh', type=int, default=4)
    ap.add_argument('--bottom', type=int, default=0)
    ap.add_argument('--top', type=int, default=0)
    ap.add_argument('--id', type=int, default=0)
    ap.add_argument('--fwd4', type=int, default=0)
    ap.add_argument('--scale', type=int, default=0)
    ap.add_argument('--out', default=str(root / 'work/ntt/yosupo_convolution_asm_shoup.cpp'))
    ap.add_argument('--io', choices=['sse', '393435'], default='sse')
    ap.add_argument('--quiet', action='store_true')
    args = ap.parse_args()
    base_path = root / 'work/ntt/yosupo_convolution_shoup.cpp'
    base = base_path.read_text()
    kernel = (here / 'kernels/qasm.hpp').read_text()
    kernel = kernel.replace('#pragma once\n', '')
    kernel = re.sub(r'#include <[a-z_]+(\.h)?>\n', '', kernel)
    sel = trimmed(args.fwd, args.inv, args.leaf, args.bottom, args.top, args.id, args.scale, args.fwd4)
    kernel = kernel.replace('#include "asm_bfly.inc"\n#include "asm_leaf.inc"\n#include "asm_bottom.inc"\n', sel)
    assert '#include "' not in kernel
    start = base.index('// Round-7 kernel family "flip"')
    end = base.index('}  // namespace qflip') + len('}  // namespace qflip')
    cfg_old = 'qflip::Kernel<qflip::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true>>'
    cfg_new = (f'qasm::Kernel<qasm::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true, '
               f'{args.fwd}, {args.inv}, {args.leaf}, {args.minh}, {args.bottom}, {args.top}, {args.id}, {args.scale}, {args.fwd4}>>')
    assert base.count(cfg_old) == 1
    src = base[:start] + kernel + base[end:]
    src = src.replace(cfg_old, cfg_new)
    khash = hashlib.sha256((here / 'kernels/qasm.hpp').read_bytes()).hexdigest()
    head_old = src[:src.index('#if defined(__GNUC__)')]
    head_new = (f'// Library Checker convolution_mod (https://judge.yosupo.jp/problem/convolution_mod).\n'
                f'// Generated by work/ntt/asm_explore/make_yosupo_asm.py from {base_path.relative_to(root)}\n'
                f'// (SHA256 {hashlib.sha256(base.encode()).hexdigest()}, the submission-406403 kernel)\n'
                f'// with the kernel replaced by kernels/qasm.hpp (SHA256 {khash}) and generated\n'
                f'// inline assembly: forward loop {args.fwd} (h=4: {args.fwd4 or args.fwd}), inverse loop {args.inv} (h >= {args.minh}), '
                f'leaf {args.leaf}, fused bottom {args.bottom}, copy-free top {args.top}, identity {args.id}, scale {args.scale}.\n'
                '// Arithmetic, ranges, memory layout, I/O and main() are those of the base file:\n'
                + ''.join('// ' + l[3:] + '\n' for l in head_old.splitlines()[7:] if l.startswith('// ')))
    src = head_new + src[len(head_old):]
    if args.io == '393435':
        old_path = root / 'work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed_io393435.cpp'
        old = old_path.read_text()
        marker = "// Selected uint32 I/O from QgQ's submission 393435"
        old_io = old[old.index(marker):old.index('constexpr int max_transform')]
        start, end = src.index(marker), src.index('// Pre-faulted 2 MiB-aligned zeroed words')
        src = src[:start] + old_io + '\n' + src[end:]
        assert src.count('read_sse_short(input_cursor)') == 4
        src = src.replace('read_sse_short(input_cursor)', 'read_mod998_u32(input_cursor)')
        note_old = ('// I/O: sse_short_lut8 from work/ntt/yosupo_convolution_asm_radix4_pair_large_fixed_io_sse.cpp\n'
                    '// (exploration 007), adapted from QgQ')
        note_new = (f'// I/O: pre-exploration-007 reader/writer from {old_path.relative_to(root)}\n'
                    f'// (SHA256 {hashlib.sha256(old.encode()).hexdigest()[:16]}...; exploration 006), adapted from QgQ')
        assert note_old in src
        src = src.replace(note_old, note_new)
    if args.quiet:
        for old_s, new_s in (('// Prints the transform time to stderr (compute_ms=...) unless QPOLY_QUIET is defined.',
                              '// Prints the transform time to stderr (compute_ms=...) only with -DQPOLY_TIMING.'),
                             ('#ifndef QPOLY_QUIET\n', '#ifdef QPOLY_TIMING\n')):
            assert src.count(old_s) == 1, old_s
            src = src.replace(old_s, new_s)
    Path(args.out).write_text(src)
    print(Path(args.out).relative_to(root) if Path(args.out).is_relative_to(root) else args.out,
          len(src), 'bytes, SHA256', hashlib.sha256(src.encode()).hexdigest())


if __name__ == '__main__':
    main()
