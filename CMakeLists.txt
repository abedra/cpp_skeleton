cmake_minimum_required(VERSION 3.26)
project(cpp_skeleton)

set(CMAKE_CXX_STANDARD 23)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

include(cmake/testing.cmake)

include_directories(${PROJECT_SOURCE_DIR}/src)

add_executable(cpp_skeleton
        bin/main.cpp
        src/Writer.cpp)

target_link_libraries(cpp_skeleton ${CONAN_LIBS})

