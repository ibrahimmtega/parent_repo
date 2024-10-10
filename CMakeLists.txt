cmake_minimum_required(VERSION 3.16)

project(parent_repo LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(/opt/Qt/6.5.3/macos/lib/cmake/Qt6/qt.toolchain.cmake)
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core)

include(ExternalProject)
ExternalProject_Add(
  my_repo_2
  GIT_REPOSITORY https://github.com/ibrahimmtega/my_repo_2.git
  GIT_TAG main
  BINARY_DIR ${CMAKE_SOURCE_DIR}/build/vendor/my_repo_2
  PREFIX ${CMAKE_SOURCE_DIR}/build/extras/my_repo_2
  SOURCE_DIR ${CMAKE_SOURCE_DIR}/vendor/my_repo_2
  INSTALL_COMMAND ""
  BUILD_ALWAYS ON
  GIT_PROGRESS ON
  # INSTALL_DIR ${CMAKE_SOURCE_DIR}/build/external/install
  # CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/my_repo_2-install # Arguments passed to CMake of the external project
)

ExternalProject_Add(
  my_repo
  GIT_REPOSITORY https://github.com/ibrahimmtega/my_repo.git
  GIT_TAG main
  BINARY_DIR ${CMAKE_SOURCE_DIR}/build/vendor/my_repo
  PREFIX ${CMAKE_SOURCE_DIR}/build/extras/my_repo
  SOURCE_DIR ${CMAKE_SOURCE_DIR}/vendor/my_repo
  INSTALL_COMMAND ""
  BUILD_ALWAYS ON
  GIT_PROGRESS ON
  # INSTALL_DIR ${CMAKE_SOURCE_DIR}/build/external/install
  # CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/my_repo_2-install # Arguments passed to CMake of the external project
)

add_executable(parent_repo
  main.cpp
)
target_link_libraries(parent_repo Qt${QT_VERSION_MAJOR}::Core)

add_library(my_repo_2_lib INTERFACE IMPORTED)
set_target_properties(my_repo_2_lib PROPERTIES
  IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/build/vendor/my_repo_2/libmy_repo_2_lib.a
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_SOURCE_DIR}/vendor/my_repo_2
)
add_dependencies(my_repo_2_lib my_repo_2)
target_link_libraries(parent_repo my_repo_2_lib)

add_library(my_repo_lib INTERFACE IMPORTED)
set_target_properties(my_repo_lib PROPERTIES
  IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/build/vendor/my_repo/libmy_repo_lib.a
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_SOURCE_DIR}/vendor/my_repo
)
add_dependencies(my_repo_lib my_repo)
target_link_libraries(parent_repo my_repo_lib)
