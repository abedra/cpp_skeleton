cmake_minimum_required(VERSION 3.26)
project(cpp_skeleton)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake)
include_directories(src)

file(GLOB HEADERS src/**/*.h)
find_package(spdlog REQUIRED)

add_executable(example bin/example.cpp)
target_link_libraries(example spdlog::spdlog)

add_subdirectory(tests)
