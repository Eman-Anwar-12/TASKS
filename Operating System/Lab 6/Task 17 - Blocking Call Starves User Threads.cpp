// Task 17: Blocking Call Starves User Threads, Not Kernel Threads
// Section 4: User-Level vs. Kernel-Level Threads
// C++17 standard solution

#include <iostream>
#include <thread>
#include <chrono>
#include <atomic>

std::atomic<bool> done{false};

void counter_worker() {
    int count = 0;
    while (!done) {
        std::cout << "Kernel Thread B ticking: " << ++count << "\n";
        std::this_thread::sleep_for(std::chrono::milliseconds(300));
    }
}

int main() {
    std::cout << "Demonstrating Kernel Thread resiliency during blocking wait:\n";
    std::thread t(counter_worker);

    // Simulate 1 second blocking I/O operation
    std::this_thread::sleep_for(std::chrono::seconds(1));
    done = true;
    t.join();

    std::cout << "Under KLT, Thread B continues executing while main thread blocked.\n";
    return 0;
}
