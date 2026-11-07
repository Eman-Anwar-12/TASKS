// Task 14: Amdahl vs. Gustafson on the Same Data
// Section 3: Amdahl's Law
// C++17 standard solution

#include <iostream>
#include <iomanip>

int main() {
    double p = 0.95; // 95% parallel fraction
    std::cout << "N Cores | Amdahl (Fixed-Size) | Gustafson (Scaled-Size)\n";
    std::cout << "-------------------------------------------------------\n";
    std::cout << std::fixed << std::setprecision(2);

    for (int N = 1; N <= 8; ++N) {
        double s_amdahl = 1.0 / ((1.0 - p) + p / N);
        double s_gustafson = N - (1.0 - p) * (N - 1);
        std::cout << std::setw(7) << N << " | " << std::setw(16) << s_amdahl
                  << "x | " << std::setw(18) << s_gustafson << "x\n";
    }
    return 0;
}
