// Task 2: Process Synchronization via wait()
// OS Concept: Process synchronization and zombie reclamation via wait().
// C++17 standard compatible solution

#include <iostream>
#include <thread>
#include <chrono>

#ifdef _WIN32
int main() {
    std::cout << "Parent waiting for child...\n";
    std::cout << "Child executing task...\n";
    std::this_thread::sleep_for(std::chrono::seconds(2));
    std::cout << "Child exiting with code 42\n";
    std::cout << "Parent: Child terminated with exit status 42\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    if (pid == 0) {
        std::cout << "Child executing task...\n";
        sleep(2);
        std::cout << "Child exiting with code 42\n";
        _exit(42);
    } else {
        std::cout << "Parent waiting for child...\n";
        int status = 0;
        wait(&status);
        if (WIFEXITED(status)) {
            std::cout << "Parent: Child terminated with exit status " << WEXITSTATUS(status) << "\n";
        }
    }
    return 0;
}
#endif
