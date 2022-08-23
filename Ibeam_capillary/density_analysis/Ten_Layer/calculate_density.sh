#!/bin/bash
#
# Calculate average surface area of carbon-water interface prior to freezing
# Input dump file
# Output a data file with the following:
# YBIN, N, XMIN, XMAX, BIN_VOLUME, BIN_DENSITY

# For each z-bin we want to know the average density
# -- for each z-bin, find the average densiy averaged over y-bin
# -- where the y-bin density is N_in_bin / bin_volume 
# -- where bin_volume = (max_x - min_x)*y_binw*z_binw
# -- the average density in that z-layer is the average density of all y-bins

DIR=../../Ten_Molecular_Layers


for RUN in 5
do
	echo $RUN
	mkdir run_$RUN
	for timestep in 0 320000 640000
	#for timestep in {0..1920000..320000}
	do
		mkdir run_$RUN/$timestep
		sed -i -E "22 s/[0-9]+/$timestep/" find_density.awk
		for zbin in 10.062 13.056 16.05 19.044 22.038 25.032 28.026 31.02 34.014 37.008
		do
			sed -i -E "24 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$zbin/" find_density.awk
			for ybin in 0 3.0406 6.0812 9.1218 12.1624 15.203 18.2436 21.2842 24.3248 27.3654 30.406 33.4466 \
			36.4872 39.5278 42.5684 45.609 48.6496 51.6902 54.7308 57.7714 60.812 63.8526 66.8932 69.9338
			do
				sed -i -E "21 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$ybin/" find_density.awk
				./find_density.awk $DIR/Constant_Cooling/run_$RUN/prod.ibeam_cooling_$RUN.dump >> ./run_$RUN/$timestep/$zbin.dat
			done
		done
	done
done

