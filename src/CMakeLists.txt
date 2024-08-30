# Collect source files for library
set(rcm-sources
        rcm.f90
        rcm_kinds.f90
)


# Build library
add_library(rcm-f90 ${rcm-sources})

# Setting Fortran standard, flags, and warnings using target-based approach
target_link_libraries(rcm-f90 PRIVATE $<BUILD_LOCAL_INTERFACE:rcm_project_options;rcm_project_warnings>)

# Store generated mod-files in a separate folder
set(moddir "${CMAKE_CURRENT_BINARY_DIR}/mod")
set_target_properties(rcm-f90 PROPERTIES
    Fortran_MODULE_DIRECTORY "${moddir}"
)

# Add mod-file directory to include search path for targets depending on the library
target_include_directories(rcm-f90 PUBLIC
    $<BUILD_INTERFACE:${moddir}>
    $<INSTALL_INTERFACE:${INSTALL_MODULEDIR}>
)

# Install the library
install(TARGETS rcm-f90
    EXPORT rcm-f90-targets
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${INSTALL_INCLUDEDIR}"
)

# Install the folder with the modfiles (needed by projects using the library)
install(DIRECTORY "${moddir}/" DESTINATION "${INSTALL_MODULEDIR}")
