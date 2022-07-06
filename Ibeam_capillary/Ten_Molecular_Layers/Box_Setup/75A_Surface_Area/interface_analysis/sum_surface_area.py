# plot and analyze total surface area
# interested to know, how variable the total surface area is over different timesteps

import numpy as np
import matplotlib.pyplot as plt

steps = list(range(30000, 45000, 5000))
area_data = [] # total_surface_area, average_width

for step in steps:
	data_file = 'timesteps/' + str(step) + '.dat'
	data = np.loadtxt(data_file)
	data = np.transpose(data)
	
	# average total area of interface
	total_A = sum(data[9])
	
	# average width of ibeam at interface
	widths_top = data[4]-data[3]
	widths_bot = data[6]-data[5]
	widths = np.concatenate((widths_top, widths_bot))
	average_width = np.average(widths)
	std_width = np.std(widths)
	
	area_data.append([total_A, average_width, std_width])

# Print averages
# average total surface area
avg_area = np.average(area_data, axis=0)
std_area = np.std(area_data, axis=0)
print (avg_area, std_area)
print (area_data)
