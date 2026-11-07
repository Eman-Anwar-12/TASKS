// Task 12: User-Level Mutex Primitives (Cooperative Locks)
// Part 2: User-Level Threads (ULT) and Coroutines
// C++17 standard solution

#include <iostream>
#include <queue>

struct UserMutex {
    bool locked = false;
    int owner_id = -1;
    std::queue<int> wait_queue;

    void lock(int thread_id) {
        if (!locked) {
            locked = true;
            owner_id = thread_id;
            std::cout << "Thread " << thread_id << " acquired UserMutex.\n";
        } else {
            std::cout << "UserMutex held by " << owner_id << ". Thread "
                      << thread_id << " transitioned to BLOCKED state.\n";
            wait_queue.push(thread_id);
        }
    }

    void unlock(int thread_id) {
        if (!wait_queue.empty()) {
            int next_id = wait_queue.front();
            wait_queue.pop();
            owner_id = next_id;
            std::cout << "UserMutex unblocked Thread " << next_id << "\n";
        } else {
            locked = false;
            owner_id = -1;
            std::cout << "UserMutex released cleanly.\n";
        }
    }
};

int main() {
    UserMutex u_mtx;
    u_mtx.lock(1);
    u_mtx.lock(2);
    u_mtx.unlock(1);
    u_mtx.unlock(2);
    return 0;
}
