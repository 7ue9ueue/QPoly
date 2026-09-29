# Settings read by run.sh (edit per experiment round).
# Round 6: generated asm micro-kernels (gen_asm.py) vs the intrinsics kernels, L1-resident.
PROBE=0
CHECK=none
CHECK_VARIANTS=w44_sw4_vec
KBENCH_DEPTHS="64 128 256 1024"
KBENCH_KERNELS=all
TIME_VARIANTS=w44_sw4_vec
SIZES=1024x1024x1024
REPS=5
BUDGET=12
