// Task 3: Direct Low-Level Thread Creation via clone()
// Part 1: Kernel-Level Threads (KLT) and POSIX Primitives
// C++17 solution

#include <iostream>
#include <thread>
#include <chrono>

#ifdef __linux__
#include <sched.h>
#include <sys/syscall.h>
#include <unistd.h>

const int STACK_SIZE = 65536;

int child_execution(void* arg) {
    std::cout << "Inside child clone thread. Kernel TID: " << syscall(SYS_gettid) << "\n";
    return 0;
}

int main() {
    char* child_stack = new char[STACK_SIZE];
    char* stack_top = child_stack + STACK_SIZE;

    int clone_flags = CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_THREAD;
    int tid = clone(child_execution, stack_top, clone_flags, nullptr);

    if (tid == -1) {
        std::cerr << "Clone creation failed\n";
        delete[] child_stack;
        return 1;
    }

    std::cout << "Spawned kernel thread with TID: " << tid << "\n";
    sleep(1);
    delete[] child_stack;
    return 0;
}
#else
int main() {
    std::cout << "Low-level thread creation demonstration (C++17 runtime abstraction):\n";
    std::thread t([]() {
        std::cout << "Inside child thread. Kernel TID active.\n";
    });
    t.join();
    std::cout << "Thread joined and resources freed.\n";
    return 0;
}
#endif
