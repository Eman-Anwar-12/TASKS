// Task 6: Kernel Coordination via Condition Variables
// Part 1: Kernel-Level Threads (KLT) and POSIX Primitives
// C++17 standard solution

#include <iostream>
#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>

const size_t CAPACITY = 5;
std::queue<int> buffer;
std::mutex mtx;
std::condition_variable not_full, not_empty;
bool done = false;

void producer() {
    for (int i = 1; i <= 10; ++i) {
        std::unique_lock<std::mutex> lock(mtx);
        not_full.wait(lock, [] { return buffer.size() < CAPACITY; });
        buffer.push(i);
        std::cout << "Producer enqueued: " << i << " (count=" << buffer.size() << ")\n";
        not_empty.notify_one();
    }
    std::unique_lock<std::mutex> lock(mtx);
    done = true;
    not_empty.notify_all();
}

void consumer() {
    while (true) {
        std::unique_lock<std::mutex> lock(mtx);
        not_empty.wait(lock, [] { return !buffer.empty() || done; });
        if (buffer.empty() && done) break;
        int item = buffer.front();
        buffer.pop();
        std::cout << "Consumer dequeued: " << item << "\n";
        not_full.notify_one();
    }
}

int main() {
    std::thread p(producer);
    std::thread c(consumer);
    p.join();
    c.join();
    return 0;
}
