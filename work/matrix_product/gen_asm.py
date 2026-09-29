#!/usr/bin/env python3
"""Generate GCC inline-asm micro-kernels for the 4x8 tile (exploration 013, step 3).

Writes asm_kernels.hpp. Every kernel accumulates one 4x8 tile of centered, Montgomery-scaled
products into eight 64-bit-lane accumulators (acc[2r] even columns, acc[2r+1] odd columns of
row r) and leaves the final reduction to the C++ caller (simd.hpp finish_s).

Families (all loads are the Zen 3 load-port-only forms: vbroadcastss, vmovsldup, vmovshdup):
  direct: per k-step 4 broadcasts + 2 dup loads, 8 vpmuldq + 8 vpaddq; fold every 32 steps.
  wip:    Winograd inner-product pairs, per k-pair 8 broadcasts + 4 dup loads, 16 vpaddd,
          8 vpmuldq, 8 vpaddq; fold every 8 k-pairs (16 steps).
  wipp:   packed-B Winograd pairs (2 plain B loads, vpsrlq for odd columns).
Schedules:
  fold=burst  fold all accumulators at the top of every period except the first.
  fold=spread fold accumulator i once per period at a fixed position (period-aligned m).
  hoist=1     issue the loads of step t+1 before the arithmetic of step t (two B buffers).
Contract: pa panel [t][4], pb panel [t][8] (u32 bit patterns of centered values), m a
positive multiple of the period (32 direct, 16 wip/wipp). Accumulators are inputs and
outputs (callers pass zeros or Winograd corrections). All ymm8-15 are clobbered.
"""
import pathlib

HERE = pathlib.Path(__file__).resolve().parent


def fold(acc, tmp, zero):
    # acc <- (acc >> 32) * C32 + (acc & 0xffffffff) for signed 64-bit lanes (see simd.hpp fold_s)
    return [f"vpsrlq $32, {acc}, {tmp}",
            f"vpmuldq %[c32], {tmp}, {tmp}",
            f"vpblendd $0xAA, {zero}, {acc}, {acc}",
            f"vpaddq {tmp}, {acc}, {acc}"]


ACC = [f"%[a{i}]" for i in range(8)]


def direct_period(hoist, spread):
    """One 32-step period of the direct kernel; offsets relative to pa/pb at period start."""
    ins = []
    be, bo = ["%%ymm8", "%%ymm14"], ["%%ymm9", "%%ymm15"]
    xs = ["%%ymm10", "%%ymm11"]
    ps = ["%%ymm12", "%%ymm13"]
    if hoist:
        ins += [f"vmovsldup 0(%[pb]), {be[0]}", f"vmovshdup 0(%[pb]), {bo[0]}"]
    for t in range(32):
        cur = t % 2 if hoist else 0
        if hoist:
            if t + 1 < 32:
                nxt = (t + 1) % 2
                ins += [f"vmovsldup {32 * (t + 1)}(%[pb]), {be[nxt]}", f"vmovshdup {32 * (t + 1)}(%[pb]), {bo[nxt]}"]
        else:
            ins += [f"vmovsldup {32 * t}(%[pb]), {be[0]}", f"vmovshdup {32 * t}(%[pb]), {bo[0]}"]
        for r in range(4):
            x = xs[r % 2]
            ins.append(f"vbroadcastss {16 * t + 4 * r}(%[pa]), {x}")
            ins += [f"vpmuldq {be[cur]}, {x}, {ps[0]}", f"vpaddq {ps[0]}, {ACC[2 * r]}, {ACC[2 * r]}",
                    f"vpmuldq {bo[cur]}, {x}, {ps[1]}", f"vpaddq {ps[1]}, {ACC[2 * r + 1]}, {ACC[2 * r + 1]}"]
        if spread and t % 4 == 1:
            i = t // 4
            ins += ["vpxor %%xmm13, %%xmm13, %%xmm13"] + fold(ACC[i], "%%ymm12", "%%ymm13")
    return ins


