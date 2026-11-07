// Task 16: Shortest Job First (SJF - Non-Preemptive)
// OS Concept: Minimizing average waiting time using shortest burst priority.
// C++17 standard solution

#include <iostream>
#include <vector>
#include <iomanip>

struct Process {
    std::string pid;
    int burst_time;
    int arrival_time = 0;
    int wait_time = 0;
    int turnaround_time = 0;
    bool completed = false;
};

void schedule_sjf(std::vector<Process>& processes) {
    int current_time = 0;
    int completed_count = 0;
    size_t n = processes.size();
    double total_wait = 0;

    std::cout << "Execution Order: ";
    bool first = true;

    while (completed_count < (int)n) {
        int best_idx = -1;
        int min_burst = 1e9;

        for (size_t i = 0; i < n; ++i) {
            if (!processes[i].completed && processes[i].burst_time < min_burst) {
                min_burst = processes[i].burst_time;
                best_idx = (int)i;
            }
        }

        if (best_idx == -1) break;

        auto& p = processes[best_idx];
        if (!first) std::cout << " -> ";
        std::cout << p.pid;
        first = false;

        p.wait_time = current_time;
        current_time += p.burst_time;
        p.turnaround_time = current_time;
        p.completed = true;
        total_wait += p.wait_time;
        completed_count++;
    }
    std::cout << "\n\n";

    std::cout << "PID | Burst | Wait Time | Turnaround Time\n";
    for (const auto& p : processes) {
        std::cout << p.pid << "  | " << p.burst_time << "     | "
                  << p.wait_time << "         | " << p.turnaround_time << "\n";
    }

    std::cout << std::fixed << std::setprecision(2);
    std::cout << "Average Waiting Time: " << (total_wait / n) << " ms\n";
}

int main() {
    std::vector<Process> processes = {
        {"P1", 6},
        {"P3", 2},
        {"P2", 8}
    };
    schedule_sjf(processes);
    return 0;
}
