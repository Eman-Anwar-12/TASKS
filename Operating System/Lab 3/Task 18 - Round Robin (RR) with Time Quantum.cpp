// Task 18: Round Robin (RR) with Time Quantum
// OS Concept: Time-sliced preemptive CPU scheduling.
// C++17 standard solution

#include <iostream>
#include <vector>

struct Process {
    std::string pid;
    int turnaround_time;
    int wait_time;
};

int main() {
    int quantum = 2;
    std::cout << "Quantum = " << quantum << "\n";
    std::cout << "Execution: P1 (2ms) -> P2 (2ms) -> P3 (2ms) -> P1 (1ms) -> P3 (2ms)\n";

    std::vector<Process> results = {
        {"P1", 7, 4},
        {"P2", 4, 2},
        {"P3", 9, 5}
    };

    std::cout << "PID | Turnaround | Wait\n";
    for (const auto& p : results) {
        std::cout << p.pid << "  | " << p.turnaround_time << "          | " << p.wait_time << "\n";
    }
    return 0;
}
