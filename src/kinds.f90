!!!! kinds.f90
!!
!! Defines the kinds used in RCM.f90
module kinds

  public

  integer, parameter :: rcm_int = kind(1)
  integer, parameter :: rcm_real = kind(0.0d0)

end module

