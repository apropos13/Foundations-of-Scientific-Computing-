!!------------------------------------------------------------------
!! A Fortran example code for finding a root of a user-defined 
!! function f(x) = 0.
!! 
!! This code is written by Prof. Dongwook Lee for AMS 209.
!!
!!
!! * Two methods of iteration:
!!   1. Newton's method
!!   2. Modified Newton's method
!!
!! * This routine is a driver routine which calls subroutines:
!!   
!!   RootFinder:
!!       |- setup_init (from setup_module)
!!       |
!!       |   / newton_method (from findRootMethod_module)
!!       |- |
!!       |   \ modified_newton_method (from findRootMethod_module)
!!       | 
!!       |- output_write (from output_module)
!!
!!------------------------------------------------------------------

   
program RootFinder

  !! include a C-type header file:
  !! this is why the file extensions are .F90, instead of .f90
#include "definition.h"

  !! Begining of the real implementation of the driver
  !! define usages of module variables and subroutines 
  use setup_module,          only : setup_init, threshold, maxIter, methodType,xInit
  use findRootMethod_module, only : newton_method, modified_newton_method
  use output_module,         only : output_write


  !! Always start with implicit none after use module section
  implicit none

  !! These are local variables whose scopes are within RootFinder.F90
  integer :: nIter
  real    :: x, xNew, residual, f

  !! Define allocatable arrays
  real, allocatable, dimension(:) :: x_history,f_history,res_history
!!$  real, dimension(:,:), allocatable :: dummyVar

  !! Initial values for residual and number of iteration
  residual = 1.e10
  nIter = 1
  
  !! Call setup_init to initialize the runtime parameters
  call setup_init()

  !! allocate arrays with size of a user-defined integer value, maxIter
  allocate(  x_history(maxIter))
  allocate(  f_history(maxIter))
  allocate(res_history(maxIter))


  !! The first initial guess for Newton's search.
  !! This is a user-defined value in rootFinder.init
  x = xInit

  !! Start root searches using either 
  !! (a) Newton's method, or
  !! (b) modified Newton's method.

  if (methodType == 'newton') then

     !! Keep search iteration until 
     !! (a) residual is bigger then a user-defined threshold value, and
     !! (b) iteration number is less than a user-defined maximum iteration number.

     do while ((residual > threshold) .and. (nIter < maxIter))

        !! Search using conventional Newton's method
        call newton_method(x,xNew,f,residual)

        !! Store a newly updated root into an array 
        x_history(nIter) = xNew

        !! Save for the next search iteration
        x = xNew

        !! Store a newly updated residual into an array
        res_history(nIter) = residual

        !! Update iteration number
        nIter = nIter + 1
     end do
     
  elseif (methodType == 'modified_newton') then

     do while ((residual > threshold) .and. (nIter < maxIter))
        !! Search using a modified Newton's method
        call modified_newton_method(x,xNew,f,residual)

        !! Store a newly updated root into an array
        x_history(nIter) = x

        !! Save for the next search iteration
        x = xNew

        !! Store a newly updated residual into an array
        res_history(nIter) = residual


        !! Update iteration number
        nIter = nIter + 1
     end do
  else
     !! Exit the program if the search method is unknown.
     print *, "Unknown method type. Please choose either Newton or Modified Newton"
     print *, "Aborting the program."
     stop
  end if


  !! Prepare to report outputs:
  !! (a) Short summary onto the screen
  if ((nIter < maxIter) .and. (residual < threshold)) then
     print *, '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
     print *, '             Solution Convergence Summary                          '
     print *, '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
     print *, 'Your converged solution x = ', xNew
     print *, 'Solution converged in Nstep=', nIter-1
     print *, 'Threshold value = ', threshold
     print *, '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  end if

  !! (b) File output
  call output_write(nIter-1,x_history,f_history,res_history)

  !! Make sure allocatable arrays are deallocated before exiting the program
  deallocate(  x_history)
  deallocate(  f_history)
  deallocate(res_history)
  
end program RootFinder
