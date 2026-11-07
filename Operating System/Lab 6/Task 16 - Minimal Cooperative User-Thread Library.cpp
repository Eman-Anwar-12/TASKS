// Task 16: Minimal Cooperative User-Thread Library
// Section 4: User-Level vs. Kernel-Level Threads
// C++17 standard solution

#include <iostream>
#include <vector>
#include <functional>

// User-level cooperative fiber simulation
class UserFiber {
    int id;
public:
    explicit UserFiber(int fiber_id) : id(fiber_id) {}
    void step(int round) {
        std::cout << "Fiber ID: " << id << " executing round " << round
                  << " (All fibers share OS thread)\n";
    }
};

int main() {
    std::vector<UserFiber> fibers = {UserFiber(1), UserFiber(2), UserFiber(3)};
    for (int round = 1; round <= 3; ++round) {
        for (auto& f : fibers) {
            f.step(round);
        }
    }
    return 0;
}
