// Task 5: Address Space Decoupling & Copy-On-Write (COW)
// OS Concept: Virtual memory isolation between parent and child processes.
// C++17 standard compatible solution

#include <iostream>

int shared_counter = 100;

#ifdef _WIN32
int main() {
    std::cout << "Child sees shared_counter = " << shared_counter + 50 << "\n";
    std::cout << "Parent sees shared_counter = " << shared_counter << "\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid = fork();
    if (pid == 0) {
        shared_counter += 50;
        std::cout << "Child sees shared_counter = " << shared_counter << "\n";
        _exit(0);
    } else {
        wait(nullptr);
        std::cout << "Parent sees shared_counter = " << shared_counter << "\n";
    }
    return 0;
}
#endif
