########################################################################################
#                       Makefile for LU DECOMPOSITION code
#                Written by Panos Karagiannis, AMS 209, UCSC
########################################################################################

FC	= gfortran

FFLAGS_DEBUG = -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=1 -g -fcheck=all -fbacktrace

FFLAGS_OPT = -ggdb -O3 -fdefault-real-8 -fdefault-double-8 -ffree-line-length-none -Wuninitialized

EXE_FILE = linear_solve.exe

OBJS =	linear_solve.o \
	read_data.o\
	write_to_screen.o  \
	LU_decomp.o \
	forward_solve.o \
	backward_solve.o \
	write_data.f90

.PHONY: clean
########################################################################################
#COMPILING AND LINKING USING GENERIC SUFFIX RULE FOR f90

$(EXE_FILE) : $(OBJS)
	@$(FC) $(FFLAGS_OPT) $(OBJS) -o $(EXE_FILE)
	@echo "code is now linking..."

#LET'S APPLY GENERIC SUFFIX RULE HERE FOR FORTRAN 90

# method 1 using generic suffix rule
#.SUFFIXES: 
#.SUFFIXES: .F90 .o
#.F90.o:
#	$(FC) $(FFLAGS_OPT) -c $<

# method 2 using inference rule
%.o: %.f90
	$(FC) $(FFLAGS_OPT) -c $<

#######################################################################################
#SOME USEFUL COMMANDS
clean:
	@rm -f *.o *.mod *~ rootFinder.exe *.dat

# debug: clean
debug: FFLAGS_OPT = $(FFLAGS_DEBUG)
debug: $(EXE_FILE)

#######################################################################################
#LET'S DEFINE SOME MODULE DEPENDENCIES!
linear_solve.o: read_data.o write_to_screen.o LU_decomp.o forward_solve.o backward_solve.o write_data.o
write_data.o : write_to_screen.o

#ftn_module.o : read_data.o

#findRootMethod_module.o : ftn_module.o read_data.o

#######################################################################################
