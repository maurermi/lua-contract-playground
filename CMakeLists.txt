cmake_minimum_required(VERSION 3.13)
include(CheckCXXCompilerFlag)

project(lua-test-environment)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_EXTENSIONS False)

check_cxx_compiler_flag(-Wshadow-all W_SHADOW_ALL)
check_cxx_compiler_flag(-Wnewline-eof W_NEWLINE_EOF)

set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Threads)

if(USE_STDFS_LIB)
    link_libraries(-lstdc++fs)
endif()

find_library(LUA_LIBRARY lua REQUIRED)

set(LUA_LIBRARY "${LUA_LIBRARY}" "-ldl")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")

include_directories(/usr/lib /usr/local/lib /usr/local/include /opt/homebrew/include ./prefix/include)

if(DEFINED CMAKE_PREFIX_PATH)
    include_directories(SYSTEM "${CMAKE_PREFIX_PATH}/include")
endif()

add_subdirectory(src)