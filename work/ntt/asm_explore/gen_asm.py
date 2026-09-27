#!/usr/bin/env python3
"""Generates inline-assembly radix-4 Shoup butterfly loops (exploration 009).

Each butterfly is built as a dataflow graph of AVX2 instructions, scheduled
(several strategies), register-allocated onto ymm0..ymm15 and emitted as one
GCC extended-asm statement containing the whole j loop. The arithmetic is that
of qflip::fwd4/inv4 with Mul=2 (Shoup) and LdOdd (forward):

  forward (inputs/outputs < 4P, Cooley-Tukey):
    a=low(f0) b=low(f1) c=x*f2 d=x*f3        (odd lanes of f2,f3 from f+4 bytes)
    ac=low(a+c) amc=low(a-c) bd=b+d bmd=b-d+2P
    out = ac+y*bd, ac-y*bd+2P, amc+z*bmd, amc-z*bmd+2P
  inverse (inputs/outputs < 2P, Gentleman-Sande):
    ab=low(a+b) cd=low(c+d) amb=y*(a-b+2P) cmd=z*(c-d+2P)
    out = low(ab+cd), low(amb+cmd), x*(ab-cd+2P), x*(amb-cmd+2P)
  Shoup: q = hi32(v*wi) per lane, r = v*w - q*P mod 2^32, r in [0,2P) for any v.
  low(v) = min(v, v-2P). The forward low(a-c) is min(t, t+2P) with t = a-c:
  for a,c < 2P this equals min(a-c+2P, a-c) and saves one instruction.

Register conventions: ymm15 = P, ymm14 = 2P; twiddles (w, wi for x,y,z) in
ymm8..13, or in a 32-byte aligned stack array used as memory operands (twmem).

Strategies
  df    one butterfly per iteration in dataflow (source) order
  ls    one butterfly per iteration, list-scheduled on a Zen 3 model
  ls2   two butterflies per iteration, list-scheduled together
  sp    software pipelined: loads/first half of butterfly j+1 with the
        second half of butterfly j (carried values in fixed registers)
  sp2   software pipelined with two butterflies per stage
fold: loads folded into instructions as memory operands where legal (a load
used twice is then read twice from L1); otherwise one explicit load each.

Usage: gen_asm.py [--mca] [--tries N]   (writes kernels/asm_bfly.inc, kernels/asm_leaf.inc)
"""
import argparse
import itertools
import os
import re
import subprocess
import sys
import tempfile

# Zen 3 model (uops.info; probe.cpp re-measures the uncertain entries).
LAT = {'vpmuludq': 3, 'vpmulld': 3, 'vpsrlq': 1, 'vpaddd': 1, 'vpsubd': 1,
       'vpminud': 1, 'vpblendd': 1, 'vpaddq': 1}
CLS = {'vpmuludq': 'mul', 'vpmulld': 'mul', 'vpsrlq': 'shf', 'vpaddd': 'alu',
       'vpsubd': 'alu', 'vpminud': 'alu', 'vpblendd': 'alu', 'vpaddq': 'alu'}
COMMUTATIVE = {'vpaddd', 'vpminud', 'vpmuludq', 'vpmulld', 'vpaddq'}
LOADS = ('vmovdqa', 'vmovdqu', 'vbroadcastss')
LOAD_LAT = 8


class AllocError(Exception):
    pass


class Val:
    """kind 'reg': computed value; 'mem': data memory operand (slot, disp);
    'creg': constant register; 'cmem': constant memory operand (stack twiddles)."""
    _ids = itertools.count()

    def __init__(self, kind, name, mem=None, reg=None):
        self.kind, self.name, self.mem, self.reg = kind, name, mem, reg
        self.id = next(Val._ids)

    @property
    def is_mem(self):
        return self.kind in ('mem', 'cmem')

    def __repr__(self):
        return self.name


class Op:
    def __init__(self, mn, dst, srcs, imm=None, store=None):
        self.mn, self.dst, self.srcs, self.imm, self.store = mn, dst, srcs, imm, store
        self.stage = 0

    def __repr__(self):
        return f'{self.mn} {self.dst} <- {self.srcs}'


class Builder:
    def __init__(self, consts, fold, tag, disp, bank=0):
        self.ops, self.c, self.fold, self.tag, self.disp = [], consts, fold, tag, disp
        self.bank = bank   # 0: array at %[p], 1: array at %[q] (forward "ab" variants)
        self.share_bcast = True   # one broadcast per (base, disp) per builder
        self.loaded = {}          # data mem Val id (or broadcast key) -> register Val

    def at(self, name, base, disp, fold=None):
        """Vector at disp(%[base]) (bottom stage)."""
        v = Val('mem', f'{name}{self.tag}', mem=(base, disp))
        return v if (self.fold if fold is None else fold) else self.materialize(v)

    def scalar(self, name, base, disp):
        return Val('bmem', f'{name}{self.tag}', mem=(base, disp))

    def store_at(self, v, base, disp):
        self.ops.append(Op('vmovdqa', None, [v], store=(base, disp)))

    def materialize(self, v):
        if v.kind == 'bmem':          # scalar in memory, broadcast to all lanes
            key = ('b',) + v.mem
            if self.share_bcast and key in self.loaded:
                return self.loaded[key]
            d = Val('reg', v.name + 'r')
            self.ops.append(Op('vbroadcastss', d, [v]))
            if self.share_bcast:
                self.loaded[key] = d
            return d
        if v.kind != 'mem':
            return v
        if v.id not in self.loaded:
            d = Val('reg', v.name + 'r')
            aligned = v.mem[1] % 32 == 0
            self.ops.append(Op('vmovdqa' if aligned else 'vmovdqu', d, [v]))
            self.loaded[v.id] = d
        return self.loaded[v.id]

    def mem(self, name, slot, extra=0):
        v = Val('mem', f'{name}{self.tag}', mem=(4 * self.bank + slot, self.disp + extra))
        return v if self.fold else self.materialize(v)

    def op(self, mn, name, *srcs, imm=None):
        srcs = [self.materialize(s) if s.kind == 'bmem' else self.loaded.get(s.id, s) for s in srcs]
        if mn == 'vpsubd' or mn == 'vpblendd':
            srcs[0] = self.materialize(srcs[0])      # only the second source may be memory
            if srcs[0].kind == 'cmem':
                raise AllocError('constant minuend in memory')
        elif mn in COMMUTATIVE and srcs[0].is_mem and srcs[1].is_mem:
            data = 0 if srcs[0].kind == 'mem' else 1
            srcs[data] = self.materialize(srcs[data])
        d = Val('reg', f'{name}{self.tag}')
        self.ops.append(Op(mn, d, list(srcs), imm))
        return d

    def store(self, v, slot):
        self.ops.append(Op('vmovdqa', None, [v], store=(4 * self.bank + slot, self.disp)))

    def low(self, x, name):          # min(x, x - 2P)
        return self.op('vpminud', name, x, self.op('vpsubd', name + 't', x, self.c['P2']))

    def low_signed(self, t, name):   # min(t, t + 2P) for t in (-2P, 2P)
        return self.op('vpminud', name, t, self.op('vpaddd', name + 'u', t, self.c['P2']))

    def diff(self, x, y, name):      # x + 2P - y
        return self.op('vpsubd', name, self.op('vpaddd', name + 'p', x, self.c['P2']), y)

    def shoup(self, x, xo, w, wi, name):
        if xo is None:
            xo = self.op('vpsrlq', name + 'o', x, imm=32)
        qe = self.op('vpmuludq', name + 'qe', x, wi)
        qo = self.op('vpmuludq', name + 'qo', xo, wi)
        qs = self.op('vpsrlq', name + 'qs', qe, imm=32)
        q = self.op('vpblendd', name + 'q', qs, qo, imm=0xAA)    # odd lanes from qo
        xw = self.op('vpmulld', name + 'xw', x, w)
        qp = self.op('vpmulld', name + 'qp', q, self.c['P'])
        return self.op('vpsubd', name, xw, qp)


