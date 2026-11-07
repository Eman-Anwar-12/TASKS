// Task 18: The Shared Blackboard (Memory-Mapped Files / Shared Memory)
// OS Concept: Shared Memory (IPC)
// C++17 Solution

#include <iostream>
#include <cstring>
#ifdef _WIN32
#include <windows.h>
#else
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#endif

int main() {
#ifdef _WIN32
    HANDLE hMap = CreateFileMappingA(INVALID_HANDLE_VALUE, nullptr,
                                    PAGE_READWRITE, 0, 256, "Local\\MySharedMem");
    if (!hMap) return 1;

    char* pBuf = (char*)MapViewOfFile(hMap, FILE_MAP_ALL_ACCESS, 0, 0, 256);
    if (!pBuf) {
        CloseHandle(hMap);
        return 1;
    }

    strcpy_s(pBuf, 256, "Shared memory payload");
    std::cout << "Data in shared region: " << pBuf << "\n";

    UnmapViewOfFile(pBuf);
    CloseHandle(hMap);
#else
    int fd = shm_open("/MySharedMem", O_CREAT | O_RDWR, 0666);
    ftruncate(fd, 256);
    char* pBuf = (char*)mmap(nullptr, 256, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    strcpy(pBuf, "Shared memory payload");
    std::cout << "Data in shared region: " << pBuf << "\n";
    munmap(pBuf, 256);
    close(fd);
    shm_unlink("/MySharedMem");
#endif
    return 0;
}
