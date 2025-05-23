project(Tests)

Include(FetchContent)
FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG release-1.11.0
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

include_directories(../../libs)

#project(Tests)
#
##add_library(catch ../../../libs/Catch2/single_include/catch.hpp)
##set_target_properties(catch PROPERTIES LINKER_LANGUAGE CXX)
#
#Include(FetchContent)
#
##FetchContent_Declare(
##        Catch2
##        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
##        GIT_TAG        v3.0.1
##)
##
##FetchContent_MakeAvailable(Catch2)
#
#FetchContent_Declare(
#        googletest
#        GIT_REPOSITORY https://github.com/google/googletest.git
#        GIT_TAG release-1.11.0
#)
## For Windows: Prevent overriding the parent project's compiler/linker settings
#set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
#FetchContent_MakeAvailable(googletest)
#
#include_directories(../../libs)
#
## These tests can use the Catch2-provided main
##add_executable(tests test.cpp)
##link_libraries(PRIVATE Catch2::Catch2WithMain)
#
##link_libraries(PRIVATE Catch2::Catch2WithMain)
##link_libraries(typescript)


#Include(FetchContent)
#
#FetchContent_Declare(
#        Catch2
#        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
#        GIT_TAG v2.13.9 # or a later release
#)
#
#FetchContent_MakeAvailable(Catch2)

file(GLOB TESTS test*.cpp)
add_executable(Tests_run test_core.cpp)
target_link_libraries(Tests_run gtest gtest_main typescript)

foreach (file ${TESTS})
    get_filename_component(name ${file} NAME_WE)
    MESSAGE("Test found typescript_${name}.")
    add_executable(typescript_${name} ${file})
    target_link_libraries(typescript_${name} PRIVATE gtest gtest_main typescript)
endforeach ()
