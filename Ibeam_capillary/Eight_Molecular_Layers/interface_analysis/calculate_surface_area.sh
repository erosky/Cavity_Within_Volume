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


BINW=3
YMAX=66

for RUN in 0
do
	echo $RUN
	mkdir run_$RUN
	for ybin in {0..$YMAX..$BINW}
	do
		sed -i -E "22 s/[0-9]+/$ybin/" find_surface.awk
		./find_surface.awk ../Constant_Cooling/run_$RUN/prod.ibeam_cooling_$RUN.dump >> ./run_$run/bin_$ybin.dat
	done
done
