#!/bin/bash


# extract data from dump files using the ice_ratio.awk script


for VARIABLE in 0
do
	echo $VARIABLE
	mkdir analysis/run_$VARIABLE

	./ice_ratio_215.awk run_$VARIABLE/prod.freecavity_constant_215-215.dump > analysis/run_$VARIABLE/ice_ratio.dat

	# make plot of ice ratio, raw data
	gnuplot -e "set terminal png size 2000,600; \
	    set output 'analysis/run_$VARIABLE/ice_ratio_raw.png'; \
            set title 'Ice Ratio vs. Temperature, -1000 atm, cooling at 0.5K/ns'; \
            set ylabel 'N ice / N total'; \
            set xlabel 'Temp (K)'; \
            set style data lines; \
            set xrange [215:190] reverse; \
            set xtics 190,2; \
            plot 'analysis/run_$VARIABLE/ice_ratio.dat' using 3:7"
	

	# plot data from log file
	./make_gnuplots.sh $VARIABLE
	

done




