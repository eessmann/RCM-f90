# rcm library
rcm_sources = files('rcm.f90', 'rcm_kinds.f90')

rcm_lib = library(
    meson.project_name(),
    rcm_sources,
    install: true,
)

if host_machine.system() == 'windows'
    symbols_file = 'lib'+meson.project_name()+'-'+meson.project_version().split('.')[0]+'.dll.symbols'
    obj_files = ['rcm.f90.obj', 'rcm_kinds.f90.obj']
else
    symbols_file = 'lib'+meson.project_name()+'.so.'+meson.project_version()+'.symbols'
    obj_files = ['rcm.f90.o', 'rcm_kinds.f90.o']
endif
install_subdir(rcm_lib.full_path()+'.p',
    install_dir: 'include',
    strip_directory: true,
    exclude_files: [
        'depscan.dd',
        meson.project_name()+'-deps.json',
        meson.project_name()+'.dat',
        symbols_file,
        obj_files,
    ]
)