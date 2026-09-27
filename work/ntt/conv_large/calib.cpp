// Exploration 010 machine calibration: fixed costs at convolution_mod_large scale.
//   calib [tmpfs_dir]   (default /dev/shm)
// 1. single-core memory bandwidth on 512 MiB (read, write, NT write, copy, NT copy,
//    in-place read-modify-write), best of 3;
// 2. first-touch cost of 256 MiB anonymous memory (4 KiB vs THP, touch vs
//    MADV_POPULATE_WRITE) and munmap cost;
// 3. writing ~335 MB (the text size of 2^25 outputs) into a new tmpfs file: 64 KiB and
//    1 MiB write() calls, and ftruncate + MAP_SHARED mapping + memcpy (lazy faults or
//    MADV_POPULATE_WRITE first);
// 4. reading a ~335 MB tmpfs file: mmap lazy / MAP_POPULATE / MADV_WILLNEED (one byte
//    per page), and read() into a 64 KiB buffer;
// 5. the exploration-007 routines at scale: parse_tokens on 2^25 random residues
//    (max_random-like text in memory) and the table writer (write_mod998) on 2^25
//    values into the 64 KiB buffer, without and with write() into tmpfs.
// Prints "name,ms,extra" lines. Nothing here is a correctness claim except the parse
// check (parsed values must equal the generated ones).
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC optimize("O3,unroll-loops")
#endif
#pragma GCC target("avx2,bmi")
#include "io007.hpp"
#include <chrono>
#include <cpuid.h>
#include <fcntl.h>
#include <random>
#include <string>
#include <vector>

static double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static volatile uint64_t sink;
static void report(const char* name, double ms, const std::string& extra = "") { std::printf("%s,%.3f,%s\n", name, ms, extra.c_str()); std::fflush(stdout); }
static std::string gbps(double bytes, double ms) { char b[64]; std::snprintf(b, sizeof b, "%.2f GB/s", bytes / ms / 1e6); return b; }

