# Settings read by run.sh (edit per experiment round).
# Round 4: Winograd inner-product kernel (kbench) and Strassen over it.
PROBE=0
CHECK=full
CHECK_VARIANTS=w44_sw4_vec,w52_sw2_wip,w53_sw3_wip,w54_sw4_wip
KBENCH_DEPTHS="64 128 256 1024"
KBENCH_KERNELS=s_sd_4x8_u1,s_sd_4x8_u8,wip_4x8_u1,wip_4x8_u2,wip_4x8_u4
TIME_VARIANTS=w43_sw3_vec,w44_sw4_vec,w52_sw2_wip,w53_sw3_wip,w54_sw4_wip
SIZES=1024x1024x1024,810x812x664
REPS=15
BUDGET=12
