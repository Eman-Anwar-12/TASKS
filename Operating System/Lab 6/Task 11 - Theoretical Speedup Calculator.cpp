// Task 11: Theoretical Speedup Calculator
// Section 3: Amdahl's Law
// S(N) = 1 / ((1 - p) + p / N)
// C++17 standard solution

#include <iostream>
#include <iomanip>

int main() {
    double p = 0.90; // 90% parallel fraction
    std::cout << "Amdahl Speedup Table for Parallel Fraction p = " << p << ":\n";
    std::cout << "Cores (N) | Theoretical Speedup S(N)\n";
    std::cout << "-----------------------------------\n";
    std::cout << std::fixed << std::setprecision(3);

    for (int N = 1; N <= 16; ++N) {
        double speedup = 1.0 / ((1.0 - p) + (p / N));
        std::cout << std::setw(9) << N << " | " << std::setw(12) << speedup << "\n";
    }
    return 0;
}
