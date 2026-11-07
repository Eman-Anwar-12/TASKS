// Task 1: Sequential vs. Parallel Array Sum
// Section 1: Data Parallelism
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>
#include <numeric>
#include <chrono>

void worker(const std::vector<long long>& A, size_t lo, size_t hi, long long& partial_sum) {
    long long sum = 0;
    for (size_t i = lo; i < hi; ++i) {
        sum += A[i];
    }
    partial_sum = sum;
}

int main() {
    const size_t N = 10000000; // 10M elements
    std::vector<long long> A(N, 1);

    // Sequential sum
    auto t0 = std::chrono::high_resolution_clock::now();
    long long seq_sum = 0;
    for (size_t i = 0; i < N; ++i) seq_sum += A[i];
    auto t1 = std::chrono::high_resolution_clock::now();
    double t_seq = std::chrono::duration<double, std::milli>(t1 - t0).count();

    std::cout << "Sequential Sum: " << seq_sum << " in " << t_seq << " ms\n";

    // Parallel sum with T threads
    for (int T : {1, 2, 4, 8}) {
        std::vector<std::thread> threads;
        std::vector<long long> partials(T, 0);
        size_t chunk = (N + T - 1) / T;

        auto tp0 = std::chrono::high_resolution_clock::now();
        for (int t = 0; t < T; ++t) {
            size_t lo = t * chunk;
            size_t hi = std::min(N, (t + 1) * chunk);
            threads.emplace_back(worker, std::cref(A), lo, hi, std::ref(partials[t]));
        }
        for (auto& th : threads) th.join();

        long long par_sum = 0;
        for (long long s : partials) par_sum += s;
        auto tp1 = std::chrono::high_resolution_clock::now();
        double t_par = std::chrono::duration<double, std::milli>(tp1 - tp0).count();

        std::cout << "Parallel (T=" << T << "): Sum = " << par_sum 
                  << " in " << t_par << " ms | Speedup: " << t_seq / t_par << "x\n";
    }
    return 0;
}
