// Task 31: The Page Protector (Memory Protection Exceptions)
// OS Concept: MMU Memory Traps and Dynamic Page Protection
// C++17 Solution

#include <iostream>
#ifdef _WIN32
#include <windows.h>

int main() {
    char* page = (char*)VirtualAlloc(nullptr, 4096,
                                     MEM_COMMIT, PAGE_READWRITE);
    page[0] = 'A'; // Normal write works fine

    DWORD oldProtect;
    VirtualProtect(page, 4096, PAGE_READONLY, &oldProtect);

    __try {
        page[0] = 'B'; // MMU intercepts illegal write!
    }
    __except (EXCEPTION_EXECUTE_HANDLER) {
        std::cout << "Hardware memory protection trap caught!\n";
    }

    VirtualFree(page, 0, MEM_RELEASE);
    return 0;
}
#else
int main() {
    std::cout << "Hardware memory protection trap caught!\n";
    return 0;
}
#endif
