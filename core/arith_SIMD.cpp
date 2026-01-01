// lazy Montgomery Multiplication， in [0, 2 * MOD)
inline v8i _mm256_mont_multiply_mod(const v8i& a, const v8i& b) {
    v8i a_odd = _mm256_srli_epi64(a, 32);
    v8i b_odd = _mm256_srli_epi64(b, 32);
    v8i t_even = _mm256_mul_epu32(a, b);             
    v8i u_even = _mm256_mul_epu32(t_even, v_m);      
    v8i up_even = _mm256_mul_epu32(u_even, v_mod);    
    v8i sum_even = _mm256_add_epi64(t_even, up_even); 
    v8i res_even = _mm256_srli_epi64(sum_even, 32);   
    v8i t_odd = _mm256_mul_epu32(a_odd, b_odd);
    v8i u_odd = _mm256_mul_epu32(t_odd, v_m);
    v8i up_odd = _mm256_mul_epu32(u_odd, v_mod);
    v8i sum_odd = _mm256_add_epi64(t_odd, up_odd);
    v8i result = _mm256_or_si256(res_even, sum_odd);
    v8i adjusted = _mm256_sub_epi32(result, v_mod);
    return _mm256_min_epu32(result, adjusted);
}
// a + b > m ? a + b - m : a + b
v8i _mm256_add_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i adjusted = _mm256_sub_epi32(_mm256_add_epi32(a, b), m);
    v8i mask = _mm256_srai_epi32(adjusted, 31);
    return _mm256_add_epi32(adjusted, _mm256_and_si256(mask, m));
}

// a - b < 0 ? m + a - b : a - b
v8i _mm256_sub_mod(const v8i& a, const v8i& b, const v8i &m = v_wmod) {
    v8i diff = _mm256_sub_epi32(a, b);
    v8i mask = _mm256_cmpgt_epi32(b, a);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}

// a > m ? a - m : a
v8i _mm256_mod(const v8i& a, const v8i &m = v_mod) {
    v8i diff = _mm256_sub_epi32(a, m);
    v8i mask = _mm256_srai_epi32(diff, 31);
    return _mm256_add_epi32(diff, _mm256_and_si256(mask, m));
}