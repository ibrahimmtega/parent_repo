set(RECIPE_NAME my_repo)
if(NOT TARGET ${RECIPE_NAME})
    ExternalProject_Add(
      ${RECIPE_NAME}
      GIT_REPOSITORY https://github.com/ibrahimmtega/my_repo.git
      GIT_TAG main
      BINARY_DIR ${VENDOR_BINARY_DIR}/${RECIPE_NAME}
      PREFIX ${VENDOR_PREFIX_DIR}/${RECIPE_NAME}
      SOURCE_DIR ${VENDOR_SRC_DIR}/${RECIPE_NAME}
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

ExternalProject_Get_Property(${RECIPE_NAME} BINARY_DIR SOURCE_DIR)

if(EXISTS "${SOURCE_DIR}/CMakeLists.txt")
    add_subdirectory(${RECIPE_NAME} EXCLUDE_FROM_ALL SYSTEM)
endif()

set(LIB_NAME libmy_repo_lib.a)
if(NOT EXISTS "${BINARY_DIR}/${LIB_NAME}")
    file(TOUCH "${BINARY_DIR}/${LIB_NAME}")
endif()

add_library(imported_${RECIPE_NAME} STATIC IMPORTED )
set_target_properties(imported_${RECIPE_NAME} PROPERTIES
  IMPORTED_LOCATION ${BINARY_DIR}/${LIB_NAME}
  INTERFACE_INCLUDE_DIRECTORIES ${SOURCE_DIR}
)
add_dependencies(imported_${RECIPE_NAME} ${RECIPE_NAME})

target_link_libraries(vendor_repo_libs INTERFACE imported_${RECIPE_NAME})
