module backward_solve

! This module solves Ux = y and returns x
  
  implicit none

  contains

  subroutine backward(U,x,y)
  	implicit none
  	real, intent(in) :: y(:)
    real, dimension(size(y),size(y)), intent(in):: U 
    real, dimension(:),allocatable, intent(out) :: x
    integer :: i 
    real :: p_sum

    allocate(x(size(y)))

    do i = size(y), 1, -1
    	call partial_sum(U,x,i,p_sum)
    	x(i) = (1.0/U(i,i)) * (y(i) - p_sum)
    end do

   end subroutine backward

   subroutine partial_sum(U, x, i, p_sum)
   	real, dimension(:,:), intent(in):: U 
    real, dimension(:), intent(in) :: x
    real, intent(out) :: p_sum
    integer, intent(in):: i
    integer :: k
    p_sum = 0
    do k = i+1 , size(x) 
    	p_sum = p_sum + U(i,k) * x(k)
    end do 

   	end subroutine partial_sum

    
       
  



end module backward_solve