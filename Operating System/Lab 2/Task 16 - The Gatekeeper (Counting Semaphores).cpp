// Task 16: The Gatekeeper (Counting Semaphores)
// OS Concept: Counting Semaphores (Resource Capacity Management)
// C++17 Solution

#include <iostream>
#include <thread>
#include <vector>
#ifdef _WIN32
#include <windows.h>
#else
#include <semaphore.h>
#endif

#ifdef _WIN32
HANDLE sem;

void worker(int id) {
    WaitForSingleObject(sem, INFINITE);
    std::cout << "Thread " << id << " acquired resource.\n";

    Sleep(1000); // Simulate work using shared resource

    std::cout << "Thread " << id << " releasing resource.\n";
    ReleaseSemaphore(sem, 1, nullptr);
}

int main() {
    sem = CreateSemaphoreA(nullptr, 2, 2, nullptr);

    std::vector<std::thread> threads;
    for (int i = 1; i <= 4; ++i) {
        threads.emplace_back(worker, i);
    }

    for (auto& t : threads) {
        t.join();
    }

    CloseHandle(sem);
    return 0;
}
#else
sem_t sem;

void worker(int id) {
    sem_wait(&sem);
    std::cout << "Thread " << id << " acquired resource.\n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << "Thread " << id << " releasing resource.\n";
    sem_post(&sem);
}

int main() {
    sem_init(&sem, 0, 2);
    std::vector<std::thread> threads;
    for (int i = 1; i <= 4; ++i) {
        threads.emplace_back(worker, i);
    }
    for (auto& t : threads) {
        t.join();
    }
    sem_destroy(&sem);
    return 0;
}
#endif
