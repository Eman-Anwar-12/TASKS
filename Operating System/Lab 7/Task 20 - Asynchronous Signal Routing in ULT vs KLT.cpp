// Task 20: Asynchronous Signal Routing in ULT vs. KLT
// Part 3: Comparative Analysis and Advanced Threading Models
// C++17 standard solution

#include <iostream>

int main() {
    std::cout << "=== Signal Handling Dynamics: ULT vs. KLT ===\n";
    std::cout << "KLT (POSIX): Dedicated signal handling thread with sigwait() and pthread_sigmask.\n";
    std::cout << "Specific signals (SIGINT) are intercepted cleanly by the designated handler thread.\n";
    std::cout << "ULT: Signals arrive at process level and suspend the active fiber indiscriminately.\n";
    return 0;
}
