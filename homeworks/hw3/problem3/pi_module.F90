!!------------------------------------------------------------------
!! A Fortran example code for finding a root of a user-defined 
!! function f(x) = 0.
!! 
!! This code is written by Prof. Dongwook Lee for AMS 209.
!!
!! This module has two subroutines each of which implements
!!   1. Newton's method,
!!   2. Modified Newton's method
!!
!!------------------------------------------------------------------


module pi_module

#include "definition.h"

contains

  !! Pi summation series
  subroutine pi_summation(N,piNew,residual)
    implicit none
    integer, intent(IN) :: N
    real, intent(OUT) :: piNew, residual
    real (kind = 8) :: f1, f2, f3, f4, total

  
    f1 = 4. / (8.*N + 1.)
    f2 = 2. / (8.*N + 4.)
    f3 = 1. / (8.*N + 5.)
    f4 = 1. / (8.*N + 6.)

    total = f1 - f2 - f3 - f4

    piNew = piNew + 16.**(-1. * N) * (total)
    !print *, 'i =',N
    !print *, 'piNew =',piNew
    

    !residual =  new pi approximation - pi 
    residual = abs(piNew - acos(-1.d0) )

    
  end subroutine pi_summation
  
end module pi_module
