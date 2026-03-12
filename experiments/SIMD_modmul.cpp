
v8i _mm256_multiply_mod(const v8i& a, const v8i& b) {
    v8i v_mod = _mm256_set1_epi32(MOD);
    v8i v_m = _mm256_set1_epi32(M_INV);
    
    // Step 1: Multiply a * b to get 64-bit result (t1:t0)
    // Handle even lanes (0,2,4,6)
    v8i t_even = _mm256_mul_epu32(a, b);  // lanes 0,2,4,6 -> 64-bit results
    
    // Handle odd lanes (1,3,5,7) by shifting into even positions
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
    
    // Step 2: Compute u = (t0 * m) mod 2^32 (just keep low 32 bits)
    v8i u_even = _mm256_mullo_epi32(t_even, v_m);
    v8i u_odd = _mm256_mullo_epi32(t_odd, v_m);
    
    // Step 3: Compute (t + u*p) >> 32
    v8i up_even = _mm256_mul_epu32(u_even, v_mod);
    v8i up_odd = _mm256_mul_epu32(u_odd, v_mod);
    
    v8i sum_even = _mm256_add_epi64(t_even, up_even);
    v8i sum_odd = _mm256_add_epi64(t_odd, up_odd);
    
    // Extract high 32 bits (the result after division by 2^32)
    v8i res_even = _mm256_srli_epi64(sum_even, 32);
    v8i res_odd = _mm256_srli_epi64(sum_odd, 32);
    
    // Merge even and odd lanes back together
    // res_even: [r0, 0, r2, 0, r4, 0, r6, 0] (32-bit view)
    // res_odd:  [r1, 0, r3, 0, r5, 0, r7, 0] (32-bit view)
    v8i result = _mm256_blend_epi32(res_even, _mm256_slli_epi64(res_odd, 32), 0xAA); // 0xAA = 10101010
    
    // Step 4: Conditional subtraction if result >= mod
    // Compare unsigned: result >= mod means result - mod doesn't underflow
    v8i adjusted = _mm256_sub_epi32(result, v_mod);
    v8i needs_sub = _mm256_cmpgt_epi32(result, _mm256_sub_epi32(v_mod, _mm256_set1_epi32(1)));
    result = _mm256_blendv_epi8(result, adjusted, needs_sub);
    
    return result;
}