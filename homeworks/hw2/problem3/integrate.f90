! to run the program: 
! gf integrate.f90 -o myprogram && ./myprogram
! where we define: alias gf 'gfortran -Wall -Wextra -fPIC -fmax-errors=1 -g -fcheck=all -fbacktrace -fdefault-real-8 -fdefault-double-8'
module trapezimodule

contains 
  subroutine trapezoidSub(a,b,N,approx)
    ! compute trapeziodal rule subroutine
    implicit none

    real(kind=8), intent(in) :: a,b
    integer, intent(in) :: N

    real(kind=8), intent(out) :: approx
    real(kind=8) :: dx, xk1, xk2 !define variables dx, xk_-1 and xk_-2
    real(kind=8), external :: f
    real(kind=8) :: frac ! fraction to gold the value (fx_k + fx_k+1)/2
    integer :: i

    !we consider equally spaced intervals hence dx= (b-a)/N
    dx= (b-a)/N
    approx = 0 !approximation starts as 0
    !print *, "dx=", dx
    
    do i=0,N-1

    xk1 = a + i*dx
    xk2 = xk1 + dx
    frac = (f(xk1) + f(xk2))/2
    approx = approx + frac * dx

    end do

  end subroutine trapezoidSub

  subroutine trapezoidExact(a,b, value)
    implicit none

    real(kind=8), intent(in) :: a,b
    real(kind=8), external :: integral_f
    real(kind=8), intent(out) :: value
    
    value = integral_f(b) - integral_f(a)

  end subroutine trapezoidExact


  real(kind=8) function trapezoidFunc(a,b,N)
    implicit none

    real(kind=8), intent(in) :: a,b
    integer, intent(in) :: N

    
    real(kind=8) :: dx, xk1, xk2 !define variables dx, xk_-1 and xk_-2
    real(kind=8), external :: f
    real(kind=8) :: frac ! fraction to hold the value (fx_k + fx_k+1)/2
    integer :: i

    !we consider equally spaced intervals hence dx= (b-a)/N
    dx= (b-a)/N
   
    do i=0,N-1

    xk1 = a + i*dx
    xk2 = xk1 + dx
    frac = (f(xk1) + f(xk2))/2
    trapezoidFunc = trapezoidFunc + frac * dx

    end do
    
  end function trapezoidFunc


end module trapezimodule

!-------------------Program starts here---------------------------
program sub3
  use trapezimodule
  implicit none
  real(kind=8) :: a,b, result_sub, result_func, result_exact
  integer :: N
  real(kind=8), external :: f

  a = 0.
  b = 1.
  N = 200
  call trapezoidSub(a,b,N, result_sub)
  call trapezoidExact(a,b,result_exact)
  result_func = trapezoidFunc(a,b,N)

  print *, "a  =",a
  print *, "b  =",b
  print *, "N  =",N
  print *, "[1] Trapeziodal in function =",result_func
  print *, "[2] Trapezoidal in subroutine =",result_sub
  print *, "[3] Exact integration =",result_exact
  print *, "[4] Error in function  =",result_exact - result_func
  print *, "[5] Error in subroutine  =",result_exact - result_sub
  


end program sub3


real(kind=8) function f(x)
  implicit none
  real(kind=8), intent(in) :: x
  f = x**2 + 1
end function f


real(kind=8) function integral_f(x)
  implicit none
  real(kind=8), intent(in) :: x
  integral_f = (x**3)/3 + x
end function integral_f



