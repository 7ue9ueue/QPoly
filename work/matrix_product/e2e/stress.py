#!/usr/bin/env python3
"""End-to-end stress test: stress.py REFERENCE_BIN WORKDIR BIN [BIN ...].

Generates deterministic inputs in the official format (random shapes from 1 to 1024 with a
bias to small, odd, power-of-two and Strassen-padding boundaries; random, all-extreme and
mixed-extreme values), runs every program with the input as a regular file (mmap path) and,
for a subset, through a pipe (fallback path), and requires the same whitespace-separated
tokens as the reference (the official model solution), i.e. the problem's testlib wcmp checker. Exits non-zero on the first mismatch.
"""
import os
import random
import subprocess
import sys

P = 998244353
ref, work, bins = sys.argv[1], sys.argv[2], sys.argv[3:]
os.makedirs(work, exist_ok=True)
rng = random.Random(20260930)
EXT = [0, 1, 2, P // 2 - 1, (P - 1) // 2, (P + 1) // 2, P - 2, P - 1]


def dim():
    r = rng.random()
    if r < 0.30:
        return rng.randint(1, 40)
    if r < 0.50:
        return rng.choice([63, 64, 65, 127, 128, 129, 255, 256, 257, 511, 512, 513, 1023, 1024])
    if r < 0.65:
        return rng.randint(1, 8) * 32 + rng.choice([-1, 0, 1])
    return rng.randint(1, 1024)


def values(count, mode):
    if mode == 0:
        return [rng.randrange(P) for _ in range(count)]
    if mode == 1:
        v = rng.choice(EXT)
        return [v] * count
    return [rng.choice(EXT) for _ in range(count)]


def case(n, m, k, mode):
    lines = [f'{n} {m} {k}']
    a = values(n * m, mode)
    b = values(m * k, mode)
    for i in range(n):
        lines.append(' '.join(map(str, a[i * m:(i + 1) * m])))
    for i in range(m):
        lines.append(' '.join(map(str, b[i * k:(i + 1) * k])))
    return ('\n'.join(lines) + '\n').encode()


cases = [(1, 1, 1, 0), (1, 1024, 1, 0), (1024, 1, 1024, 1), (1024, 1024, 1, 2), (1, 1, 1024, 0),
         (1024, 1024, 1024, 1), (1024, 1024, 1024, 2), (999, 1000, 1001, 0), (4, 1024, 8, 1)]
budget = 0
while len(cases) < 160:
    n, m, k = dim(), dim(), dim()
    if n * m * k > 2.5e8 and budget > 8:
        continue
    budget += n * m * k > 2.5e8
    cases.append((n, m, k, rng.choice([0, 0, 0, 1, 2])))
path = os.path.join(work, 'stress.in')
for idx, (n, m, k, mode) in enumerate(cases):
    data = case(n, m, k, mode)
    with open(path, 'wb') as f:
        f.write(data)
    with open(path, 'rb') as f:
        want = subprocess.run([ref], stdin=f, capture_output=True, check=True).stdout
    for b in bins:
        with open(path, 'rb') as f:
            got = subprocess.run([b], stdin=f, capture_output=True, check=True).stdout
        if got != want and got.split() != want.split():
            print(f'FAIL {os.path.basename(b)} case {idx} n={n} m={m} k={k} mode={mode}')
            sys.exit(1)
        if idx % 8 == 0:  # pipe input exercises the non-mmap reader
            got = subprocess.run([b], input=data, capture_output=True, check=True).stdout
            if got != want and got.split() != want.split():
                print(f'FAIL(pipe) {os.path.basename(b)} case {idx} n={n} m={m} k={k} mode={mode}')
                sys.exit(1)
print(f'PASS stress: {len(cases)} cases x {len(bins)} programs token-identical to the model solution')
