# Example: http://gnuplot.sourceforge.net/demo/timedat.html
# {/Symbol \260} is the degree symbol
set ylabel 'Temperature ({/Symbol \260}C)'
set xlabel "Time (dd.mm)"
set timefmt "%Y.%m.%d %H:%M"
set format x "%d.%m."
set xdata time
set key left
set terminal postscript eps colour enhanced
set output "daily-temps.eps"
set title "Daily temperatures of processor zone on host lost24"
plot "max-daily-temps.tsv" using 1:3 title 'Max temp' with linespoints, \
     "min-daily-temps.tsv" using 2:3 title 'Min temp' with linespoints

