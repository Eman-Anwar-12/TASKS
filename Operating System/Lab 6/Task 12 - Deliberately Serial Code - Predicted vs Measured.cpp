// Task 12: Deliberately Serial Code — Predicted vs. Measured
// Section 3: Amdahl's Law
// C++17 standard solution

#include <iostream>
#include <vector>
#include <iomanip>

int main() {
    double f = 0.10; // 10% forced serial fraction
    std::cout << "Serial Fraction f = " << f << "\n";
    std::cout << "Threads (T) | Predicted Speedup (1 / (f + (1-f)/T))\n";
    std::cout << "--------------------------------------------------\n";
    std::cout << std::fixed << std::setprecision(2);

    for (int T : {1, 2, 4, 8}) {
        double predicted = 1.0 / (f + (1.0 - f) / T);
        std::cout << std::setw(11) << T << " | " << std::setw(15) << predicted << "x\n";
    }
    return 0;
}
