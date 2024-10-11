cmake_minimum_required(VERSION 3.16)

set(PROJECT_NAME app)
project(${PROJECT_NAME} LANGUAGES C CXX )

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(Qt6_DIR           /opt/Qt/6.5.3/macos/lib/cmake/Qt6)
set(VENDOR_SRC_DIR    ${CMAKE_SOURCE_DIR}/vendor)
set(VENDOR_BINARY_DIR ${CMAKE_SOURCE_DIR}/build/vendor)
set(VENDOR_PREFIX_DIR ${CMAKE_SOURCE_DIR}/build/prefix)

include(${Qt6_DIR}/qt.toolchain.cmake)
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core)

add_subdirectory(vendor)

add_executable(${PROJECT_NAME}
  main.cpp
)

add_dependencies(${PROJECT_NAME} vendor_repo_libs)

target_link_libraries(${PROJECT_NAME} PRIVATE  Qt${QT_VERSION_MAJOR}::Core)
target_link_libraries(${PROJECT_NAME} PRIVATE  vendor_repo_libs)


