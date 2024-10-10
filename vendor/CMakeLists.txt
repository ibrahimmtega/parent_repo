cmake_minimum_required(VERSION 3.16)

project(vendor_repo_libs LANGUAGES CXX)

set(Qt6_DIR           /opt/Qt/6.5.3/macos/lib/cmake/Qt6)
set(VENDOR_SRC_DIR    ${CMAKE_SOURCE_DIR}/vendor)
set(VENDOR_BINARY_DIR ${CMAKE_SOURCE_DIR}/build/vendor)
set(VENDOR_PREFIX_DIR ${CMAKE_SOURCE_DIR}/build/prefix)


include(ExternalProject)
if(NOT TARGET my_repo)
    ExternalProject_Add(
      my_repo
      GIT_REPOSITORY https://github.com/ibrahimmtega/my_repo.git
      GIT_TAG main
      BINARY_DIR ${VENDOR_BINARY_DIR}/my_repo
      PREFIX ${VENDOR_PREFIX_DIR}/my_repo
      SOURCE_DIR ${VENDOR_SRC_DIR}/my_repo
      INSTALL_COMMAND ""
      BUILD_ALWAYS ON
      GIT_PROGRESS ON
      CMAKE_ARGS
        -DVENDOR_SRC_DIR=${VENDOR_SRC_DIR}
        -DVENDOR_BINARY_DIR=${VENDOR_BINARY_DIR}
        -DVENDOR_PREFIX_DIR=${VENDOR_PREFIX_DIR}
        -DQt6_DIR=${Qt6_DIR}
    )
endif()

if(NOT TARGET my_repo_2)
    ExternalProject_Add(
      my_repo_2
      GIT_REPOSITORY https://github.com/ibrahimmtega/my_repo_2.git
      GIT_TAG main
      BINARY_DIR ${VENDOR_BINARY_DIR}/my_repo_2
      PREFIX ${VENDOR_PREFIX_DIR}/my_repo_2
      SOURCE_DIR ${VENDOR_SRC_DIR}/my_repo_2
      INSTALL_COMMAND ""
      BUILD_ALWAYS ON
      GIT_PROGRESS ON
      CMAKE_ARGS
        -DVENDOR_SRC_DIR=${VENDOR_SRC_DIR}
        -DVENDOR_BINARY_DIR=${VENDOR_BINARY_DIR}
        -DVENDOR_PREFIX_DIR=${VENDOR_PREFIX_DIR}
        -DQt6_DIR=${Qt6_DIR}
     )
endif()

add_library(vendor_repo_libs)


add_library(imported_my_repo_2_lib INTERFACE IMPORTED)
set_target_properties(imported_my_repo_2_lib PROPERTIES
  IMPORTED_LOCATION ${VENDOR_BINARY_DIR}/my_repo_2/libmy_repo_2_lib.a
  INTERFACE_INCLUDE_DIRECTORIES ${VENDOR_SRC_DIR}/my_repo_2
)
add_dependencies(imported_my_repo_2_lib my_repo_2)
target_link_libraries(vendor_repo_libs PUBLIC imported_my_repo_2_lib)
if(EXISTS "${VENDOR_SRC_DIR}/my_repo_2/CMakeLists.txt")
    add_subdirectory(my_repo_2 EXCLUDE_FROM_ALL SYSTEM)
endif()


add_library(imported_my_repo_lib INTERFACE IMPORTED)
set_target_properties(imported_my_repo_lib PROPERTIES
  IMPORTED_LOCATION ${VENDOR_BINARY_DIR}/my_repo_2/libmy_repo_lib.a
  INTERFACE_INCLUDE_DIRECTORIES ${VENDOR_SRC_DIR}/my_repo_2
)
add_dependencies(imported_my_repo_lib my_repo)
target_link_libraries(vendor_repo_libs PUBLIC imported_my_repo_lib)
if(EXISTS "${VENDOR_SRC_DIR}/my_repo/CMakeLists.txt")
    add_subdirectory(my_repo EXCLUDE_FROM_ALL SYSTEM)
endif()

