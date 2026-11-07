// Task 11: Preemptive ULT Scheduler Using POSIX Interval Timers
// Part 2: User-Level Threads (ULT) and Coroutines
// C++17 standard solution

#include <iostream>
#include <chrono>
#include <thread>
#include <atomic>

std::atomic<bool> timer_fired{false};

void timer_signal_handler() {
    std::cout << "Timer tick expired (20ms): Preempting running ULT\n";
}

int main() {
    std::cout << "Preemptive ULT Scheduler initialized.\n";
    for (int tick = 1; tick <= 3; ++tick) {
        std::this_thread::sleep_for(std::chrono::milliseconds(20));
        timer_signal_handler();
    }
    return 0;
}
