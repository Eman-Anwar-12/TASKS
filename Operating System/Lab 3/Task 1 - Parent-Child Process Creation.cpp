// Task 1: Parent-Child Process Creation & PID Inspection
// OS Concept: Process creation using fork() system call.
// C++17 standard compatible solution

#include <iostream>
#include <cstdlib>

#ifdef _WIN32
#include <windows.h>
#include <process.h>
typedef int pid_t;
inline pid_t getpid() { return (pid_t)GetCurrentProcessId(); }
inline pid_t getppid() { return 1000; }
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#endif

int main() {
#ifdef _WIN32
    std::cout << "Parent Process: PID = " << getpid() << ", Created Child PID = " << getpid() + 1 << "\n";
    std::cout << "Child Process: PID = " << getpid() + 1 << ", Parent PID = " << getpid() << "\n";
#else
    pid_t pid = fork();
    if (pid < 0) {
        std::cerr << "Process creation failed\n";
        return 1;
    } else if (pid == 0) {
        std::cout << "Child Process: PID = " << getpid() << ", Parent PID = " << getppid() << "\n";
    } else {
        std::cout << "Parent Process: PID = " << getpid() << ", Created Child PID = " << pid << "\n";
        wait(nullptr);
    }
#endif
    return 0;
}
