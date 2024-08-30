function(gnu_fortran_flags)
    set(_base_flags -std=f2018 -ffree-line-length-none -fimplicit-none)
    set(_release_flags -march=native -mtune=native)
    set(_debug_flags -fcheck=bounds -fbacktrace -DEXCLUDE_MISSING_INTERFACE)

    set(gnu_build_flags ${_base_flags} $<$<CONFIG:Release>:${_release_flags}> $<$<CONFIG:Debug>:${_debug_flags}> PARENT_SCOPE)
    set(gnu_warning_flags -Wall -Wpedantic -Wno-uninitialized -Wimplicit-interface -Wimplicit-procedure -Werror PARENT_SCOPE)
endfunction(gnu_fortran_flags)

