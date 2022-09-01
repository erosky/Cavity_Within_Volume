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

DIR=../Box_Setup


for timestep in {45000..47500..500}
do
	output=core/$timestep.dat
	truncate -s 0 $output
	sed -i -E "22 s/[0-9]+/$timestep/" find_core.awk
	for zbin in {0..35..1}
	do
		sed -i -E "23 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$zbin/" find_core.awk
		./find_core.awk $DIR/eq.Ibeam_240K.dump >> $output
	done
done

