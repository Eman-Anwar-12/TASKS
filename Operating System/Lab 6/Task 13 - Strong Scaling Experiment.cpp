// Task 13: Strong Scaling Experiment
// Section 3: Amdahl's Law
// C++17 standard solution

#include <iostream>
#include <vector>
#include <iomanip>

int main() {
    double T1 = 100.0; // Baseline sequential time in ms
    std::cout << "Threads (T) | Time (ms) | Speedup S(T) | Efficiency E(T)\n";
    std::cout << "-----------------------------------------------------\n";
    std::cout << std::fixed << std::setprecision(2);

    std::vector<double> simulated_times = {100.0, 52.0, 28.0, 16.5};
    int idx = 0;
    for (int T : {1, 2, 4, 8}) {
        double tT = simulated_times[idx++];
        double S = T1 / tT;
        double E = S / T;
        std::cout << std::setw(11) << T << " | " << std::setw(9) << tT << " | "
                  << std::setw(10) << S << "x | " << std::setw(14) << E * 100 << "%\n";
    }
    return 0;
}
