! to run the program: 
! gf pi.f90 -o myprogram && ./myprogram
! where we define: alias gf 'gfortran -Wall -Wextra -fPIC -fmax-errors=1 -g -fcheck=all -fbacktrace -fdefault-real-8 -fdefault-double-8'
program piprogram 

implicit none

integer ::  i
real (kind=8) :: pi, x, f1, f2, f3, f4, total, threshold
pi = acos(-1.d0)
x = 0.d0
threshold = 1.e-16
do 
f1 = 4. / (8*i + 1)
f2 = 2. / (8*i + 4)
f3 = 1. / (8*i + 5)
f4 = 1. / (8*i + 6)

total = f1 - f2 - f3 - f4

x = x + (1./16.) ** (i) * total
if (pi - x < threshold) then
print *, 'At i=',i,'the approximation is:= ',x
exit
end if

i = i+1

end do


end program piprogram 