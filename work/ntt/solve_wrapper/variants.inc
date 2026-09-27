// Wrapper experiments. All call the exact same asm_radix4_pair_large_fixed kernel.
// Judge contract: canonical inputs modulo 998244353, each size <= 2^19.
namespace wrapper_experiment {
using Vec = std::vector<int>;
using U = uint32_t;
constexpr U mod = 998244353;
constexpr int limit = 1 << 20;

inline bool small(Vec& a, Vec& b, Vec& result) {
    if (a.empty() || b.empty()) return true;
    if (a.size() < b.size()) a.swap(b);
    if (b.size() == 1) {
        const U multiplier = b[0];
        for (int& x : a) x = uint64_t(U(x)) * multiplier % mod;
        result = std::move(a);
        return true;
    }
    if (b.size() > 16) return false;
    // At most 16 canonical products fit in uint64_t; reduce once per output.
    static_assert(uint64_t(16) * (mod-1) * (mod-1) < UINT64_MAX);
    result.resize(a.size() + b.size() - 1);
    const int n = int(a.size()), m = int(b.size());
    for (int i = 0; i < int(result.size()); ++i) {
        uint64_t sum = 0;
        const int lo = std::max(0, i - n + 1), hi = std::min(i + 1, m);
        for (int j = lo; j < hi; ++j) sum += uint64_t(U(a[i-j])) * U(b[j]);
        result[i] = sum % mod;
    }
    return true;
}
inline int length_for(size_t count) {
    return 1 << (32 - __builtin_clz(unsigned(std::max<size_t>(64, count) - 1)));
}
struct FreeAligned { void operator()(U* p) const noexcept { _mm_free(p); } };
using Owner = std::unique_ptr<U, FreeAligned>;
inline Owner allocate(size_t words) {
    Owner p(static_cast<U*>(_mm_malloc(words * sizeof(U), 32)));
    if (!p) throw std::bad_alloc();
    return p;
}

template<bool Cache>
Vec static_scratch(Vec a, Vec b) {
    Vec result;
    if (small(a, b, result)) return result;
    const size_t count = a.size() + b.size() - 1;
    const int length = length_for(count);
    alignas(32) static U aa[limit], bb[limit];
    alignas(32) static U roots[limit/16], inverse_roots[limit/16];
    static int root_size = 0, high_water = 0;
    std::memcpy(aa, a.data(), a.size() * sizeof(U));
    std::memcpy(bb, b.data(), b.size() * sizeof(U));
    // First-call BSS padding is already zero. After reuse, clear every possibly
    // dirty coefficient; high_water must not shrink when a smaller call occurs.
    const int dirty_end = Cache ? std::min(high_water, length) : length;
    if (size_t(dirty_end) > a.size()) std::fill(aa+a.size(), aa+dirty_end, 0u);
    if (size_t(dirty_end) > b.size()) std::fill(bb+b.size(), bb+dirty_end, 0u);
    high_water = std::max(high_water, length);
    asm_radix4_pair_large_fixed::invoke(length, aa, bb, roots, inverse_roots, root_size, !Cache);
    return Vec(aa, aa+count);
}

// Resize creates live int elements; alignment uses an interior pointer. Never
// mutate vector internals or write past size() into capacity-only storage.
inline U* prepare(Vec& a, int length) {
    const size_t count = a.size();
    a.resize(size_t(length) + 7);
    const size_t offset = ((32 - (reinterpret_cast<uintptr_t>(a.data()) & 31)) & 31) / sizeof(int);
    int* p = a.data() + offset;
    if (offset) std::memmove(p, a.data(), count * sizeof(int));
    return reinterpret_cast<U*>(p);
}
inline void finish(Vec& a, U* aa, size_t count) {
    if (static_cast<void*>(a.data()) != static_cast<void*>(aa))
        std::memmove(a.data(), aa, count * sizeof(int));
    a.resize(count);
}
template<bool Both>
Vec reuse_vectors(Vec a, Vec b) {
    Vec result;
    if (small(a, b, result)) return result;
    const size_t count = a.size() + b.size() - 1;
    const int length = length_for(count);
    const size_t rs = std::max(8, length / 16);
    auto storage = allocate((Both ? 0 : size_t(length)) + 2*rs);
    U* aa = prepare(a, length);
    U* bb;
    U* roots;
    if constexpr (Both) {
        bb = prepare(b, length);
        roots = storage.get();
    } else {
        bb = storage.get();
        roots = bb + length;
        std::memcpy(bb, b.data(), b.size() * sizeof(U));
        std::fill(bb+b.size(), bb+length, 0u);
    }
    int root_size = 0;
    asm_radix4_pair_large_fixed::invoke(length, aa, bb, roots, roots+rs, root_size, true);
    finish(a, aa, count);
    return a;
}
} // namespace wrapper_experiment

std::vector<int> solve_static_fresh(std::vector<int> a, std::vector<int> b) {
    return wrapper_experiment::static_scratch<false>(std::move(a),std::move(b));
}
std::vector<int> solve_static_cached(std::vector<int> a, std::vector<int> b) {
    return wrapper_experiment::static_scratch<true>(std::move(a),std::move(b));
}
std::vector<int> solve_reuse_a(std::vector<int> a, std::vector<int> b) {
    return wrapper_experiment::reuse_vectors<false>(std::move(a),std::move(b));
}
std::vector<int> solve_reuse_both(std::vector<int> a, std::vector<int> b) {
    return wrapper_experiment::reuse_vectors<true>(std::move(a),std::move(b));
}
