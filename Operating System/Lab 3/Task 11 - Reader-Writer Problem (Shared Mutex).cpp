// Task 11: Reader-Writer Problem (Shared Mutex)
// OS Concept: Concurrency arbitration using reader-writer locks.
// C++17 standard solution using std::shared_mutex

#include <iostream>
#include <thread>
#include <shared_mutex>
#include <vector>

int shared_data = 0;
std::shared_mutex rw_lock;

void reader(int id) {
    std::shared_lock<std::shared_mutex> lock(rw_lock);
    std::cout << "Reader " << id << " read value: " << shared_data << "\n";
}

void writer(int id, int val) {
    std::unique_lock<std::shared_mutex> lock(rw_lock);
    shared_data = val;
    std::cout << "Writer " << id << " updated value to: " << shared_data << "\n";
}

int main() {
    std::thread w1(writer, 1, 42);
    w1.join();

    std::thread r1(reader, 1);
    std::thread r2(reader, 2);
    r1.join();
    r2.join();

    std::thread w2(writer, 2, 99);
    w2.join();

    std::thread r3(reader, 3);
    r3.join();

    return 0;
}
