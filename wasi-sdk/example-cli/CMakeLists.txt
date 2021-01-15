cmake_minimum_required(VERSION 3.8.2)

include(../cmake/CMakeCompiler.txt)

project(example-cli)

set(CMAKE_C_FLAGS            "--target=wasm32-unknown-wasi")
set(CMAKE_C_FLAGS_RELEASE    "-Os -DNDEBUG")
set(CMAKE_CXX_FLAGS          "--target=wasm32-unknown-wasi")
set(CMAKE_CXX_FLAGS_RELEASE  "-Os -DNDEBUG")
set(CMAKE_EXE_LINKER_FLAGS   "")

include(../cmake/CMakeInclude.txt)

# Add all the source files to the SOURCES variable.
file(GLOB_RECURSE SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

# Set the compiled file to the TARGET variable.
set(TARGET "${PROJECT_NAME}.wasm")

add_executable(${TARGET} ${SOURCES})

target_include_directories(${TARGET} PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
)
