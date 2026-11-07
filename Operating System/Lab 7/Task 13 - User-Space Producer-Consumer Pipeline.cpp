// Task 13: User-Space Producer-Consumer Pipeline
// Part 2: User-Level Threads (ULT) and Coroutines
// C++17 standard solution

#include <iostream>
#include <queue>

int user_buffer[5];
int user_items = 0;

void user_producer() {
    if (user_items < 5) {
        user_items++;
        std::cout << "Produced user item. Total: " << user_items << "\n";
    }
}

void user_consumer() {
    if (user_items > 0) {
        user_items--;
        std::cout << "Consumed user item. Total: " << user_items << "\n";
    }
}

int main() {
    for (int i = 0; i < 3; ++i) user_producer();
    for (int i = 0; i < 2; ++i) user_consumer();
    for (int i = 0; i < 3; ++i) user_producer();
    for (int i = 0; i < 4; ++i) user_consumer();
    return 0;
}
