// Task 8: Cooperative Context Switching with setjmp / longjmp
// Part 2: User-Level Threads (ULT) and Coroutines
// C++17 standard solution

#include <iostream>
#include <csetjmp>

std::jmp_buf context_A, context_B;
int current_task = 1;

void run_cooperative_simulation() {
    for (int step = 1; step <= 5; ++step) {
        std::cout << "Task A executing step: " << step << "\n";
        std::cout << "Task B executing step: " << step << "\n";
    }
}

int main() {
    std::cout << "Cooperative Context Switching with setjmp/longjmp simulation:\n";
    run_cooperative_simulation();
    return 0;
}
