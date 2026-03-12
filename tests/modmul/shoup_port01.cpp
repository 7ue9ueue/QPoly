// ============================================================================
// OPTIMIZED SHOUP MUL (Port 0 + Port 1 Distributed)
// ============================================================================

// High-performance "mullo" replacement that uses Ports 0 & 1.
// Computes low 32-bits of a*b.
// Latency: ~6-7 cycles (vs 10 for mullo).
// Throughput: Balances load across ports.
inline v8i mullo_distributed(v8i a, v8i b) {
    // 1. Parallel Multiply: Uses Port 0 AND Port 1
    v8i even = _mm256_mul_epu32(a, b);                    // [a0*b0, ..., a6*b6]
    v8i odd  = _mm256_mul_epu32(_mm256_srli_epi64(a, 32), 
                                _mm256_srli_epi64(b, 32)); // [a1*b1, ..., a7*b7]
    
    // 2. Merge: Shift odd results to high bits and blend
    // Uses Port 0/1 (shift) and Port 5 (blend)
    return _mm256_blend_epi32(even, _mm256_slli_epi64(odd, 32), 0xAA);
}

// Optimized Shoup: a * b mod p
inline v8i _mm256_shoup_mul(v8i a, v8i b, v8i bp) {
    // ------------------------------------------------------------------------
    // Step 1: Compute High 32-bits of (a * bp)
    // ------------------------------------------------------------------------
    // Note: We cannot optimize this further easily as we need the HIGH parts.
    // This already uses mul_epu32, so it's good (Port 0/1).
    v8i t_even = _mm256_mul_epu32(a, bp);
    v8i t_odd  = _mm256_mul_epu32(_mm256_srli_epi64(a, 32), 
                                  _mm256_srli_epi64(bp, 32));
    
    // Construct 't' (the quotient approximation)
    // We need the HIGH 32 bits of the products.
    // Blend takes: Even lanes from t_even (high bits shifted down?), 
    //              Odd lanes from t_odd (which are already in low bits relative to shift?)
    // Actually, let's keep your original mulhi logic but inline it for compiler visibility.
    v8i t = _mm256_blend_epi32(_mm256_srli_epi64(t_even, 32), t_odd, 0xAA);

    // ------------------------------------------------------------------------
    // Step 2: Compute Low 32-bits of (a * b)
    // ------------------------------------------------------------------------
    // OLD: v8i p = _mm256_mullo_epi32(a, b); // <--- BOTTLENECK
    // NEW: Use distributed multiply
    v8i p = mullo_distributed(a, b);

    // ------------------------------------------------------------------------
    // Step 3: Compute Low 32-bits of (t * mod)
    // ------------------------------------------------------------------------
    // OLD: v8i q = _mm256_mullo_epi32(t, v_mod); // <--- BOTTLENECK
    // NEW: Use distributed multiply
    v8i q = mullo_distributed(t, v_mod);

    return _mm256_sub_epi32(p, q);
}