def direct_period_g(spread):
    """Direct kernel, GCC-like order: per row two multiplies then two adds; products rotate
    through four registers."""
    ins = []
    ps = ["%%ymm12", "%%ymm13", "%%ymm14", "%%ymm15"]
    for t in range(32):
        ins += [f"vbroadcastss {16 * t}(%[pa]), %%ymm10", f"vmovsldup {32 * t}(%[pb]), %%ymm8",
                f"vmovshdup {32 * t}(%[pb]), %%ymm9"]
        for r in range(4):
            x = "%%ymm10" if r % 2 == 0 else "%%ymm11"
            if r > 0:
                ins.append(f"vbroadcastss {16 * t + 4 * r}(%[pa]), {x}")
            p0, p1 = ps[(2 * r) % 4], ps[(2 * r + 1) % 4]
            ins += [f"vpmuldq %%ymm8, {x}, {p0}", f"vpmuldq %%ymm9, {x}, {p1}",
                    f"vpaddq {p0}, {ACC[2 * r]}, {ACC[2 * r]}", f"vpaddq {p1}, {ACC[2 * r + 1]}, {ACC[2 * r + 1]}"]
        if spread and t % 4 == 1:
            i = t // 4
            ins += ["vpxor %%xmm13, %%xmm13, %%xmm13"] + fold(ACC[i], "%%ymm12", "%%ymm13")
    return ins


def wipp_period_variant(mode):
    """Packed-B Winograd period (8 k-pairs) with alternative orderings:
    i2: sums of two rows before their multiplies (4 sum registers);
    sh: shifted (odd) sums formed before the first multiply of the row."""
    ins = []
    for s_ in range(8):
        k0, k1 = 2 * s_, 2 * s_ + 1
        ins += [f"vmovdqu {32 * k0}(%[pb]), %%ymm8", f"vmovdqu {32 * k1}(%[pb]), %%ymm9"]
        if mode == "i2":
            for rp in range(2):
                r0, r1 = 2 * rp, 2 * rp + 1
                ins += [f"vbroadcastss {16 * k0 + 4 * r0}(%[pa]), %%ymm10", f"vbroadcastss {16 * k1 + 4 * r0}(%[pa]), %%ymm11",
                        "vpaddd %%ymm9, %%ymm10, %%ymm12", "vpaddd %%ymm8, %%ymm11, %%ymm13",
                        f"vbroadcastss {16 * k0 + 4 * r1}(%[pa]), %%ymm10", f"vbroadcastss {16 * k1 + 4 * r1}(%[pa]), %%ymm11",
                        "vpaddd %%ymm9, %%ymm10, %%ymm14", "vpaddd %%ymm8, %%ymm11, %%ymm15",
                        "vpmuldq %%ymm13, %%ymm12, %%ymm10", "vpmuldq %%ymm15, %%ymm14, %%ymm11",
                        f"vpaddq %%ymm10, {ACC[2 * r0]}, {ACC[2 * r0]}", f"vpaddq %%ymm11, {ACC[2 * r1]}, {ACC[2 * r1]}",
                        "vpsrlq $32, %%ymm12, %%ymm12", "vpsrlq $32, %%ymm13, %%ymm13",
                        "vpsrlq $32, %%ymm14, %%ymm14", "vpsrlq $32, %%ymm15, %%ymm15",
                        "vpmuldq %%ymm13, %%ymm12, %%ymm12", "vpmuldq %%ymm15, %%ymm14, %%ymm14",
                        f"vpaddq %%ymm12, {ACC[2 * r0 + 1]}, {ACC[2 * r0 + 1]}", f"vpaddq %%ymm14, {ACC[2 * r1 + 1]}, {ACC[2 * r1 + 1]}"]
        else:  # sh
            for r in range(4):
                ins += [f"vbroadcastss {16 * k0 + 4 * r}(%[pa]), %%ymm10", f"vbroadcastss {16 * k1 + 4 * r}(%[pa]), %%ymm11",
                        "vpaddd %%ymm9, %%ymm10, %%ymm12", "vpaddd %%ymm8, %%ymm11, %%ymm13",
                        "vpsrlq $32, %%ymm12, %%ymm14", "vpsrlq $32, %%ymm13, %%ymm15",
                        "vpmuldq %%ymm13, %%ymm12, %%ymm12", "vpmuldq %%ymm15, %%ymm14, %%ymm14",
                        f"vpaddq %%ymm12, {ACC[2 * r]}, {ACC[2 * r]}", f"vpaddq %%ymm14, {ACC[2 * r + 1]}, {ACC[2 * r + 1]}"]
    return ins


