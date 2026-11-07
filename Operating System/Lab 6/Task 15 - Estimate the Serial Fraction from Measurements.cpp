// Task 15: Estimate the Serial Fraction from Measurements
// Section 3: Amdahl's Law
// Inverting S = 1 / (f + (1-f)/N) -> f = (1/S - 1/N) / (1 - 1/N)
// C++17 standard solution

#include <iostream>
#include <vector>
#include <iomanip>

int main() {
    struct Meas { int N; double S; };
    std::vector<Meas> measurements = { {2, 1.85}, {4, 3.20}, {8, 5.10} };

    std::cout << "Cores (N) | Measured Speedup | Inferred Serial Fraction (f)\n";
    std::cout << "-----------------------------------------------------------\n";
    std::cout << std::fixed << std::setprecision(4);

    for (auto& m : measurements) {
        double f = ((1.0 / m.S) - (1.0 / m.N)) / (1.0 - (1.0 / m.N));
        std::cout << std::setw(9) << m.N << " | " << std::setw(15) << m.S
                  << "x | " << std::setw(18) << f * 100 << "%\n";
    }
    return 0;
}
