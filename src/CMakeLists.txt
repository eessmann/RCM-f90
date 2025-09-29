# Build library
add_library(rcm-f90)
target_sources(
    rcm-f90
    PRIVATE
        rcm.f90
        rcm_kinds.f90
)

# Setting Fortran standard, flags, and warnings using target-based approach
target_link_libraries(rcm-f90 PRIVATE rcm_project_options rcm_project_warnings)
target_include_directories(
  rcm-f90
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_Fortran_MODULE_DIRECTORY}>
  $<INSTALL_INTERFACE:${rcm_f90_module_install_dir}>
)