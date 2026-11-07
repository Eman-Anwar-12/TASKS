// Task 4: Multi-Core Hardware Parallelism & CPU Pinning
// Part 1: Kernel-Level Threads (KLT) and POSIX Primitives
// C++17 solution

#include <iostream>
#include <vector>
#include <thread>
#include <atomic>
#include <chrono>

#ifdef _WIN32
#include <windows.h>
inline void pin_thread(int core_id) {
    SetThreadAffinityMask(GetCurrentThread(), (DWORD_PTR)1 << core_id);
}
#elif defined(__linux__)
#include <pthread.h>
inline void pin_thread(int core_id) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(core_id, &cpuset);
    pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
}
#else
inline void pin_thread(int) {}
#endif

int main() {
    unsigned int num_cores = std::thread::hardware_concurrency();
    std::cout << "Detected " << num_cores << " CPU cores. Pinning workers...\n";

    std::vector<std::thread> workers;
    for (unsigned int i = 0; i < std::min(num_cores, 4u); ++i) {
        workers.emplace_back([i]() {
            pin_thread(i);
            std::cout << "Worker pinned to Core " << i << " executing compute load.\n";
            std::this_thread::sleep_for(std::chrono::milliseconds(100));
        });
    }

    for (auto& t : workers) t.join();
    std::cout << "Multicore pinning test finished.\n";
    return 0;
}
