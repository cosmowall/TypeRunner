cmake_minimum_required(VERSION 3.16)
project(typescript)

set(CMAKE_CXX_STANDARD 20)

# 添加LLVM路径
set(LLVM_ROOT "/opt/homebrew/Cellar/llvm@14/14.0.6")
include_directories(${LLVM_ROOT}/include)
link_directories(${LLVM_ROOT}/lib)

set(CMAKE_CXX_FLAGS "-Wno-error=enum-constexpr-conversion -Wno-unused-variable -Wno-switch -Wno-trigraphs -Wno-error=consteval -Wno-error=undeclared-identifier -Wno-error=no-matching-function -Wno-error=no-member -Wno-error=expected-expression -Wno-error=incompatible-pointer-types -Wno-error=conversion -Wno-error=invalid-conversion -Wno-error=return-type -Wno-error=non-constant-expression -Wno-error=literal-operator -Wno-error=ferror-limit")

if(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -ffast-math")
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_compile_options(-Wno-error=unknown-warning-option -Wno-error=incompatible-pointer-types -Wno-error=conversion -Wno-error=invalid-conversion -Wno-error=return-type -Wno-error=non-constant-expression -Wno-error=literal-operator -Wno-error=ferror-limit)
endif()

include_directories(libs/tracy/)
include_directories(libs/fmt/include/)
include_directories(libs/doctest/doctest/)

list(APPEND CMAKE_MODULE_PATH libs)

add_subdirectory(libs/doctest)
add_subdirectory(libs/tracy)
add_subdirectory(libs/fmt)

set(ASMJIT_STATIC TRUE)
#add_subdirectory(libs/asmjit)

# enable for profiling
#add_definitions(-DTRACY_ENABLE)
#link_libraries(Tracy::TracyClient)

#include_directories(libs/asmjit/src)
include_directories(libs/magic_enum)

add_subdirectory(src)

add_executable(typescript_main main.cpp)
target_link_libraries(typescript_main typescript)

add_executable(bench bench.cpp)
target_link_libraries(bench typescript)