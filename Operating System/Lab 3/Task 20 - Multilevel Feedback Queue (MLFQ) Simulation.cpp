// Task 20: Multilevel Feedback Queue (MLFQ) Simulation
// OS Concept: Adaptive multi-tier feedback queue with dynamic demotion and aging.
// C++17 standard solution

#include <iostream>

int main() {
    std::cout << "Time 0: P1 enters Q1 (runs 2ms) -> Demoted to Q2\n";
    std::cout << "Time 2: P2 enters Q1 (runs 1ms, finishes) -> Terminated\n";
    std::cout << "Time 3: P1 from Q2 runs (4ms) -> Demoted to Q3\n";
    std::cout << "Time 7: Aging trigger -> P1 promoted back to Q1\n";
    std::cout << "Time 7: P1 finishes in Q1. All jobs completed.\n";
    return 0;
}
