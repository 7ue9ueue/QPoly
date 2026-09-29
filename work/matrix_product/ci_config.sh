# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Final state (round 20): validation of the deliverable against the judged 007-I/O version and
# 401223: 22 official cases, native stress test, THP modes. Set BENCH=1 (and CHECK/TIME_VARIANTS,
# SIZES, REPS, BUDGET, KBENCH_*) to run the kernel benchmark instead; see run.sh.
BENCH=0
E2E=1
STRESS=1
PHASES=0
REPS=15
THP_MODES="madvise always never"
