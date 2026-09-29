# Settings read by run.sh (edit per experiment round).
# Round 2: finish step 1 (Strassen over the i-k-j leaf, depth 5), first step-2 SIMD kernels,
# and Strassen-Winograd over the SIMD kernel (step 2b).
CHECK=full
CHECK_VARIANTS=s03_blocked_1024,s14_sw4_tile,s15_sw5_tile,s22_sw2_ikj,s23_sw3_ikj,s24_sw4_ikj,s25_sw5_ikj,v01_u_bs_4x8,v02_u_sd_4x8,v03_s_bs_4x8,v04_s_sd_4x8,v05_s_sd_4x8_u2,v06_s_sd_4x8_u4,v07_s_sd_6x8_u2,v08_s_sd_2x16_u2,v09_s_sd_4x8_u4_nc128,v10_s_sd_4x8_u4_nc32,w11_sw1_s4x8u4,w12_sw2_s4x8u4,w13_sw3_s4x8u4,w14_sw4_s4x8u4,w15_sw5_s4x8u4,w23_sw3_s4x8u1,w33_sw3_s2x16u2
TIME_VARIANTS=$CHECK_VARIANTS
SIZES=1024x1024x1024,810x812x664,599x906x573
REPS=9
BUDGET=12
