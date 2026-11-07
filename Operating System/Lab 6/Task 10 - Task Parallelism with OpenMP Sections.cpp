// Task 10: Task Parallelism with OpenMP Sections (or C++17 Async/Future fallback)
// Section 2: Task Parallelism
// C++17 standard solution

#include <iostream>
#include <future>
#include <chrono>
#include <cmath>
#include <vector>
#include <algorithm>

void TaskX() {
    volatile double sum = 0;
    for (long i = 1; i <= 10000000; ++i) sum += std::sqrt(i);
}

void TaskY() {
    std::vector<int> data(1000000);
    for (int i = 0; i < 1000000; ++i) data[i] = 1000000 - i;
    std::sort(data.begin(), data.end());
}

int main() {
    auto t0 = std::chrono::high_resolution_clock::now();

    // C++17 async executes sections in parallel
    auto f1 = std::async(std::launch::async, TaskX);
    auto f2 = std::async(std::launch::async, TaskY);
    f1.get();
    f2.get();

    auto t1 = std::chrono::high_resolution_clock::now();
    std::cout << "Parallel sections completed in "
              << std::chrono::duration<double, std::milli>(t1 - t0).count() << " ms\n";
    return 0;
}
