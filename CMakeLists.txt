cmake_minimum_required(VERSION 3.16)

# Set basic project properties
project(RCM-f90
    VERSION 0.1
    DESCRIPTION "RCM f90 is a modified version of the code available at https://people.math.sc.edu/Burkardt/f_src/rcm/rcm.html to facilitate building as a library, released under an LGPL license - see LICENSE."
    LANGUAGES Fortran
)

# Set up install directories
include(GNUInstallDirs)
set(INSTALL_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}")
set(INSTALL_MODULEDIR "${INSTALL_INCLUDEDIR}")

# Include project specific CMake functions
include(cmake/RCM-f90.cmake)

# Include user customizable config settings
include(config.cmake)

# Configure the build type (see cmake/RCM-f90.cmake)
rcm_configure_build_type()

# Configure the compiler flags (see cmake/RCM-f90.cmake)
rcm_configure_compiler_flags()

# Build library
add_subdirectory(src)


#
# Install package config find, so that other CMake project can find this project
#
include(CMakePackageConfigHelpers)

# Add an alias to export library 'rcm-f90' as target RCM-f90::RCM-f90
add_library(RCM-f90 INTERFACE)
target_link_libraries(RCM-f90 INTERFACE rcm-f90)
install(TARGETS RCM-f90 EXPORT rcm-f90-targets)

# If project uses customized finders, they should be installed with it
if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/rcm-f90
)
endif()

# Install project, add namespace
install(
    EXPORT rcm-f90-targets
    FILE "rcm-f90-targets.cmake"
    NAMESPACE "RCM-f90::"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/rcm-f90"
)

# Create and install CMake package config file
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/export/rcm-f90-config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/rcm-f90-config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/rcm-f90"
)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/rcm-f90-config-version.cmake"
    VERSION "${PROJECT_VERSION}"
    COMPATIBILITY SameMajorVersion
)
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/cmake/rcm-f90-config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/rcm-f90-config-version.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/rcm-f90"
)
