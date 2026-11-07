// Task 7: Thread-Specific Data & Thread-Local Storage (TLS)
// Part 1: Kernel-Level Threads (KLT) and POSIX Primitives
// C++17 standard solution

#include <iostream>
#include <thread>
#include <vector>
#include <string>

thread_local int private_counter = 0;
thread_local std::string tls_log;

void worker(int id) {
    private_counter += id * 10;
    tls_log = "Log entry for thread " + std::to_string(id);
    std::cout << "Thread " << id << " | TLS Data: " << tls_log
              << " | Private Counter: " << private_counter << "\n";
}

int main() {
    std::vector<std::thread> workers;
    for (int i = 1; i <= 4; ++i) {
        workers.emplace_back(worker, i);
    }
    for (auto& t : workers) {
        t.join();
    }
    return 0;
}