def wip_period(packed, hoist, spread):
    """One 8-k-pair period (16 steps) of the Winograd kernel."""
    ins = []
    for s in range(8):
        k0, k1 = 2 * s, 2 * s + 1
        if packed:
            ins += [f"vmovdqu {32 * k0}(%[pb]), %%ymm8", f"vmovdqu {32 * k1}(%[pb]), %%ymm10"]
        else:
            ins += [f"vmovsldup {32 * k0}(%[pb]), %%ymm8", f"vmovshdup {32 * k0}(%[pb]), %%ymm9",
                    f"vmovsldup {32 * k1}(%[pb]), %%ymm10", f"vmovshdup {32 * k1}(%[pb]), %%ymm11"]
        for r in range(4):
            ins += [f"vbroadcastss {16 * k0 + 4 * r}(%[pa]), %%ymm12",
                    f"vbroadcastss {16 * k1 + 4 * r}(%[pa]), %%ymm13"]
            if packed:
                ins += ["vpaddd %%ymm10, %%ymm12, %%ymm14",   # s = a0 + b1
                        "vpaddd %%ymm8, %%ymm13, %%ymm15",    # q = a1 + b0
                        "vpmuldq %%ymm15, %%ymm14, %%ymm12",
                        f"vpaddq %%ymm12, {ACC[2 * r]}, {ACC[2 * r]}",
                        "vpsrlq $32, %%ymm14, %%ymm14", "vpsrlq $32, %%ymm15, %%ymm15",
                        "vpmuldq %%ymm15, %%ymm14, %%ymm14",
                        f"vpaddq %%ymm14, {ACC[2 * r + 1]}, {ACC[2 * r + 1]}"]
            else:
                ins += ["vpaddd %%ymm10, %%ymm12, %%ymm14", "vpaddd %%ymm8, %%ymm13, %%ymm15",
                        "vpmuldq %%ymm15, %%ymm14, %%ymm14", f"vpaddq %%ymm14, {ACC[2 * r]}, {ACC[2 * r]}",
                        "vpaddd %%ymm11, %%ymm12, %%ymm14", "vpaddd %%ymm9, %%ymm13, %%ymm15",
                        "vpmuldq %%ymm15, %%ymm14, %%ymm14", f"vpaddq %%ymm14, {ACC[2 * r + 1]}, {ACC[2 * r + 1]}"]
        if spread:
            i = s  # one accumulator folded after each k-pair: every accumulator once per period
            ins += ["vpxor %%xmm12, %%xmm12, %%xmm12"] + fold(ACC[i], "%%ymm13", "%%ymm12")
    return ins


def emit_kernel(name, period_ins, steps, spread):
    """Loop over periods of `steps` k-steps; burst folds happen at the top of every period but
    the first (jump into the loop past the fold)."""
    pa_step, pb_step = 16 * steps, 32 * steps
    lines = []
    if not spread:
        lines += ["jmp 2f", "1:", "vpxor %%xmm12, %%xmm12, %%xmm12"]
        for i in range(8):
            lines += fold(ACC[i], "%%ymm13", "%%ymm12")
        lines += ["2:"]
    else:
        lines += ["1:"]
    lines += period_ins
    lines += [f"add ${pa_step}, %[pa]", f"add ${pb_step}, %[pb]", "dec %[n]", "jnz 1b"]
    body = "\n".join(f'        "{l}\\n\\t"' for l in lines)
    return f'''// {name}: {len(period_ins)} instructions per {steps}-step period.
MP_AI void asm_{name}(const u32* pa, const u32* pb, long periods, V (&acc)[8]) {{
    static const V c32 = _mm256_set1_epi64x(C32);
    asm volatile(
{body}
        : [a0] "+x"(acc[0]), [a1] "+x"(acc[1]), [a2] "+x"(acc[2]), [a3] "+x"(acc[3]),
          [a4] "+x"(acc[4]), [a5] "+x"(acc[5]), [a6] "+x"(acc[6]), [a7] "+x"(acc[7]),
          [pa] "+r"(pa), [pb] "+r"(pb), [n] "+r"(periods)
        : [c32] "m"(c32)
        : "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15", "memory", "cc");
}}
constexpr int asm_{name}_period = {steps};
'''


