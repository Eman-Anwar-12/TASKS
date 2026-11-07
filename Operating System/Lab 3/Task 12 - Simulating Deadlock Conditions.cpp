// Task 12: Simulating Deadlock Conditions
// OS Concept: Coffman deadlock conditions (Circular Wait).
// C++17 standard solution

#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>

std::mutex mutexA;
std::mutex mutexB;

void thread1_work() {
    mutexA.lock();
    std::cout << "Thread 1 acquired Lock A, waiting for Lock B...\n";
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    mutexB.lock();
    mutexB.unlock();
    mutexA.unlock();
}

void thread2_work() {
    mutexB.lock();
    std::cout << "Thread 2 acquired Lock B, waiting for Lock A...\n";
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
    mutexA.lock();
    mutexA.unlock();
    mutexB.unlock();
}

int main() {
    std::cout << "Simulating circular wait deadlock...\n";
    std::thread t1(thread1_work);
    std::thread t2(thread2_work);
    t1.join();
    t2.join();
    return 0;
}
