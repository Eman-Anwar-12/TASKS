// Task 5: Synchronization Primitives: Futex-Based Mutex vs. Spinlock
// Part 1: Kernel-Level Threads (KLT) and POSIX Primitives
// C++17 standard solution

#include <iostream>
#include <thread>
#include <vector>
#include <mutex>
#include <atomic>
#include <chrono>

std::mutex mtx_lock;
std::atomic_flag spin_lock = ATOMIC_FLAG_INIT;
long counter = 0;

void spin_acquire() {
    while (spin_lock.test_and_set(std::memory_order_acquire)) {
        // Busy spin
    }
}
void spin_release() {
    spin_lock.clear(std::memory_order_release);
}

int main() {
    const int ITERATIONS = 100000;
    const int THREADS = 4;

    // Mutex Benchmark
    counter = 0;
    auto t0 = std::chrono::high_resolution_clock::now();
    {
        std::vector<std::thread> pool;
        for (int t = 0; t < THREADS; ++t) {
            pool.emplace_back([&]() {
                for (int i = 0; i < ITERATIONS; ++i) {
                    std::lock_guard<std::mutex> l(mtx_lock);
                    counter++;
                }
            });
        }
        for (auto& th : pool) th.join();
    }
    auto t1 = std::chrono::high_resolution_clock::now();
    double mutex_time = std::chrono::duration<double, std::milli>(t1 - t0).count();

    // Spinlock Benchmark
    counter = 0;
    auto t2 = std::chrono::high_resolution_clock::now();
    {
        std::vector<std::thread> pool;
        for (int t = 0; t < THREADS; ++t) {
            pool.emplace_back([&]() {
                for (int i = 0; i < ITERATIONS; ++i) {
                    spin_acquire();
                    counter++;
                    spin_release();
                }
            });
        }
        for (auto& th : pool) th.join();
    }
    auto t3 = std::chrono::high_resolution_clock::now();
    double spin_time = std::chrono::duration<double, std::milli>(t3 - t2).count();

    std::cout << "Mutex Execution Elapsed:    " << mutex_time << " ms\n";
    std::cout << "Spinlock Execution Elapsed: " << spin_time << " ms\n";
    return 0;
}
