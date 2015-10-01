if (exists("term_type")) set term term_type
if (exists("output_file")) set output output_file
set xrange [0: pi]
set title "Wavespeed"
set xlabel "$h\\omega$"
set ylabel "$V_{\\omega}$"
plot (8*sin(x)-sin(2*x))/(6*x) title '4th order', sin(x)/x title '1st order'
if (exists("output_file")) unset output
