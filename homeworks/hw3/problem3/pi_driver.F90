
program pi_approx

  !! include a C-type header file:
  !! this is why the file extensions are .F90, instead of .f90
#include "definition.h"

  !! Begining of the real implementation of the driver
  !! define usages of module variables and subroutines 
  use setup_module,          only : setup_init, threshold, maxIter
  use pi_module, only : pi_summation
  use output_module,         only : output_write


  !! Always start with implicit none after use module section
  implicit none

  !! These are local variables whose scopes are within RootFinder.F90
  integer :: nIter
  real    :: xNew, residual

  !! Define allocatable arrays
  real, allocatable, dimension(:) :: x_history,res_history
!!$  real, dimension(:,:), allocatable :: dummyVar


  !! Initial values for residual and number of iteration
  residual = 1.e10
  nIter = 1
  xNew = 0 !starts from 0
  
  !! Call setup_init to initialize the runtime parameters
  call setup_init()

  !! allocate arrays with size of a user-defined integer value, maxIter
  allocate(  x_history(maxIter+1))
  allocate(res_history(maxIter+1))

   do while ((residual > threshold) .and. (nIter < maxIter))
      ! need to set nIter -1 because summation must start at 0 
      call pi_summation(nIter-1,xNew,residual)

      !! Store a newly updated approximation into an array 
      x_history(nIter) = xNew

      !! Store a newly updated residual into an array
      res_history(nIter) = residual

      !! Update iteration number
      nIter = nIter + 1

   end do

  !! Prepare to report outputs:
  !! (a) Short summary onto the screen
  if ((nIter < maxIter+1) .and. (residual < threshold)) then
     print *, '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
     print *, '             Solution Convergence Summary                          '
     print *, '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
     print *, 'Your converged solution x = ', xNew
     print *, 'Solution converged in Nstep=', nIter-1
     print *, 'Threshold value = ', threshold

     print *, '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  end if

  !! (b) File output
  call output_write(nIter-1,x_history,res_history)

  !! Make sure allocatable arrays are deallocated before exiting the program
  deallocate(  x_history)
  deallocate(res_history)
  
end program pi_approx
