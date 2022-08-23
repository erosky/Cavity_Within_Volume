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


for RUN in 4 5 6 7 8 9 10
do
	echo $RUN
	mkdir run_$RUN
	mkdir run_$RUN/timesteps
	for timestep in {0..1120000..160000}
	do
		sed -i -E "22 s/[0-9]+/$timestep/" find_surface.awk
		for ybin in 0.0 3.11004 6.22008 9.33012 12.44016 15.5502 18.66024 21.77028 24.88032 \
			27.99036 31.1004 34.21044 37.32048 40.43052 43.54056 46.6506 49.76064 52.87068 55.98072 \
			59.09076 62.2008 65.31084 68.42088 71.53092 74.64096 77.751
		do
			sed -i -E "21 s/([0-9]+\.?[0-9]*)|([0-9]*\.[0-9]+)/$ybin/" find_surface.awk
			./find_surface.awk ../Constant_Cooling/run_$RUN/prod.ibeam_cooling_$RUN.dump >> ./run_$RUN/timesteps/$timestep.dat
		done
	done
done

# make a file that is RUN, TOP_SURFACE_AREA, BOTTOM_SURFACE_AREA, TOTAL_SURFACE_AREA

