"""Forward-only Montgomery twiddle representation experiments.

Inverse, root-table generation, direct8 products and normalization retain the
frozen Fixed implementation. The arithmetic/ranges are identical; only the
state exposed to register allocation and broadcast placement changes.
"""

VARIANTS = ("h14_forward_scalar", "h14_forward_late", "h14_forward_packed")


MUL = """        V e=_mm256_mul_epu32(x,w),o=_mm256_mul_epu32(odd(x),w);
        e=_mm256_add_epi64(e,_mm256_mul_epu32(_mm256_mul_epu32(x,wi),splat(P)));
        o=_mm256_add_epi64(o,_mm256_mul_epu32(_mm256_mul_epu32(odd(x),wi),splat(P)));
        return _mm256_or_si256(odd(e),o);
"""


def _fixed(kind: str) -> str:
    if kind == "scalar":
        fields = """    U value,correction;
    explicit ForwardFixed(V x):value(U(_mm256_extract_epi32(x,0))),correction(value*NI){}
"""
        expand = "        V w=splat(value),wi=splat(correction);\n"
    elif kind == "late":
        fields = """    U value;
    explicit ForwardFixed(V x):value(U(_mm256_extract_epi32(x,0))){}
"""
        expand = "        V w=splat(value),wi=splat(value*NI);\n"
    elif kind == "packed":
        fields = """    V packed;
    explicit ForwardFixed(V x) {
        U value=U(_mm256_extract_epi32(x,0));
        packed=_mm256_set1_epi64x(W(value)|(W(value*NI)<<32));
    }
"""
        expand = "        V w=packed,wi=odd(packed);\n"
    else:
        raise ValueError(kind)
    return "struct ForwardFixed {\n" + fields + """    __attribute__((always_inline)) inline V operator()(V x) const {
""" + expand + MUL + """    }
};
struct ForwardTwiddle {
    ForwardFixed x,y,z;
    ForwardTwiddle(V a,V b,V c):x(a),y(b),z(c){}
};
"""


def _replace(s: str, old: str, new: str, count: int = 1) -> str:
    assert s.count(old) == count, (old, s.count(old))
    return s.replace(old, new)


def transform(source: str, variant: str) -> str:
    if variant not in VARIANTS:
        raise ValueError(variant)
    kind = variant.removeprefix("h14_forward_")
    source = _replace(source,
        "// Lazy=false is an ablation", _fixed(kind) + "\n// Lazy=false is an ablation")
    source = _replace(source,
        "template<bool Lazy,bool Twist,bool Identity,bool Inverse>\n",
        "template<bool Lazy,bool Twist,bool Identity,bool Inverse,class TT>\n")
    source = _replace(source, "void radix4(V* f,int h,const Twiddle& t)",
        "void radix4(V* f,int h,const TT& t)")
    source = _replace(source, "inline Twiddle twiddle(int h,int k)",
        "inline auto twiddle(int h,int k)")
    # Both root modes are maintained so compile-time selection keeps its original
    # behavior; all current experiments instantiate the hybrid table mode.
    for args in (
        "splat(x),splat(y),splat(z)",
        "_mm256_permute4x64_epi64(current,0x00),_mm256_permute4x64_epi64(current,0x55),_mm256_permute4x64_epi64(current,0xaa)",
    ):
        source = _replace(source, f"return Twiddle({args});",
            f"if constexpr(Inv)return Twiddle({args});\n"
            f"            else return ForwardTwiddle({args});")
    return _replace(source, "Twiddle t=twiddle<Inv>", "auto t=twiddle<Inv>", 3)
