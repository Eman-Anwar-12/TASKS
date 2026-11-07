// Task 6: Two Independent Tasks
// Section 2: Task Parallelism
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>
#include <algorithm>
#include <cmath>
#include <chrono>

void TaskX() {
    volatile double sum = 0;
    for (long i = 1; i <= 20000000; ++i) {
        sum += std::sqrt(i);
    }
}

void TaskY() {
    std::vector<int> data(2000000);
    for (int i = 0; i < 2000000; ++i) data[i] = 2000000 - i;
    std::sort(data.begin(), data.end());
}

int main() {
    // Sequential
    auto s0 = std::chrono::high_resolution_clock::now();
    TaskX();
    TaskY();
    auto s1 = std::chrono::high_resolution_clock::now();
    double t_seq = std::chrono::duration<double, std::milli>(s1 - s0).count();

    // Concurrent (Task Parallelism)
    auto p0 = std::chrono::high_resolution_clock::now();
    std::thread t1(TaskX);
    std::thread t2(TaskY);
    t1.join();
    t2.join();
    auto p1 = std::chrono::high_resolution_clock::now();
    double t_par = std::chrono::duration<double, std::milli>(p1 - p0).count();

    std::cout << "Sequential Time: " << t_seq << " ms\n";
    std::cout << "Parallel Time:   " << t_par << " ms (approaching max(X, Y))\n";
    std::cout << "Speedup: " << t_seq / t_par << "x\n";
    return 0;
}
