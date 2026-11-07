// Task 10: Producer-Consumer using Condition Variables
// OS Concept: Bounded buffer management with condition variables.
// C++17 standard solution

#include <iostream>
#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>

const size_t CAPACITY = 3;
std::queue<int> buffer;
std::mutex mtx;
std::condition_variable cv_producer;
std::condition_variable cv_consumer;

void producer() {
    for (int item = 1; item <= 5; ++item) {
        std::unique_lock<std::mutex> lock(mtx);
        cv_producer.wait(lock, [] { return buffer.size() < CAPACITY; });
        buffer.push(item);
        std::cout << "Produced: " << item << "\n";
        cv_consumer.notify_one();
    }
}

void consumer() {
    for (int i = 1; i <= 5; ++i) {
        std::unique_lock<std::mutex> lock(mtx);
        cv_consumer.wait(lock, [] { return !buffer.empty(); });
        int item = buffer.front();
        buffer.pop();
        std::cout << "Consumed: " << item << "\n";
        cv_producer.notify_one();
    }
}

int main() {
    std::thread tProd(producer);
    std::thread tCons(consumer);
    tProd.join();
    tCons.join();
    return 0;
}
