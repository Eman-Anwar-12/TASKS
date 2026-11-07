// Task 2: The Diary (Basic File I/O)
// C++17 standard solution

#include <iostream>
#include <fstream>

int main() {
    std::ofstream diary("diary.txt");
    if (!diary.is_open()) {
        std::cerr << "Error creating diary.txt\n";
        return 1;
    }
    diary << "Hello OS\n";
    diary.close();
    std::cout << "File 'diary.txt' created successfully with contents: Hello OS\n";
    return 0;
}
