// Task 5: Dot Product — Demonstrating a Race Condition and Fixes
// Section 1: Data Parallelism
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>
#include <mutex>
#include <atomic>

const size_t N = 1000000;
long long racy_dot = 0;
long long mutex_dot = 0;
std::atomic<long long> atomic_dot{0};
std::mutex mtx;

int main() {
    std::vector<int> A(N, 2), B(N, 3);
    long long expected = (long long)N * 2 * 3;

    // Mutex fix demonstration
    const int T = 4;
    size_t chunk = N / T;
    std::vector<std::thread> threads;
    for (int t = 0; t < T; ++t) {
        threads.emplace_back([&, t]() {
            long long p = 0;
            for (size_t i = t * chunk; i < (t + 1) * chunk; ++i) p += A[i] * B[i];
            std::lock_guard<std::mutex> lock(mtx);
            mutex_dot += p;
        });
    }
    for (auto& th : threads) th.join();

    std::cout << "Expected Dot Product: " << expected << "\n";
    std::cout << "Mutex-Protected Dot Product: " << mutex_dot << "\n";
    return 0;
}
