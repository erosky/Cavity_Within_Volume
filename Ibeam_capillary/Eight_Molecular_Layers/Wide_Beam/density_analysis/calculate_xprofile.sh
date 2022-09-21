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


for timestep in {25000..47500..500}
do
	output=x_profile/$timestep.dat
	truncate -s 0 $output
	sed -i -E "22 s/[0-9]+/$timestep/" find_xprofile.awk
	for xbin in {40..120..2}
	do
		sed -i -E "23 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$xbin/" find_xprofile.awk
		./find_xprofile.awk $DIR/eq.Ibeam_240K.dump >> $output
	done
done

