"""Whole-leaf GNU AVX2 assembly, independently derived from our direct8 kernel.

This replaces preparation, accumulation, and reduction together. Earlier
lowlevel experiments put only the accumulation loop in assembly and transferred
its eight accumulators through C++ arrays before Montgomery reduction.

transform() is pure; the shared experiment generator chooses the namespace and
instantiation. No study/reference source is used here.
"""
import json


VARIANTS = ("asm_leaf_full", "asm_leaf_pair", "asm_leaf_inplace")


def _leaf(paired=False, inplace=False):
    # Constants are reloaded after the dot-product loop because the paired
    # schedule deliberately uses all 16 YMM registers.
    ops = ["vpbroadcastd 0(%[mod]), %%ymm13",
           "vpbroadcastd 4(%[mod]), %%ymm14",
           "vpbroadcastd 8(%[mod]), %%ymm15"]
    for t in range(4):
        # Fully canonical x and y; incoming forward coefficients can be <4P.
        ops += [f"vmovdqa {32*t}(%[aa]), %%ymm0",
                f"vmovdqa {32*t}(%[bb]), %%ymm1",
                "vpsubd %%ymm14, %%ymm0, %%ymm2",
                "vpsubd %%ymm14, %%ymm1, %%ymm3",
                "vpminud %%ymm2, %%ymm0, %%ymm0",
                "vpminud %%ymm3, %%ymm1, %%ymm1",
                "vpsubd %%ymm13, %%ymm0, %%ymm2",
                "vpsubd %%ymm13, %%ymm1, %%ymm3",
                "vpminud %%ymm2, %%ymm0, %%ymm0",
                "vpminud %%ymm3, %%ymm1, %%ymm1",
                f"vmovdqa %%ymm0, {64*t+32}(%[scratch])",
                f"vmovdqa %%ymm1, {32*t}(%[coefbase])",
                f"vpbroadcastd {4*t}(%[weight]), %%ymm2",
                "vpmuludq %%ymm15, %%ymm2, %%ymm3",
                "vpsrlq $32, %%ymm0, %%ymm1",
                "vpmuludq %%ymm2, %%ymm0, %%ymm4",
                "vpmuludq %%ymm2, %%ymm1, %%ymm5",
                "vpmuludq %%ymm3, %%ymm0, %%ymm6",
                "vpmuludq %%ymm3, %%ymm1, %%ymm7",
                "vpmuludq %%ymm13, %%ymm6, %%ymm6",
                "vpmuludq %%ymm13, %%ymm7, %%ymm7",
                "vpaddq %%ymm6, %%ymm4, %%ymm4",
                "vpaddq %%ymm7, %%ymm5, %%ymm5",
                "vpsrlq $32, %%ymm4, %%ymm4",
                "vpor %%ymm5, %%ymm4, %%ymm4",
                "vpsubd %%ymm13, %%ymm4, %%ymm5",
                "vpminud %%ymm5, %%ymm4, %%ymm4",
                f"vmovdqa %%ymm4, {64*t}(%[scratch])"]

    ops += [f"vpxor %%ymm{i}, %%ymm{i}, %%ymm{i}" for i in range(8)]
    ops += ["mov $8, %[count]", ".p2align 5", "1:"]
    if paired:
        for t in (0, 2):
            ops += [f"vmovdqu {64*t}(%[win]), %%ymm8",
                    f"vmovdqu {64*(t+1)}(%[win]), %%ymm9",
                    f"vpbroadcastd {32*t}(%[coef]), %%ymm10",
                    f"vpbroadcastd {32*(t+1)}(%[coef]), %%ymm11",
                    "vpmuludq %%ymm10, %%ymm8, %%ymm12",
                    "vpmuludq %%ymm11, %%ymm9, %%ymm13",
                    "vpsrlq $32, %%ymm8, %%ymm8",
                    "vpsrlq $32, %%ymm9, %%ymm9",
                    "vpmuludq %%ymm10, %%ymm8, %%ymm14",
                    "vpmuludq %%ymm11, %%ymm9, %%ymm15",
                    f"vpaddq %%ymm12, %%ymm{2*t}, %%ymm{2*t}",
                    f"vpaddq %%ymm13, %%ymm{2*t+2}, %%ymm{2*t+2}",
                    f"vpaddq %%ymm14, %%ymm{2*t+1}, %%ymm{2*t+1}",
                    f"vpaddq %%ymm15, %%ymm{2*t+3}, %%ymm{2*t+3}"]
    else:
        for t in range(4):
            ops += [f"vmovdqu {64*t}(%[win]), %%ymm8",
                    f"vpbroadcastd {32*t}(%[coef]), %%ymm9",
                    "vpmuludq %%ymm9, %%ymm8, %%ymm10",
                    "vpsrlq $32, %%ymm8, %%ymm11",
                    "vpmuludq %%ymm9, %%ymm11, %%ymm12",
                    f"vpaddq %%ymm10, %%ymm{2*t}, %%ymm{2*t}",
                    f"vpaddq %%ymm12, %%ymm{2*t+1}, %%ymm{2*t+1}"]
    ops += ["sub $4, %[win]", "add $4, %[coef]", "dec %[count]", "jnz 1b",
            "vpbroadcastd 0(%[mod]), %%ymm13",
            "vpbroadcastd 4(%[mod]), %%ymm14",
            "vpbroadcastd 8(%[mod]), %%ymm15"]

    for t in range(4):
        e, o = 2*t, 2*t+1
        ops += [f"vpmuludq %%ymm15, %%ymm{e}, %%ymm8",
                f"vpmuludq %%ymm15, %%ymm{o}, %%ymm9",
                "vpmuludq %%ymm13, %%ymm8, %%ymm8",
                "vpmuludq %%ymm13, %%ymm9, %%ymm9",
                f"vpaddq %%ymm8, %%ymm{e}, %%ymm{e}",
                f"vpaddq %%ymm9, %%ymm{o}, %%ymm{o}",
                f"vpsrlq $32, %%ymm{e}, %%ymm{e}",
                f"vpor %%ymm{o}, %%ymm{e}, %%ymm{e}",
                f"vpsubd %%ymm14, %%ymm{e}, %%ymm8",
                f"vpminud %%ymm8, %%ymm{e}, %%ymm{e}",
                f"vmovdqa %%ymm{e}, {32*t}(%[aa])"]

    body = "\n".join("        " + json.dumps(op + "\n\t") for op in ops)
    return '''template<int Batch,int Schedule=0>
__attribute__((always_inline)) inline void leaf(V* a,V* b,const U* weights) {
    static_assert(Batch==4, "whole-leaf assembly uses four independent products");
    // Every scratch byte is written before any read. Suppress optional compiler
    // zero-initialization; otherwise -ftrivial-auto-var-init=zero adds a memset.
    alignas(32) U scratch[''' + str(64 if inplace else 96) + ''']
        __attribute__((uninitialized));
    static constexpr U mod[3]={P,P2,NI};
    U* coeff=''' + ('reinterpret_cast<U*>(b)' if inplace else 'scratch+64') + ''';
    const U* wp=scratch+8; const U* cp=coeff; int count;
    // Whole GNU asm block, AT&T syntax. B may be overwritten by the inplace
    // variant; this is within Kernel::run's existing destructive-input contract.
    // All registers and memory modifications are declared. The pointer operands
    // are early-clobber because the assembly mutates them before its last input.
    asm volatile(
''' + body + '''
        : [win] "+&r"(wp), [coef] "+&r"(cp), [count] "=&r"(count)
        : [aa] "r"(a), [bb] "r"(b), [weight] "r"(weights),
          [scratch] "r"(scratch), [coefbase] "r"(coeff), [mod] "r"(mod)
        : "cc", "memory", ''' + ', '.join('"ymm'+str(i)+'"' for i in range(16)) + ''');
}

'''


def transform(source: str, variant: str) -> str:
    if variant not in VARIANTS:
        raise ValueError(f"unknown assembly variant: {variant}")
    start = source.index("template<int Batch,int Schedule=0>\n")
    end = source.index("// RootMode=0:", start)
    return (source[:start]
            + _leaf(paired=variant != "asm_leaf_full", inplace=variant == "asm_leaf_inplace")
            + source[end:])
