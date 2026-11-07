// Task 8: Three-Stage Pipeline
// Section 2: Task Parallelism
// C++17 standard solution

#include <iostream>
#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>

template<typename T>
class PipelineQueue {
    std::queue<T> q;
    std::mutex mtx;
    std::condition_variable cv;
public:
    void push(T val) {
        std::lock_guard<std::mutex> lock(mtx);
        q.push(val);
        cv.notify_one();
    }
    T pop() {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return !q.empty(); });
        T val = q.front();
        q.pop();
        return val;
    }
};

PipelineQueue<int> Q1, Q2;

void Stage1(int n) {
    for (int i = 0; i < n; ++i) Q1.push(i);
    Q1.push(-1);
}

void Stage2() {
    while (true) {
        int x = Q1.pop();
        if (x == -1) { Q2.push(-1); break; }
        Q2.push(x * x);
    }
}

void Stage3() {
    long long sum = 0;
    while (true) {
        int y = Q2.pop();
        if (y == -1) break;
        sum += y;
    }
    std::cout << "Pipeline Stage 3 Result Sum: " << sum << "\n";
}

int main() {
    std::thread s1(Stage1, 10);
    std::thread s2(Stage2);
    std::thread s3(Stage3);
    s1.join(); s2.join(); s3.join();
    return 0;
}