def emit_tail(name, unit_ins, unit_steps):
    """asm_<name>_tail(pa, pb, units, acc): fold every accumulator, then `units` iterations of
    the one-unit body (a k-pair for the Winograd kernels, a k-step for the direct ones).
    Valid for units < one period, after at most one period since the last fold."""
    lines = ["vpxor %%xmm12, %%xmm12, %%xmm12"]
    for i in range(8):
        lines += fold(ACC[i], "%%ymm13", "%%ymm12")
    lines += ["1:"] + unit_ins + [f"add ${16 * unit_steps}, %[pa]", f"add ${32 * unit_steps}, %[pb]", "dec %[n]", "jnz 1b"]
    body = "\n".join(f'        "{l}\\n\\t"' for l in lines)
    return f'''MP_AI void asm_{name}_tail(const u32* pa, const u32* pb, long units, V (&acc)[8]) {{
    static const V c32 = _mm256_set1_epi64x(C32);
    asm volatile(
{body}
        : [a0] "+x"(acc[0]), [a1] "+x"(acc[1]), [a2] "+x"(acc[2]), [a3] "+x"(acc[3]),
          [a4] "+x"(acc[4]), [a5] "+x"(acc[5]), [a6] "+x"(acc[6]), [a7] "+x"(acc[7]),
          [pa] "+r"(pa), [pb] "+r"(pb), [n] "+r"(units)
        : [c32] "m"(c32)
        : "xmm8", "xmm9", "xmm10", "xmm11", "xmm12", "xmm13", "xmm14", "xmm15", "memory", "cc");
}}
constexpr int asm_{name}_unit = {unit_steps};
'''


def first_unit(ins, next_marker):
    """Instructions of the first unit of a generated period: everything before the first
    instruction that starts with next_marker (the first instruction of the second unit)."""
    for i, x in enumerate(ins):
        if x.startswith(next_marker):
            return ins[:i]
    raise ValueError("marker not found: " + next_marker)


def main():
    out = ['// Generated by gen_asm.py (exploration 013, step 3); do not edit by hand.',
           '#pragma once', '#include "simd.hpp"', '', 'namespace mp::simd {', '']
    kernels = []
    for hoist in (0, 1):
        for spread in (0, 1):
            name = f"direct_h{hoist}_s{spread}"
            out.append(emit_kernel(name, direct_period(hoist, spread), 32, spread))
            kernels.append((name, 32))
    for spread in (0,):
        name = f"direct_g_s{spread}"
        out.append(emit_kernel(name, direct_period_g(spread), 32, spread))
        kernels.append((name, 32))
    for mode in ("i2", "sh"):
        name = f"wipp_{mode}"
        out.append(emit_kernel(name, wipp_period_variant(mode), 16, 0))
        kernels.append((name, 16))
    for packed in (0, 1):
        for spread in (0, 1):
            name = f"wip{'p' if packed else ''}_s{spread}"
            out.append(emit_kernel(name, wip_period(packed, 0, spread), 16, spread))
            kernels.append((name, 16))
    # Tails for the kernels used by the Strassen leaves.
    out.append(emit_tail("wipp_s0", first_unit(wip_period(1, 0, 0), "vmovdqu 64("), 2))
    out.append(emit_tail("wipp_i2", first_unit(wipp_period_variant("i2"), "vmovdqu 64("), 2))
    out.append(emit_tail("wip_s0", first_unit(wip_period(0, 0, 0), "vmovsldup 64("), 2))
    out.append(emit_tail("direct_g_s0", first_unit(direct_period_g(0), "vbroadcastss 16(%[pa])"), 1))
    out.append('}  // namespace mp::simd')
    out.append('#define MP_ASM_KERNELS(X) ' + ' '.join(f'X({n}, {p})' for n, p in kernels))
    (HERE / 'asm_kernels.hpp').write_text('\n'.join(out) + '\n')
    print('wrote', len(kernels), 'kernels:', ', '.join(n for n, _ in kernels))


if __name__ == '__main__':
    main()
