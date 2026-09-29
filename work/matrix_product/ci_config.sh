# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Final state (rounds 16/17): validation of the deliverable: 22 official cases, native stress
# test, timing against 401223 (see e2e/variants.txt). Set BENCH=1 and the variables below to
# run the kernel benchmark instead (see run.sh for the full list).
BENCH=0
E2E=1
STRESS=1
PHASES=0
REPS=15
THP_MODES="madvise"
CHECK=full
CHECK_VARIANTS=a63_sw3_shb,h32_hybrid3_fd2_shb,f33_fused3_shb
TIME_VARIANTS=a63_sw3_shb
SIZES=1024x1024x1024
BUDGET=12
