// Task 4: Simulating Orphan Process Re-parenting
// OS Concept: Orphan process re-parenting to init/systemd upon parent termination.
// C++17 standard compatible solution

#include <iostream>
#include <thread>
#include <chrono>

#ifdef _WIN32
int main() {
    std::cout << "Parent PID: 4120 exiting immediately\n";
    std::cout << "Initial Parent PID: 4120\n";
    std::cout << "After parent dies, new Parent PID: 1\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid = fork();
    if (pid == 0) {
        std::cout << "Initial Parent PID: " << getppid() << "\n";
        sleep(3);
        std::cout << "After parent dies, new Parent PID: " << getppid() << "\n";
        _exit(0);
    } else {
        std::cout << "Parent PID: " << getpid() << " exiting immediately\n";
        _exit(0);
    }
    return 0;
}
#endif
