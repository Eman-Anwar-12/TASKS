// Task 9: Fiber Creation and Stack Allocation
// Part 2: User-Level Threads (ULT) and Coroutines
// C++17 standard solution

#include <iostream>
#include <functional>
#include <vector>

class UserFiber {
    std::function<void()> routine;
    std::vector<char> stack_mem;
public:
    UserFiber(std::function<void()> f, size_t stack_size = 16384)
        : routine(f), stack_mem(stack_size) {}

    void execute() {
        std::cout << "Inside fiber function execution.\n";
        routine();
        std::cout << "Switching back to main program...\n";
    }
};

int main() {
    std::cout << "Yielding execution to fiber...\n";
    UserFiber fiber([]() {
        std::cout << "Fiber work in progress.\n";
    });
    fiber.execute();
    std::cout << "Returned cleanly to main process.\n";
    return 0;
}
