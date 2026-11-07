// Task 7: Multithreaded Matrix-Vector Multiplication
// OS Concept: Multithreaded parallelism using shared memory spaces.
// C++17 standard solution

#include <iostream>
#include <vector>
#include <thread>

void worker_multiply_row(int row_idx, const std::vector<std::vector<int>>& matrix,
                         const std::vector<int>& vec, std::vector<int>& result) {
    int sum = 0;
    for (size_t col = 0; col < vec.size(); ++col) {
        sum += matrix[row_idx][col] * vec[col];
    }
    result[row_idx] = sum;
}

int main() {
    std::vector<std::vector<int>> matrix = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };
    std::vector<int> vec = {1, 2, 3};
    std::vector<int> result(3, 0);

    std::vector<std::thread> thread_list;
    for (int i = 0; i < 3; ++i) {
        thread_list.emplace_back(worker_multiply_row, i, std::cref(matrix), std::cref(vec), std::ref(result));
    }

    for (auto& t : thread_list) {
        t.join();
    }

    std::cout << "Result Vector: [" << result[0] << ", " << result[1] << ", " << result[2] << "]\n";
    return 0;
}
