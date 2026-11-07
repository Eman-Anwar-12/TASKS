// Task 2: Kernel Task ID vs. POSIX Thread Handle
// Part 1: Kernel-Level Threads (KLT) and POSIX Primitives
// C++17 standard compatible solution

#include <iostream>
#include <vector>
#include <thread>

#ifdef _WIN32
#include <windows.h>
#define GET_PID() GetCurrentProcessId()
#define GET_TID() GetCurrentThreadId()
#else
#include <unistd.h>
#include <sys/syscall.h>
#define GET_PID() getpid()
#define GET_TID() syscall(SYS_gettid)
#endif

void thread_inspect(int id) {
    std::cout << "Task " << id << " | PID: " << GET_PID()
              << " | Native TID: " << GET_TID()
              << " | std::thread::id: " << std::this_thread::get_id() << "\n";
}

int main() {
    std::vector<std::thread> threads;
    for (int i = 0; i < 3; ++i) {
        threads.emplace_back(thread_inspect, i);
    }
    for (auto& t : threads) {
        t.join();
    }
    return 0;
}
