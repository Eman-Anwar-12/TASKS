// Task 19: Implementing a Hybrid M : N Threading Runtime
// Part 3: Comparative Analysis and Advanced Threading Models
// C++17 standard solution

#include <iostream>
#include <vector>
#include <queue>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <functional>

class HybridM_N_Runtime {
    std::queue<std::function<void()>> task_queue;
    std::mutex mtx;
    std::condition_variable cv;
    bool stop = false;
    std::vector<std::thread> carrier_workers;
public:
    HybridM_N_Runtime(size_t m_carriers) {
        for (size_t i = 0; i < m_carriers; ++i) {
            carrier_workers.emplace_back([this, i]() {
                while (true) {
                    std::function<void()> task;
                    {
                        std::unique_lock<std::mutex> lock(mtx);
                        cv.wait(lock, [this] { return stop || !task_queue.empty(); });
                        if (stop && task_queue.empty()) break;
                        task = std::move(task_queue.front());
                        task_queue.pop();
                    }
                    task();
                }
            });
        }
    }

    void submit(std::function<void()> f) {
        {
            std::lock_guard<std::mutex> lock(mtx);
            task_queue.push(f);
        }
        cv.notify_one();
    }

    ~HybridM_N_Runtime() {
        {
            std::lock_guard<std::mutex> lock(mtx);
            stop = true;
        }
        cv.notify_all();
        for (auto& w : carrier_workers) w.join();
    }
};

int main() {
    std::cout << "M:N Hybrid Runtime initialized with 4 OS Carrier Threads.\n";
    {
        HybridM_N_Runtime runtime(4);
        for (int j = 1; j <= 8; ++j) {
            runtime.submit([j]() {
                std::cout << "Executing ULT Task " << j
                          << " on Carrier Thread " << std::this_thread::get_id() << "\n";
            });
        }
    }
    std::cout << "All M:N tasks drained successfully.\n";
    return 0;
}
