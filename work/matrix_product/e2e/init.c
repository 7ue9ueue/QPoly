// Copied unchanged from work/ntt/io_yosupo/init.c (QPoly exploration 007).
// Equivalent of Library Checker's library-checker-init (langs/init/src/main.rs):
// open input read-only and output write/create (mode 0, no truncation), dup2 them
// onto stdin/stdout, then execvp the solution. Descriptors 3/4 stay open as there.
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char** argv) {
    if (argc <= 3) return 101;
    int in = open(argv[1], O_RDONLY), out = open(argv[2], O_WRONLY | O_CREAT, 0);
    if (in < 0 || out < 0 || dup2(in, 0) < 0 || dup2(out, 1) < 0) return 102;
    execvp(argv[3], argv + 3);
    return 103;
}
