// Task 6: The Detective (Environment Variables)
// C++17 cross-platform compatible solution

#include <iostream>
#include <cstdlib>

int main() {
    const char* user = std::getenv("USER");
    if (!user) {
        user = std::getenv("USERNAME"); // Windows fallback
    }
    if (user) {
        std::cout << "Current user is: " << user << "\n";
    } else {
        std::cout << "User environment variable not found.\n";
    }
    return 0;
}
