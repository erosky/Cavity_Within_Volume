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



mkdir ./profile
for timestep in {45000..47500..500}
#for timestep in {0..1920000..320000}
do
	mkdir ./profile/$timestep
	sed -i -E "22 s/[0-9]+/$timestep/" find_density.awk
	for zbin in {0..36..2}
	do
		truncate -s 0 ./profile/$timestep/$zbin.dat
		sed -i -E "24 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$zbin/" find_density.awk
		for ybin in 0.0 3.11004 6.22008 9.33012 12.44016 15.5502 18.66024 21.77028 24.88032 \
		27.99036 31.1004 34.21044 37.32048
		do
			sed -i -E "21 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$ybin/" find_density.awk
			./find_density.awk $DIR/eq.Ibeam_240K.dump >> ./profile/$timestep/$zbin.dat
		done
	done
done

