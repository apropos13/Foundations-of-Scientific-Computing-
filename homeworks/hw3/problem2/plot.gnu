set title "Convergence Plot"
set label 1 "We converge to the root (-0.9045) as we increase n"
set label 1 at graph 0.5, 0.85 tc lt 3
set style data linespoints
set ylabel "x-values"
set xlabel "Number of Iterations"
#set yrange [0:200]
#
set key autotitle columnhead
plot 'rootFinder_newton.dat' title "Root finding for Function type 2"
#