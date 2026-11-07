// Task 21: The Core Pin (Thread CPU Affinity)
// OS Concept: Thread CPU Affinity
// C++17 Solution

#include <iostream>
#include <thread>
#ifdef _WIN32
#include <windows.h>

void pinnedWorker() {
    DWORD_PTR mask = 1; // Core 0
    DWORD_PTR prev = SetThreadAffinityMask(GetCurrentThread(), mask);
    if (prev != 0) {
        std::cout << "Thread successfully bound to Core 0.\n";
    }
}

int main() {
    std::cout << "Available hardware cores: "
              << std::thread::hardware_concurrency() << "\n";
    std::thread t(pinnedWorker);
    t.join();
    return 0;
}
#else
#include <pthread.h>
void pinnedWorker() {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(0, &cpuset);
    pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
    std::cout << "Thread successfully bound to Core 0.\n";
}
int main() {
    std::cout << "Available hardware cores: " << std::thread::hardware_concurrency() << "\n";
    std::thread t(pinnedWorker);
    t.join();
    return 0;
}
#endif
