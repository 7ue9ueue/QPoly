void dif_ntt(uint32_t *f, const int &n) {
    const uint32_t* rt = get_root(n).first;
        
    for (int i = n >> 1; i >= 8; i >>= 1) {
        // i >= 8
        for (int j = 0, k = 0; j != n; j += i << 1, ++k) {
            const v8i v_rt = _mm256_set1_epi32(rt[k]);
            for (int p = j; p != j + i; p += 8) {
                v8i v_u = _mm256_loadu_si256((v8i*)(f + p));
                v8i v_q = _mm256_loadu_si256((v8i*)(f + p + i));
                v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                v8i v_np = _mm256_add_mod(v_u, v_v);
                v8i v_nq = _mm256_sub_mod(v_u, v_v);
                _mm256_storeu_si256((v8i*)(f + p), v_np);
                _mm256_storeu_si256((v8i*)(f + p + i), v_nq);
            }
        }
    }
    {
        // i <= 4
        static const int BLOCK = 1024;
        static const v8i perm_i2 = _mm256_setr_epi32(0, 0, 0, 0, 1, 1, 1, 1);
        static const v8i perm_i1 = _mm256_setr_epi32(0, 0, 1, 1, 2, 2, 3, 3);

        for (int j_start = 0; j_start < n; j_start += BLOCK) {
            int j_end = std::min(j_start + BLOCK, n);
            int j = j_start;
            __builtin_prefetch(f + j_start + BLOCK);
            for (; j <= j_end - 32; j += 32) {
                v8i f0 = _mm256_loadu_si256((v8i*)(f + j));
                v8i f1 = _mm256_loadu_si256((v8i*)(f + j + 8));
                v8i f2 = _mm256_loadu_si256((v8i*)(f + j + 16));
                v8i f3 = _mm256_loadu_si256((v8i*)(f + j + 24));
                {
                    int k_4 = j >> 3;
                    v8i rts_all = _mm256_broadcastsi128_si256(_mm_loadu_si128((__m128i*)(rt + k_4)));
                    v8i rt0 = _mm256_shuffle_epi32(rts_all, 0x00); 
                    v8i rt1 = _mm256_shuffle_epi32(rts_all, 0x55); 
                    v8i rt2 = _mm256_shuffle_epi32(rts_all, 0xAA); 
                    v8i rt3 = _mm256_shuffle_epi32(rts_all, 0xFF);

                    auto layer4_op = [&](v8i &v, const v8i &w) {
                        v8i u = _mm256_permute2x128_si256(v, v, 0x00);
                        v8i q = _mm256_permute2x128_si256(v, v, 0x11);
                        v8i v_v = _mm256_mont_multiply_mod(q, w);
                        v8i np = _mm256_add_mod(u, v_v);
                        v8i nq = _mm256_sub_mod(u, v_v);
                        v = _mm256_permute2x128_si256(np, nq, 0x20);
                    };

                    layer4_op(f0, rt0);
                    layer4_op(f1, rt1);
                    layer4_op(f2, rt2);
                    layer4_op(f3, rt3);
                }
                {
                    int k_2 = j >> 2;
                    v8i all_rts = _mm256_loadu_si256((v8i*)(rt + k_2));

                    auto layer2_op = [&](v8i &v, const v8i &roots) {
                        v8i u = _mm256_shuffle_epi32(v, _MM_SHUFFLE(1, 0, 1, 0));
                        v8i q = _mm256_shuffle_epi32(v, _MM_SHUFFLE(3, 2, 3, 2));
                        v8i v_v = _mm256_mont_multiply_mod(q, roots);
                        v8i np = _mm256_add_mod(u, v_v);
                        v8i nq = _mm256_sub_mod(u, v_v);
                        v = _mm256_unpacklo_epi64(np, nq);
                    };
                    layer2_op(f0, _mm256_permutevar8x32_epi32(all_rts, perm_i2));
                    
                    v8i rts_23 = _mm256_shuffle_epi32(all_rts, _MM_SHUFFLE(3, 2, 3, 2));
                    layer2_op(f1, _mm256_permutevar8x32_epi32(rts_23, perm_i2));

                    v8i rts_hi = _mm256_permute2x128_si256(all_rts, all_rts, 0x11);
                    layer2_op(f2, _mm256_permutevar8x32_epi32(rts_hi, perm_i2));

                    v8i rts_67 = _mm256_shuffle_epi32(rts_hi, _MM_SHUFFLE(3, 2, 3, 2));
                    layer2_op(f3, _mm256_permutevar8x32_epi32(rts_67, perm_i2));
                }
                {
                    int k_1 = j >> 1;
                    v8i rts_lo = _mm256_loadu_si256((v8i*)(rt + k_1));
                    v8i rts_hi = _mm256_loadu_si256((v8i*)(rt + k_1 + 8));

                    auto layer1_op = [&](v8i &v, const v8i &roots) {
                        v8i u = _mm256_shuffle_epi32(v, _MM_SHUFFLE(2, 2, 0, 0));
                        v8i q = _mm256_shuffle_epi32(v, _MM_SHUFFLE(3, 3, 1, 1));
                        v8i v_v = _mm256_mont_multiply_mod(q, roots);
                        v8i np = _mm256_add_mod(u, v_v);
                        v8i nq = _mm256_sub_mod(u, v_v);
                        v = _mm256_blend_epi32(np, _mm256_shuffle_epi32(nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
                    };
                    layer1_op(f0, _mm256_permutevar8x32_epi32(rts_lo, perm_i1));
                    v8i rts_47 = _mm256_permute2x128_si256(rts_lo, rts_lo, 0x11);
                    layer1_op(f1, _mm256_permutevar8x32_epi32(rts_47, perm_i1));
                    layer1_op(f2, _mm256_permutevar8x32_epi32(rts_hi, perm_i1));
                    v8i rts_1215 = _mm256_permute2x128_si256(rts_hi, rts_hi, 0x11);
                    layer1_op(f3, _mm256_permutevar8x32_epi32(rts_1215, perm_i1));
                }
                _mm256_storeu_si256((v8i*)(f + j), _mm256_mod(f0));
                _mm256_storeu_si256((v8i*)(f + j + 8), _mm256_mod(f1));
                _mm256_storeu_si256((v8i*)(f + j + 16), _mm256_mod(f2));
                _mm256_storeu_si256((v8i*)(f + j + 24), _mm256_mod(f3));
            }
            for (; j != j_end; j += 8) { 
                v8i v_f = _mm256_loadu_si256((v8i*)(f + j));
                {
                    int k_4 = j >> 3;
                    v8i v_rt = _mm256_set1_epi32(rt[k_4]);
                    v8i v_u = _mm256_permute2x128_si256(v_f, v_f, 0x00);
                    v8i v_q = _mm256_permute2x128_si256(v_f, v_f, 0x11);
                    v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                    v8i v_np = _mm256_add_mod(v_u, v_v);
                    v8i v_nq = _mm256_sub_mod(v_u, v_v);
                    v_f = _mm256_permute2x128_si256(v_np, v_nq, 0x20);
                }
                {
                    int k_2 = j >> 2;
                    v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadl_epi64((__m128i*)(rt + k_2)));
                    v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i2);
                    v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(1, 0, 1, 0));
                    v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 2, 3, 2));
                    v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                    v8i v_np = _mm256_add_mod(v_u, v_v);
                    v8i v_nq = _mm256_sub_mod(v_u, v_v);
                    v_f = _mm256_unpacklo_epi64(v_np, v_nq);             
                }
                {
                    int k_1 = j >> 1;
                    v8i v_rt_raw = _mm256_castsi128_si256(_mm_loadu_si128((__m128i*)(rt + k_1)));
                    v8i v_rt = _mm256_permutevar8x32_epi32(v_rt_raw, perm_i1);
                    v8i v_u = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(2, 2, 0, 0));
                    v8i v_q = _mm256_shuffle_epi32(v_f, _MM_SHUFFLE(3, 3, 1, 1));
                    v8i v_v = _mm256_mont_multiply_mod(v_q, v_rt);
                    v8i v_np = _mm256_add_mod(v_u, v_v);
                    v8i v_nq = _mm256_sub_mod(v_u, v_v);
                    v_f = _mm256_blend_epi32(v_np, _mm256_shuffle_epi32(v_nq, _MM_SHUFFLE(2, 3, 0, 1)), 0xAA);
                }
                _mm256_storeu_si256((v8i*)(f + j), _mm256_mod(v_f));
            }
        }
    }
}