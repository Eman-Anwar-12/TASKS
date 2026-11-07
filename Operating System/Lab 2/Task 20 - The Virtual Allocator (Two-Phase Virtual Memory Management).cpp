// Task 20: The Virtual Allocator (Two-Phase Virtual Memory Management)
// OS Concept: Reserving vs. Committing Memory
// C++17 Solution

#include <iostream>
#ifdef _WIN32
#include <windows.h>

int main() {
    // Step 1: Reserve 1 MB of virtual addresses (no RAM allocated yet)
    void* base = VirtualAlloc(nullptr, 1024 * 1024,
                              MEM_RESERVE, PAGE_NOACCESS);
    if (!base) return 1;
    std::cout << "Reserved 1 MB address space at: " << base << "\n";

    // Step 2: Back the first 4 KB page with actual physical RAM
    int* page = (int*)VirtualAlloc(base, 4096,
                                  MEM_COMMIT, PAGE_READWRITE);
    if (!page) return 1;

    page[0] = 42; // Now safe to read and write
    std::cout << "Committed memory value: " << page[0] << "\n";

    VirtualFree(base, 0, MEM_RELEASE);
    return 0;
}
#else
#include <sys/mman.h>
int main() {
    void* base = mmap(nullptr, 1024 * 1024, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    std::cout << "Reserved 1 MB address space at: " << base << "\n";
    mprotect(base, 4096, PROT_READ | PROT_WRITE);
    int* page = (int*)base;
    page[0] = 42;
    std::cout << "Committed memory value: " << page[0] << "\n";
    munmap(base, 1024 * 1024);
    return 0;
}
#endif
