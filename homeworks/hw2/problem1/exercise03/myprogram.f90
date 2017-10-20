program firstprogramm 

implicit none

integer :: i,j,k
real :: x,y,z


x = 3.16
y = cos(x)
z= x + y

i = 3
j = i**2
k = i-j


open(1, file='out.txt')
write(1,*) 'The value of x is',x,'the value of y is',y,'the value of z is',z
write(1,*) 'The value of i is',i,'the value of j is',j,'the value of k is',k
close(1)

end program firstprogramm 
