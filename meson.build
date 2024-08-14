project(
  'rcm-f90',
  'fortran',
  version: '0.2.0',
  default_options: ['fortran_std=f2018', 'b_staticpic=true', 'b_pie=true', 'warning_level=3', 'default_library=both'],
)

# Create Library
subdir('src')

# License
rcm_lic = files(
    'LICENSE',
)
install_data(
    rcm_lic,
    install_dir : join_paths(get_option('prefix'), 'share', 'licenses', meson.project_name()),
)

#test_exe = executable('asimov_ccs_test', 'asimov_ccs_test.f90',
#  link_with : lib)
#test('asimov_ccs', test_exe)

# Make this library usable as a Meson subproject.
rcm_f90_dep = declare_dependency(
  link_with: rcm_lib,
)

pkg_mod = import('pkgconfig')
pkg_mod.generate(
  name: meson.project_name(),
  description: 'RCM is a FORTRAN90 library which computes the Reverse Cuthill McKee ("RCM") ordering of the nodes of a graph.',
  subdirs: meson.project_name(),
  libraries: rcm_lib,
  version: meson.project_version(),
)