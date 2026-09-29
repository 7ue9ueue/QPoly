# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Round 10: sh-form schedule family (fold placement, row pairing) in kbench; e2e chunked
# parse+pack / fused output vs row-major buffers.
BENCH=1
CHECK=none
CHECK_VARIANTS=a53_sw3_wippsh
KBENCH_DEPTHS="64 128 1024"
KBENCH_KERNELS=asm_wipp_sh,asm_wipp_i2,asm_sh_half_p0,asm_sh_half_p1,asm_sh_quarter_p0,asm_sh_quarter_p1,asm_sh_burst_p1
TIME_VARIANTS=a53_sw3_wippsh
SIZES=1024x1024x1024
REPS=5
BUDGET=12
E2E=1
