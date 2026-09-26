"""Independent complete forward radix-4 loops, preserving the existing formula.

Only lazy, untwisted, non-identity forward butterflies change. Identity and inverse
butterflies remain the frozen h14 C++ implementation for a focused ablation.
"""
import json

VARIANTS = ("asm_radix4_serial", "asm_radix4_pair")


def _single(reg, w, wi):
    # Four temporaries; the in/out operand is overwritten only after its last use.
    return [f"vpsrlq $32, %%ymm{reg}, %%ymm12",
            f"vpmuludq %%ymm{w}, %%ymm{reg}, %%ymm13",
            f"vpmuludq %%ymm{w}, %%ymm12, %%ymm14",
            f"vpmuludq %%ymm{wi}, %%ymm{reg}, %%ymm15",
            "vpmuludq %%ymm10, %%ymm15, %%ymm15",
            "vpaddq %%ymm15, %%ymm13, %%ymm13",
            f"vpmuludq %%ymm{wi}, %%ymm12, %%ymm{reg}",
            f"vpmuludq %%ymm10, %%ymm{reg}, %%ymm{reg}",
            f"vpaddq %%ymm{reg}, %%ymm14, %%ymm14",
            "vpsrlq $32, %%ymm13, %%ymm13",
            f"vpor %%ymm14, %%ymm13, %%ymm{reg}"]


def _pair(a, b, wa, wia, wb, wib):
    # Interleave independent Montgomery operations with four temporaries.
    # ymm12/13 retain odd input lanes; ymm14/15 retain even products.
    return [f"vpsrlq $32, %%ymm{a}, %%ymm12",
            f"vpsrlq $32, %%ymm{b}, %%ymm13",
            f"vpmuludq %%ymm{wa}, %%ymm{a}, %%ymm14",
            f"vpmuludq %%ymm{wb}, %%ymm{b}, %%ymm15",
            f"vpmuludq %%ymm{wia}, %%ymm{a}, %%ymm{a}",
            f"vpmuludq %%ymm{wib}, %%ymm{b}, %%ymm{b}",
            f"vpmuludq %%ymm10, %%ymm{a}, %%ymm{a}",
            f"vpmuludq %%ymm10, %%ymm{b}, %%ymm{b}",
            f"vpaddq %%ymm{a}, %%ymm14, %%ymm14",
            f"vpaddq %%ymm{b}, %%ymm15, %%ymm15",
            f"vpmuludq %%ymm{wa}, %%ymm12, %%ymm{a}",
            f"vpmuludq %%ymm{wb}, %%ymm13, %%ymm{b}",
            f"vpmuludq %%ymm{wia}, %%ymm12, %%ymm12",
            f"vpmuludq %%ymm{wib}, %%ymm13, %%ymm13",
            "vpmuludq %%ymm10, %%ymm12, %%ymm12",
            "vpmuludq %%ymm10, %%ymm13, %%ymm13",
            f"vpaddq %%ymm12, %%ymm{a}, %%ymm{a}",
            f"vpaddq %%ymm13, %%ymm{b}, %%ymm{b}",
            "vpsrlq $32, %%ymm14, %%ymm14",
            "vpsrlq $32, %%ymm15, %%ymm15",
            f"vpor %%ymm14, %%ymm{a}, %%ymm{a}",
            f"vpor %%ymm15, %%ymm{b}, %%ymm{b}"]


