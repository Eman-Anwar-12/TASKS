// Task 1: Basic POSIX Thread Lifecycle
// Part 1: Kernel-Level Threads (KLT) and POSIX Primitives
// C++17 standard compatible solution

#include <iostream>
#include <vector>
#include <thread>

void worker_routine(int arg) {
    std::cout << "Worker executing with Arg: " << arg
              << ", Thread ID: " << std::this_thread::get_id() << "\n";
}

int main() {
    std::vector<std::thread> threads;
    std::vector<int> args = {1, 2, 3, 4};

    for (int i = 0; i < 4; ++i) {
        threads.emplace_back(worker_routine, args[i]);
    }

    for (auto& t : threads) {
        t.join();
    }

    std::cout << "All kernel worker threads completed successfully.\n";
    return 0;
}
