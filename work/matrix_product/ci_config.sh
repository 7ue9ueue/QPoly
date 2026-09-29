# Settings read by run.sh (edit per experiment round).
# Round 3b: port probes for the kernel instruction mix (no timing of GEMM variants).
PROBE=1
CHECK=none
CHECK_VARIANTS=v06_s_sd_4x8_u4
KBENCH_DEPTHS="256"
KBENCH_KERNELS=s_sd_4x8_u1,s_sd_4x8_u8,u_bs_4x8_u1
TIME_VARIANTS=v06_s_sd_4x8_u4
SIZES=1024x1024x1024
REPS=3
BUDGET=12
