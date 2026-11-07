// Task 8: The Interrupt Shield (Basic Signals)
// C++17 standard solution using <csignal>

#include <iostream>
#include <csignal>
#include <thread>
#include <chrono>
#include <atomic>

std::atomic<bool> running{true};
std::atomic<int> interrupt_count{0};

void handle_sigint(int signum) {
    std::cout << "\n^C You can't close me!\n";
    interrupt_count++;
    if (interrupt_count >= 3) {
        std::cout << "Shield deactivated after 3 attempts. Exiting cleanly.\n";
        running = false;
    }
}

int main() {
    std::signal(SIGINT, handle_sigint);
    std::cout << "Interrupt Shield active. Press Ctrl+C (attempt 3 times to exit)...\n";
    while (running) {
        std::cout << "Running...\n";
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
    return 0;
}
