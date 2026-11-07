// Task 2: Parallel Vector Expression
// Section 1: Data Parallelism
// C[i] = A[i] * B[i] + sin(A[i])
// C++17 standard solution

#include <iostream>
#include <vector>
#include <cmath>
#include <thread>
#include <chrono>

void compute_chunk(const std::vector<double>& A, const std::vector<double>& B,
                   std::vector<double>& C, size_t lo, size_t hi) {
    for (size_t i = lo; i < hi; ++i) {
        C[i] = A[i] * B[i] + std::sin(A[i]);
    }
}

int main() {
    const size_t N = 5000000;
    std::vector<double> A(N, 1.5), B(N, 2.5), C_seq(N), C_par(N);

    // Sequential
    auto t0 = std::chrono::high_resolution_clock::now();
    compute_chunk(A, B, C_seq, 0, N);
    auto t1 = std::chrono::high_resolution_clock::now();
    double t_seq = std::chrono::duration<double, std::milli>(t1 - t0).count();

    // Parallel with 4 threads
    const int T = 4;
    std::vector<std::thread> threads;
    size_t chunk = (N + T - 1) / T;
    auto tp0 = std::chrono::high_resolution_clock::now();
    for (int t = 0; t < T; ++t) {
        size_t lo = t * chunk;
        size_t hi = std::min(N, (t + 1) * chunk);
        threads.emplace_back(compute_chunk, std::cref(A), std::cref(B), std::ref(C_par), lo, hi);
    }
    for (auto& th : threads) th.join();
    auto tp1 = std::chrono::high_resolution_clock::now();
    double t_par = std::chrono::duration<double, std::milli>(tp1 - tp0).count();

    // Epsilon verification
    double max_diff = 0;
    for (size_t i = 0; i < N; ++i) {
        max_diff = std::max(max_diff, std::abs(C_seq[i] - C_par[i]));
    }
    std::cout << "Vector expression completed. Max diff: " << max_diff << "\n";
    std::cout << "Sequential: " << t_seq << " ms | Parallel (T=4): " << t_par << " ms\n";
    return 0;
}
