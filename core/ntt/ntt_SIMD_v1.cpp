void dif_ntt(uint32_t *f, const int &n) {
    const uint32_t* rt = get_root(n).first;
    
    const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
    const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);
    
    for (int i = n >> 1; i >= 8; i >>= 1) {
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            v8i v_rt = _mm256_set1_epi32(rt[k]);
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));
                v8i v_q = _mm256_loadu_si256((v8i*)(f + p + i));
                v8i v_v = _mm256_multiply_mod(v_q, v_rt);
                v8i v_np = _mm256_add_mod(v_u, v_v);
                v8i v_nq = _mm256_sub_mod(v_u, v_v);
                _mm256_storeu_si256((v8i*)(f + p), v_np);
                _mm256_storeu_si256((v8i*)(f + p + i), v_nq);
            }
        }
    }
    {
        for (int j = 0, k = 0; j != n; j += 8, ++k) {
            v8i v_rt = _mm256_set1_epi32(rt[k]);
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
            v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
            v8i v_v = _mm256_multiply_mod(v_q, v_rt);
            v8i v_np = _mm256_add_mod(v_u, v_v);
            v8i v_nq = _mm256_sub_mod(v_u, v_v);
            v8i v_result = _mm256_permute2x128_si256(v_np, v_nq, 0x20);
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
    {
        for (int j = 0; j != n; j += 8) {
            int k = j >> 2;
            v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + k)));
            v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i2);
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
            v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
            v8i v_v = _mm256_multiply_mod(v_q, v_rt);
            v8i v_np = _mm256_add_mod(v_u, v_v);
            v8i v_nq = _mm256_sub_mod(v_u, v_v);
            v8i v_result = _mm256_unpacklo_epi64(v_np, v_nq);
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
    {
        for (int j = 0; j != n; j += 8) {
            int k = j >> 1;
            v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + k)));
            v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i1);
            v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
            v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
            v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
            v8i v_v = _mm256_multiply_mod(v_q, v_rt);
            v8i v_np = _mm256_add_mod(v_u, v_v);
            v8i v_nq = _mm256_sub_mod(v_u, v_v);
            v8i v_result = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
            _mm256_storeu_si256((v8i*)(f + j), v_result);
        }
    }
}