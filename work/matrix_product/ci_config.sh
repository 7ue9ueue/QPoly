# Settings read by run.sh (edit per experiment round).
# Round 5: Strassen addition cost (adds-only diagnostics), packed-B Winograd kernel.
PROBE=0
CHECK=none
CHECK_VARIANTS=w44_sw4_vec
KBENCH_DEPTHS="64 256 1024"
KBENCH_KERNELS=s_sd_4x8_u8,wip_4x8_u1,wipp_4x8_u1,wipp_4x8_u2
TIME_VARIANTS=w43_sw3_vec,w44_sw4_vec,x42_adds_only,x43_adds_only,x44_adds_only,x43_pack_only,x43_unpack_only
SIZES=1024x1024x1024
REPS=15
BUDGET=12
