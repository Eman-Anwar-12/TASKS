// Task 8: Demonstrating Race Conditions
// OS Concept: Unsynchronized concurrent read-modify-write access to shared memory.
// C++17 standard solution

#include <iostream>
#include <thread>

volatile int counter = 0;

void increment_task() {
    for (int i = 0; i < 100000; ++i) {
        counter = counter + 1;
    }
}

int main() {
    std::thread t1(increment_task);
    std::thread t2(increment_task);
    t1.join();
    t2.join();

    std::cout << "Expected: 200000 | Actual counter: " << counter << "\n";
    return 0;
}
