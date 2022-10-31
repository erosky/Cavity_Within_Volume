#!/bin/bash
#
# Calculate average surface area of carbon-water interface prior to freezing
# Input dump file
# Output a data file with the following:
# RUN, TOP_SURFACE_AREA, BOTTOM_SURFACE_AREA, TOTAL_SURFACE_AREA

# Workflow:
# -- define slices
# -- define z-layer
# Go through dumpfile (interface_area.awk)
# -- produce data file with surface area per timestep (every 50 timesteps)
# -- average over all timesteps to produce final file, exclude timesteps where ice ratio is above a certain threshold


for RUN in 4 5 6 7 8 9 10 11 12 13 14 15
do
	echo $RUN
	mkdir run_$RUN
	mkdir run_$RUN/timesteps
	for timestep in {0..1120000..160000}
	do
		truncate -s 0 ./run_$RUN/timesteps/$timestep.dat
		sed -i -E "22 s/[0-9]+/$timestep/" center.awk
		for ybin in 0.0 3.11004 6.22008 9.33012 12.44016 15.5502 18.66024 21.77028 24.88032 \
			27.99036 31.1004 34.21044 37.32048
		do
			sed -i -E "21 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$ybin/" center.awk
			./center.awk ../Constant_Cooling_240K/run_$RUN/prod.ibeam_cooling_$RUN.dump >> ./run_$RUN/timesteps/$timestep.dat
		done
	done
done

# make a file that is RUN, TOP_SURFACE_AREA, BOTTOM_SURFACE_AREA, TOTAL_SURFACE_AREA

