# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Round 12: whole-leaf benchmark (kernel in context: corrections, tile loop, L2 streaming).
BENCH=1
CHECK=none
CHECK_VARIANTS=a63_sw3_shb
KBENCH_DEPTHS="128"
KBENCH_KERNELS=asm_sh_burst_p1,asm_wipp_sh
TIME_VARIANTS=a63_sw3_shb
SIZES=1024x1024x1024
REPS=3
BUDGET=12
E2E=0
