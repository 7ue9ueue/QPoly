"""Independent traversal/scheduling experiments over the frozen ll_inline_h14.

These transformations preserve its arithmetic, root representation and scratch
contract. No study/reference code is used. Each match is asserted deliberately:
applying an experiment to a different starting source must fail visibly.
"""

VARIANTS = (
    "h14_fuse_bottom",
    "h14_fuse_two",
    "h14_fixed_tile",
    "h14_fixed_bottom",
    "h14_pair_forward",
)


def replace_once(s: str, old: str, new: str) -> str:
    assert s.count(old) == 1, (old[:100], s.count(old))
    return s.replace(old, new, 1)


def fused_bottom(s: str) -> str:
    """Keep four transformed vectors adjacent to their direct products/inverse."""
    s = replace_once(s,
        "        for(int j=0;j<nv;j+=4) {\n            U w[4];",
        "        for(int j=0;j<nv;j+=4) {\n"
        "            group<false>(a+j,b+j,1,(first+j)/4);\n"
        "            U w[4];")
    s = replace_once(s,
        "            else leaf<4,LeafSchedule>(a+j,b+j,w);",
        "            else leaf<4,LeafSchedule>(a+j,b+j,w);\n"
        "            group<true>(a+j,nullptr,1,(first+j)/4);")
    s = replace_once(s, "for(int h=nv/4;h;h/=4)", "for(int h=nv/4;h>1;h/=4)")
    s = replace_once(s, "for(int h=1;h<nv;h*=4)", "for(int h=4;h<nv;h*=4)")
    return s


def fused_two(s: str) -> str:
    """Extend the bottom fusion to 16-vector (128-coefficient) subtrees."""
    s = fused_bottom(s)
    s = replace_once(s, "for(int h=nv/4;h>1;h/=4)", "for(int h=nv/4;h>4;h/=4)")
    s = replace_once(s, "            leaves(a,b,nv,k*nv);", """            if(nv==4)leaves(a,b,nv,k*nv);
            else for(int j=0;j<nv;j+=16) {
                int key=(k*nv+j)/16;
                group<false>(a+j,b+j,4,key);
                leaves(a+j,b+j,16,k*nv+j);
                group<true>(a+j,nullptr,4,key);
            }""")
    s = replace_once(s, "for(int h=4;h<nv;h*=4)", "for(int h=16;h<nv;h*=4)")
    return s


def fixed_tile(s: str, bottom: bool = False) -> str:
    """Make the stages and group-key arithmetic constant within the tile.

    The noinline boundary is once per tile, avoiding cloning the four complete
    tile specializations into every recursive caller. A group loop is kept
    counted so exposing its bounds does not also force hundreds of group copies.
    """
    low = 4 if bottom else 1
    s = replace_once(s, "    void visit(V* a,V* b,int nv,int k) {", f"""    template<int NV,int H>
    __attribute__((always_inline)) inline void tile_forward(V* a,V* b,int k) {{
        if constexpr(H>={low}) {{
            #pragma GCC unroll 1
            for(int j=0;j<NV;j+=4*H)group<false>(a+j,b+j,H,k*(NV/(4*H))+j/(4*H));
            tile_forward<NV,H/4>(a,b,k);
        }}
    }}
    template<int NV,int H>
    __attribute__((always_inline)) inline void tile_inverse(V* a,int k) {{
        if constexpr(H<NV) {{
            #pragma GCC unroll 1
            for(int j=0;j<NV;j+=4*H)group<true>(a+j,nullptr,H,k*(NV/(4*H))+j/(4*H));
            tile_inverse<NV,H*4>(a,k);
        }}
    }}
    template<int NV>
    __attribute__((noinline)) void fixed_tile(V* a,V* b,int k) {{
        tile_forward<NV,NV/4>(a,b,k);
        leaves(a,b,NV,k*NV);
        tile_inverse<NV,{low}>(a,k);
    }}
    void visit(V* a,V* b,int nv,int k) {{""")
    start = s.index("        if(nv<=Tile) {", s.index("    void visit("))
    end = s.index("        } else {", start)
    s = s[:start] + """        if(nv<=Tile) {
            static_assert(Tile==256,"fixed tile experiment dispatches the original tile sizes");
            switch(nv) {
                case 4:fixed_tile<4>(a,b,k);break;
                case 16:fixed_tile<16>(a,b,k);break;
                case 64:fixed_tile<64>(a,b,k);break;
                case 256:fixed_tile<256>(a,b,k);break;
                default:assert(false);
            }
""" + s[end:]
    return s


def pair_forward(s: str) -> str:
    """Schedule the two independent input transforms within each j iteration."""
    start = s.index("template<bool Lazy,bool Twist,bool Identity,bool Inverse>\n")
    stop = s.index("\n// Own direct8", start)
    radix = s[start:stop]
    body_start = radix.index("        V a=f[j],b=f[j+h],c=f[j+2*h],d=f[j+3*h];")
    body_end = radix.index("\n    }\n}", body_start)
    body = radix[body_start:body_end]
    paired = """// Fuse only the forward A/B traversal; the arithmetic is unchanged.
template<bool Lazy,bool Twist,bool Identity>
__attribute__((always_inline)) inline void radix4_pair(V* fa,V* fb,int h,const Twiddle& t) {
    constexpr bool Inverse=false;
    const Fixed imag(constants.q[0]);
    for(int j=0;j<h;++j) {
        auto one=[&](V* f) __attribute__((always_inline)) {
""" + body + """
        };
        one(fa);one(fb);
    }
}
"""
    s = s[:stop] + "\n" + paired + s[stop:]
    # All three existing group paths (h=1, h=4, runtime h) use the same pairing.
    for h in ("1", "4", "h"):
        for identity in ("true", "false"):
            old = f"            radix4<Lazy,Twist,{identity},Inv>(a,{h},t);\n            if constexpr(!Inv)radix4<Lazy,Twist,{identity},false>(b,{h},t);"
            new = f"            if constexpr(Inv)radix4<Lazy,Twist,{identity},true>(a,{h},t);\n            else radix4_pair<Lazy,Twist,{identity}>(a,b,{h},t);"
            s = replace_once(s, old, new)
    return s


def transform(source: str, variant: str) -> str:
    if variant == "h14_fuse_bottom":
        return fused_bottom(source)
    if variant == "h14_fuse_two":
        return fused_two(source)
    if variant == "h14_fixed_tile":
        return fixed_tile(source)
    if variant == "h14_fixed_bottom":
        return fixed_tile(fused_bottom(source), bottom=True)
    if variant == "h14_pair_forward":
        return pair_forward(source)
    raise ValueError(variant)
