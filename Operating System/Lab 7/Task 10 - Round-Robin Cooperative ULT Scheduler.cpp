// Task 10: Round-Robin Cooperative ULT Scheduler
// Part 2: User-Level Threads (ULT) and Coroutines
// C++17 standard solution

#include <iostream>
#include <queue>
#include <string>

enum class ThreadState { READY, RUNNING, TERMINATED };

struct ULT_TCB {
    int id;
    int steps_remaining;
    ThreadState state;
};

int main() {
    std::queue<ULT_TCB> ready_queue;
    ready_queue.push({1, 3, ThreadState::READY});
    ready_queue.push({2, 3, ThreadState::READY});
    ready_queue.push({3, 3, ThreadState::READY});

    std::cout << "Starting Round-Robin Cooperative ULT Scheduler...\n";
    while (!ready_queue.empty()) {
        ULT_TCB current = ready_queue.front();
        ready_queue.pop();

        current.state = ThreadState::RUNNING;
        std::cout << "Scheduler dispatched Thread " << current.id
                  << " (Remaining steps: " << current.steps_remaining << ")\n";

        current.steps_remaining--;
        if (current.steps_remaining > 0) {
            current.state = ThreadState::READY;
            ready_queue.push(current); // Yield and re-enqueue
        } else {
            std::cout << "Thread " << current.id << " TERMINATED. Freeing stack.\n";
        }
    }
    std::cout << "All user-level threads completed.\n";
    return 0;
}
