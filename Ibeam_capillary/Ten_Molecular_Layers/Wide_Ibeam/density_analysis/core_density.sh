#!/bin/bash

DIR=../Constant_Cooling_240K

output=core_density/timesteps.dat
truncate -s 0 $output

for run in 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
do

	echo $run
	sed -i -E "7 s/[0-9]+/$run/" core_density.awk
	for timestep in {0..400000..4000}
	do
		sed -i -E "6 s/[0-9]+/$timestep/" core_density.awk
		./core_density.awk $DIR/run_$run/prod.ibeam_cooling_$run.dump >> $output
	done
done
