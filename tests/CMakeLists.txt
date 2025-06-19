cmake_minimum_required(VERSION 3.26)

find_package(Catch2 REQUIRED)
add_executable(tests
   example_test.cpp 
)
target_link_libraries(tests Catch2::Catch2WithMain)
enable_testing()
add_test(NAME tests COMMAND tests)
