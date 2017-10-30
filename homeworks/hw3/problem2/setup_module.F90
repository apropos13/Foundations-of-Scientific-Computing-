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

    call read_initFileChar('rootFinder.init','run_name',runName)
    call read_initFileChar('rootFinder.init','method_type',methodType)
    call read_initFileInt ('rootFinder.init','multiplicity', multiplicity)
    call read_initFileInt ('rootFinder.init', 'ftn_type', ftnType)
    if (ftnType > 4) then
       print*,'Not a valid function input type.'
       print*,'Aborting now!'
       stop
    end if
    call read_initFileInt ('rootFinder.init', 'max_iter', maxIter)
    call read_initFileReal('rootFinder.init', 'x_beg', xBeg)
    call read_initFileReal('rootFinder.init', 'x_end', xEnd)
    call read_initFileReal('rootFinder.init', 'threshold', threshold)
    call read_initFileReal('rootFinder.init', 'init_guess', xInit)
    if ((xInit > xEnd) .or. (xInit < xBeg)) then
       print*,'Not a valid initial guess -- out of domain.'
       print*,'Choose your initial guess between x_min and x_max. Aborting now!'
       stop
    end if

    print *,'-----------------Parameters--------------------'
    print *, 'runName = ', runName
    print *, 'method_type = ', methodType
    print *, 'multiplicity = ', multiplicity
    print *, 'function type = ', ftnType
    print *, 'Max iterations = ', maxIter
    print *, 'Begin Interval at = ', xBeg
    print *, 'End Interval at = ', xEnd
    print *, 'Threshold Interval at = ', threshold
    !xinit is ommited since it is include in exercise 1

    print *,'-----------------------------------------------'
    
  end subroutine setup_init

  
end module setup_module
