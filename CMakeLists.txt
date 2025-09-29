cmake_minimum_required(VERSION 3.16)

# Set basic project properties
project(RCM-f90
    VERSION 0.2.0
    DESCRIPTION "RCM f90 is a modified version of the code available at https://people.math.sc.edu/Burkardt/f_src/rcm/rcm.html to facilitate building as a library, released under an LGPL license - see LICENSE."
    LANGUAGES Fortran
)

include(GNUInstallDirs)
set(CMAKE_Fortran_MODULE_DIRECTORY "${CMAKE_BINARY_DIR}/modules/rcm-90")
set(rcm_f90_module_install_dir "${CMAKE_INSTALL_LIBDIR}/fortran/${CMAKE_Fortran_COMPILER_ID}-${CMAKE_Fortran_COMPILER_VERSION}")

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
set(rcm_f90_INSTALL_CONFIGDIR "${CMAKE_INSTALL_LIBDIR}/cmake/rcm-f90")

install(
    TARGETS rcm-f90 rcm_project_options rcm_project_warnings
    COMPONENT rcm-f90
    EXPORT rcm-f90-targets
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/rcm-f90ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY ExactVersion
)

# Install project, add namespace
install(
    EXPORT rcm-f90-targets
    FILE "rcm-f90-targets.cmake"
    NAMESPACE "RCM-f90::"
    DESTINATION "${rcm_f90_INSTALL_CONFIGDIR}"
)

# Create and install CMake package config file
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/export/rcm-f90-config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/rcm-f90-config.cmake"
    INSTALL_DESTINATION "${rcm_f90_INSTALL_CONFIGDIR}"
)

install(
  DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}
  DESTINATION ${rcm_f90_module_install_dir}
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/rcm-f90-config.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/rcm-f90ConfigVersion.cmake"
  DESTINATION "${rcm_f90_INSTALL_CONFIGDIR}"
)