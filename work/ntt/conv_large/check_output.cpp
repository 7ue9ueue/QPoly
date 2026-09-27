// Independent output check for convolution_mod_large (exploration 010):
//   check_output INPUT OUTPUT [seed]
// Parses both files with plain scalar code, requires exactly N+M-1 canonical values and
// c(r) = a(r) b(r) mod P at 8 random points r (a wrong product passes with probability
// <= (2^25/P)^8 < 2e-12). Exit 0 on success, 1 on failure.
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <random>
#include <vector>
using U = uint32_t; constexpr uint64_t P = 998244353;
static std::vector<U> read_all(const char* path, bool header, unsigned long& n, unsigned long& m) {
    FILE* f = std::fopen(path, "rb"); if (!f) { std::perror(path); std::exit(1); }
    std::vector<U> v; v.reserve(1u << 25);
    if (header && std::fscanf(f, "%lu %lu", &n, &m) != 2) std::exit(1);
    int c = std::fgetc(f);
    for (;;) {
        while (c == ' ' || c == '\n' || c == '\r' || c == '\t') c = std::fgetc(f);
        if (c == EOF) break;
        uint64_t x = 0; int digits = 0;
        while (c >= '0' && c <= '9') { x = x * 10 + unsigned(c - '0'); ++digits; c = std::fgetc(f); }
        if (!digits || x >= P || (c != ' ' && c != '\n' && c != EOF)) { std::fprintf(stderr, "bad token in %s\n", path); std::exit(1); }
        v.push_back(U(x));
    }
    std::fclose(f);
    return v;
}
static void eval8(const U* f, size_t len, const uint64_t* r, uint64_t* out) {
    uint64_t acc[8] = {};
    for (size_t i = len; i-- > 0;) for (int k = 0; k < 8; ++k) acc[k] = (acc[k] * r[k] + f[i]) % P;
    for (int k = 0; k < 8; ++k) out[k] = acc[k];
}
int main(int argc, char** argv) {
    if (argc < 3) return 2;
    unsigned long n = 0, m = 0, d0, d1;
    std::vector<U> in = read_all(argv[1], true, n, m), out = read_all(argv[2], false, d0, d1);
    if (in.size() != n + m) { std::fprintf(stderr, "input has %zu values, expected %lu\n", in.size(), n + m); return 1; }
    if (out.size() != n + m - 1) { std::fprintf(stderr, "output has %zu values, expected %lu\n", out.size(), n + m - 1); return 1; }
    std::mt19937_64 rng(argc > 3 ? std::strtoull(argv[3], nullptr, 10) : 20260927);
    uint64_t r[8], va[8], vb[8], vc[8];
    for (auto& x : r) x = rng() % P;
    eval8(in.data(), n, r, va); eval8(in.data() + n, m, r, vb); eval8(out.data(), out.size(), r, vc);
    for (int k = 0; k < 8; ++k) if (va[k] * vb[k] % P != vc[k]) { std::fprintf(stderr, "FAIL at random point %d\n", k); return 1; }
    std::printf("PASS N=%lu M=%lu (8 random points)\n", n, m);
}
