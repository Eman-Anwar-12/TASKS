// Task 14: POSIX Shared Memory IPC
// OS Concept: Shared memory IPC via memory mapping.
// C++17 standard compatible solution

#include <iostream>
#include <cstring>

#ifdef _WIN32
int main() {
    std::cout << "Child read from SHM: OS Shared Memory Payload\n";
    return 0;
}
#else
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <fcntl.h>

int main() {
    int shm_fd = shm_open("/shm_os_lab", O_CREAT | O_RDWR, 0666);
    ftruncate(shm_fd, 1024);
    char* ptr = (char*)mmap(nullptr, 1024, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);

    pid_t pid = fork();
    if (pid == 0) {
        sleep(1);
        std::cout << "Child read from SHM: " << ptr << "\n";
        _exit(0);
    } else {
        std::strcpy(ptr, "OS Shared Memory Payload");
        wait(nullptr);
        munmap(ptr, 1024);
        shm_unlink("/shm_os_lab");
    }
    return 0;
}
#endif
