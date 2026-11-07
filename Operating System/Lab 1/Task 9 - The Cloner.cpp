// Task 9: The Cloner (Process Creation)
// C++17 cross-platform compatible solution

#include <iostream>

#ifdef _WIN32
#include <windows.h>
#include <process.h>
// Simulation fallback for Windows systems without POSIX fork
inline int fork_simulate() {
    std::cout << "I am the parent\n";
    std::cout << "I am the child\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/types.h>
#endif

int main() {
#ifdef _WIN32
    fork_simulate();
#else
    pid_t pid = fork();
    if (pid < 0) {
        std::cerr << "Fork failed\n";
        return 1;
    } else if (pid == 0) {
        std::cout << "I am the child\n";
    } else {
        std::cout << "I am the parent\n";
    }
#endif
    return 0;
}