def fwd_graph(b):
    c = b.c
    f0, f1, f2, f3 = (b.mem(f'f{i}', i) for i in range(4))
    f2o, f3o = b.mem('f2o', 2, 4), b.mem('f3o', 3, 4)
    a = b.low(f0, 'a'); bb = b.low(f1, 'b')
    cc = b.shoup(f2, f2o, c['WX'], c['WIX'], 'c')
    dd = b.shoup(f3, f3o, c['WX'], c['WIX'], 'd')
    ac = b.low(b.op('vpaddd', 's', a, cc), 'ac')
    amc = b.low_signed(b.op('vpsubd', 't', a, cc), 'amc')
    bd = b.op('vpaddd', 'bd', bb, dd); bmd = b.diff(bb, dd, 'bmd')
    split = len(b.ops)
    y = b.shoup(bd, None, c['WY'], c['WIY'], 'y')
    z = b.shoup(bmd, None, c['WZ'], c['WIZ'], 'z')
    b.store(b.op('vpaddd', 'o0', ac, y), 0)
    b.store(b.diff(ac, y, 'o1'), 1)
    b.store(b.op('vpaddd', 'o2', amc, z), 2)
    b.store(b.diff(amc, z, 'o3'), 3)
    for o in b.ops[split:]:
        o.stage = 1
    return [ac, amc, bd, bmd]


def inv_graph(b):
    c = b.c
    f0, f1, f2, f3 = (b.mem(f'f{i}', i) for i in range(4))
    ab = b.low(b.op('vpaddd', 'sab', f0, f1), 'ab')
    cd = b.low(b.op('vpaddd', 'scd', f2, f3), 'cd')
    amb = b.shoup(b.diff(f0, f1, 'eamb'), None, c['WY'], c['WIY'], 'y')
    cmd = b.shoup(b.diff(f2, f3, 'ecmd'), None, c['WZ'], c['WIZ'], 'z')
    split = len(b.ops)
    b.store(b.low(b.op('vpaddd', 's0', ab, cd), 'o0'), 0)
    b.store(b.low(b.op('vpaddd', 's1', amb, cmd), 'o1'), 1)
    b.store(b.shoup(b.diff(ab, cd, 'e2'), None, c['WX'], c['WIX'], 'x2'), 2)
    b.store(b.shoup(b.diff(amb, cmd, 'e3'), None, c['WX'], c['WIX'], 'x3'), 3)
    for o in b.ops[split:]:
        o.stage = 1
    return [ab, cd, amb, cmd]


GRAPHS = {'fwd': fwd_graph, 'inv': inv_graph}


def constants(twmem):
    """twmem: False = all six twiddle vectors in ymm8..13; True = all six as
    stack memory operands; 'half' = quotients wi in ymm11..13, values w in memory."""
    c = {'P': Val('creg', 'P', reg=15), 'P2': Val('creg', 'P2', reg=14)}
    reserved = {14, 15}
    for i, n in enumerate(['WX', 'WIX', 'WY', 'WIY', 'WZ', 'WIZ']):
        if twmem is True or (twmem == 'half' and not n.startswith('WI')):
            c[n] = Val('cmem', n, mem=('tw', 32 * i))
        else:
            r = 8 + i if twmem is False else 11 + i // 2
            c[n] = Val('creg', n, reg=r)
            reserved.add(r)
    return c, reserved


