program linear_solve

use read_data 
use write_to_screen
use LU_decomp
use forward_solve
use backward_solve
use write_data

implicit none


real, dimension(:,:), allocatable :: L, U
real, dimension(:), allocatable :: y,x
logical :: partial_pivot
CHARACTER (LEN=*), PARAMETER :: ex_number= "1"

!set partial_pivot to false to run without partial pivoting
!set partial_pivot to true to run with partial pivoting
partial_pivot = .True.
if (partial_pivot) then
	print*,"--> Running WITH partial pivoting"
else
	print*,"--> Running WITHOUT partial pivoting"
endif

call read_init_files()


call print_A_b(A, b)

call LU(A,b, L, U, partial_pivot)
call forward(L,y,b)
call backward(U,x,y)

call print_solution(L,U,x)
call output_write(x, ex_number)


! no longer needed
deallocate (b) 
deallocate (A)

deallocate (L) 
deallocate (U)

deallocate (y) 
deallocate (x)


end program linear_solve
