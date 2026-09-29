# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Round 11: sh_burst_p1 leaf with plain / fused / hybrid Strassen (bench); e2e chunked with
# row-buffered output and hybrid fused levels.
BENCH=1
CHECK=full
CHECK_VARIANTS=h32_hybrid3_fd2_shb,h31_hybrid3_fd1_shb,a63_sw3_shb,f33_fused3_shb
KBENCH_DEPTHS=""
TIME_VARIANTS=a53_sw3_wippsh,a63_sw3_shb,f33_fused3_shb,h32_hybrid3_fd2_shb,h31_hybrid3_fd1_shb
SIZES=1024x1024x1024,810x812x664
REPS=11
BUDGET=12
E2E=1
