// Task 28: The File Guard (Mandatory File Locking)
// OS Concept: File Byte-Range Locking
// C++17 Solution

#include <iostream>
#ifdef _WIN32
#include <windows.h>

int main() {
    HANDLE hFile = CreateFileA("guard_test.txt",
                               GENERIC_READ | GENERIC_WRITE,
                               FILE_SHARE_READ | FILE_SHARE_WRITE,
                               nullptr, CREATE_ALWAYS, 0, nullptr);
    if (hFile == INVALID_HANDLE_VALUE) return 1;

    // Lock bytes 0 through 100 exclusively
    if (LockFile(hFile, 0, 0, 100, 0)) {
        std::cout << "Byte range [0-100] locked successfully.\n";
        UnlockFile(hFile, 0, 0, 100, 0);
        std::cout << "Byte range unlocked.\n";
    }
    CloseHandle(hFile);
    return 0;
}
#else
#include <fcntl.h>
#include <unistd.h>
int main() {
    int fd = open("guard_test.txt", O_CREAT | O_RDWR, 0666);
    struct flock fl{};
    fl.l_type = F_WRLCK;
    fl.l_whence = SEEK_SET;
    fl.l_start = 0;
    fl.l_len = 100;
    if (fcntl(fd, F_SETLK, &fl) >= 0) {
        std::cout << "Byte range [0-100] locked successfully.\n";
        fl.l_type = F_UNLCK;
        fcntl(fd, F_SETLK, &fl);
        std::cout << "Byte range unlocked.\n";
    }
    close(fd);
    return 0;
}
#endif
