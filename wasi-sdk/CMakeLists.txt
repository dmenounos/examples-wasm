cmake_minimum_required(VERSION 3.8.2)

include(cmake/CMakeCompiler.txt)

project(examples-wasi-sdk)

add_subdirectory(example-cli)
add_subdirectory(example-web)

message("")
