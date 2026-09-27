# Exploration 008 raw results (GitHub Actions, branch claude/ntt-uop-explore)

Each directory is one workflow run (`gh run view <id> --repo 7ue9ueue/QPoly`);
subdirectories are jobs with `environment.txt` (lscpu, compiler), `flags.txt`,
`source-hashes.txt`, `check-*.txt` and `time-<profile>-<round>.csv` (columns:
mode, log2, implementation, median/min/max ms, speedup vs first entry, raw
samples). `yosupo-*` jobs hold the submission end-to-end checks, `micro.txt`
per-phase cycles and `max-timing.txt` (N=M=2^19 compute/wall). Summaries:
`python3 work/ntt/uop_explore/summarize.py <run-dir> 20 h14 fresh`.

| Run | Commit | Content |
| --- | --- | --- |
| 36281505047 | 4108b91 | flip/pair/leaf first round; AtCoder GCC flags + Clang 21 |
| 36281761876 | 8cd53c4 | mullo, pair, leaf modes, shuffle ablations (all AMD) |
| 36282232212 | d0370f7 | Library Checker flags; Shoup mode |
| 36282451044 | be7c2fa | Shoup leaf/scale, tile sweep, fresh+reuse |
| 36282742022 | c648495 | Opq barrier, LdOdd |
| 36282928940 | b22004d | block tables, interleave |
| 36283188579 | 6c65e73 | first submission end-to-end (page-fault finding) |
| 36283674322 | 771a8f2 | pre-faulted arena submission, micro benchmark |
| 36283878352 | f5ce4f5 | pipelined leaf windows |
| 36284102216 | aa9fe30 | leaf register reuse |
| 36284307810 | 2ad60df | interleaved leaf register reuse |
| 36284690367 | 3687d37 | final submission (SHA256 bcaf4be7…) validation |
| 36285017214 | 164cf52 | register-built leaf windows (negative) |
| 36285228524 | 50dff22 | optimization-pragma variants (`opt-*.csv`; summarize_opt.py) |

Earlier runs of the first rounds used the AtCoder GCC flag set (`native`/`avx2`
profiles); from 36282232212 on, `lc` is the exact Library Checker command and
`znver3` pins its ISA/tuning. Compare only within a job and CPU model.
