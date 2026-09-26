"""C++ scheduling experiments for two operands sharing a Montgomery constant.

The two inputs retain exactly the original x<4P and w<P contract. This changes
only the way independent operations are exposed to the optimizer, not the
number of multiplies or the arithmetic. Native assembly/timing must decide
whether a compiler actually chooses a better schedule.
"""

VARIANTS = ("h14_pairmul_small", "h14_pairmul_all")


PAIR = """    // Finish the two even-lane correction chains before creating odd-lane
    // products, so the source does not expose eight wide products at once.
    __attribute__((always_inline)) inline void pair(V& x,V& y) const {
        V p=splat(P);
        V xe=_mm256_mul_epu32(x,w),ye=_mm256_mul_epu32(y,w);
        V xc=_mm256_mul_epu32(x,wi),yc=_mm256_mul_epu32(y,wi);
        xe=odd(_mm256_add_epi64(xe,_mm256_mul_epu32(xc,p)));
        ye=odd(_mm256_add_epi64(ye,_mm256_mul_epu32(yc,p)));
        x=odd(x);y=odd(y);
        V xo=_mm256_mul_epu32(x,w),yo=_mm256_mul_epu32(y,w);
        xc=_mm256_mul_epu32(x,wi);yc=_mm256_mul_epu32(y,wi);
        xo=_mm256_add_epi64(xo,_mm256_mul_epu32(xc,p));
        yo=_mm256_add_epi64(yo,_mm256_mul_epu32(yc,p));
        x=_mm256_or_si256(xe,xo);y=_mm256_or_si256(ye,yo);
    }
"""


def transform(source: str, variant: str) -> str:
    if variant not in VARIANTS:
        raise ValueError(variant)
    marker = "struct Fixed {\n"
    assert source.count(marker) == 1
    source = source.replace(marker, marker + PAIR, 1)
    old = "else {c=t.x(c);d=t.x(d);}"
    assert source.count(old) == 1
    if variant == "h14_pairmul_small":
        new = "else {if(h<=4)t.x.pair(c,d);else {c=t.x(c);d=t.x(d);}}"
    else:
        new = "else {t.x.pair(c,d);}"
    return source.replace(old, new, 1)
