#!/usr/bin/env python3
"""Library Checker timing replica; usage:
judge_replica.py IMAGE BIN_DIR CASE_DIR CPU REPS OUT.csv VARIANT,... CASE,...

Per run, as executor/execute.go does: `docker create -i --init` with the judge's
limits, then `docker start -i`, while a host thread reads the container's
cgroup.procs about every millisecond. Time is last minus first observation with
at least two tasks (docker-init plus the solution). Python sleep granularity makes
the poll slightly coarser than the judge's Go ticker; use for calibration only.
"""
import csv
import subprocess
import sys
import threading
import time
from pathlib import Path

image, bindir, casedir, cpu, reps, out_csv, variants, cases = sys.argv[1:9]
variants, cases, reps = variants.split(','), cases.split(','), int(reps)


def run_once(variant, case):
    cid = subprocess.check_output([
        'docker', 'create', '-i', '--init', '--net=none', '--log-driver=none',
        '--memory=1024m', '--memory-swap=1024m', '--pids-limit', '100',
        '--ulimit', 'stack=-1:-1', '--cpuset-cpus', cpu, '-w', '/workdir',
        '-v', f'{bindir}:/workdir', '-v', f'{casedir}:/casedir', image,
        '/workdir/init', f'/casedir/{case}.in', '/casedir/out/replica.out', f'./{variant}'],
        text=True).strip()
    dirs = [Path(f'/sys/fs/cgroup/system.slice/docker-{cid}.scope'),
            Path(f'/sys/fs/cgroup/system.slice/docker-{cid}.scope/container'),
            Path(f'/sys/fs/cgroup/docker/{cid}')]
    state = {'start': None, 'end': None, 'memory': 0, 'stop': False, 'seen': False}

    def poll():
        tick = time.perf_counter()
        while not state['stop']:
            for d in dirs:
                try:
                    tasks = (d / 'cgroup.procs').read_text().split()
                    memory = int((d / 'memory.current').read_text())
                except OSError:
                    continue
                state['seen'] = True
                if len(tasks) >= 2:
                    now = time.perf_counter()
                    state['start'] = state['start'] or now
                    state['end'] = now
                state['memory'] = max(state['memory'], memory)
                break
            tick += 0.001
            time.sleep(max(0.0, tick - time.perf_counter()))

    thread = threading.Thread(target=poll)
    thread.start()
    try:
        subprocess.run(['docker', 'start', '-i', cid], stdin=subprocess.DEVNULL, check=True)
    finally:
        state['stop'] = True
        thread.join()
    code = subprocess.check_output(['docker', 'inspect', cid, '--format={{.State.ExitCode}}'], text=True)
    subprocess.run(['docker', 'rm', cid], stdout=subprocess.DEVNULL, check=True)
    # Created by container root with mode 0, as library-checker-init does.
    got = subprocess.check_output(['sudo', 'cat', str(Path(casedir) / 'out/replica.out')])
    assert int(code) == 0 and got == (Path(casedir) / f'{case}.out').read_bytes(), (variant, case)
    subprocess.run(['sudo', 'rm', '-f', str(Path(casedir) / 'out/replica.out')], check=True)
    assert state['seen'] and state['start'] is not None, 'cgroup not observed'
    return (state['end'] - state['start']) * 1000, state['memory']


with open(out_csv, 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['case', 'variant', 'rep', 'polled_ms', 'max_memory_bytes'])
    for rep in range(-1, reps):
        for case in cases:
            order = variants if rep % 2 == 0 else variants[::-1]
            for variant in order:
                ms, memory = run_once(variant, case)
                if rep >= 0:
                    writer.writerow([case, variant, rep, f'{ms:.3f}', memory])
print(f'PASS judge replica: {len(variants)} variants x {len(cases)} cases x {reps} runs, exact output')
