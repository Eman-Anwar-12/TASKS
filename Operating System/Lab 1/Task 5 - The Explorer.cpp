// Task 5: The Explorer (Running Shell Commands)
// C++17 cross-platform compatible solution

#include <iostream>
#include <cstdlib>

int main() {
#ifdef _WIN32
    std::cout << "Executing Windows directory listing (dir):\n";
    std::system("dir");
#else
    std::cout << "Executing Unix directory listing (ls -l):\n";
    std::system("ls -l");
#endif
    return 0;
}
