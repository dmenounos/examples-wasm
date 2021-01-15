cmake_minimum_required(VERSION 3.8.2)

include(../cmake/CMakeCompiler.txt)

project(example-web)

set(CMAKE_C_FLAGS_RELEASE    "-Os -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE  "-Os -DNDEBUG")
set(CMAKE_EXE_LINKER_FLAGS   "--no-entry" " -s EXPORTED_FUNCTIONS='[\"_add\"]'")

include(../cmake/CMakeInclude.txt)

# Add all the source files to the SOURCES variable.
file(GLOB_RECURSE SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

# Set the compiled file to the TARGET variable.
set(TARGET "${PROJECT_NAME}.js")

add_executable(${TARGET} ${SOURCES})

target_include_directories(${TARGET} PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
)
