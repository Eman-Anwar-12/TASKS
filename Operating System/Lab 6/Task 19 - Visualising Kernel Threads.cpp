// Task 19: Visualising Kernel Threads via /proc
// Section 4: User-Level vs. Kernel-Level Threads
// C++17 standard solution

#include <iostream>
#include <thread>
#include <vector>
#include <chrono>

void worker(int id) {
    std::cout << "Worker " << id << " active on distinct thread ID: "
              << std::this_thread::get_id() << "\n";
}

int main() {
    std::vector<std::thread> pool;
    for (int i = 1; i <= 4; ++i) {
        pool.emplace_back(worker, i);
    }
    for (auto& t : pool) {
        t.join();
    }
    std::cout << "Each thread represents a distinct 1:1 schedulable kernel entity.\n";
    return 0;
}
