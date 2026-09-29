# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Round 9: fused Strassen passes (bench) and e2e with an in-job reference (401223).
CHECK=full
CHECK_VARIANTS=f13_fused3_wippi2,f14_fused4_wippi2,f23_fused3_wippsh,a53_sw3_wippsh
KBENCH_DEPTHS=""
TIME_VARIANTS=a23_sw3_wippi2,a53_sw3_wippsh,f13_fused3_wippi2,f14_fused4_wippi2,f23_fused3_wippsh,x43_adds_only,y13_fused3_adds_only,x44_adds_only,y14_fused4_adds_only
SIZES=1024x1024x1024,810x812x664
REPS=11
BUDGET=12
E2E=1
