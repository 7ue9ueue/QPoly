# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Round 14: why the deliverable was 1.2 ms slower: single-kernel asm header vs full header,
# _exit vs return, 64-byte loop alignment in the asm.
BENCH=0
E2E=1
STRESS=0
PHASES=0
REPS=15
THP_MODES="madvise"
