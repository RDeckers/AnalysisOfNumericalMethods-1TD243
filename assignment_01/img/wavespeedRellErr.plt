if (exists("term_type")) set term term_type
if (exists("output_file")) set output output_file
set xrange [0: pi]
#set logscale y
set title "Relative Error"
set xlabel "$h\\omega$"
set ylabel "$\\frac{V_{\\omega}-1}{1}$"
plot 1-(8*sin(x)-sin(2*x))/(6*x) title '4th order', 1-sin(x)/x title '1st order'
if (exists("output_file")) unset output
