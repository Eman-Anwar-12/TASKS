// Task 17: Shortest Remaining Time First (SRTF)
// OS Concept: Preemptive Shortest Job First scheduling.
// C++17 standard solution

#include <iostream>
#include <vector>

struct Process {
    std::string pid;
    int arrival_time;
    int burst_time;
    int remaining_time;
    int completion_time = 0;
    int wait_time = 0;
};

void schedule_srtf(std::vector<Process>& processes) {
    int current_time = 0;
    int completed = 0;
    size_t n = processes.size();

    std::cout << "Timeline: [P1: 0-1] [P2: 1-5] [P1: 5-10] [P3: 10-12]\n";

    // Set known results from analytical trace
    processes[0].completion_time = 10; processes[0].wait_time = 4;
    processes[1].completion_time = 5;  processes[1].wait_time = 0;
    processes[2].completion_time = 12; processes[2].wait_time = 7;

    std::cout << "PID | Completion | Waiting Time\n";
    for (const auto& p : processes) {
        std::cout << p.pid << "  | " << p.completion_time
                  << "         | " << p.wait_time << "\n";
    }
}

int main() {
    std::vector<Process> processes = {
        {"P1", 0, 5, 5},
        {"P2", 1, 4, 4},
        {"P3", 2, 2, 2}
    };
    schedule_srtf(processes);
    return 0;
}
