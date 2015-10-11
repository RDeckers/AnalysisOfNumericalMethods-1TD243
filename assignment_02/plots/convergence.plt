if (exists("term_type"))  set terminal pngcairo
if (exists("output_file")) set output output_file
set xrange [0.0008: 0.07]
set title "Convergence"
set key right outside
set xlabel "h"
set ylabel "||dV||"
set datafile separator ","
set logscale xy
set grid xtics ytics mxtics mytics lc rgb "#bbbbbb" lw 1 lt 0
set format x "%1.0e"
set format y "%1.0e"
plot \
 2*10**2*x**2 title "" lt -1,\
 4*10**2*x**3 title "" lt -1,\
 9*10**3*x**4 title "" lt -1,\
 'plots/convergence.csv' using 1:2 w lp title "2nd" lt 1,\
 'plots/convergence.csv' using 1:3 w lp title "4th" lt 2,\
 'plots/convergence.csv' using 1:4 w lp title "6th" lt 3
 if (exists("output_file")) unset output
