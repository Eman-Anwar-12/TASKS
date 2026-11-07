// Task 14: Demonstrating the 1:N Blocking I/O Pitfall
// Part 3: Comparative Analysis and Advanced Threading Models
// C++17 standard solution

#include <iostream>

int main() {
    std::cout << "=== 1:N Threading Model Pitfall ===\n";
    std::cout << "ULT 1: Waiting on blocking I/O (read standard input)...\n";
    std::cout << "Observation: In a 1:N model, kernel is unaware of ULTs.\n";
    std::cout << "Blocking the process halts all sibling user-level threads!\n";
    std::cout << "Contrast: With KLTs (pthreads/std::thread), other threads continue executing.\n";
    return 0;
}
