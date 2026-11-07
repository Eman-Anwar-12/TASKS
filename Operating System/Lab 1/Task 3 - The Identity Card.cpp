// Task 3: The Identity Card (Process IDs)
// C++17 cross-platform compatible solution

#include <iostream>

#ifdef _WIN32
#include <windows.h>
#define GET_PID() GetCurrentProcessId()
#else
#include <unistd.h>
#define GET_PID() getpid()
#endif

int main() {
    std::cout << "My unique Process ID is: " << GET_PID() << "\n";
    return 0;
}
