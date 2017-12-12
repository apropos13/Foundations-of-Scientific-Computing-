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

call read_init_files()


call print_A_b(A, b)

!set this to false to run without partial pivoting
partial_pivot = .True.
call LU(A,b, L, U, partial_pivot)
call forward(L,y,b)
call backward(U,x,y)

call print_solution(L,U,x)
call output_write(x, ex_number)

!print*,"L = "
!call prettyPrintMatrix(L, size(b), size(b))
!print*,"U = "
!call prettyPrintMatrix(U, size(b), size(b))
!print *,'b = '
!call prettyPrintMatrix(b, size(b), 1 )
!print *,'y = '
!call prettyPrintMatrix(y, size(y), 1 )
!print *,'x = '
!call prettyPrintMatrix(x, size(x), 1 )


! no longer needed
deallocate (b) 
deallocate (A)

deallocate (L) 
deallocate (U)

deallocate (y) 
deallocate (x)


end program linear_solve
