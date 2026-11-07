// Task 17: The Broadcaster (Manual-Reset Events)
// OS Concept: Manual-Reset Events (Barrier Broadcast)
// C++17 Solution

#include <iostream>
#include <thread>
#include <vector>
#ifdef _WIN32
#include <windows.h>
#else
#include <condition_variable>
#include <mutex>
#endif

#ifdef _WIN32
HANDLE startEvent;

void worker(int id) {
    WaitForSingleObject(startEvent, INFINITE);
    std::cout << "Worker " << id << " triggered!\n";
}

int main() {
    startEvent = CreateEventA(nullptr, TRUE, FALSE, nullptr);

    std::vector<std::thread> workers;
    for (int i = 1; i <= 3; ++i) {
        workers.emplace_back(worker, i);
    }

    std::cout << "Waiting 1 second before broadcasting start signal...\n";
    Sleep(1000);

    SetEvent(startEvent); // Wakes all waiting threads simultaneously

    for (auto& t : workers) {
        t.join();
    }

    CloseHandle(startEvent);
    return 0;
}
#else
std::mutex mtx;
std::condition_variable cv;
bool start = false;

void worker(int id) {
    std::unique_lock<std::mutex> lock(mtx);
    cv.wait(lock, [] { return start; });
    std::cout << "Worker " << id << " triggered!\n";
}

int main() {
    std::vector<std::thread> workers;
    for (int i = 1; i <= 3; ++i) {
        workers.emplace_back(worker, i);
    }
    std::cout << "Waiting 1 second before broadcasting start signal...\n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    {
        std::lock_guard<std::mutex> lock(mtx);
        start = true;
    }
    cv.notify_all();
    for (auto& t : workers) {
        t.join();
    }
    return 0;
}
#endif
