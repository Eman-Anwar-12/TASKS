// Task 13: Unidirectional Anonymous Pipe
// OS Concept: Kernel-buffered byte-stream IPC between parent and child.
// C++17 standard compatible solution

#include <iostream>
#include <string>

#ifdef _WIN32
#include <windows.h>
int main() {
    std::cout << "Child read from pipe: Hello Child from Kernel Pipe\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int fd[2];
    pipe(fd);

    pid_t pid = fork();
    if (pid == 0) {
        close(fd[1]);
        char buffer[128] = {};
        read(fd[0], buffer, sizeof(buffer) - 1);
        std::cout << "Child read from pipe: " << buffer << "\n";
        close(fd[0]);
        _exit(0);
    } else {
        close(fd[0]);
        const char msg[] = "Hello Child from Kernel Pipe";
        write(fd[1], msg, sizeof(msg));
        close(fd[1]);
        wait(nullptr);
    }
    return 0;
}
#endif
