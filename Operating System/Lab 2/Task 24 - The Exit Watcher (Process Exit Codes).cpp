// Task 24: The Exit Watcher (Process Exit Codes)
// OS Concept: Process Termination and Exit Codes
// C++17 Solution

#include <iostream>
#ifdef _WIN32
#include <windows.h>

int main() {
    STARTUPINFOA si{};
    PROCESS_INFORMATION pi{};
    si.cb = sizeof(si);

    char command[] = "cmd.exe /C exit 42";

    if (CreateProcessA(nullptr, command, nullptr, nullptr,
                       FALSE, 0, nullptr, nullptr, &si, &pi)) {
        WaitForSingleObject(pi.hProcess, INFINITE);

        DWORD exitCode = 0;
        GetExitCodeProcess(pi.hProcess, &exitCode);
        std::cout << "Child process exited with code: " << exitCode << "\n";

        CloseHandle(pi.hThread);
        CloseHandle(pi.hProcess);
    }
    return 0;
}
#else
#include <unistd.h>
#include <sys/wait.h>
int main() {
    pid_t pid = fork();
    if (pid == 0) {
        _exit(42);
    } else {
        int status;
        waitpid(pid, &status, 0);
        std::cout << "Child process exited with code: " << WEXITSTATUS(status) << "\n";
    }
    return 0;
}
#endif
