module read_data
  
  implicit none
  integer :: line_number
  real, dimension(:,:), allocatable, save :: A
  real, dimension(:), allocatable, save :: b

  contains

  subroutine get_lines()

    implicit none
    integer :: io

    open(12, file = 'b_1.dat', iostat=io)

    !initalize number of line
    line_number = 0
    do 
    read(12, *, iostat=io)

    if (io/=0) exit
    line_number = 1 + line_number !increment by one for each line

	   end do

	 close(12)   
  end subroutine get_lines

  
  subroutine read_init_files()

	  implicit none 
	  call get_lines()
	  !print *, 'number of lines is', line_number
	  allocate( b(line_number))
	  open(12, file = 'b_1.dat')
	  read(12, *) b
	  close(12)

	  allocate(A(line_number, line_number))
	  open(13, file = 'A_1.dat')
	  read(13, *) A
    A = transpose(A)
	  close(13)
  end subroutine read_init_files


end module read_data
