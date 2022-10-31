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
		sed -i -E "22 s/[0-9]+/$timestep/" find_surface.awk
		for ybin in 0 3.066 6.132 9.198 12.264 15.33 18.396 21.462 24.528 27.594 30.66 33.726 36.792 39.858
		do
			sed -i -E "21 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$ybin/" find_surface.awk
			./find_surface.awk ../Constant_Cooling/run_$RUN/prod.ibeam_cooling_$RUN.dump >> ./run_$RUN/timesteps/$timestep.dat
		done
	done
done

# make a file that is RUN, TOP_SURFACE_AREA, BOTTOM_SURFACE_AREA, TOTAL_SURFACE_AREA

