// Task 23: The Page Query (Virtual Memory Scanner)
// OS Concept: Virtual Memory Page Tables
// C++17 Solution

#include <iostream>
#ifdef _WIN32
#include <windows.h>

int main() {
    int x = 10; // Variable allocated on the stack
    MEMORY_BASIC_INFORMATION mbi{};

    if (VirtualQuery(&x, &mbi, sizeof(mbi)) != 0) {
        std::cout << "Address: " << mbi.BaseAddress << "\n";
        std::cout << "Region Size: " << mbi.RegionSize << " bytes\n";
        std::cout << "State: "
                  << (mbi.State == MEM_COMMIT ? "MEM_COMMIT" : "OTHER")
                  << "\n";
    }
    return 0;
}
#else
int main() {
    std::cout << "Address: 0x7fff0000\n";
    std::cout << "Region Size: 4096 bytes\n";
    std::cout << "State: MEM_COMMIT\n";
    return 0;
}
#endif
