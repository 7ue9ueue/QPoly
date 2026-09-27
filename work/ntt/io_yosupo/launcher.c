// Judge-like process timer; usage: launcher PLAN RESULTS.csv.
// PLAN lines: "reps R", "warmups W", "evict MiB", "init PATH", "outdir DIR",
// "variant NAME PATH", "case NAME INPUT EXPECTED".
// Each run: unlink the output, optionally evict caches by touching a buffer, then
// time posix_spawn(init IN OUT ./variant) until wait4 returns. This mirrors the
// judge window (child exists -> child exits), including exec, dynamic loading,
// page faults, write() into a new file and process teardown. Every output must
// be byte-identical to EXPECTED and the exit status zero, or the launcher fails.
// Variant order rotates each repetition and reverses on odd repetitions.
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <spawn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

extern char** environ;
enum { MAX_ITEMS = 128 };
static char variant_name[MAX_ITEMS][64], variant_path[MAX_ITEMS][512];
static char case_name[MAX_ITEMS][64], case_in[MAX_ITEMS][512], case_expected[MAX_ITEMS][512];
static int variants, cases, reps = 11, warmups = 2, evict_mib = 0;
static char init_path[512] = "/workdir/init", outdir[512] = "/casedir/out";

static void fail(const char* what, const char* detail) {
    fprintf(stderr, "FAIL %s %s (errno %d)\n", what, detail, errno);
    exit(1);
}
static long long now_ns(void) {
    struct timespec t;
    clock_gettime(CLOCK_MONOTONIC, &t);
    return t.tv_sec * 1000000000LL + t.tv_nsec;
}
static char* slurp(const char* path, size_t* size) {
    int fd = open(path, O_RDONLY);
    if (fd < 0) fail("open", path);
    struct stat st;
    if (fstat(fd, &st) != 0) fail("fstat", path);
    char* data = malloc((size_t)st.st_size + 1);
    size_t done = 0;
    while (done < (size_t)st.st_size) {
        ssize_t got = read(fd, data + done, (size_t)st.st_size - done);
        if (got <= 0) fail("read", path);
        done += (size_t)got;
    }
    close(fd);
    *size = done;
    return data;
}
static void evict(void) {
    static volatile unsigned char* buffer;
    const size_t bytes = (size_t)evict_mib << 20;
    if (!bytes) return;
    if (!buffer) buffer = calloc(bytes, 1);
    for (size_t i = 0; i < bytes; i += 64) buffer[i] += 1;
}

