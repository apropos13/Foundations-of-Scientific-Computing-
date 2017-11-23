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


module findRootMethod_module

#include "definition.h"
  
  use ftn_module, only: ftn_eval, ftn_derivative
  use setup_module, only: multiplicity,xBeg,xEnd
  
contains

  !! Conventional Newton's method
  subroutine newton_method(x,xNew,fNew,residual)
    implicit none
    real, intent(IN) :: x
    real, intent(OUT) :: fNew, residual
    real :: xNew, f, fprime
    
    !! compute function value evaluated at x
    call ftn_eval(x,f)

    !! compute function derivative evaluated at x
    call ftn_derivative(x,fprime)

    !! Exit if f' is near or become zero
    if (abs(fprime) < 1.e-12) then
       print *, '[Error: newton_method] Function derivative becomes very close to zero or zero.'
       print *, 'f=',f, 'df/dx =',fprime
       print *, 'Aborting now in order to avoid division by zero.'
       stop
    end if

    !! Algorithm
    xNew = x - f/fprime
    fNew = f
    
    !! Search fails if a newly updated value x is out of the search domain
    if ((xNew < xBeg) .or. (xNew > xEnd)) then
       print *, '[Error: newton_method] xNew',xNew, 'is out of domain.'
       print *, 'Failed in search. Aborting now.'
       stop
    end if
    
    !! Calculate a new residual
    residual = abs(xNew - x)
    
  end subroutine newton_method



  !! Modified Newton's method
  subroutine modified_newton_method(x,xNew,fNew,residual)
    implicit none
    real, intent(IN) :: x
    real, intent(OUT) :: fNew, residual
    real :: xNew, f, fprime
    
    !! compute function value evaluated at x
    call ftn_eval(x,f)

    !! compute function derivative evaluated at x
    call ftn_derivative(x,fprime)

    !! Exit if f' is near or become zero
    if (abs(fprime) < 1.e-12) then
       print *, '[Error: modified_newton_method] Function derivative becomes very close to zero or zero.'
       print *, 'f=',f, 'df/dx =',fprime
       print *, 'Aborting now in order to avoid division by zero.'
       stop
    end if
    
    !! Algorithm
    xNew = x - multiplicity*f/fprime
    fNew = f
    
    !! Search fails if a newly updated value x is out of the search domain
    if ((xNew < xBeg) .or. (xNew > xEnd)) then
       print *, '[Error: modified_newton_method] xNew',xNew, 'is out of domain.'
       print *, 'Failed in search. Aborting now.'
       stop
    end if

    !! Calculate a new residual
    residual = abs(xNew - x)
    
  end subroutine modified_newton_method
  
end module findRootMethod_module
