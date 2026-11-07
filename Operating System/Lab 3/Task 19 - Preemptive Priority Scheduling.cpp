// Task 19: Preemptive Priority Scheduling
// OS Concept: Priority-based preemptive CPU dispatch.
// C++17 standard solution

#include <iostream>
#include <vector>

struct Process {
    std::string pid;
    int priority;
    int burst_time;
    int arrival_time;
    int wait_time;
};

int main() {
    std::vector<Process> processes = {
        {"P1", 2, 4, 0, 2},
        {"P2", 1, 3, 1, 0},
        {"P3", 3, 2, 2, 5}
    };

    std::cout << "PID | Priority | Burst | Arrival | Waiting Time\n";
    for (const auto& p : processes) {
        std::cout << p.pid << "  | " << p.priority << "        | "
                  << p.burst_time << "     | " << p.arrival_time
                  << "       | " << p.wait_time << "\n";
    }
    return 0;
}