static char* map_anon(size_t bytes, bool huge) {
    constexpr size_t H = size_t(2) << 20;
    char* raw = (char*)mmap(nullptr, bytes + H, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (raw == MAP_FAILED) { std::perror("mmap"); std::exit(3); }
    char* p = (char*)(((uintptr_t)raw + H - 1) & ~uintptr_t(H - 1));
#if defined(MADV_HUGEPAGE) && defined(MADV_NOHUGEPAGE)
    madvise(p, bytes, huge ? MADV_HUGEPAGE : MADV_NOHUGEPAGE);
#endif
    return p;
}

static void bandwidth() {
    const size_t bytes = size_t(512) << 20, nv = bytes / 32;
    __m256i* p = (__m256i*)map_anon(bytes, true);
    for (size_t i = 0; i < bytes / 8; ++i) ((uint64_t*)p)[i] = i;
    auto best = [&](const char* name, double traffic, auto body) {
        double b = 1e30;
        for (int r = 0; r < 3; ++r) { double t0 = now_ms(); body(); b = std::min(b, now_ms() - t0); }
        report(name, b, gbps(traffic, b));
    };
    best("bw_read_512MiB", bytes, [&] {
        __m256i s0 = _mm256_setzero_si256(), s1 = s0, s2 = s0, s3 = s0;
        for (size_t i = 0; i < nv; i += 4) {
            s0 = _mm256_add_epi32(s0, _mm256_load_si256(p + i)); s1 = _mm256_add_epi32(s1, _mm256_load_si256(p + i + 1));
            s2 = _mm256_add_epi32(s2, _mm256_load_si256(p + i + 2)); s3 = _mm256_add_epi32(s3, _mm256_load_si256(p + i + 3));
        }
        __m256i s = _mm256_add_epi32(_mm256_add_epi32(s0, s1), _mm256_add_epi32(s2, s3));
        sink = uint64_t(_mm256_extract_epi64(s, 0));
    });
    best("bw_write_512MiB", bytes, [&] { const __m256i v = _mm256_set1_epi32(7); for (size_t i = 0; i < nv; ++i) _mm256_store_si256(p + i, v); });
    best("bw_write_nt_512MiB", bytes, [&] { const __m256i v = _mm256_set1_epi32(9); for (size_t i = 0; i < nv; ++i) _mm256_stream_si256(p + i, v); _mm_sfence(); });
    const size_t half = nv / 2;
    best("bw_copy_256MiB", bytes, [&] { for (size_t i = 0; i < half; ++i) _mm256_store_si256(p + half + i, _mm256_load_si256(p + i)); });
    best("bw_copy_nt_256MiB", bytes, [&] { for (size_t i = 0; i < half; ++i) _mm256_stream_si256(p + half + i, _mm256_load_si256(p + i)); _mm_sfence(); });
    best("bw_rmw_512MiB", 2.0 * bytes, [&] { const __m256i one = _mm256_set1_epi32(1); for (size_t i = 0; i < nv; ++i) _mm256_store_si256(p + i, _mm256_add_epi32(_mm256_load_si256(p + i), one)); });
    munmap(p, bytes);
}

static void faults() {
    const size_t bytes = size_t(256) << 20;
    for (int huge = 0; huge < 2; ++huge) for (int populate = 0; populate < 2; ++populate) {
        for (int rep = 0; rep < 2; ++rep) {
            double t0 = now_ms();
            char* p = map_anon(bytes, huge);
            bool done = false;
#ifdef MADV_POPULATE_WRITE
            if (populate) done = madvise(p, bytes, MADV_POPULATE_WRITE) == 0;
#endif
            if (!done) for (size_t i = 0; i < bytes; i += 4096) ((volatile char*)p)[i] = 1;
            double t1 = now_ms();
            for (size_t i = 0; i < bytes; i += 4096) ((volatile char*)p)[i] = 2;   // already mapped
            double t2 = now_ms();
            munmap(p - 0, bytes);   // (alignment slack of the raw mapping is leaked; fine here)
            double t3 = now_ms();
            std::string name = std::string("fault_256MiB_") + (huge ? "thp" : "4k") + (populate ? "_populate" : "_touch");
            if (populate && !done) name += "(fallback)";
            report(name.c_str(), t1 - t0, "retouch " + std::to_string(t2 - t1) + " ms, munmap " + std::to_string(t3 - t2) + " ms");
        }
    }
}

// ~2^25 values of text as the judge output would contain (random residues).
static std::vector<uint32_t> random_values(size_t n, uint32_t seed) {
    std::mt19937 rng(seed); std::vector<uint32_t> v(n);
    for (auto& x : v) x = rng() % 998244353u;
    return v;
}
static size_t format_all(const std::vector<uint32_t>& v, char* dst) {   // plain text, one space between
    char* p = dst;
    for (size_t i = 0; i < v.size(); ++i) { if (i) *p++ = ' '; p += std::sprintf(p, "%u", v[i]); }
    *p++ = '\n';
    return size_t(p - dst);
}

static void tmpfs_write(const std::string& dir, const char* text, size_t len) {
    const std::string path = dir + "/qpoly_calib_out";
    for (int rep = 0; rep < 2; ++rep) {
        for (size_t chunk : {size_t(1) << 16, size_t(1) << 20}) {
            unlink(path.c_str());
            int fd = open(path.c_str(), O_WRONLY | O_CREAT, 0600);
            double t0 = now_ms();
            for (size_t off = 0; off < len; off += chunk) {
                size_t c = std::min(chunk, len - off);
                if (write(fd, text + off, c) != ssize_t(c)) { std::perror("write"); std::exit(3); }
            }
            double t1 = now_ms();
            close(fd);
            double t2 = now_ms();
            unlink(path.c_str());
            double t3 = now_ms();
            report(chunk == (1u << 16) ? "tmpfs_write_64KiB_calls" : "tmpfs_write_1MiB_calls", t1 - t0,
                   gbps(double(len), t1 - t0) + ", close " + std::to_string(t2 - t1) + " ms, unlink " + std::to_string(t3 - t2) + " ms");
        }
        for (int populate = 0; populate < 2; ++populate) {
            unlink(path.c_str());
            int fd = open(path.c_str(), O_RDWR | O_CREAT, 0600);
            double t0 = now_ms();
            if (ftruncate(fd, off_t(len)) != 0) { std::perror("ftruncate"); std::exit(3); }
            char* m = (char*)mmap(nullptr, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
            if (m == MAP_FAILED) { std::perror("mmap shared"); std::exit(3); }
            bool done = false;
#ifdef MADV_POPULATE_WRITE
            if (populate) done = madvise(m, len, MADV_POPULATE_WRITE) == 0;
#endif
            double t1 = now_ms();
            std::memcpy(m, text, len);
            double t2 = now_ms();
            munmap(m, len); close(fd);
            double t3 = now_ms();
            unlink(path.c_str());
            report(populate ? "tmpfs_mmap_populate_then_copy" : "tmpfs_mmap_lazy_copy", t2 - t0,
                   std::string(populate && !done ? "(populate unsupported) " : "") + "setup+populate " + std::to_string(t1 - t0) + " ms, copy " + std::to_string(t2 - t1) + " ms, unmap+close " + std::to_string(t3 - t2) + " ms");
        }
    }
}

static void tmpfs_read(const std::string& dir, const char* text, size_t len) {
    const std::string path = dir + "/qpoly_calib_in";
    unlink(path.c_str());
    { int fd = open(path.c_str(), O_WRONLY | O_CREAT, 0600); for (size_t off = 0; off < len; off += 1 << 20) { size_t c = std::min(size_t(1) << 20, len - off); if (write(fd, text + off, c) != ssize_t(c)) std::exit(3); } close(fd); }
    for (int rep = 0; rep < 2; ++rep) {
        for (int mode = 0; mode < 3; ++mode) {
            int fd = open(path.c_str(), O_RDONLY);
            double t0 = now_ms();
            int flags = MAP_PRIVATE;
#ifdef MAP_POPULATE
            if (mode == 1) flags |= MAP_POPULATE;
#endif
            char* m = (char*)mmap(nullptr, len, PROT_READ, flags, fd, 0);
            if (m == MAP_FAILED) std::exit(3);
            if (mode == 2) madvise(m, len, MADV_WILLNEED);
            double t1 = now_ms();
            uint64_t s = 0; for (size_t i = 0; i < len; i += 4096) s += m[i];
            sink = s;
            double t2 = now_ms();
            munmap(m, len); close(fd);
            double t3 = now_ms();
            const char* names[] = {"tmpfs_read_mmap_lazy_touch", "tmpfs_read_mmap_populate_touch", "tmpfs_read_mmap_willneed_touch"};
            report(names[mode], t2 - t0, "map " + std::to_string(t1 - t0) + " ms, touch " + std::to_string(t2 - t1) + " ms, unmap " + std::to_string(t3 - t2) + " ms");
        }
        {
            int fd = open(path.c_str(), O_RDONLY);
            static char buf[1 << 16];
            double t0 = now_ms(); uint64_t s = 0;
            for (;;) { ssize_t got = read(fd, buf, sizeof buf); if (got <= 0) break; s += uint8_t(buf[got - 1]); }
            double t1 = now_ms(); sink = s; close(fd);
            report("tmpfs_read_64KiB_read_calls", t1 - t0, gbps(double(len), t1 - t0));
        }
    }
    unlink(path.c_str());
}

static void io007(const std::string& dir) {
    const size_t n = size_t(1) << 25;
    std::vector<uint32_t> v = random_values(n, 7);
    // Parser input: max_random-like text with 64 bytes of zero padding after it.
    std::vector<char> text(n * 11 + 128, 0);
    size_t len = format_all(v, text.data());
    std::vector<uint32_t> out(n + 8);
    for (int rep = 0; rep < 3; ++rep) {
        double t0 = now_ms();
        char* end = qp_parse_flat::parse_tokens(text.data(), out.data(), n);
        double t1 = now_ms();
        for (size_t i = 0; i < n; ++i) if (out[i] != v[i]) { std::printf("FAIL parse index %zu\n", i); std::exit(1); }
        report("parse_flat_2^25_random", t1 - t0, std::to_string((t1 - t0) * 1e6 / double(n)) + " ns/token, consumed " + std::to_string(end - text.data()) + " of " + std::to_string(len));
    }
    // Table writer into the 64 KiB buffer; flush() either discards (no syscall) or write()s.
    static fastio_unsafe_impl::output out_buf;
    for (int rep = 0; rep < 3; ++rep) {
        char* c = out_buf.begin(); char* const e = out_buf.end();
        double t0 = now_ms();
        for (size_t i = 0; i < n; ++i) {
            if (__builtin_expect(e - c < 16, 0)) c = out_buf.begin();
            *c++ = ' ';
            uint32_t value = v[i];
            if (value >= 100000000U) {
                const uint32_t high = value / 100000000U;
                *c++ = char('0' + high); value -= high * 100000000U;
                fastio_unsafe_impl::emit_padded(c, value / 10000U); fastio_unsafe_impl::emit_padded(c, value % 10000U);
            } else fastio_unsafe_impl::emit_u32_unchecked(c, value);
        }
        double t1 = now_ms();
        sink = uint64_t(c - out_buf.begin());
        report("format_table_2^25_nowrite", t1 - t0, std::to_string((t1 - t0) * 1e6 / double(n)) + " ns/value");
    }
    const std::string path = dir + "/qpoly_calib_fmt";
    for (int rep = 0; rep < 2; ++rep) {
        unlink(path.c_str());
        int fd = open(path.c_str(), O_WRONLY | O_CREAT, 0600);
        int saved = dup(1); dup2(fd, 1);
        fastio_unsafe_impl::output* o = new fastio_unsafe_impl::output();
        char* c = o->begin(); char* const e = o->end();
        double t0 = now_ms();
        for (size_t i = 0; i < n; ++i) write_mod998(*o, c, e, v[i]);
        o->finish(c);
        double t1 = now_ms();
        dup2(saved, 1); close(saved); close(fd);
        struct stat st{}; stat(path.c_str(), &st);
        unlink(path.c_str()); delete o;
        report("format_table_2^25_write_tmpfs", t1 - t0, std::to_string((t1 - t0) * 1e6 / double(n)) + " ns/value, file " + std::to_string(st.st_size) + " bytes");
    }
    tmpfs_write(dir, text.data(), len);
    tmpfs_read(dir, text.data(), len);
}

int main(int argc, char** argv) {
    const std::string dir = argc > 1 ? argv[1] : "/dev/shm";
    unsigned r[4]; char brand[49]{};
    for (unsigned i = 0; i < 3; ++i) { __cpuid(0x80000002 + i, r[0], r[1], r[2], r[3]); std::memcpy(brand + 16 * i, r, 16); }
    std::printf("# CPU: %s\n# compiler: %s\n# tmpfs dir: %s\n", brand, __VERSION__, dir.c_str());
    bandwidth();
    faults();
    io007(dir);
    std::printf("# done\n");
}
