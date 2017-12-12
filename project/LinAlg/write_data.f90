module write_data

use write_to_screen

implicit none
contains

subroutine print_solution(L,U,x)
	implicit none
    real, intent(in) :: x(:), L(:,:), U(:,:)

    print *, '++++++++++++LU Decomposition: L, U +++++++++++++'
    print *, '++++++++++++++++++++++++++++++++++++++++++++++++'
    print*,"L = "
	call prettyPrintMatrix(L, size(x), size(x))

	print*,"U = "
	call prettyPrintMatrix(U, size(x), size(x))
    print *, '++++++++++++++++++++++++++++++++++++++++++++++++'

    print *, '++++++++++++++++++Solution x +++++++++++++++++++'
    print *, '++++++++++++++++++++++++++++++++++++++++++++++++'
    print *,'x = '
	call prettyPrintMatrix(x, size(x), 1 )
    print *, '++++++++++++++++++++++++++++++++++++++++++++++++'

end subroutine print_solution

subroutine output_write(x, ex_id)
	implicit none
    real, intent(in) :: x(:)
    CHARACTER (LEN=*), intent(in) :: ex_id
    character(len=35) :: x_file
    integer :: k

    x_file = 'x_'//trim(ex_id)//'.dat'

    !! File open
    open(unit=20,file=x_file,status='unknown')
    do k = 1, size(x)
    	 write(20,920)x(k)
    end do

        !! Output format specifiers
920 format(1x, f16.8, 1x, f16.8, 1x, f16.12)

    close(20)
    close(21)


end subroutine output_write


end module