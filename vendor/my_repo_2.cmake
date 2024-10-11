set(RECIPE_NAME my_repo_2 )
if(NOT TARGET ${RECIPE_NAME})
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


if(EXISTS "${VENDOR_SRC_DIR}/my_repo_2/CMakeLists.txt")
    add_subdirectory(my_repo_2 EXCLUDE_FROM_ALL SYSTEM)
endif()

set(LIB_my_repo_2 ${VENDOR_BINARY_DIR}/my_repo_2/libmy_repo_2_lib.a)
if(NOT EXISTS "${LIB_my_repo_2}")
    file(TOUCH "${LIB_my_repo_2}")
endif()

add_library(imported_my_repo_2_lib STATIC IMPORTED GLOBAL)
set_target_properties(imported_my_repo_2_lib PROPERTIES
  IMPORTED_LOCATION ${LIB_my_repo_2}
  INTERFACE_INCLUDE_DIRECTORIES ${VENDOR_SRC_DIR}/my_repo_2
)
add_dependencies(imported_my_repo_2_lib my_repo_2)
add_dependencies(vendor_repo_libs imported_my_repo_2_lib)
target_link_libraries(vendor_repo_libs INTERFACE imported_my_repo_2_lib)

