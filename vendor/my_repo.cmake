set(RECIPE_NAME my_repo)
if(NOT TARGET ${RECIPE_NAME})
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


if(EXISTS "${VENDOR_SRC_DIR}/my_repo/CMakeLists.txt")
    add_subdirectory(my_repo EXCLUDE_FROM_ALL SYSTEM)
endif()

set(LIB_my_repo ${VENDOR_BINARY_DIR}/my_repo/libmy_repo_lib.a)
if(NOT EXISTS "${LIB_my_repo}")
    file(TOUCH "${LIB_my_repo}")
endif()

add_library(imported_my_repo_lib STATIC IMPORTED GLOBAL)
set_target_properties(imported_my_repo_lib PROPERTIES
  IMPORTED_LOCATION ${LIB_my_repo}
  INTERFACE_INCLUDE_DIRECTORIES ${VENDOR_SRC_DIR}/my_repo
)
add_dependencies(imported_my_repo_lib my_repo)
target_link_libraries(vendor_repo_libs INTERFACE imported_my_repo_lib)
