"""Complete non-identity inverse radix-4 AVX2 loops, from our frozen h14 math.

The scalar generator helpers are shared with our forward assembly experiment;
generated C++ is self-contained. No study/reference source is used.
"""
import json
from radix_asm_transforms import _single, _pair

VARIANTS = ("asm_inverse_serial", "asm_inverse_pair")


def _inverse(paired):
    ops = [f"vmovdqa {32*i}(%[tw]), %%ymm{4+i}" for i in range(6)]
    ops += ["vpbroadcastd 0(%[mod]), %%ymm10",
            "vpbroadcastd 4(%[mod]), %%ymm11", ".p2align 5", "1:",
            "vmovdqa (%[aa]), %%ymm0", "vmovdqa (%[bb]), %%ymm1",
            "vmovdqa (%[cc]), %%ymm2", "vmovdqa (%[dd]), %%ymm3",
            # Form amb in ymm0, ab in ymm1, cmd in ymm2, cd in ymm3.
            "vpaddd %%ymm1, %%ymm0, %%ymm12",
            "vpaddd %%ymm3, %%ymm2, %%ymm13",
            "vpaddd %%ymm11, %%ymm0, %%ymm0",
            "vpaddd %%ymm11, %%ymm2, %%ymm2",
            "vpsubd %%ymm1, %%ymm0, %%ymm0",
            "vpsubd %%ymm3, %%ymm2, %%ymm2",
            "vpsubd %%ymm11, %%ymm12, %%ymm14",
            "vpsubd %%ymm11, %%ymm13, %%ymm15",
            "vpminud %%ymm14, %%ymm12, %%ymm1",
            "vpminud %%ymm15, %%ymm13, %%ymm3"]
    ops += _pair(0, 2, 6, 7, 8, 9) if paired else _single(0, 6, 7) + _single(2, 8, 9)
    # Keep o3's argument in ymm0, o2's in ymm1, o1 in ymm2, o0 in ymm3.
    ops += ["vpaddd %%ymm3, %%ymm1, %%ymm12",
            "vpaddd %%ymm2, %%ymm0, %%ymm13",
            "vpaddd %%ymm11, %%ymm1, %%ymm1",
            "vpaddd %%ymm11, %%ymm0, %%ymm0",
            "vpsubd %%ymm3, %%ymm1, %%ymm1",
            "vpsubd %%ymm2, %%ymm0, %%ymm0",
            "vpsubd %%ymm11, %%ymm12, %%ymm14",
            "vpsubd %%ymm11, %%ymm13, %%ymm15",
            "vpminud %%ymm14, %%ymm12, %%ymm3",
            "vpminud %%ymm15, %%ymm13, %%ymm2"]
    ops += _pair(1, 0, 4, 5, 4, 5) if paired else _single(1, 4, 5) + _single(0, 4, 5)
    ops += ["vmovdqa %%ymm3, (%[aa])", "vmovdqa %%ymm2, (%[bb])",
            "vmovdqa %%ymm1, (%[cc])", "vmovdqa %%ymm0, (%[dd])",
            "add $32, %[aa]", "add $32, %[bb]",
            "add $32, %[cc]", "add $32, %[dd]", "dec %[count]", "jnz 1b"]
    body = "\n".join("        " + json.dumps(op + "\n\t") for op in ops)
    return '''// Inverse inputs and outputs remain below 2P. Fixed arguments <4P.
__attribute__((always_inline)) inline void radix4_inverse_asm(V* f,int h,const Twiddle& t) {
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
        raise ValueError(f"unknown inverse assembly variant: {variant}")
    marker = "template<bool Lazy,bool Twist,bool Identity,bool Inverse>\n"
    assert source.count(marker) == 1
    source = source.replace(marker, _inverse(variant == "asm_inverse_pair") + marker)
    marker = "void radix4(V* f,int h,const Twiddle& t) {\n"
    assert source.count(marker) == 1
    return source.replace(marker, marker + '''    if constexpr(Lazy && !Twist && !Identity && Inverse) {
        radix4_inverse_asm(f,h,t);
        return;
    }
''')