def butterflies(kind, count, fold, twmem, tag, disp0=0, ab=False):
    """count butterflies per step; ab: alternate arrays a (%[p]) and b (%[q]),
    i.e. butterfly j of a and of b share the step (forward only)."""
    c, reserved = constants(twmem)
    ops, carried = [], []
    for k in range(count):
        if ab:
            b = Builder(c, fold, f'_{tag}{k}', disp0 + 32 * (k // 2), bank=k % 2)
        else:
            b = Builder(c, fold, f'_{tag}{k}', disp0 + 32 * k)
        carried += GRAPHS[kind](b)
        ops += b.ops
    return ops, carried, reserved


# ------------------------------------------------------------- scheduling
def op_class(o):
    if o.store is not None:
        return 'st'
    if o.mn in LOADS:
        return 'ld'
    return CLS[o.mn]


def n_mem(o):
    return sum(1 for s in o.srcs if s.is_mem)


def list_schedule(ops, extra_deps=(), loads_per_cycle=2, budget=None, pinned=(), live_out=()):
    """Cycle-driven list scheduling: 4 FP pipes (mul on 2, shift on 2, alu on
    any), `loads_per_cycle` loads (explicit or folded) and one store per cycle.
    Priority: longest latency path to a sink. With `budget`, an op is issued only
    if the number of live (unpinned) registers stays within it, counted exactly
    as allocate() does (a source dying at an op frees its register for the
    destination). Returns ops in issue order."""
    if budget is not None:
        return _pressure_schedule(ops, extra_deps, loads_per_cycle, budget, set(pinned), live_out)
    producer = {o.dst.id: o for o in ops if o.dst is not None}
    preds = {id(o): [producer[s.id] for s in o.srcs if s.kind == 'reg' and s.id in producer] for o in ops}
    for a, b in extra_deps:
        preds[id(b)].append(a)
    succs = {id(o): [] for o in ops}
    for o in ops:
        for p in preds[id(o)]:
            succs[id(p)].append(o)
    lat = {id(o): LOAD_LAT if op_class(o) == 'ld' else 1 if op_class(o) == 'st' else LAT[o.mn] for o in ops}
    prio = {}

    def pr(o):
        if id(o) not in prio:
            prio[id(o)] = lat[id(o)] + max((pr(s) for s in succs[id(o)]), default=0)
        return prio[id(o)]
    for o in ops:
        pr(o)
    index = {id(o): i for i, o in enumerate(ops)}
    finish, order, cycle, remaining = {}, [], 0, list(ops)
    while remaining:
        cap = {'mul': 2, 'shf': 2, 'fp': 4, 'ld': loads_per_cycle, 'st': 1}
        ready = [o for o in remaining if all(id(p) in finish and finish[id(p)] <= cycle for p in preds[id(o)])]
        ready.sort(key=lambda o: (-prio[id(o)], index[id(o)]))
        for o in ready:
            cl, nm = op_class(o), n_mem(o)
            if cap['ld'] < nm:
                continue
            if cl in ('mul', 'shf', 'alu'):
                if cap['fp'] == 0 or (cl != 'alu' and cap[cl] == 0):
                    continue
                cap['fp'] -= 1
                if cl != 'alu':
                    cap[cl] -= 1
            elif cap[cl] == 0:
                continue
            else:
                cap[cl] -= 1
            cap['ld'] -= nm
            finish[id(o)] = cycle + lat[id(o)]
            remaining.remove(o)
            order.append(o)
        cycle += 1
    return order


SEARCH = {'rng': None, 'margin': 0, 'noise': 0.0, 'load_lat': LOAD_LAT, 'lpc': 2, 'window': None}   # set by generate()


def _pressure_schedule(ops, extra_deps, loads_per_cycle, budget, pinned, live_out):
    rng, margin, noise = SEARCH['rng'], SEARCH['margin'], SEARCH['noise']
    loads_per_cycle, load_lat = SEARCH['lpc'], SEARCH['load_lat']
    jitter = {id(o): (rng.random() * noise if rng else 0.0) for o in ops}
    producer = {o.dst.id: o for o in ops if o.dst is not None}
    preds = {id(o): [producer[s.id] for s in o.srcs if s.kind == 'reg' and s.id in producer] for o in ops}
    for a, b in extra_deps:
        preds[id(b)].append(a)
    succs = {id(o): [] for o in ops}
    for o in ops:
        for p in preds[id(o)]:
            succs[id(p)].append(o)
    lat = {id(o): load_lat if op_class(o) == 'ld' else 1 if op_class(o) == 'st' else LAT[o.mn] for o in ops}
    prio = {}

    def pr(o):
        if id(o) not in prio:
            prio[id(o)] = lat[id(o)] + max((pr(s) for s in succs[id(o)]), default=0)
        return prio[id(o)]
    for o in ops:
        pr(o)
    uses = {}
    for o in ops:
        for sid in {s.id for s in o.srcs if s.kind == 'reg'}:
            uses[sid] = uses.get(sid, 0) + 1
    keep = {v.id for v in live_out}
    index = {id(o): i for i, o in enumerate(ops)}
    finish, order, cycle, remaining, live = {}, [], 0, list(ops), 0

    def delta(o):
        dying = sum(1 for sid in {s.id for s in o.srcs if s.kind == 'reg'}
                    if sid not in pinned and sid not in keep and uses[sid] == 1)
        new = 1 if o.dst is not None and o.dst.id not in pinned else 0
        return dying, new
    stall = 0
    while remaining:
        cap = {'mul': 2, 'shf': 2, 'fp': 4, 'ld': loads_per_cycle, 'st': 1}
        window = SEARCH['window']
        cand = remaining[:window] if window else remaining
        ready = [o for o in cand if all(id(p) in finish and finish[id(p)] <= cycle for p in preds[id(o)])]
        def key(o):
            dying, new = delta(o)
            grow = new - dying > 0 and live - dying + new > budget - margin
            return (grow, -prio[id(o)] - jitter[id(o)], index[id(o)])
        ready.sort(key=key)
        issued = False
        for o in ready:
            cl, nm = op_class(o), n_mem(o)
            if cap['ld'] < nm:
                continue
            if cl in ('mul', 'shf', 'alu'):
                if cap['fp'] == 0 or (cl != 'alu' and cap[cl] == 0):
                    continue
            elif cap[cl] == 0:
                continue
            dying, new = delta(o)
            if live - dying + new > budget:
                continue
            if cl in ('mul', 'shf', 'alu'):
                cap['fp'] -= 1
                if cl != 'alu':
                    cap[cl] -= 1
            else:
                cap[cl] -= 1
            cap['ld'] -= nm
            live += new - dying
            for sid in {s.id for s in o.srcs if s.kind == 'reg'}:
                uses[sid] -= 1
            finish[id(o)] = cycle + lat[id(o)]
            remaining.remove(o)
            order.append(o)
            issued = True
        stall = 0 if issued or any(f > cycle for f in finish.values()) else stall + 1
        if stall > 2:
            raise AllocError('register budget deadlock')
        cycle += 1
    return order


# ------------------------------------------------------------ register alloc
def allocate(seq, reserved, pinned=None, live_in=(), live_out=()):
    """Linear scan. pinned: {val id: reg}; pinned registers are never handed
    out to other values. live_in values are live at entry, live_out at exit."""
    pinned = dict(pinned or {})
    pinned_regs = set(pinned.values())
    last = {}
    for i, o in enumerate(seq):
        for s in o.srcs:
            if s.kind == 'reg':
                last[s.id] = i
    for v in live_out:
        last[v.id] = len(seq)
    free = [r for r in range(16) if r not in reserved and r not in pinned_regs]
    free.reverse()
    assign, live = dict(pinned), {}
    for v in live_in:
        live[assign[v.id]] = v.id
    for i, o in enumerate(seq):
        for s in o.srcs:
            if s.kind == 'reg' and last.get(s.id) == i:
                r = assign[s.id]
                if live.get(r) == s.id:
                    del live[r]
                    if r not in pinned_regs:
                        free.append(r)
        if o.dst is None:
            continue
        if o.dst.id not in last:
            raise AllocError(f'dead value {o.dst}')
        if o.dst.id in pinned:
            r = pinned[o.dst.id]
            if r in live:
                raise AllocError(f'pinned ymm{r} still live at {o}')
        elif not free:
            raise AllocError(f'out of registers at {i}: {o}')
        else:
            r = free.pop()
        assign[o.dst.id] = r
        live[r] = o.dst.id
    return assign


# ------------------------------------------------------------------ emitter
SLOT = {0: '(%[p])', 1: '(%[p],%[H])', 2: '(%[p],%[H],2)', 3: '(%[p],%[H3])',
        4: '(%[q])', 5: '(%[q],%[H])', 6: '(%[q],%[H],2)', 7: '(%[q],%[H3])'}


def operand(v, assign):
    if v.kind in ('mem', 'bmem'):
        slot, disp = v.mem
        if isinstance(slot, str):
            return f'{disp}(%[{slot}])'
        return (str(disp) if disp else '') + SLOT[slot]
    if v.kind == 'cmem':
        return f'{v.mem[1]}(%[tw])'
    if v.kind == 'creg':
        return f'%%ymm{v.reg}'
    return f'%%ymm{assign[v.id]}'


def emit(o, assign):
    if o.store is not None:
        return f'vmovdqa {operand(o.srcs[0], assign)}, {operand(Val("mem", "st", mem=o.store), assign)}'
    d = f'%%ymm{assign[o.dst.id]}'
    if o.mn in LOADS:
        return f'{o.mn} {operand(o.srcs[0], assign)}, {d}'
    if o.mn == 'vpsrlq':
        return f'vpsrlq ${o.imm}, {operand(o.srcs[0], assign)}, {d}'
    x, y = o.srcs          # AT&T: op src2, src1, dst  -> dst = src1 OP src2
    if o.mn in COMMUTATIVE and x.is_mem:
        x, y = y, x
    assert not x.is_mem, o
    imm = f'${o.imm}, ' if o.imm is not None else ''
    return f'{o.mn} {imm}{operand(y, assign)}, {operand(x, assign)}, {d}'


# ----------------------------------------------------------------- variants
def gen_simple(kind, count, fold, twmem, schedule, ab=False):
    ops, _, reserved = butterflies(kind, count, fold, twmem, 's', ab=ab)
    seq = list_schedule(ops, budget=16 - len(reserved)) if schedule else ops
    assign = allocate(seq, reserved)
    return {'body': [emit(o, assign) for o in seq], 'step': count // 2 if ab else count, 'ab': ab}


def gen_pipelined(kind, count, fold, twmem):
    """Kernel at p = iteration i: stage 2 of i (displacement 0) interleaved with
    stage 1 of i+1 (displacement +32*count). Carried values sit in fixed
    registers; write-after-read edges order stage-1 writes after stage-2 reads."""
    step = 32 * count
    cur, cur_car, reserved = butterflies(kind, count, fold, twmem, 'c')
    nxt, nxt_car, _ = butterflies(kind, count, fold, twmem, 'n', disp0=step)
    s2 = [o for o in cur if o.stage == 1]
    s1 = [o for o in nxt if o.stage == 0]
    free = [r for r in range(16) if r not in reserved]
    if len(cur_car) + 3 > len(free):
        raise AllocError('too many carried values')
    regs = free[:len(cur_car)]
    readers = {v.id: [o for o in s2 if any(s.id == v.id for s in o.srcs)] for v in cur_car}
    writer = {o.dst.id: o for o in s1 if o.dst is not None}
    war = [(r, writer[vn.id]) for vc, vn in zip(cur_car, nxt_car) for r in readers[vc.id]]
    pin = {v.id: r for v, r in zip(cur_car + nxt_car, regs + regs)}
    budget = 16 - len(reserved) - len(regs)
    # windowed mode: source order is stage 2 of i then stage 1 of i+1, so a small
    # window stays close to an allocatable order while allowing overlap
    seq = list_schedule((s2 + s1) if SEARCH['window'] else (s1 + s2), extra_deps=war, budget=budget, pinned=pin.keys())
    assign = allocate(seq, reserved, pinned=pin, live_in=cur_car, live_out=nxt_car)
    pro, pro_car, _ = butterflies(kind, count, fold, twmem, 'p')
    ppin = {v.id: r for v, r in zip(pro_car, regs)}
    p1 = list_schedule([o for o in pro if o.stage == 0], budget=budget, pinned=ppin.keys())
    pa = allocate(p1, reserved, pinned=ppin, live_out=pro_car)
    epi, epi_car, _ = butterflies(kind, count, fold, twmem, 'e')
    epin = {v.id: r for v, r in zip(epi_car, regs)}
    e2 = list_schedule([o for o in epi if o.stage == 1], budget=budget, pinned=epin.keys())
    ea = allocate(e2, reserved, pinned=epin, live_in=epi_car)
    return {'pre': [emit(o, pa) for o in p1], 'body': [emit(o, assign) for o in seq],
            'post': [emit(o, ea) for o in e2], 'step': count, 'pipelined': True}


# name, strategy, butterflies per stage/iteration, fold, twmem
VARIANTS = [
    ('df', 'df', 1, True, False),
    ('ls', 'ls', 1, True, False),
    ('lsnf', 'ls', 1, False, False),
    ('ls2', 'ls', 2, True, False),
    ('ls2t', 'ls', 2, True, True),
    ('sp', 'sp', 1, True, False),
    ('spt', 'sp', 1, True, True),
    ('sp2t', 'sp', 2, True, True),
    # round 2
    ('sph', 'sp', 1, True, 'half'),
    ('lsh', 'ls', 1, True, 'half'),
    ('ls2h', 'ls', 2, True, 'half'),
]


# Hardware-autotuning family (round 2): fixed knobs (seed, margin, jitter, modeled
# load latency, loads per cycle) per id; micro.cpp times them all on the target.
import random as _random
AUTOTUNE = []
_r = _random.Random(2026)
# (a three-butterfly family was dropped: its step does not divide power-of-two h)
for _base, (_strategy, _count, _fold, _twmem) in ((20, ('ls', 1, True, False)), (40, ('ls', 2, True, True)),
                                                 (60, ('ls', 2, True, 'half')), (80, ('sp', 1, True, True)),
                                                 (100, ('ab', 2, True, 'half')), (120, ('ab', 2, True, True)),
                                                 (140, ('ab', 4, True, 'half'))):
    for _k in range(12):
        AUTOTUNE.append((_base + _k, _strategy, _count, _fold, _twmem,
                         (1 + _k * 7 + _base, _r.choice([0, 1, 2, 3, 4]), _r.choice([0.0, 2.0, 4.0, 8.0]),
                          _r.choice([8, 10, 12, 16]), _r.choice([2, 3]), None)))
# round 5: windowed schedules (window = instructions of lookahead in source order)
_r = _random.Random(2027)
for _base, (_strategy, _count, _fold, _twmem) in ((160, ('sp', 1, True, 'half')), (180, ('sp', 2, True, True)),
                                                 (200, ('sp', 2, True, 'half')), (220, ('ls', 2, True, False)),
                                                 (240, ('sp', 1, True, False))):
    for _k in range(12):
        AUTOTUNE.append((_base + _k, _strategy, _count, _fold, _twmem,
                         (1 + _k * 5 + _base, _r.choice([0, 1, 2, 3]), _r.choice([0.0, 2.0, 4.0]),
                          _r.choice([8, 10, 12]), 2, _r.choice([8, 12, 16, 24, 32, 48]))))


def generate_fixed(kind, strategy, count, fold, twmem, knobs):
    seed, margin, noise, lat, lpc, window = knobs
    SEARCH.update(rng=_random.Random(seed), margin=margin, noise=noise, load_lat=lat, lpc=lpc, window=window)
    try:
        if strategy == 'sp':
            g = gen_pipelined(kind, count, fold, twmem)
        else:
            g = gen_simple(kind, count, fold, twmem, True, ab=strategy == 'ab')
    finally:
        SEARCH.update(rng=None, margin=0, noise=0.0, load_lat=LOAD_LAT, lpc=2, window=None)
    g.update(strategy=strategy, fold=fold, twmem=twmem, search=knobs)
    return g


def generate(kind, strategy, count, fold, twmem, tries=0):
    """Deterministic schedule first; with tries > 0 also seeded variations
    (pressure margin, priority jitter), keeping the best llvm-mca estimate."""
    import random
    best = None
    configs = [(0, 0, 0.0)] + [(seed, m, nz) for seed in range(1, tries + 1) for m in (0, 1, 2, 3) for nz in (2.0, 6.0)]
    for seed, margin, noise in configs:
        SEARCH.update(rng=random.Random(seed) if seed else None, margin=margin, noise=noise)
        try:
            if strategy == 'sp':
                g = gen_pipelined(kind, count, fold, twmem)
            else:
                g = gen_simple(kind, count, fold, twmem, strategy == 'ls')
        except AllocError as e:
            err = e
            continue
        if strategy == 'df':
            best = g
            break
        cyc = mca(g['body']) if tries else None
        g['mca'] = cyc / g['step'] if cyc else None
        g['search'] = (seed, margin, noise)
        if best is None or (cyc is not None and (best.get('mca') is None or g['mca'] < best['mca'])):
            best = g
    SEARCH.update(rng=None, margin=0, noise=0.0)
    if best is None:
        raise err
    best.update(strategy=strategy, fold=fold, twmem=twmem)
    return best


def asm_function(name, kind, g):
    """void name(V* f, long h, const U* px, const U* py): runs butterflies j < h
    (h a positive multiple of the step, pipelined: >= 1 step). px points at w_x
    and py at w_y (w_z = py[1]) in the block table; quotients 8 words later."""
    step, twmem = g['step'], g['twmem']
    body = ['vpbroadcastd %[cP], %%ymm15', 'vpbroadcastd %[cP2], %%ymm14']
    for i, src in enumerate(['(%[px])', '32(%[px])', '(%[py])', '32(%[py])', '4(%[py])', '36(%[py])']):
        if twmem is True or (twmem == 'half' and i % 2 == 0):
            body += [f'vbroadcastss {src}, %%ymm0', f'vmovdqa %%ymm0, {32 * i}(%[tw])']
        else:
            body.append(f'vbroadcastss {src}, %%ymm{8 + i if twmem is False else 11 + i // 2}')
    if g.get('pipelined'):
        body += g['pre'] + ['cmp %[last], %[p]', 'je 2f', '.p2align 5', '1:'] + g['body']
        body += [f'add ${32 * step}, %[p]', 'cmp %[last], %[p]', 'jne 1b', '2:'] + g['post']
    else:
        inc = [f'add ${32 * step}, %[q]'] if g.get('ab') else []
        body += ['.p2align 5', '1:'] + g['body'] + inc + [f'add ${32 * step}, %[p]', 'cmp %[end], %[p]', 'jne 1b']
    L = [f'// {name}: strategy={g["strategy"]} step={step} fold={int(g["fold"])} twmem={twmem}; '
         f'{len(g["body"])} loop instructions; search (seed, margin, jitter) = {g.get("search")}; '
         f'llvm-mca znver3 {g.get("mca") or 0:.2f} cycles/butterfly',
         (f'QA_AI void {name}(V* f, V* g, long h, const U* px, const U* py) {{' if g.get('ab') else
          f'QA_AI void {name}(V* f, long h, const U* px, const U* py) {{'),
         '    alignas(32) V tw[6];' if twmem else '    V* tw = nullptr;',   # half: w at even slots
         '    char* p = (char*)f; const long H = h * 32, H3 = 3 * H;',
         '    char* q = (char*)g;' if g.get('ab') else '    char* q = nullptr;',
         f'    char* const end = p + H; char* const last = end - {32 * step};',
         '    (void)last; (void)end;',
         '    asm volatile(']
    L += [f'        "{x}\\n\\t"' for x in body]
    L += ['        : [p] "+r"(p), [q] "+r"(q)',
          '        : [end] "r"(end), [last] "r"(last), [H] "r"(H), [H3] "r"(H3), [px] "r"(px), [py] "r"(py),',
          '          [tw] "r"(tw), [cP] "m"(asm_const_P), [cP2] "m"(asm_const_P2)',
          '        : "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7", "xmm8", "xmm9",',
          '          "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15", "memory", "cc");',
          '}']
    return '\n'.join(L)


def mca(lines, cpu='znver3'):
    exe = '/opt/homebrew/opt/llvm/bin/llvm-mca'
    if not os.path.exists(exe):
        return None
    sub = {'%[p]': '%rdi', '%[q]': '%r8', '%[H3]': '%rcx', '%[H]': '%rsi', '%[tw]': '%rdx', '%%': '%',
           '%[an]': '%rdi', '%[bn]': '%rsi', '%[Ln]': '%rdx', '%[px]': '%rcx', '%[py]': '%r8', '%[lw]': '%r9',
           '%[ac]': '%r10', '%[Lc]': '%r11', '%[ipx]': '%rbx', '%[ipy]': '%rbp'}
    txt = []
    for x in lines:
        for k, v in sub.items():
            x = x.replace(k, v)
        txt.append(x)
    with tempfile.NamedTemporaryFile('w', suffix='.s', delete=False) as f:
        f.write('\n'.join(txt) + '\n')
    out = subprocess.run([exe, '-mtriple=x86_64', f'-mcpu={cpu}', '-iterations=300', f.name],
                         capture_output=True, text=True).stdout
    os.unlink(f.name)
    m = re.search(r'Total Cycles:\s+(\d+)', out)
    return int(m.group(1)) / 300 if m else None


# ------------------------------------------------------------------ leaf MAC
# LeafBuf (qasm.hpp): window[4][16] at byte 64t (words 0-7 = w*a, 8-15 = a) and
# coeff[4][8] at byte 256 + 32t. Product of leaf t, lanes l:
#   e = sum_i window[t][8-i+l] * coeff[t][i]  over even l (64-bit lanes)
#   o = same for odd l; odd lanes of load(8-i) are the even lanes of load(9-i).
# Result a[t] = low(REDC(e), REDC(o)) as in qflip::leaf_mac / reduce<false>.
# Registers: e_t = ymm t, o_t = ymm 4+t, temporaries ymm8..12, NI/P/2P in 13..15.
LEAF_VARIANTS = [
    # AsmLeaf id, form, broadcast mnemonic, leaves interleaved
    (2, 'shift', 'vpbroadcastd', 4),
    (3, 'shift', 'vbroadcastss', 4),
    (4, 'reuse', 'vbroadcastss', 1),
    (5, 'reuse', 'vbroadcastss', 2),
    (6, 'reuse', 'vbroadcastss', 4),
    (7, 'dload', 'vbroadcastss', 4),
    (8, 'reuse', 'vpbroadcastd', 4),
]


def win(t, k):
    return f'{64 * t + 4 * k}(%[L])'


def coef(t, i):
    return f'{256 + 32 * t + 4 * i}(%[L])'


def leaf_body(form, bc, group):
    out = []
    pool = itertools.cycle(range(8, 13))
    tmp = lambda: f'%%ymm{next(pool)}'
    E = lambda t: f'%%ymm{t}'
    O = lambda t: f'%%ymm{4 + t}'

    if form == 'shift':
        for i in range(8):
            for t in range(4):
                x, y, xo = tmp(), tmp(), tmp()
                out += [f'vmovdqu {win(t, 8 - i)}, {x}', f'{bc} {coef(t, i)}, {y}', f'vpsrlq $32, {x}, {xo}']
                if i == 0:
                    out += [f'vpmuludq {y}, {x}, {E(t)}', f'vpmuludq {y}, {xo}, {O(t)}']
                else:
                    out += [f'vpmuludq {y}, {x}, {x}', f'vpaddq {x}, {E(t)}, {E(t)}',
                            f'vpmuludq {y}, {xo}, {xo}', f'vpaddq {xo}, {O(t)}, {O(t)}']
    elif form == 'dload':
        for i in range(8):
            for t in range(4):
                y, p1, p2 = tmp(), tmp(), tmp()
                out.append(f'{bc} {coef(t, i)}, {y}')
                if i == 0:
                    out += [f'vpmuludq {win(t, 8)}, {y}, {E(t)}', f'vpmuludq {win(t, 9)}, {y}, {O(t)}']
                else:
                    out += [f'vpmuludq {win(t, 8 - i)}, {y}, {p1}', f'vpaddq {p1}, {E(t)}, {E(t)}',
                            f'vpmuludq {win(t, 9 - i)}, {y}, {p2}', f'vpaddq {p2}, {O(t)}, {O(t)}']
    else:   # reuse: load k=9..1 once; X_k feeds e (y_{8-k}) and o (y_{9-k})
        for t0 in range(0, 4, group):
            ts = list(range(t0, t0 + group))
            Y = {t: f'%%ymm{8 + (t - t0)}' for t in ts}           # per-leaf current y
            xt = itertools.cycle(range(8 + group, 16))   # NI/P/2P are loaded after the MAC
            for k in range(9, 0, -1):
                for t in ts:
                    x = f'%%ymm{next(xt)}'
                    out.append(f'vmovdqu {win(t, k)}, {x}')
                    if k <= 8:   # e += X_k * y_{8-k} (y already in Y[t])
                        if k == 8:
                            out.append(f'vpmuludq {Y[t]}, {x}, {E(t)}')
                        else:
                            p = f'%%ymm{next(xt)}'
                            out += [f'vpmuludq {Y[t]}, {x}, {p}', f'vpaddq {p}, {E(t)}, {E(t)}']
                    if k >= 2:   # o += X_k * y_{9-k}
                        out.append(f'{bc} {coef(t, 9 - k)}, {Y[t]}')
                        if k == 9:
                            out.append(f'vpmuludq {Y[t]}, {x}, {O(t)}')
                        else:
                            out += [f'vpmuludq {Y[t]}, {x}, {x}', f'vpaddq {x}, {O(t)}, {O(t)}']
    # REDC of both parities, combine, low, store
    out += ['vpbroadcastd %[cNI], %%ymm13', 'vpbroadcastd %[cP], %%ymm14', 'vpbroadcastd %[cP2], %%ymm15']
    for t in range(4):
        m1, m2 = tmp(), tmp()
        out += [f'vpmuludq %%ymm13, {E(t)}, {m1}', f'vpmuludq %%ymm13, {O(t)}, {m2}',
                f'vpmuludq %%ymm14, {m1}, {m1}', f'vpmuludq %%ymm14, {m2}, {m2}',
                f'vpaddq {m1}, {E(t)}, {E(t)}', f'vpaddq {m2}, {O(t)}, {O(t)}',
                f'vpsrlq $32, {E(t)}, {E(t)}', f'vpblendd $170, {O(t)}, {E(t)}, {E(t)}',
                f'vpsubd %%ymm15, {E(t)}, {m1}', f'vpminud {m1}, {E(t)}, {E(t)}',
                f'vmovdqa {E(t)}, {32 * t}(%[a])']
    return out


def leaf_function(vid, form, bc, group):
    body = leaf_body(form, bc, group)
    L = [f'// leaf_mac_asm{vid}: form={form} broadcast={bc} interleave={group}; {len(body)} instructions',
         f'QA_AI void leaf_mac_asm{vid}(V* a, const void* L) {{',
         '    asm volatile(']
    L += [f'        "{x}\\n\\t"' for x in body]
    L += ['        :',
          '        : [a] "r"(a), [L] "r"(L), [cNI] "m"(asm_const_NI), [cP] "m"(asm_const_P), [cP2] "m"(asm_const_P2)',
          '        : "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7", "xmm8", "xmm9",',
          '          "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15", "memory");',
          '}']
    return '\n'.join(L), body




# ----------------------------------------------------------- fused bottom
# One call handles a batch of four vectors (two leaves' worth of lanes x 4):
#   stage 1 (next batch, pointers an/bn): forward radix-4 butterflies at h=1 on a
#     and b with twiddles (px, py), outputs kept in registers; window rows
#     [shrink(w_t*canonical(A_t)), canonical(A_t)] and coefficients canonical(B_t)
#     stored to the leaf buffer Ln (layout of qasm::LeafBuf); lw = {w[4], wi[4]}.
#   stage 2 (current batch, pointers ac/Lc): leaf products in load-reuse form,
#     Montgomery REDC, low(), inverse radix-4 butterfly at h=1 with twiddles
#     (ipx, ipy) in registers, four stores to ac.
# Arithmetic equals qasm leaf_build / leaf_mac / fwd4 / inv4 except that the
# identity group k = 0 is multiplied by the table entry for 1 (w = 1, wi = 4):
# same residues, possibly different representatives, all within range.
def fwd_h1(b, base):
    tw = {n: b.scalar(n.lower(), src, d) for n, src, d in
          (('WX', 'px', 0), ('WIX', 'px', 32), ('WY', 'py', 0), ('WIY', 'py', 32), ('WZ', 'py', 4), ('WIZ', 'py', 36))}
    f = [b.at(f'{base}{t}', base, 32 * t) for t in range(4)]
    f2o, f3o = b.at(f'{base}2o', base, 68), b.at(f'{base}3o', base, 100)
    a = b.low(f[0], f'{base}a'); bb = b.low(f[1], f'{base}b')
    cc = b.shoup(f[2], f2o, tw['WX'], tw['WIX'], f'{base}c')
    dd = b.shoup(f[3], f3o, tw['WX'], tw['WIX'], f'{base}d')
    ac = b.low(b.op('vpaddd', f'{base}s', a, cc), f'{base}ac')
    amc = b.low_signed(b.op('vpsubd', f'{base}t', a, cc), f'{base}amc')
    bd = b.op('vpaddd', f'{base}bd', bb, dd); bmd = b.diff(bb, dd, f'{base}bmd')
    y = b.shoup(bd, None, tw['WY'], tw['WIY'], f'{base}y')
    z = b.shoup(bmd, None, tw['WZ'], tw['WIZ'], f'{base}z')
    return [b.op('vpaddd', f'{base}o0', ac, y), b.diff(ac, y, f'{base}o1'),
            b.op('vpaddd', f'{base}o2', amc, z), b.diff(amc, z, f'{base}o3')]


def canonical(b, x, name):   # shrink(low(x), P)
    y = b.low(x, name + 'l')
    return b.op('vpminud', name, y, b.op('vpsubd', name + 'p', y, b.c['P']))


def bottom_stage1(b):
    """Source order keeps pressure low: each array's butterfly is followed at once
    by the stores that consume its four outputs."""
    A = fwd_h1(b, 'an')
    for t in range(4):
        xa = canonical(b, A[t], f'xa{t}')
        b.store_at(xa, 'Ln', 64 * t + 32)
        wa = b.shoup(xa, None, b.scalar(f'w{t}', 'lw', 4 * t), b.scalar(f'wi{t}', 'lw', 16 + 4 * t), f'wa{t}')
        wa = b.op('vpminud', f'was{t}', wa, b.op('vpsubd', f'wap{t}', wa, b.c['P']))
        b.store_at(wa, 'Ln', 64 * t)
    B = fwd_h1(b, 'bn')
    for t in range(4):
        b.store_at(canonical(b, B[t], f'cb{t}'), 'Ln', 256 + 32 * t)


def bottom_stage2(b):
    """Load-reuse leaf products: window vector X_k (k = 9..1) is loaded once and
    feeds e (with y_{8-k}) and o (with y_{9-k}); values are created in use order."""
    c = b.c
    R = []
    for t in range(4):
        y = lambda i: b.scalar(f'y{t}_{i}', 'Lc', 256 + 32 * t + 4 * i)
        X = lambda k: b.at(f'x{t}_{k}', 'Lc', 64 * t + 4 * k, fold=False)
        e = o = None
        for k in range(9, 0, -1):
            x = X(k)
            if k <= 8:
                p = b.op('vpmuludq', f'pe{t}_{k}', x, y(8 - k))
                e = p if e is None else b.op('vpaddq', f'e{t}_{k}', e, p)
            if k >= 2:
                p = b.op('vpmuludq', f'po{t}_{k}', x, y(9 - k))
                o = p if o is None else b.op('vpaddq', f'o{t}_{k}', o, p)
        e = b.op('vpaddq', f're{t}', e, b.op('vpmuludq', f'mep{t}', b.op('vpmuludq', f'me{t}', e, c['NI']), c['P']))
        o = b.op('vpaddq', f'ro{t}', o, b.op('vpmuludq', f'mop{t}', b.op('vpmuludq', f'mo{t}', o, c['NI']), c['P']))
        r = b.op('vpblendd', f'r{t}', b.op('vpsrlq', f'rs{t}', e, imm=32), o, imm=0xAA)
        R.append(b.low(r, f'R{t}'))
    tw = {n: b.scalar(n.lower(), src, d) for n, src, d in
          (('WX', 'ipx', 0), ('WIX', 'ipx', 32), ('WY', 'ipy', 0), ('WIY', 'ipy', 32), ('WZ', 'ipy', 4), ('WIZ', 'ipy', 36))}
    ab = b.low(b.op('vpaddd', 'sab', R[0], R[1]), 'ab')
    cd = b.low(b.op('vpaddd', 'scd', R[2], R[3]), 'cd')
    amb = b.shoup(b.diff(R[0], R[1], 'eamb'), None, tw['WY'], tw['WIY'], 'iy')
    cmd = b.shoup(b.diff(R[2], R[3], 'ecmd'), None, tw['WZ'], tw['WIZ'], 'iz')
    b.store_at(b.low(b.op('vpaddd', 's0', ab, cd), 'O0'), 'ac', 0)
    b.store_at(b.low(b.op('vpaddd', 's1', amb, cmd), 'O1'), 'ac', 32)
    b.store_at(b.shoup(b.diff(ab, cd, 'e2'), None, tw['WX'], tw['WIX'], 'ix2'), 'ac', 64)
    b.store_at(b.shoup(b.diff(amb, cmd, 'e3'), None, tw['WX'], tw['WIX'], 'ix3'), 'ac', 96)


BOTTOM_CONSTS = {'P': Val('creg', 'P', reg=15), 'P2': Val('creg', 'P2', reg=14), 'NI': Val('creg', 'NI', reg=13)}
BOTTOM_ARGS = {'s1': ['an', 'bn', 'Ln', 'px', 'py', 'lw'], 's2': ['ac', 'Lc', 'ipx', 'ipy'],
               's12': ['an', 'bn', 'Ln', 'px', 'py', 'lw', 'ac', 'Lc', 'ipx', 'ipy']}


def gen_bottom(part, fold, share, knobs, merge=None):
    """part: 's1', 's2' or 's12' (stage 2 then stage 1 in source order, scheduled
    together). knobs = (seed, margin, jitter, window); window 0 = source order.
    merge (s12 only): interleave the two stages' source orders proportionally,
    stage 1 shifted by `merge` (fraction of its length) relative to stage 2."""
    seed, margin, noise, window = knobs
    b = Builder(BOTTOM_CONSTS, fold, '', 0)
    b.share_bcast = share
    if part in ('s2', 's12'):
        bottom_stage2(b)
    n2 = len(b.ops)
    if part in ('s1', 's12'):
        bottom_stage1(b)
    if merge is not None and part == 's12':
        s2, s1 = b.ops[:n2], b.ops[n2:]
        keyed = [(i / len(s2), 0, i, o) for i, o in enumerate(s2)] + [(j / len(s1) + merge, 1, j, o) for j, o in enumerate(s1)]
        b.ops = [o for *_, o in sorted(keyed, key=lambda t: t[:3])]
    if window == 0:
        seq = b.ops
    else:
        SEARCH.update(rng=_random.Random(seed) if seed else None, margin=margin, noise=noise, window=window)
        try:
            seq = list_schedule(b.ops, budget=13)
        finally:
            SEARCH.update(rng=None, margin=0, noise=0.0, window=None)
    assign = allocate(seq, {13, 14, 15})
    return [emit(o, assign) for o in seq]


def bottom_function(name, part, body):
    args = BOTTOM_ARGS[part]
    L = [f'// {name}: fused bottom {part}; {len(body)} instructions',
         f'QA_AI void {name}(' + ', '.join(f'const void* {a}' for a in args) + ') {',
         '    asm volatile(',
         '        "vpbroadcastd %[cP], %%ymm15\\n\\t"',
         '        "vpbroadcastd %[cP2], %%ymm14\\n\\t"',
         '        "vpbroadcastd %[cNI], %%ymm13\\n\\t"']
    L += [f'        "{x}\\n\\t"' for x in body]
    L += ['        :',
          '        : ' + ', '.join(f'[{a}] "r"({a})' for a in args) + ',',
          '          [cP] "m"(asm_const_P), [cP2] "m"(asm_const_P2), [cNI] "m"(asm_const_NI)',
          '        : "xmm0", "xmm1", "xmm2", "xmm3", "xmm4", "xmm5", "xmm6", "xmm7", "xmm8", "xmm9",',
          '          "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15", "memory");',
          '}']
    return '\n'.join(L)


# Bottom variants: id, fold, share broadcasts, scheduling window (0 = source order).
# For window > 0 the best of several seeds/margins by llvm-mca is kept.
BOTTOM_VARIANTS = [(1, True, True, 0, None), (2, True, False, 0, None), (3, True, True, 12, None),
                   (4, True, True, 24, None), (5, True, True, 48, None), (6, False, True, 24, None),
                   (7, True, False, 24, None),
                   # round 5: stages merged proportionally (per-use broadcasts), windowed
                   (8, True, False, 8, 0.0), (9, True, False, 12, 0.0), (10, True, False, 16, 0.1),
                   (11, True, False, 12, 0.25)]


def emit_bottom(args, head):
    out = list(head)
    ids = []
    for vid, fold, share, window, merge in BOTTOM_VARIANTS:
        funcs = {}
        for part in ('s1', 's2', 's12'):
            best = None
            configs = [(0, 0, 0.0, 0)] if window == 0 else \
                [(seed, m, 3.0 if seed else 0.0, window) for seed in range(0, 1 + 3 * max(1, args.tries or 0)) for m in (0, 2, 4)]
            for knobs in configs:
                try:
                    body = gen_bottom(part, fold, share, knobs, merge)
                except AllocError:
                    continue
                cyc = mca(body) if args.mca else 0.0
                if best is None or cyc < best[0]:
                    best = (cyc, body, knobs)
                if not args.mca:
                    break
            if best is None:
                print(f'bottom{vid} {part}: no feasible schedule', file=sys.stderr)
                break
            funcs[part] = best
            print(f'bottom{vid} {part}: {len(best[1])} instr, mca {best[0]:.1f} cycles/batch, knobs {best[2]}', file=sys.stderr)
        if len(funcs) < 3:
            continue
        ids.append(vid)
        for part, (cyc, body, knobs) in funcs.items():
            out += [bottom_function(f'bottom{vid}_{part}', part, body), '']
    out.append('#define ASM_BOTTOM_IDS " ' + ' '.join(map(str, ids)) + ' "')
    for part in ('s1', 's2', 's12'):
        args_ = BOTTOM_ARGS[part]
        out.append(f'QA_AI void bottom_{part}(int v, ' + ', '.join(f'const void* {a}' for a in args_) + ') {')
        out.append('    switch (v) {')
        out += [f'    case {vid}: bottom{vid}_{part}(' + ', '.join(args_) + '); break;' for vid in ids]
        out += ['    default: __builtin_unreachable();', '    }', '}']
    out.append('constexpr bool asm_bottom_has(int v) { return ' + (' || '.join(f'v == {i}' for i in ids) or 'false') + '; }')
    return out


STEPS, AB = {}, set()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--mca', action='store_true', help='llvm-mca znver3 estimates (stderr)')
    ap.add_argument('--tries', type=int, default=0, help='seeded schedule variations per variant (needs llvm-mca)')
    ap.add_argument('--out', default=os.path.join(os.path.dirname(os.path.abspath(__file__)), 'kernels'))
    args = ap.parse_args()
    head = ['// Generated by gen_asm.py; do not edit. The docstring there documents the',
            '// arithmetic, ranges, schedules and register conventions.', '#pragma once', '']
    out, cases = list(head), {'fwd': [], 'inv': []}
    for kind in ('fwd', 'inv'):
        for vid, strategy, count, fold, twmem, knobs in AUTOTUNE:
            name = f'{kind}_at{vid}'
            if strategy == 'ab' and kind == 'inv':
                continue
            try:
                g = generate_fixed(kind, strategy, count, fold, twmem, knobs)
            except AllocError as e:
                print(f'{name}: skipped ({e})', file=sys.stderr)
                continue
            if args.mca:
                cyc = mca(g['body'])
                g['mca'] = cyc / g['step']
                print(f'{vid} {name:10s} {len(g["body"]):4d} instr/{g["step"]} bfly  mca {g["mca"]:6.2f} cyc/bfly  knobs={knobs}',
                      file=sys.stderr)
            out += [asm_function(name, kind, g), '']
            cases[kind].append((vid, name))
            STEPS[vid] = g['step']
            if g.get('ab'):
                AB.add(vid)
    for kind in ('fwd', 'inv'):
        for vid, (suffix, strategy, count, fold, twmem) in enumerate(VARIANTS, start=1):
            name = f'{kind}_{suffix}'
            try:
                g = generate(kind, strategy, count, fold, twmem, args.tries)
            except AllocError as e:
                print(f'{name}: skipped ({e})', file=sys.stderr)
                continue
            if args.mca:
                cyc = mca(g['body'])
                print(f'{vid} {name:10s} {len(g["body"]):4d} instr/{g["step"]} bfly  mca {cyc / g["step"]:6.2f} cyc/bfly'
                      f'  search={g.get("search")}', file=sys.stderr)
            out += [asm_function(name, kind, g), '']
            cases[kind].append((vid, name))
    steps = {}
    for kind in ('fwd', 'inv'):
        out.append(f'#define ASM_{kind.upper()}_IDS " ' + ' '.join(str(v) for v, _ in cases[kind]) + ' "')
    out.append('constexpr int asm_step(int kind, int v) {   // butterflies per loop step (kind 0 fwd, 1 inv)')
    out.append('    switch (kind * 1000 + v) {')
    for kind_i, kind in enumerate(('fwd', 'inv')):
        for vid, name in cases[kind]:
            out.append(f'    case {kind_i * 1000 + vid}: return {STEPS.get(vid) or VARIANTS[vid - 1][2]};')
    out += ['    }', '    return 1;', '}', '#define ASM_STEP(k, v) asm_step(k, v)']
    out.append('constexpr bool asm_has(int kind, int v) {   // variant generated (not skipped)')
    out.append('    switch (kind * 1000 + v) {')
    for kind_i, kind in enumerate(('fwd', 'inv')):
        out += [f'    case {kind_i * 1000 + vid}:' for vid, _ in cases[kind]]
    out += ['        return true;', '    }', '    return false;', '}', '']
    for kind in ('fwd', 'inv'):
        out.append(f'// {kind}_asm(v, ...): variant v of VARIANTS in gen_asm.py (1-based).')
        out.append(f'QA_AI void {kind}_asm(int v, V* f, long h, const U* px, const U* py) {{')
        out.append('    switch (v) {')
        out += [f'    case {vid}: {name}(f, h, px, py); break;' for vid, name in cases[kind] if vid not in AB]
        out += ['    default: __builtin_unreachable();', '    }', '}', '']
    out.append('// fwd2_asm(v, a, b, ...): forward loops over a and b with the same twiddles;')
    out.append('// "ab" variants interleave the two arrays, others run fwd_asm twice.')
    out.append('QA_AI void fwd2_asm(int v, V* a, V* b, long h, const U* px, const U* py) {')
    out.append('    switch (v) {')
    out += [f'    case {vid}: {name}(a, b, h, px, py); break;' for vid, name in cases['fwd'] if vid in AB]
    out += ['    default: fwd_asm(v, a, h, px, py); fwd_asm(v, b, h, px, py);', '    }', '}',
            'constexpr bool asm_is_ab(int v) {', '    switch (v) {']
    out += [f'    case {vid}:' for vid in sorted(AB)]
    out += ['        return true;', '    }', '    return false;', '}', '']
    open(os.path.join(args.out, 'asm_bfly.inc'), 'w').write('\n'.join(out))
    out = list(head)
    for vid, form, bc, group in LEAF_VARIANTS:
        text, body = leaf_function(vid, form, bc, group)
        if args.mca:
            cyc = mca([x.replace('%[L]', '%rsi').replace('%[a]', '%rdi').replace('%[cNI]', '(%rax)')
                       .replace('%[cP]', '4(%rax)').replace('%[cP2]', '8(%rax)') for x in body])
            print(f'leaf{vid} {form:6s} {bc:13s} g={group}: {len(body)} instr, mca {cyc / 4:6.2f} cyc/leaf-vector',
                  file=sys.stderr)
        out += [text, '']
    out.append(f'#define ASM_LEAF_MAX {max(v for v, *_ in LEAF_VARIANTS)}')
    out.append('// leaf_mac_asm(v, a, L): AsmLeaf variant v >= 2 (LEAF_VARIANTS in gen_asm.py).')
    out.append('QA_AI void leaf_mac_asm(int v, V* a, const void* L) {')
    out.append('    switch (v) {')
    out += [f'    case {vid}: leaf_mac_asm{vid}(a, L); break;' for vid, *_ in LEAF_VARIANTS]
    out += ['    default: __builtin_unreachable();', '    }', '}', '']
    open(os.path.join(args.out, 'asm_leaf.inc'), 'w').write('\n'.join(out))
    open(os.path.join(args.out, 'asm_bottom.inc'), 'w').write('\n'.join(emit_bottom(args, head)) + '\n')


if __name__ == '__main__':
    main()
