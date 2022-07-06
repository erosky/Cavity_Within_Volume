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


mkdir timesteps
for timestep in {30000..50000..5000}
do
	sed -i -E "22 s/[0-9]+/$timestep/" find_surface.awk
	for ybin in 0 3.07725 6.1545 9.23175 12.309 15.38625 18.4635 21.54075 24.618 27.69525 30.7725 33.84975 36.927 40.00425 43.0815 46.15875 49.236 52.31325 55.3905 58.46775 61.545 64.62225 67.6995 70.77675 73.854 76.93125
	do
		sed -i -E "21 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$ybin/" find_surface.awk
		./find_surface.awk ../eq.Ibeam_235K.dump >> ./timesteps/$timestep.dat
	done
done

# make a file that is RUN, TOP_SURFACE_AREA, BOTTOM_SURFACE_AREA, TOTAL_SURFACE_AREA

