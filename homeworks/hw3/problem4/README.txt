Details about how to run the code is included in the report.pdf file. 

For example for the first question type:
gfortran -g -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=1 -fcheck=all -fbacktrace buggy_code_1.f90 -o myprog1

valgrind --leak-check=full --dsymutil=yes --track-origins=yes ./myprog1 2> output_1