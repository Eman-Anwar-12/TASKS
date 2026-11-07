// Task 4: Parallel Maximum with Reduction
// Section 1: Data Parallelism
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>
#include <algorithm>
#include <random>

void local_max_worker(const std::vector<int>& A, size_t lo, size_t hi, int& out_max) {
    int m = A[lo];
    for (size_t i = lo; i < hi; ++i) {
        if (A[i] > m) m = A[i];
    }
    out_max = m;
}

int main() {
    const size_t N = 10000000;
    std::vector<int> A(N);
    for (size_t i = 0; i < N; ++i) A[i] = (int)(i % 50000);
    A[424242] = 9999999; // True global maximum

    const int T = 4;
    size_t chunk = (N + T - 1) / T;
    std::vector<std::thread> threads;
    std::vector<int> local_maxes(T);

    for (int t = 0; t < T; ++t) {
        size_t lo = t * chunk;
        size_t hi = std::min(N, (t + 1) * chunk);
        threads.emplace_back(local_max_worker, std::cref(A), lo, hi, std::ref(local_maxes[t]));
    }
    for (auto& th : threads) th.join();

    // Reduction phase: private slots prevent data race during parallel search
    int global_max = local_maxes[0];
    for (int t = 1; t < T; ++t) {
        global_max = std::max(global_max, local_maxes[t]);
    }

    std::cout << "Parallel Maximum with Reduction result: " << global_max << "\n";
    return 0;
}
