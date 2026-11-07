// Task 27: The System Profiler (CPU Time Accounting)
// OS Concept: Kernel Mode (Ring 0) vs. User Mode (Ring 3)
// C++17 Solution

#include <iostream>
#ifdef _WIN32
#include <windows.h>

int main() {
    volatile long count = 0;
    for (long i = 0; i < 20000000; ++i) { count += i; }

    FILETIME createTime, exitTime, kernelTime, userTime;
    GetProcessTimes(GetCurrentProcess(),
                    &createTime, &exitTime, &kernelTime, &userTime);

    ULARGE_INTEGER kTime, uTime;
    kTime.LowPart = kernelTime.dwLowDateTime;
    kTime.HighPart = kernelTime.dwHighDateTime;
    uTime.LowPart = userTime.dwLowDateTime;
    uTime.HighPart = userTime.dwHighDateTime;

    std::cout << "Kernel Time (Ring 0): " << kTime.QuadPart / 10000 << " ms\n";
    std::cout << "User Time (Ring 3): " << uTime.QuadPart / 10000 << " ms\n";
    return 0;
}
#else
#include <sys/resource.h>
int main() {
    struct rusage usage;
    getrusage(RUSAGE_SELF, &usage);
    std::cout << "Kernel Time (Ring 0): " << usage.ru_stime.tv_sec * 1000 + usage.ru_stime.tv_usec / 1000 << " ms\n";
    std::cout << "User Time (Ring 3): " << usage.ru_utime.tv_sec * 1000 + usage.ru_utime.tv_usec / 1000 << " ms\n";
    return 0;
}
#endif
