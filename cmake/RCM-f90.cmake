# Set up build type
function(rcm_configure_build_type)

    set(_build_types "Release;Debug")
    set(_default_build_type "Release")

    get_property(_multiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
    if(_multiConfig)
        set(CMAKE_CONFIGURATION_TYPES "${_build_types}")
        message(STATUS "Build type: Multi-Config (build type selected at the build step)")
    else()
        if(NOT CMAKE_BUILD_TYPE)
            message(STATUS "Build type: ${_default_build_type} (default single-config)")
            set(CMAKE_BUILD_TYPE "${_default_build_type}" CACHE STRING "Build type" FORCE)
            set_property(CACHE CMAKE_BUILD_TYPE PROPERTY HELPSTRING "Choose the type of build")
            set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "${_build_types}")
        else()
            message(STATUS "Build type: ${CMAKE_BUILD_TYPE} (manually selected single-config)")
        endif()
    endif()

endfunction(rcm_configure_build_type)


# Copy user configured compiler flags into global compiler flags
macro(rcm_configure_compiler_flags)
    include(${CMAKE_SOURCE_DIR}/cmake/compilers/gnu_flags.cmake)
    include(${CMAKE_SOURCE_DIR}/cmake/compilers/cray_flags.cmake)

    add_library(rcm_project_warnings INTERFACE)
    add_library(rcm_project_options INTERFACE)

    if(CMAKE_Fortran_COMPILER_ID STREQUAL "GNU")
        message("GNU fortran compiler!")
        gnu_fortran_flags()
        target_compile_options(rcm_project_warnings 
            INTERFACE # Fortran warnings
            $<$<COMPILE_LANGUAGE:Fortran>:${gnu_warning_flags}>)
        target_compile_options(rcm_project_options 
            INTERFACE 
            $<$<COMPILE_LANGUAGE:Fortran>:${gnu_build_flags}>)
    elseif(CMAKE_Fortran_COMPILER_ID STREQUAL "CrayClang" OR CMAKE_Fortran_COMPILER_ID STREQUAL "Cray")
        cray_fortran_flags()
        target_compile_options(rcm_project_warnings 
        INTERFACE # Fortran warnings
            $<$<COMPILE_LANGUAGE:Fortran>:${cray_warning_flags}>)
        target_compile_options(rcm_project_options 
        INTERFACE
            $<$<COMPILE_LANGUAGE:Fortran>:${cray_build_flags}>)
    else()
    endif()

    unset(gnu_warning_flags)
    unset(gnu_build_flags)
    unset(cray_warning_flags)
    unset(cray_build_flags)

endmacro(rcm_configure_compiler_flags)
