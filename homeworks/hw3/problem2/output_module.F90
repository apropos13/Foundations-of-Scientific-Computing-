!!------------------------------------------------------------------
!! A Fortran example code for finding a root of a user-defined 
!! function f(x) = 0.
!! 
!! This code is written by Prof. Dongwook Lee for AMS 209.
!!
!! This module has one subroutine which writes an output 
!! to a file whose name is also defined by users.
!! Users can specify a custom file name, 'runName', in
!! rootFinder.init
!!
!!------------------------------------------------------------------

module output_module

  use setup_module, only : runName
  implicit none

contains

  subroutine output_write(length,x,f,residual)
    implicit none
    integer, intent(IN) :: length
    real, dimension(:), intent(IN) :: x,f,residual
    integer :: i
    character(len=35) :: ofile

    !! File name for ascii output
    ofile = 'rootFinder_'//trim(runName)//'.dat'

    !! File open
    open(unit=20,file=ofile,status='unknown')
    
    !! Write into a file:
    !!   iteration number, search result x, function value f(x), and residual
    do i=1,length
       write(20,920)i,x(i),f(i),residual(i)
    end do

    !! Output format specifiers
920 format(1x, i5, f16.8, 1x, f16.8, 1x, f16.12)
    
    !! File close
    close(20)

  end subroutine output_write
  
end module output_module
