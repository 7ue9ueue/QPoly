// Exploration 014: transform-level checks and timings for convolution_mod_large variants.
//   bench_ntt check [max_lg]   (1) the N1 twiddle generator equals the full root tables entry by
//                              entry (both directions, lg 9..max_lg); (2) for lg 9..max_lg and
//                              several input shapes every entry is bit-identical to qlarge::Core
//                              (exploration-010 driver), which is itself checked against a textbook
//                              NTT (lg <= 18) or at 8 random evaluation points (lg >= 19); exit 1 on
//                              any failure
//   bench_ntt time lg reps     interleaved timings at n = 2^lg, N = M = n/2 random inputs; tables
//                              "warm" (pre-faulted, reused) and "fresh" (new THP mapping per call, as
//                              in the submission, where tables are first touched inside the call)
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "core_tw.hpp"
#include <algorithm>
#include <chrono>
#include <cpuid.h>
#include <cstdio>
#include <cstring>
#include <random>
#include <string>
#include <sys/mman.h>
#include <vector>

namespace {
using U = uint32_t;
constexpr U P = 998244353;
[[noreturn]] void fail(const std::string& s) { std::printf("FAIL %s\n", s.c_str()); std::fflush(stdout); std::exit(1); }
double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }

void* map_huge(size_t bytes, bool prefault) {
    constexpr size_t huge = size_t(2) << 20;
    bytes = (bytes + huge - 1) & ~(huge - 1);
    char* raw = (char*)mmap(nullptr, bytes + huge, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (raw == MAP_FAILED) fail("mmap");
    char* p = (char*)(((uintptr_t)raw + huge - 1) & ~uintptr_t(huge - 1));
#ifdef MADV_HUGEPAGE
    madvise(p, bytes, MADV_HUGEPAGE);
#endif
    if (prefault) for (size_t i = 0; i < bytes; i += 4096) ((volatile char*)p)[i] = 0;
    return p;
}

using Fn = void (*)(int lg, U* a, U* b, qlarge::Tables& T, long nza, long nzb);
void e_core(int lg, U* a, U* b, qlarge::Tables& T, long nza, long nzb) { qlarge::Core<qlarge::Sel>::run(lg, a, b, T, nza, nzb); }
void e_tw(int lg, U* a, U* b, qlarge::Tables& T, long nza, long nzb) { qopt::CoreTw<qlarge::Sel>::run(lg, a, b, T, nza, nzb); }
struct Entry { const char* name; Fn fn; size_t (*words)(int); };
const Entry ENTRIES[] = {{"core", e_core, qlarge::table_words}, {"tw", e_tw, qopt::table_words_tw}};

U power(U a, U e) { U r = 1; for (; e; e >>= 1, a = U(uint64_t(a) * a % P)) if (e & 1) r = U(uint64_t(r) * a % P); return r; }
void textbook(std::vector<U>& a, bool inverse) {
    const int n = int(a.size());
    for (int i = 1, j = 0; i < n; ++i) { int b = n / 2; for (; j & b; b >>= 1) j ^= b; j ^= b; if (i < j) std::swap(a[i], a[j]); }
    for (int len = 2; len <= n; len *= 2) {
        U step = power(3, (P - 1) / U(len)); if (inverse) step = power(step, P - 2);
        for (int i = 0; i < n; i += len) { U w = 1; for (int j = 0; j < len / 2; ++j) {
            U x = a[i + j], y = U(uint64_t(a[i + j + len / 2]) * w % P);
            a[i + j] = (x + y) % P; a[i + j + len / 2] = (x + P - y) % P; w = U(uint64_t(w) * step % P); } }
    }
    if (inverse) { U w = power(U(n), P - 2); for (U& x : a) x = U(uint64_t(x) * w % P); }
}
void eval8(const U* f, size_t len, const U* r, U* out) {
    uint64_t acc[8] = {};
    for (size_t i = len; i-- > 0;) for (int k = 0; k < 8; ++k) acc[k] = (acc[k] * r[k] + f[i]) % P;
    for (int k = 0; k < 8; ++k) out[k] = U(acc[k]);
}

void check_generator(int max_lg) {
    using K = qasm::Kernel<qlarge::Sel>;
    const int lg = max_lg, count = (1 << lg) / 16;   // full tables, as Core builds them
    std::vector<U> r(qlarge::table_words(lg) + 64), ir(r.size());
    U* rr = (U*)(((uintptr_t)r.data() + 31) & ~uintptr_t(31));
    U* irr = (U*)(((uintptr_t)ir.data() + 31) & ~uintptr_t(31));
    int size = 0;
    K::tables(count, rr, irr, size, true);
    for (int dir = 0; dir < 2; ++dir) {
        qopt::TwGen g(dir ? qopt::tw_inv : qopt::tw_fwd);
        const U* t = dir ? irr : rr;
        alignas(64) U px[16], py[16];
        for (long k = 0; 2 * k + 1 < count; ++k) {
            if (k == 0 || k == 12345) g.seek(k);   // also exercise a mid-stream seek
            g.emit_advance(px, py);
            const int bx = K::blk(int(k)), by = K::blk(int(2 * k));
            if (px[0] != t[bx] || px[8] != t[bx + 8] || py[0] != t[by] || py[8] != t[by + 8] || py[1] != t[by + 1] || py[9] != t[by + 9])
                fail("generator dir " + std::to_string(dir) + " k " + std::to_string(k));
        }
    }
    std::printf("PASS generator equals the root tables for k < %d (both directions)\n", count / 2);
}

void check_entries(int max_lg) {
    std::mt19937 rng(20261007);
    const size_t maxn = size_t(1) << max_lg;
    U* a = (U*)map_huge((maxn + 64) * 4, true);
    U* b = (U*)map_huge((maxn + 64) * 4, true);
    qlarge::Tables T, T2;
    T.r = (U*)map_huge(qlarge::table_words(max_lg) * 4 + 4096, true); T.ir = (U*)map_huge(qlarge::table_words(max_lg) * 4 + 4096, true);
    for (int lg = 9; lg <= max_lg; ++lg) {
        const size_t n = size_t(1) << lg;
        for (int shape = 0; shape < 4; ++shape) {
            const size_t na = shape == 1 ? n : shape == 3 ? 3 : n / 2, nb = shape == 1 ? n : shape == 2 ? std::min<size_t>(1000, n / 2) : n / 2;
            std::vector<U> x(na), y(nb);
            for (U& v : x) v = shape == 3 ? P - 1 : rng() % P;
            for (U& v : y) v = rng() % P;
            std::vector<U> want;
            for (const Entry& e : ENTRIES) {
                std::copy(x.begin(), x.end(), a); std::fill(a + na, a + n + 64, 0);
                std::copy(y.begin(), y.end(), b); std::fill(b + nb, b + n + 64, 0);
                if (na <= n / 2) std::fill(a + n / 2, a + n, 0xfffffff0u);   // never read: poison
                if (nb <= n / 2) std::fill(b + n / 2, b + n, 0xfffffff0u);
                for (int i = 0; i < 16; ++i) a[n + i] = b[n + i] = 0;
                e.fn(lg, a, b, T, long(na), long(nb));
                for (int i = 0; i < 16; ++i) if (a[n + i] != 0) fail(std::string(e.name) + " wrote past the end");
                if (want.empty()) want.assign(a, a + n);
                else for (size_t i = 0; i < n; ++i) if (a[i] != want[i])
                    fail(std::string(e.name) + " differs from core at lg " + std::to_string(lg) + " shape " + std::to_string(shape) + " index " + std::to_string(i));
            }
            if (lg <= 18) {   // core against the textbook transform
                std::vector<U> xf(x), yf(y); xf.resize(n); yf.resize(n);
                textbook(xf, false); textbook(yf, false);
                for (size_t i = 0; i < n; ++i) xf[i] = U(uint64_t(xf[i]) * yf[i] % P);
                textbook(xf, true);
                if (xf != want) fail("core vs textbook at lg " + std::to_string(lg));
            } else {   // core at 8 random points (cyclic product when inputs are full length)
                U r8[8], va[8], vb[8], vc[8];
                for (U& t : r8) t = rng() % P;
                eval8(x.data(), na, r8, va); eval8(y.data(), nb, r8, vb);
                if (na + nb - 1 <= n) {
                    eval8(want.data(), n, r8, vc);
                    for (int k = 0; k < 8; ++k) if (uint64_t(va[k]) * vb[k] % P != vc[k]) fail("core random-point check at lg " + std::to_string(lg));
                }
            }
        }
        std::printf("PASS lg %d: entries bit-identical to core, core verified\n", lg);
    }
}

double median(std::vector<double> s) { std::sort(s.begin(), s.end()); return (s[(s.size() - 1) / 2] + s[s.size() / 2]) / 2; }
void timing(int lg, int reps) {
    const size_t n = size_t(1) << lg, len = n / 2;
    std::mt19937 rng(42);
    std::vector<U> x(len), y(len); for (U& t : x) t = rng() % P; for (U& t : y) t = rng() % P;
    U* a = (U*)map_huge((n + 64) * 4, true);
    U* b = (U*)map_huge((n + 64) * 4, true);
    const int count = int(sizeof ENTRIES / sizeof ENTRIES[0]);
    std::vector<qlarge::Tables> warm(count);
    for (int j = 0; j < count; ++j) {
        warm[j].r = (U*)map_huge(ENTRIES[j].words(lg) * 4 + 4096, true); warm[j].ir = (U*)map_huge(ENTRIES[j].words(lg) * 4 + 4096, true);
    }
    for (int mode = 0; mode < 2; ++mode) {   // 0 warm, 1 fresh tables
        std::vector<std::vector<double>> s(count);
        uint64_t expect = 0;
        for (int rep = -2; rep < reps; ++rep) for (int pos = 0; pos < count; ++pos) {
            int j = (pos + rep + 2) % count; if (rep & 1) j = count - 1 - j;
            const Entry& e = ENTRIES[j];
            std::copy(x.begin(), x.end(), a); std::fill(a + len, a + n, 0);
            std::copy(y.begin(), y.end(), b); std::fill(b + len, b + n, 0);
            qlarge::Tables T = warm[j];
            size_t bytes = 0;
            const double t0 = now_ms();
            if (mode == 1) {
                bytes = ((e.words(lg) * 4 + (size_t(2) << 20) - 1) & ~((size_t(2) << 20) - 1)) * 2;
                T.r = (U*)map_huge(bytes, false); T.ir = T.r + bytes / 8;
            }
            e.fn(lg, a, b, T, long(len), long(len));
            const double t1 = now_ms();
            if (mode == 1) munmap(T.r, bytes);   // (the mapping's alignment slack leaks; fine for a benchmark)
            uint64_t h = 0; for (size_t i = 0; i < n; ++i) h = h * 31 + a[i];
            if (expect && h != expect) fail(std::string("checksum ") + e.name);
            expect = h;
            if (rep >= 0) s[j].push_back(t1 - t0);
        }
        for (int j = 0; j < count; ++j) {
            auto v = s[j]; std::sort(v.begin(), v.end());
            std::printf("ntt,%s,%d,%s,%.3f,%.3f,%.3f,%.4f\n", mode ? "fresh" : "warm", lg, ENTRIES[j].name, median(s[j]), v.front(), v.back(),
                        median(s[0]) / median(s[j]));
        }
    }
}
}  // namespace

int main(int argc, char** argv) {
    unsigned r[4]; char brand[49]{};
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    std::printf("# CPU: %s\n# compiler: %s\n", brand, __VERSION__);
    const std::string cmd = argc > 1 ? argv[1] : "check";
    if (cmd == "check") {
        const int max_lg = argc > 2 ? std::atoi(argv[2]) : 25;
        check_generator(max_lg);
        check_entries(max_lg);
        std::printf("ALL NTT CHECKS PASSED\n");
    } else if (cmd == "time") {
        std::printf("kind,tables,lg,entry,median_ms,min_ms,max_ms,speedup_vs_core\n");
        timing(argc > 2 ? std::atoi(argv[2]) : 25, argc > 3 ? std::atoi(argv[3]) : 7);
    } else fail("usage");
    return 0;
}
