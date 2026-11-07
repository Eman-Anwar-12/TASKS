// Task 3: Row-Block Matrix Multiplication
// Section 1: Data Parallelism
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>
#include <chrono>

const int N = 512;

void block_mul(const std::vector<std::vector<int>>& A,
               const std::vector<std::vector<int>>& B,
               std::vector<std::vector<int>>& C, int row_start, int row_end) {
    for (int i = row_start; i < row_end; ++i) {
        for (int j = 0; j < N; ++j) {
            int sum = 0;
            for (int k = 0; k < N; ++k) {
                sum += A[i][k] * B[k][j];
            }
            C[i][j] = sum;
        }
    }
}

int main() {
    std::vector<std::vector<int>> A(N, std::vector<int>(N, 1));
    std::vector<std::vector<int>> B(N, std::vector<int>(N, 2));
    std::vector<std::vector<int>> C(N, std::vector<int>(N, 0));

    const int T = 4;
    int rows_per_thread = (N + T - 1) / T;
    std::vector<std::thread> threads;

    auto t0 = std::chrono::high_resolution_clock::now();
    for (int t = 0; t < T; ++t) {
        int r_start = t * rows_per_thread;
        int r_end = std::min(N, (t + 1) * rows_per_thread);
        threads.emplace_back(block_mul, std::cref(A), std::cref(B), std::ref(C), r_start, r_end);
    }
    for (auto& th : threads) th.join();
    auto t1 = std::chrono::high_resolution_clock::now();

    std::cout << "Matrix Multiplication (" << N << "x" << N << ") completed with " << T
              << " threads in " << std::chrono::duration<double, std::milli>(t1 - t0).count()
              << " ms. C[0][0] = " << C[0][0] << "\n";
    return 0;
}
