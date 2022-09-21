# plot and analyze total surface area
# output surface area info for all runs
# output to 8layer_surface_data.txt


import numpy as np
import matplotlib.pyplot as plt


runs = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
area_data = [] # total_surface_area, surface_area_std

for run in runs:

	data_file = 'run_' + str(run) + '/run' + str(run) + '_surface_data.dat'
	data = np.loadtxt(data_file)
	data = np.transpose(data)

	area_data.append(data)

# Print run averages
# average total surface area
avg_area = np.average(area_data, axis=0)[0]
std_area = np.std(area_data, axis=0)[0]
avg_std = np.average(area_data, axis=0)[1]
max_area = avg_area + avg_std
min_area = avg_area - avg_std
avg_width = np.average(area_data, axis=0)[2]
width_std = np.average(area_data, axis=0)[3]
avg_center = np.average(area_data, axis=0)[4]
print (avg_area, std_area)
print (area_data)
with open('8layer_surface_data.txt', "w") as output:
	output.write(str(avg_area) + '\t' + str(std_area) + '\t' + str(avg_std) + '\t' + str(max_area) + '\t' + str(min_area) + '\t' + str(avg_width) + '\t' + str(width_std) + '\t' + str(avg_center))
