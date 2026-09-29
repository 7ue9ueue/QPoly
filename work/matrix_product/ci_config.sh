# Settings read by run.sh (edit per experiment round).
# Round 3: kernel microbenchmark (L1-resident, cycles per k-step) and the phase split of the
# Strassen+SIMD path (conversion/packing vs multiply vs unpacking).
CHECK=quick
CHECK_VARIANTS=v06_s_sd_4x8_u4,w13_sw3_s4x8u4,w14_sw4_s4x8u4
KBENCH_DEPTHS="64 128 256 1024"
KBENCH_KERNELS=all
TIME_VARIANTS=v06_s_sd_4x8_u4,w13_sw3_s4x8u4,w14_sw4_s4x8u4,x13_pack_only,x13_unpack_only,x13_mul_only
SIZES=1024x1024x1024
REPS=15
BUDGET=12
