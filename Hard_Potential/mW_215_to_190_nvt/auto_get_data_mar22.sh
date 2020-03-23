#!/bin/bash


# extract data from dump files using the ice_ratio.awk script


for VARIABLE in 0
do
	echo $VARIABLE
	mkdir analysis/run_$VARIABLE

	./ice_ratio_215.awk run_$VARIABLE/prod.hardcavity_freeze_nvt_$VARIABLE-215-190.dump > analysis/run_$VARIABLE/ice_ratio.dat

	# make plot of ice ratio, raw data
	gnuplot -e "set terminal png size 2000,600; \
	    set output 'analysis/run_$VARIABLE/ice_ratio_raw.png'; \
            set title 'Ice Ratio vs. Temperature, Hard Cavity NVT, cooling at 0.5K/ns'; \
            set ylabel 'N ice / N total'; \
            set xlabel 'Temp (K)'; \
            set style data lines; \
            set xrange [215:190] reverse; \
            set xtics 190,2; \
            plot 'analysis/run_$VARIABLE/ice_ratio.dat' using 3:7"
	
	# get running average of ice_ratio
	~/Freezing_Simulations/Cavity_Within_Volume/running_avg.awk analysis/run_$VARIABLE/ice_ratio.dat > analysis/run_$VARIABLE/ice_ratio_smooth.dat

	# plot ice ratio
	python3 ~/Freezing_Simulations/Cavity_Within_Volume/find_freezing_temp.py analysis/run_$VARIABLE/

	# plot data from log file
	./make_gnuplots.sh $VARIABLE
	

done




