module forward_solve

! This module solves Ly = b and returns y
  
  implicit none

  contains

  subroutine forward(L,y,b)
  	implicit none
  	real, intent(in) :: b(:)
    real, dimension(size(b),size(b)), intent(in):: L 
    real, dimension(:),allocatable, intent(out) :: y
    integer :: i 
    real :: p_sum

    allocate(y(size(b)))

    do i = 1, size(b)
    	call partial_sum(L,y,i,p_sum)
    	y(i) = (1.0/L(i,i)) * (b(i) - p_sum)
    end do

   end subroutine forward

   subroutine partial_sum(L, y, i, p_sum)
   	real, dimension(:,:), intent(in):: L 
    real, dimension(:), intent(in) :: y
    real, intent(out) :: p_sum
    integer, intent(in):: i
    integer :: k
    p_sum = 0
    do k = 1 , i-1 
    	p_sum = p_sum + L(i,k) * y(k)
    end do 




   	end subroutine partial_sum

    

end module forward_solve