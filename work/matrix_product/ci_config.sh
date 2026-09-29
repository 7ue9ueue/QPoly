# Settings read by run.sh (edit per experiment round).
# Round 3c: Winograd inner-product probes; vectorized conversions for the Strassen path.
PROBE=1
CHECK=full
CHECK_VARIANTS=w43_sw3_vec,w44_sw4_vec
KBENCH_DEPTHS=""
TIME_VARIANTS=w13_sw3_s4x8u4,w14_sw4_s4x8u4,w43_sw3_vec,w44_sw4_vec,x13_pack_only,x13_unpack_only,x43_pack_only,x43_unpack_only
SIZES=1024x1024x1024
REPS=15
BUDGET=12
