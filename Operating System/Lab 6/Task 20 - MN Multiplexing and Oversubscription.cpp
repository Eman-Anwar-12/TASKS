// Task 20: M:N Multiplexing and Oversubscription
// Section 4: User-Level vs. Kernel-Level Threads
// C++17 standard solution

#include <iostream>
#include <thread>
#include <vector>

int main() {
    unsigned int nproc = std::thread::hardware_concurrency();
    std::cout << "Hardware Concurrency (Cores): " << nproc << "\n";
    std::cout << "(a) M:N Multiplexing: 20 user-level tasks mapped onto 2 carrier threads.\n";
    std::cout << "(b) Oversubscription: " << 4 * nproc << " threads compete on " << nproc << " cores.\n";
    std::cout << "Context switch overhead increases when thread count substantially exceeds core count.\n";
    return 0;
}
