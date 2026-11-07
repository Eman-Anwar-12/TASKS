// Task 7: The Error Catcher (System Errors)
// C++17 standard solution

#include <iostream>
#include <cstdio>
#include <cerrno>
#include <cstring>

int main() {
    FILE* f = std::fopen("ghost.txt", "r");
    if (f == nullptr) {
        std::perror("Failed to open file");
    } else {
        std::cout << "File opened successfully.\n";
        std::fclose(f);
    }
    return 0;
}
