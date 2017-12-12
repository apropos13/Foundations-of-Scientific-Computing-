module LU_decomp

implicit none

contains

!interface to call LU with pivot or without
subroutine LU(A,b, L, U, ppivot)
	logical :: ppivot
	real, intent(out) :: b(:)
    real, dimension(size(b),size(b)), intent(in):: A 
    real, dimension(:,:), allocatable, intent(out) :: L, U

	if (ppivot) then
		call LU_with_pivot(A,b, L, U)
	else
		call LU_no_pivot(A,b, L, U)
	end if
end subroutine LU

subroutine LU_no_pivot(A,b, L, U)
	implicit none
    real, intent(out) :: b(:)
    real, dimension(size(b),size(b)), intent(in):: A 
    real, dimension(:,:), allocatable, intent(out) :: L, U
    integer :: k, i, j 


    allocate(L(size(b),size(b)))
    L(:,:) = 0 

    allocate(U(size(b),size(b)))
    !U starts as a copy of A
    U = A 

    ! Fix diagonal entries of L
    do k = 1 , size(b)
    	L(k,k) = 1
    end do

    ! loop over column
    do k = 1, size(b)-1
    	!if diagonal is 0 stop
    	if ( U(k,k) == 0 ) then
    		print*, 'Pivot is 0, stop' 
    		stop
    	end if

    	do i = k+1, size(b)
    		L(i,k) =  U(i,k) / U(k,k)
    	end do

    	do j = k, size(b)
    		do i = k+1, size(b)

    			U(i,j) = U(i,j) - L(i,k)*U(k,j)

    		end do
    	end do 
    end do
end subroutine LU_no_pivot

subroutine LU_with_pivot(A,b,L,U)
	implicit none
    real, intent(out) :: b(:)
    real, dimension(size(b),size(b)), intent(in):: A 
    real, dimension(:,:), allocatable, intent(out) :: L, U
    integer :: k, i, j 


    allocate(L(size(b),size(b)))
    L(:,:) = 0 

    allocate(U(size(b),size(b)))
    !U starts as a copy of A
    U = A 

    ! loop over column
    do k = 1, size(b)-1

    	call all_swaps(b,L,U,k)

    	do j = k+1, size(b)
    		L(j,k) = U(j,k) / U(k,k)
    		U(j, k: size(b))=U(j, k:size(b)) - L(j,k)*U(k, k:size(b))


    	end do 

    	
    end do

    do k = 1 , size(b)
    	L(k,k) = 1
    	do j = k+1 , size(b)
    		L(k, j) = 0
    	end do
    end do



end subroutine LU_with_pivot

subroutine all_swaps(b_swap, L, U, k)
	implicit none
    real :: b_swap(:), temp_b_swap
    real, dimension(:,:), allocatable :: L, U
    real, dimension(size(b_swap)) :: temp_U, temp_L

    integer :: k , max_index

    call get_max_index(U(:, k), max_index, k)

    ! swap entries in U
    temp_U = U(k, k:size(b_swap))
    U(k, k:size(b_swap)) = U(max_index, k:size(b_swap))
    U(max_index, k:size(b_swap)) = temp_U


    if (k > 1) then 
	    ! swap entries in L
	    temp_L = L(k, 1:k-1)
	    L(k, 1:k-1) = L(max_index, 1:k-1)
	    L(max_index, 1:k-1) = temp_L

	end if

	! swap b_swap entries 
    temp_b_swap = b_swap(k)
    b_swap(k) = b_swap(max_index)
    b_swap(max_index) = temp_b_swap


    

    !print*, 'max_index is', max_index

end subroutine all_swaps

!get index of maximum element in column
subroutine get_max_index(c_vector, index, col_number)
	implicit none
    real, intent(in) :: c_vector(:)
    integer, intent(in) :: col_number
    integer, intent(out) :: index 
    integer :: j
    real :: temp

    ! initially temp is - infinity
    temp = -10000000
    ! first index is 1
    index = 1

    do j = col_number, size(c_vector)
    	if ( abs(c_vector(j)) > temp) then 
    		temp = c_vector(j)
    		index = j
    	end if 
    end do 

end subroutine get_max_index


end module LU_decomp