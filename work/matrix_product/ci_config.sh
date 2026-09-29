# Settings read by run.sh / e2e/run_e2e.sh (edit per experiment round).
# Round 18 (I/O): exploration-011 I/O (ms2 parser, blocks3 fixed-width output, 160 KiB buffer)
# vs the exploration-007 I/O of the deliverable; output gathered vs direct from tiles; lazy arena.
BENCH=0
E2E=1
STRESS=1
PHASES=1
REPS=15
THP_MODES="madvise"
