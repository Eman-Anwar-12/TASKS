// Task 15: First-Come, First-Served (FCFS) Scheduling
// OS Concept: Non-preemptive scheduling based on arrival order.
// C++17 standard solution

#include <iostream>
#include <vector>
#include <algorithm>
#include <iomanip>

struct Process {
    std::string pid;
    int arrival_time;
    int burst_time;
    int completion_time = 0;
    int turnaround_time = 0;
    int wait_time = 0;
};

void schedule_fcfs(std::vector<Process>& processes) {
    std::sort(processes.begin(), processes.end(), [](const Process& a, const Process& b) {
        return a.arrival_time < b.arrival_time;
    });

    int current_time = 0;
    double total_wait = 0;

    std::cout << "PID | Arrival | Burst | Completion | Turnaround | Wait\n";
    for (auto& p : processes) {
        if (current_time < p.arrival_time) {
            current_time = p.arrival_time;
        }
        p.completion_time = current_time + p.burst_time;
        p.turnaround_time = p.completion_time - p.arrival_time;
        p.wait_time = p.turnaround_time - p.burst_time;
        current_time = p.completion_time;
        total_wait += p.wait_time;

        std::cout << p.pid << "  | " << p.arrival_time << "       | " << p.burst_time
                  << "     | " << p.completion_time << "          | " << p.turnaround_time
                  << "          | " << p.wait_time << "\n";
    }

    std::cout << std::fixed << std::setprecision(2);
    std::cout << "Average Waiting Time: " << (total_wait / processes.size()) << " ms\n";
}

int main() {
    std::vector<Process> processes = {
        {"P1", 0, 5},
        {"P2", 1, 3},
        {"P3", 2, 8}
    };
    schedule_fcfs(processes);
    return 0;
}