int main(int argc, char** argv) {
    if (argc != 3) fail("usage", "launcher PLAN RESULTS.csv");
    FILE* plan = fopen(argv[1], "r");
    if (!plan) fail("open", argv[1]);
    char key[32];
    while (fscanf(plan, "%31s", key) == 1) {
        if (!strcmp(key, "reps")) { if (fscanf(plan, "%d", &reps) != 1) fail("plan", key); }
        else if (!strcmp(key, "warmups")) { if (fscanf(plan, "%d", &warmups) != 1) fail("plan", key); }
        else if (!strcmp(key, "evict")) { if (fscanf(plan, "%d", &evict_mib) != 1) fail("plan", key); }
        else if (!strcmp(key, "init")) { if (fscanf(plan, "%511s", init_path) != 1) fail("plan", key); }
        else if (!strcmp(key, "outdir")) { if (fscanf(plan, "%511s", outdir) != 1) fail("plan", key); }
        else if (!strcmp(key, "variant") && variants < MAX_ITEMS) {
            if (fscanf(plan, "%63s %511s", variant_name[variants], variant_path[variants]) != 2) fail("plan", key);
            ++variants;
        } else if (!strcmp(key, "case") && cases < MAX_ITEMS) {
            if (fscanf(plan, "%63s %511s %511s", case_name[cases], case_in[cases], case_expected[cases]) != 3)
                fail("plan", key);
            ++cases;
        } else fail("plan key", key);
    }
    fclose(plan);
    if (!variants || !cases) fail("plan", "needs variants and cases");
    FILE* results = fopen(argv[2], "w");
    if (!results) fail("open", argv[2]);
    fprintf(results, "case,variant,rep,position,wall_ns,user_us,sys_us,minflt,majflt,nvcsw,nivcsw,"
                     "main_ns,mapped_ns,parsed_ns,ntt_ns,written_ns,write_syscall_ns\n");
    char out_path[600], err_path[600];
    snprintf(out_path, sizeof out_path, "%s/actual.out", outdir);
    snprintf(err_path, sizeof err_path, "%s/stderr.txt", outdir);
    for (int rep = -warmups; rep < reps; ++rep) {
        for (int c = 0; c < cases; ++c) {
            size_t expected_size;
            char* expected = slurp(case_expected[c], &expected_size);
            for (int position = 0; position < variants; ++position) {
                int shift = ((rep % variants) + variants) % variants;
                int k = (position + shift) % variants;
                if (rep & 1) k = variants - 1 - k;
                if (unlink(out_path) != 0 && errno != ENOENT) fail("unlink", out_path);
                evict();
                posix_spawn_file_actions_t actions;
                posix_spawn_file_actions_init(&actions);
                posix_spawn_file_actions_addopen(&actions, 2, err_path, O_WRONLY | O_CREAT | O_TRUNC, 0644);
                char* child_argv[] = {init_path, case_in[c], out_path, variant_path[k], NULL};
                pid_t pid;
                struct rusage usage;
                int status;
                const long long begin = now_ns();
                if (posix_spawn(&pid, init_path, &actions, NULL, child_argv, environ) != 0) fail("spawn", variant_path[k]);
                if (wait4(pid, &status, 0, &usage) != pid) fail("wait4", variant_path[k]);
                const long long end = now_ns();
                posix_spawn_file_actions_destroy(&actions);
                if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) fail("exit status", variant_name[k]);
                size_t got_size, err_size;
                chmod(out_path, 0600);  // Created with mode 0 like the judge; readable when not root.
                char* got = slurp(out_path, &got_size);
                if (got_size != expected_size || memcmp(got, expected, got_size) != 0) {
                    fprintf(stderr, "case %s variant %s\n", case_name[c], variant_name[k]);
                    fail("output mismatch", case_name[c]);
                }
                free(got);
                char* err = slurp(err_path, &err_size);
                err[err_size] = 0;
                long long marks[6] = {0, 0, 0, 0, 0, 0};
                if (err_size && !strncmp(err, "compute_ms=", 11)) err_size = 0;  // Shoup file's own timer.
                if (err_size) {
                    if (sscanf(err, "QP %lld %lld %lld %lld %lld %lld", &marks[0], &marks[1], &marks[2],
                               &marks[3], &marks[4], &marks[5]) != 6) fail("unexpected stderr", variant_name[k]);
                    for (int i = 0; i < 5; ++i) marks[i] -= begin;
                }
                free(err);
                if (rep >= 0)
                    fprintf(results, "%s,%s,%d,%d,%lld,%ld,%ld,%ld,%ld,%ld,%ld,%lld,%lld,%lld,%lld,%lld,%lld\n",
                            case_name[c], variant_name[k], rep, position, end - begin,
                            usage.ru_utime.tv_sec * 1000000L + usage.ru_utime.tv_usec,
                            usage.ru_stime.tv_sec * 1000000L + usage.ru_stime.tv_usec,
                            usage.ru_minflt, usage.ru_majflt, usage.ru_nvcsw, usage.ru_nivcsw,
                            marks[0], marks[1], marks[2], marks[3], marks[4], marks[5]);
            }
            free(expected);
        }
        fflush(results);
    }
    fclose(results);
    printf("PASS %d variants x %d cases x %d measured (+%d warmup) runs: exact output, exit 0\n",
           variants, cases, reps, warmups);
    return 0;
}
