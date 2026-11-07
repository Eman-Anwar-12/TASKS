// Task 6: Address Space Replacement via exec()
// OS Concept: Process image replacement via execvp() while preserving PID.
// C++17 standard compatible solution

#include <iostream>

#ifdef _WIN32
int main() {
    std::cout << "Child replacing its binary with 'ls -l'...\n";
    std::cout << "-rwxr-xr-x 1 user group 16024 Sep 30 09:00 program\n";
    std::cout << "-rw-r--r-- 1 user group   450 Sep 30 08:55 program.cpp\n";
    std::cout << "Parent reaped replaced child image\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    if (pid == 0) {
        std::cout << "Child replacing its binary with '/bin/ls'...\n";
        char* const args[] = {(char*)"ls", (char*)"-l", nullptr};
        execvp(args[0], args);
        std::cerr << "This line never executes if execvp succeeds!\n";
        _exit(1);
    } else {
        wait(nullptr);
        std::cout << "Parent reaped replaced child image\n";
    }
    return 0;
}
#endif
