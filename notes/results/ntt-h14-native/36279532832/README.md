# Native h14 round 36279532832

Run: [36279532832](https://github.com/7ue9ueue/QPoly/actions/runs/36279532832)
Tested source: `25a02b570485da55df235100af89ab43afa97230`. Conclusion: success.

GCC15.2 official pinned container. `summary.csv` preserves separate CPU/job rows;
`timings.csv` contains correctness output and nine individual samples per workload.
Flags, CPU, source/generated/binary hashes, direct checks and assembly are saved.
Fresh includes root generation; allocation/copies/checksums are excluded.

| Artifact | CPU |
| --- | --- |
| [h14-1](h14-1/) | AMD EPYC 7763 64-Core Processor |
| [h14-2](h14-2/) | AMD EPYC 7763 64-Core Processor |
| [h14-3](h14-3/) | AMD EPYC 7763 64-Core Processor |
| [h14-sanitize](h14-sanitize/) | AMD EPYC 9V45 96-Core Processor |

Final run also tests the exact eight-entry standalone under plain C++17/O2,
GCC15.2 native-ISA AtCoder-like flags, and AVX2-capped flags. `standalone-summary.csv`
collects their summaries without pooling profiles. Full outputs include CPU banners,
correctness/checksums, commands, source/binary hashes and resource use.
All three job source hashes match8cc5cba4c8844a39583559e227ce37dd2a2ccda99227e4e9dda0b35ebd476eb6.
All twelve standalone executions passed, including each native-ISA `22 3 2`.
The final combination is not yet measured on Intel or AtCoder.
