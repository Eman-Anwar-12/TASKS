// Task 7: Producer–Consumer with a Bounded Buffer
// Section 2: Task Parallelism
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>
#include <mutex>
#include <condition_variable>

const int K = 5; // Buffer capacity
int B[K];
int in_idx = 0, out_idx = 0, count = 0;
std::mutex m;
std::condition_variable notFull, notEmpty;

void Producer(int n) {
    for (int i = 0; i < n; ++i) {
        std::unique_lock<std::mutex> lock(m);
        notFull.wait(lock, [] { return count < K; });
        B[in_idx] = i;
        in_idx = (in_idx + 1) % K;
        count++;
        notEmpty.notify_one();
    }
    // Sentinel
    std::unique_lock<std::mutex> lock(m);
    notFull.wait(lock, [] { return count < K; });
    B[in_idx] = -1;
    in_idx = (in_idx + 1) % K;
    count++;
    notEmpty.notify_one();
}

void Consumer() {
    while (true) {
        std::unique_lock<std::mutex> lock(m);
        notEmpty.wait(lock, [] { return count > 0; });
        int x = B[out_idx];
        out_idx = (out_idx + 1) % K;
        count--;
        notFull.notify_one();
        lock.unlock();

        if (x == -1) break;
        std::cout << "Consumer processed: " << x << "\n";
    }
}

int main() {
    std::thread p(Producer, 10);
    std::thread c(Consumer);
    p.join();
    c.join();
    std::cout << "Bounded buffer test completed successfully.\n";
    return 0;
}
