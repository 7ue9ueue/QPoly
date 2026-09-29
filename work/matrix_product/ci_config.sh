# Settings read by run.sh (edit per experiment round).
# Round 7: more asm schedules (kbench) and the asm kernels inside Strassen-Winograd / plain GEMM.
PROBE=0
CHECK=full
CHECK_VARIANTS=a01_gemm_wipp,a02_gemm_direct_g,a12_sw2_wipp,a13_sw3_wipp,a14_sw4_wipp,a23_sw3_wippi2,a24_sw4_wippi2,a33_sw3_wip,a43_sw3_direct,a44_sw4_direct
KBENCH_DEPTHS="64 128 1024"
KBENCH_KERNELS=s_sd_4x8_u8,wipp_4x8_u1,asm_wipp_s0,asm_wipp_i2,asm_wipp_sh,asm_wip_s0,asm_direct_g_s0,asm_direct_h0_s0
TIME_VARIANTS=w44_sw4_vec,a01_gemm_wipp,a02_gemm_direct_g,a12_sw2_wipp,a13_sw3_wipp,a14_sw4_wipp,a23_sw3_wippi2,a24_sw4_wippi2,a33_sw3_wip,a43_sw3_direct,a44_sw4_direct
SIZES=1024x1024x1024,810x812x664,599x906x573
REPS=11
BUDGET=12
