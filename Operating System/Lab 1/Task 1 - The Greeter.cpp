// Task 1: The Greeter (Command Line Arguments)
// C++17 standard solution

#include <iostream>
#include <string>

int main(int argc, char* argv[]) {
    if (argc > 1) {
        std::cout << "Hello, " << argv[1] << "!\n";
    } else {
        std::cout << "Hello, World!\n";
    }
    return 0;
}
