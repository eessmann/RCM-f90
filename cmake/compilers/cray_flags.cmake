function(cray_fortran_flags)
    set(_base_flags "-ef" "-eF" "-M969")
    set(_release_flags "-O3")
    set(_debug_flags "-fcheck=bounds" "-fbacktrace" "-DEXCLUDE_MISSING_INTERFACE" "-G0" "-g" "-R bcdps" "-en")

    set(cray_build_flags "$<JOIN:${_base_flags};$<$<CONFIG:Release>:${_release_flags}>;$<$<CONFIG:Debug>:${_debug_flags}>, >" PARENT_SCOPE)
    set(cray_warning_flags "-m 1" PARENT_SCOPE)
endfunction(cray_fortran_flags)
