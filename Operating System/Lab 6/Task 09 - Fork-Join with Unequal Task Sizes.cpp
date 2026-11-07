// Task 9: Fork–Join with Unequal Task Sizes
// Section 2: Task Parallelism
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>
#include <chrono>

void Busy(int ms) {
    auto start = std::chrono::high_resolution_clock::now();
    while (std::chrono::duration<double, std::milli>(std::chrono::high_resolution_clock::now() - start).count() < ms) {
        // busy spin
    }
}

int main() {
    // Imbalanced: {100, 400, 100, 400}
    std::vector<int> work_imbal = {100, 400, 100, 400};
    auto t0 = std::chrono::high_resolution_clock::now();
    std::vector<std::thread> th_imbal;
    for (int ms : work_imbal) th_imbal.emplace_back(Busy, ms);
    for (auto& t : th_imbal) t.join();
    auto t1 = std::chrono::high_resolution_clock::now();
    double t_imbal = std::chrono::duration<double, std::milli>(t1 - t0).count();

    // Balanced: {250, 250, 250, 250}
    std::vector<int> work_bal = {250, 250, 250, 250};
    auto tb0 = std::chrono::high_resolution_clock::now();
    std::vector<std::thread> th_bal;
    for (int ms : work_bal) th_bal.emplace_back(Busy, ms);
    for (auto& t : th_bal) t.join();
    auto tb1 = std::chrono::high_resolution_clock::now();
    double t_bal = std::chrono::duration<double, std::milli>(tb1 - tb0).count();

    std::cout << "Imbalanced execution time: " << t_imbal << " ms (dominated by 400ms max task)\n";
    std::cout << "Balanced execution time:   " << t_bal << " ms (ideal ~250ms)\n";
    return 0;
}
