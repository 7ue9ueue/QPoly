#!/usr/bin/env python3
"""End-to-end checks (copy of work/ntt/verify_yosupo_convolution.py that also accepts
the optional compute_ms=... stderr line). usage: script SOLUTION SCALAR_REFERENCE [--quick]."""
import random
import re
import subprocess
import sys
import tempfile

P = 998244353
rng = random.Random(20260927)
solution, reference = sys.argv[1:3]
quick = '--quick' in sys.argv[3:]
checks = 0


def check(a, b, *, mode='pipe', trailing='\n', page=0, known=None):
    global checks
    data = (f'{len(a)} {len(b)}\n' + ' '.join(map(str, a)) + '\n'
            + ' '.join(map(str, b)) + trailing).encode()
    if page:
        data = b' ' * ((-len(data)) % page) + data
        assert len(data) % page == 0
    if known is not None:
        want = known
    elif len(a) * len(b) <= 20000:
        want = [0] * (len(a) + len(b) - 1)
        for i, x in enumerate(a):
            for j, y in enumerate(b):
                want[i+j] = (want[i+j] + x*y) % P
    else:
        want = list(map(int, subprocess.run([reference], input=data,
                    capture_output=True, check=True).stdout.split()))
    if mode == 'file':
        with tempfile.TemporaryFile() as f:
            f.write(data)
            f.seek(0)
            result = subprocess.run([solution], stdin=f, capture_output=True, check=True)
    else:
        result = subprocess.run([solution], input=data, capture_output=True, check=True)
    got = list(map(int, result.stdout.split()))
    assert got == want, (len(a), len(b), mode, 'coefficient mismatch')
    assert result.stdout.endswith(b'\n') and re.fullmatch(rb'(compute_ms=[0-9.]+\n)?', result.stderr), result.stderr
    checks += 1


check([1, 2, 3, 4], [5, 6, 7, 8, 9], known=[5, 16, 34, 60, 70, 70, 59, 36])
check([10000000], [10000000], known=[871938225])
digits = [0, 1, 9, 10, 99, 100, 999, 1000, 9999, 10000, 99999, 100000,
          999999, 1000000, 9999999, 10000000, 99999999, 100000000, P-1]
for mode in ('pipe', 'file'):
    check([1], digits, mode=mode, trailing='')
    for page in (4096, 16384):
        check([P-1], [P-1], mode=mode, trailing='', page=page)
    for n, m in ((1, 1), (2, 3), (31, 32), (32, 33), (33, 33), (63, 65), (129, 3)):
        for value in (0, 1, P-1):
            check([value]*n, [value]*m, mode=mode)
for _ in range(80):
    n, m = rng.randint(1, 100), rng.randint(1, 100)
    check([rng.randrange(P) for _ in range(n)], [rng.randrange(P) for _ in range(m)])
for lg in range(6, 13 if quick else 20):
    for delta in (-1, 0, 1):
        n, m = (1 << (lg-1)), (1 << (lg-1)) + delta
        check([rng.randrange(P) for _ in range(n)], [rng.randrange(P) for _ in range(m)],
              mode='file' if delta == 0 else 'pipe', trailing='' if delta == 1 else '\n')
if not quick:
    n = 1 << 19
    a, b = [rng.randrange(P) for _ in range(n)], [rng.randrange(P) for _ in range(n)]
    check(a, b, mode='file')
    check(a, b, mode='pipe')  # Multiple fread chunks and output-buffer flushes.
    check([P-1]*n, [P-1]*n, known=list(range(1, n+1)) + list(range(n-1, 0, -1)))
    check([1], b, known=b)
print(f'PASS {checks} end-to-end cases; samples, brute force, independent radix-2, '
      f'file/pipe I/O, exact-page EOF; maximum transform 2^{13 if quick else 20}')
