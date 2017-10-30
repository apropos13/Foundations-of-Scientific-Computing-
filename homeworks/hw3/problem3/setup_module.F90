!!------------------------------------------------------------------
!! A Fortran example code for finding a root of a user-defined 
!! function f(x) = 0.
!! 
!! This code is written by Prof. Dongwook Lee for AMS 209.
!!
!! This module has one subroutine which initialize your setup
!! by reading in runtime parameters from 'rootFinder.init' file.
!! The setup_init subroutine calls read_initFile*** subroutines
!! that are implemented as subroutines in read_initFile_module. 
!!
!!------------------------------------------------------------------


module setup_module

#include "definition.h"
  
  use read_initFile_module
  
  implicit none

  real, save :: xBeg,xEnd
  real, save :: threshold
  real, save :: xInit
  integer, save :: maxIter
  integer, save :: ftnType
  character(len=MAX_STRING_LENGTH), save :: runName, methodType
  integer, save :: multiplicity
  
contains

  subroutine setup_init()

    implicit none

    call read_initFileChar('pi_approx.init','run_name',runName)

    call read_initFileInt ('pi_approx.init', 'max_iter', maxIter)

    call read_initFileReal('pi_approx.init', 'threshold', threshold)


    print *,'-----------------Parameters--------------------'
    print *, 'runName = ', runName
    print *, 'Max iterations = ', maxIter
    print *, 'Threshold Interval at = ', threshold
    !xinit is ommited since it is included in the pi_driver file

    print *,'-----------------------------------------------'
    
  end subroutine setup_init

  
end module setup_module