def _forward(paired):
    ops = [f"vmovdqa {32*i}(%[tw]), %%ymm{4+i}" for i in range(6)]
    ops += ["vpbroadcastd 0(%[mod]), %%ymm10",
            "vpbroadcastd 4(%[mod]), %%ymm11", ".p2align 5", "1:",
            "vmovdqa (%[aa]), %%ymm0", "vmovdqa (%[bb]), %%ymm1",
            "vmovdqa (%[cc]), %%ymm2", "vmovdqa (%[dd]), %%ymm3",
            "vpsubd %%ymm11, %%ymm0, %%ymm12",
            "vpsubd %%ymm11, %%ymm1, %%ymm13",
            "vpminud %%ymm12, %%ymm0, %%ymm0",
            "vpminud %%ymm13, %%ymm1, %%ymm1"]
    ops += _pair(2, 3, 4, 5, 4, 5) if paired else _single(2, 4, 5) + _single(3, 4, 5)
    # Keep amc in ymm0, bmd in ymm1, bd in ymm2, ac in ymm3.
    ops += ["vpaddd %%ymm2, %%ymm0, %%ymm12",
            "vpaddd %%ymm11, %%ymm0, %%ymm0",
            "vpsubd %%ymm2, %%ymm0, %%ymm0",
            "vpaddd %%ymm3, %%ymm1, %%ymm2",
            "vpaddd %%ymm11, %%ymm1, %%ymm1",
            "vpsubd %%ymm3, %%ymm1, %%ymm1",
            "vpsubd %%ymm11, %%ymm0, %%ymm14",
            "vpsubd %%ymm11, %%ymm12, %%ymm15",
            "vpminud %%ymm14, %%ymm0, %%ymm0",
            "vpminud %%ymm15, %%ymm12, %%ymm3"]
    ops += _pair(2, 1, 6, 7, 8, 9) if paired else _single(2, 6, 7) + _single(1, 8, 9)
    ops += ["vpaddd %%ymm2, %%ymm3, %%ymm12",
            "vpaddd %%ymm11, %%ymm3, %%ymm3",
            "vpsubd %%ymm2, %%ymm3, %%ymm3",
            "vpaddd %%ymm1, %%ymm0, %%ymm13",
            "vpaddd %%ymm11, %%ymm0, %%ymm0",
            "vpsubd %%ymm1, %%ymm0, %%ymm0",
            "vmovdqa %%ymm12, (%[aa])", "vmovdqa %%ymm3, (%[bb])",
            "vmovdqa %%ymm13, (%[cc])", "vmovdqa %%ymm0, (%[dd])",
            "add $32, %[aa]", "add $32, %[bb]",
            "add $32, %[cc]", "add $32, %[dd]", "dec %[count]", "jnz 1b"]
    body = "\n".join("        " + json.dumps(op + "\n\t") for op in ops)
    return '''// All four coefficients remain below 4P, exactly as the C++ formula.
// Twiddle has six consecutive aligned YMM members: x.w,x.wi,y.w,y.wi,z.w,z.wi.
__attribute__((always_inline)) inline void radix4_forward_asm(V* f,int h,const Twiddle& t) {
    static_assert(sizeof(Fixed)==64 && sizeof(Twiddle)==192);
    static constexpr U mod[2]={P,P2};
    V* a=f; V* b=f+h; V* c=f+2*h; V* d=f+3*h; int count=h;
    asm volatile(
''' + body + '''
        : [aa] "+&r"(a), [bb] "+&r"(b), [cc] "+&r"(c),
          [dd] "+&r"(d), [count] "+&r"(count)
        : [tw] "r"(&t), [mod] "r"(mod)
        : "cc", "memory", ''' + ', '.join('"ymm'+str(i)+'"' for i in range(16)) + ''');
}

'''


def transform(source: str, variant: str) -> str:
    if variant not in VARIANTS:
        raise ValueError(f"unknown radix assembly variant: {variant}")
    marker = "template<bool Lazy,bool Twist,bool Identity,bool Inverse>\n"
    assert source.count(marker) == 1
    source = source.replace(marker, _forward(variant == "asm_radix4_pair") + marker)
    marker = "void radix4(V* f,int h,const Twiddle& t) {\n"
    assert source.count(marker) == 1
    return source.replace(marker, marker + '''    if constexpr(Lazy && !Twist && !Identity && !Inverse) {
        radix4_forward_asm(f,h,t);
        return;
    }
''')
