// ============================================================================
// Benchmark driver: speed table and acceleration chart on std::cerr.
// Library Checker keeps only the first 1 KiB of a test case's stderr, so the
// whole report is built in memory, kept under that size and written once.
// The program ignores stdin and writes nothing to stdout (the judge reports WA);
// it exits with status 1 (RE) if any implementation disagrees with the others.
// Workload: cyclic convolution of random canonical residues, length n = 2^k.
// Timed region: one convolution call with fresh roots (root generation included);
// input copies are outside the timer. KACTL receives its vectors by move, so
// only its own work (incl. its internal allocations) is timed. Median of
// adaptive repetitions after one warmup (for KACTL, one NTT of the same size,
// which builds its static root table without a full convolution).
// Time guard: a measurement whose predicted cost would end after 80% of
// TIME_LIMIT_S is skipped and shown as "-" (the report is only written at exit,
// so a TLE would lose it). Set TIME_LIMIT_S to the problem's limit.
// ============================================================================
namespace bench {
constexpr double TIME_LIMIT_S = 5.0;   // e.g. 10.0 on a problem with a 10 s limit
using U = uint32_t;
constexpr U P = 998244353;
#ifndef QPOLY_BENCH_MAX_LOG
#define QPOLY_BENCH_MAX_LOG 22
#endif
constexpr int MIN_LOG = 10, MAX_LOG = QPOLY_BENCH_MAX_LOG, STEP = 2;
constexpr int NIMPL = 4;
const char* const NAMES[NIMPL] = {"kactl", "simd-v0", "406403", "406478"};
using Live = qasm::Kernel<qasm::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true>>;
using Asm = qasm::Kernel<qasm::Cfg<2, false, true, 0, false, 256, true, true, true, 1, true, true,
                                   11, 71, 0, 4, 23, 0, 2, 2, 104>>;

double now_ms() {
    return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count();
}
template<class T> T* alloc(size_t count) {
    void* p = std::aligned_alloc(64, (count * sizeof(T) + 63) / 64 * 64);
    if (!p) std::exit(3);
    std::memset(p, 0, count * sizeof(T));
    return static_cast<T*>(p);
}
struct Work {
    int max_n;
    U *a, *b, *r, *ir;                 // qasm kernels: data with 16 words of padding, roots n/8 + 16
    simd0::v8i *sa, *sb;               // simd-v0 data
    U *sr, *sir;                       // simd-v0 roots (n words)
    explicit Work(int n) : max_n(n) {
        a = alloc<U>(n + 16); b = alloc<U>(n + 16); r = alloc<U>(n / 8 + 16); ir = alloc<U>(n / 8 + 16);
        sa = alloc<simd0::v8i>(n / 8); sb = alloc<simd0::v8i>(n / 8); sr = alloc<U>(n); sir = alloc<U>(n);
    }
};
// One timed convolution of x*y (length n) by implementation `impl`; result to out.
double once(int impl, int n, const U* x, const U* y, U* out, Work& w) {
    double t0, t1;
    if (impl == 0) {
        std::vector<int> va(x, x + n), vb(y, y + n);
        t0 = now_ms();
        std::vector<int> c = KACTL::cyclic_conv(std::move(va), std::move(vb), n);
        t1 = now_ms();
        for (int i = 0; i < n; ++i) out[i] = U(c[i]);
    } else if (impl == 1) {
        std::memcpy(w.sa, x, size_t(n) * 4); std::memcpy(w.sb, y, size_t(n) * 4);
        int rs = 0;
        simd0::reset_roots(w.sr, w.sir, rs);
        t0 = now_ms();
        simd0::run_simd_convolution(n, w.sa, w.sb, w.sr, w.sir, rs);
        t1 = now_ms();
        std::memcpy(out, w.sa, size_t(n) * 4);
    } else {
        std::memcpy(w.a, x, size_t(n) * 4); std::memcpy(w.b, y, size_t(n) * 4);
        int rs = 0;
        t0 = now_ms();
        if (impl == 2) Live::run(n, w.a, w.b, w.r, w.ir, rs, true);
        else Asm::run(n, w.a, w.b, w.r, w.ir, rs, true);
        t1 = now_ms();
        std::memcpy(out, w.a, size_t(n) * 4);
    }
    return t1 - t0;
}
// Median of adaptive repetitions: at least min_reps, until `budget` ms are spent, at most 15.
double measure(int impl, int n, const U* x, const U* y, U* out, Work& w, double budget, int min_reps) {
    if (impl == 0) { std::vector<int> z(n); KACTL::ntt(z); }   // KACTL warmup: static roots, caches
    else once(impl, n, x, y, out, w);
    double t[15], total = 0;
    int k = 0;
    while (k < 15 && (k < min_reps || total < budget)) { t[k] = once(impl, n, x, y, out, w); total += t[k++]; }
    std::sort(t, t + k);
    return k % 2 ? t[k / 2] : (t[k / 2 - 1] + t[k / 2]) / 2;
}
double ghz() {   // dependent integer adds: one per cycle
    uint64_t x = 1; const long n = 60000000;
    const double t = now_ms();
    for (long i = 0; i < n; i += 8)
        asm volatile("add %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0\n\tadd %0,%0" : "+r"(x));
    return n / (now_ms() - t) / 1e6;
}
std::string cpu_name() {
    unsigned r[4]; char brand[49] = {};
    if (__get_cpuid_max(0x80000000, nullptr) < 0x80000004) return "unknown CPU";
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    std::string s(brand);
    while (!s.empty() && s.back() == ' ') s.pop_back();
    size_t i = s.find_first_not_of(' ');
    return i == std::string::npos ? s : s.substr(i);
}
void add(std::string& s, const char* fmt, ...) __attribute__((format(printf, 2, 3)));
void add(std::string& s, const char* fmt, ...) {
    char buf[256];
    va_list ap; va_start(ap, fmt); std::vsnprintf(buf, sizeof buf, fmt, ap); va_end(ap);
    s += buf;
}
int run() {
    const double start = now_ms();
    const double f = ghz();   // also warms the core up before timing
    Work w(1 << MAX_LOG);
    std::mt19937 rng(20260927);
    std::vector<U> x(size_t(1) << MAX_LOG), y(x.size()), out(x.size()), ref(x.size());
    std::string fails;
    // Brute-force check of every implementation at n = 256.
    {
        const int n = 256;
        for (int i = 0; i < n; ++i) { x[i] = rng() % P; y[i] = rng() % P; }
        std::vector<uint64_t> c(n);
        for (int i = 0; i < n; ++i) for (int j = 0; j < n; ++j) c[(i + j) % n] = (c[(i + j) % n] + uint64_t(x[i]) * y[j]) % P;
        for (int m = 0; m < NIMPL; ++m) {
            once(m, n, x.data(), y.data(), out.data(), w);
            for (int i = 0; i < n; ++i) if (out[i] != c[i]) { add(fails, " %s@2^8", NAMES[m]); break; }
        }
    }
    const int rows = (MAX_LOG - MIN_LOG) / STEP + 1;
    std::vector<std::array<double, NIMPL>> ms(rows);
    double deadline = start + 800.0 * TIME_LIMIT_S;
    int checked_lg = 0;   // largest size at which at least two implementations were compared
    for (int row = 0; row < rows; ++row) {
        const int lg = MIN_LOG + STEP * row, n = 1 << lg;
        for (int i = 0; i < n; ++i) { x[i] = rng() % P; y[i] = rng() % P; }
        bool have_ref = false;
        for (int m = 0; m < NIMPL; ++m) {
            const int min_reps = m == 0 && lg >= 21 ? 2 : 3;
            // predicted cost: previous row's time x (size ratio x 1.6 for log n and cache effects), warmup + reps
            const double guess = row ? ms[row - 1][m] * (1 << STEP) * 1.6 * (min_reps + 1) : 0;
            if (row && (ms[row - 1][m] < 0 || now_ms() + guess > deadline)) { ms[row][m] = -1; continue; }
            ms[row][m] = measure(m, n, x.data(), y.data(), have_ref ? out.data() : ref.data(), w, m ? 30.0 : 60.0, min_reps);
            if (!have_ref) have_ref = true;   // first measured implementation is the reference
            else {
                checked_lg = lg;
                if (std::memcmp(out.data(), ref.data(), size_t(n) * 4)) add(fails, " %s@2^%d", NAMES[m], lg);
            }
        }
    }
    std::string s;
    add(s, "QPoly NTT bench: cyclic convolution mod 998244353\n%s | %.2f GHz | GCC %s\n",
        cpu_name().c_str(), f, __VERSION__);
    add(s, "median ms (fresh roots)\n    n     kactl   simd-v0    406403    406478\n");
    for (int row = 0; row < rows; ++row) {
        add(s, " 2^%-2d", MIN_LOG + STEP * row);
        for (int m = 0; m < NIMPL; ++m) {
            if (ms[row][m] < 0) add(s, " %9s", "-");
            else add(s, ms[row][m] < 10 ? " %9.4f" : ms[row][m] < 100 ? " %9.3f" : " %9.2f", ms[row][m]);
        }
        s += '\n';
    }
    int top = rows - 1;   // largest size with every implementation measured
    while (top > 0 && std::any_of(ms[top].begin(), ms[top].end(), [](double v) { return v < 0; })) --top;
    const auto& last = ms[top];
    const int top_lg = MIN_LOG + STEP * top;
    add(s, "speedup vs kactl at 2^%d (# = 1x)\n", top_lg);
    for (int m = 0; m < NIMPL; ++m) {
        const double sp = last[0] / last[m];
        add(s, " %-7s %5.1fx |%s\n", NAMES[m], sp, std::string(std::min(40, std::max(1, int(sp + 0.5))), '#').c_str());
    }
    if (top > 0) {
        const auto& prev = ms[top - 1];
        add(s, "at 2^%d: simd-v0 %.1fx, 406403 %.1fx, 406478 %.1fx\n", top_lg - STEP,
            prev[0] / prev[1], prev[0] / prev[2], prev[0] / prev[3]);
    }
    add(s, "406478 vs 406403 time:");
    for (int row = 0; row < rows; ++row) {
        if (ms[row][2] > 0 && ms[row][3] > 0) add(s, " %.3f", ms[row][3] / ms[row][2]);
        else add(s, " -");
    }
    add(s, "\n406478 vs simd-v0: %.2fx faster at 2^%d; total %.1f s\n", last[1] / last[3], top_lg,
        (now_ms() - start) / 1000);
    add(s, "check: brute 2^8, agree 2^%d..2^%d: %s\n", MIN_LOG, checked_lg,
        fails.empty() ? "PASS" : ("FAIL" + fails).c_str());
    if (s.size() > 1000) s = s.substr(0, 990) + "\n[cut]\n";
    std::fwrite(s.data(), 1, s.size(), stderr);
    std::fflush(stderr);
    return fails.empty() ? 0 : 1;
}
}  // namespace bench

int main() { return bench::run(); }
