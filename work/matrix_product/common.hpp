// Shared declarations for the matrix_product kernel exploration (QPoly exploration 013).
// Contract for every registered variant `fn(n, m, k, a, b, c)`:
//   a: n x m, b: m x k, c: n x k, all row-major with unpadded strides (m, k, k);
//   inputs are canonical residues in [0, P); c receives canonical residues of a*b mod P;
//   1 <= n, m, k <= 1024; c does not alias a or b; a, b, c are 64-byte aligned.
//   Variants may keep state in mp::scratch() slots between calls (never assume zeroed).
#pragma once
#include <cstddef>
#include <cstdint>
#include <vector>

namespace mp {
using u32 = uint32_t;
using u64 = uint64_t;
using i32 = int32_t;
using i64 = int64_t;
constexpr u32 P = 998244353;

using Fn = void (*)(int n, int m, int k, const u32* a, const u32* b, u32* c);
struct Variant {
    const char* name;
    Fn fn;
    const char* note;
    bool checked = true;  // false: diagnostic timing-only variant (e.g. conversions alone)
};
std::vector<Variant>& registry();
struct Reg {
    Reg(const char* name, Fn fn, const char* note, bool checked = true) { registry().push_back({name, fn, note, checked}); }
};

// Grow-only, 2 MiB-aligned anonymous memory (THP hint where available), one buffer per
// slot; contents persist between calls and are not zeroed after the first allocation.
void* scratch(std::size_t bytes, int slot = 0);
}  // namespace mp

#define MP_REGISTER(id, fn, note) static mp::Reg mp_reg_##id(#id, fn, note)
#define MP_REGISTER_DIAG(id, fn, note) static mp::Reg mp_reg_##id(#id, fn, note, false)
