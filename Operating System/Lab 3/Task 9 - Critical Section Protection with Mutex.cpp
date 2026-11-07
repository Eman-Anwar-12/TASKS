// Task 9: Critical Section Protection with Mutex
// OS Concept: Mutual Exclusion (Mutex) primitives.
// C++17 standard solution

#include <iostream>
#include <thread>
#include <mutex>

int counter = 0;
std::mutex mtx;

void safe_increment() {
    for (int i = 0; i < 100000; ++i) {
        std::lock_guard<std::mutex> lock(mtx);
        counter = counter + 1;
    }
}

int main() {
    std::thread t1(safe_increment);
    std::thread t2(safe_increment);
    t1.join();
    t2.join();

    std::cout << "Final counter with Mutex: " << counter << "\n";
    return 0;
}
