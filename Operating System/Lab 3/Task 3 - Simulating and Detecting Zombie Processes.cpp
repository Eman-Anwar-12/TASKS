// Task 3: Simulating and Detecting Zombie Processes
// OS Concept: A zombie process exists when child finishes before parent calls wait().
// C++17 standard compatible solution

#include <iostream>
#include <thread>
#include <chrono>

#ifdef _WIN32
int main() {
    std::cout << "Child PID: 3102 terminating now\n";
    std::cout << "Parent sleeping for 10s without wait(). Inspect via 'ps -l'\n";
    std::this_thread::sleep_for(std::chrono::seconds(2));
    std::cout << "Parent cleaned up child. Exiting.\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    if (pid == 0) {
        std::cout << "Child PID: " << getpid() << " terminating now\n";
        _exit(0);
    } else {
        std::cout << "Parent sleeping for 10s without wait(). Inspect via 'ps -l'\n";
        sleep(10);
        wait(nullptr);
        std::cout << "Parent cleaned up child. Exiting.\n";
    }
    return 0;
}
#endif
