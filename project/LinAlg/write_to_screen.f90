module write_to_screen
  
  implicit none
  contains

  subroutine print_A_b(A,b)
    implicit none
    real, intent(in) :: b(:), A(:,:)
    print *, '++++++++++++++++++++++++++++++++++++++++++++++++'
    print *, '++++++++++++Input Parameters: b, A +++++++++++++'
    print *, '++++++++++++++++++++++++++++++++++++++++++++++++'
    print *,'b = '
    call prettyPrintMatrix(b, size(b), 1 )

    print *,'A = '
    call prettyPrintMatrix(A, size(b), size(b) )
    print *, '++++++++++++++++++++++++++++++++++++++++++++++++'
  end subroutine print_A_b

  subroutine prettyPrintMatrix(m, d1, d2)
    implicit none
    real, intent(in) :: m(d1, d2)
    integer, intent(in) :: d1,d2 

    integer :: j

    do j = 1, d1
    print*, m(j, :)
    end do 
  end subroutine prettyPrintMatrix

end module write_to_screen
