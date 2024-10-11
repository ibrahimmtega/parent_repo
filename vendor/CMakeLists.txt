cmake_minimum_required(VERSION 3.16)

project(vendor_repo_libs LANGUAGES CXX)

set(Qt6_DIR           /opt/Qt/6.5.3/macos/lib/cmake/Qt6)
set(VENDOR_SRC_DIR    ${CMAKE_SOURCE_DIR}/vendor)
set(VENDOR_BINARY_DIR ${CMAKE_SOURCE_DIR}/build/vendor)
set(VENDOR_PREFIX_DIR ${CMAKE_SOURCE_DIR}/build/prefix)

include(ExternalProject)

add_library(vendor_repo_libs STATIC)

set(INTERFACE_LIB vendor_repo_libs)

file(GLOB cmake_files "${CMAKE_CURRENT_LIST_DIR}/*.cmake")
foreach(cmake_file ${cmake_files})
    include(${cmake_file})
endforeach()

