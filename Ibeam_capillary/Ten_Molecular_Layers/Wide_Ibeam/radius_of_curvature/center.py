# plot and analyze total surface area
# output surface area info for all runs
# output to 8layer_surface_data.txt


import numpy as np
import matplotlib.pyplot as plt


runs = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
area_data = [] # total_surface_area, surface_area_std

for run in runs:

	data_file = 'run_' + str(run) + '/run' + str(run) + '_center_data.dat'
	data = np.loadtxt(data_file)
	data = np.transpose(data)
	print(data)

	area_data.append(data)

# Print run averages
# average total surface area
avg_width = np.average(area_data, axis=0)[0]
width_std = np.average(area_data, axis=0)[1]
avg_center = np.average(area_data, axis=0)[2]
print (area_data)
with open('10layer_center_data.txt', "w") as output:
	output.write(str(avg_width) + '\t' + str(width_std) + '\t' + str(avg_center))
