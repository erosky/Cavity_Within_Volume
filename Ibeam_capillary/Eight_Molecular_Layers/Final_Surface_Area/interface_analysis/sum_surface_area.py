# plot and analyze total surface area
# interested to know, how variable the total surface area is over different timesteps
# output surface area info for each run
# output to runN_surface_data.txt
# 

import numpy as np
import matplotlib.pyplot as plt


runs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
steps = list(range(0, 1120000, 160000))


for run in runs:
	area_data = [] # total_surface_area, average_width
	timestep_out = open('run_' + str(run) + '/timestep_surface_data.dat', "a")
	timestep_out.seek(0) 
	timestep_out.truncate()
	
	for step in steps:
		
		data_file = 'run_' + str(run) + '/timesteps/' + str(step) + '.dat'
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
		
		centers_top = (data[4]+data[3])/2
		centers_bot = (data[6]+data[5])/2
		centers = np.concatenate((centers_top, centers_bot))
		average_center = np.average(centers)		
		
		area_data.append([step, total_A, average_width, std_width, average_center])
		timestep_out.write(str(step)+'\t'+str(total_A)+'\t'+str(average_width)+'\t'+str(std_width)+'\t'+str(average_center)+'\n')

	# Print run averages
	# average total surface area
	avg_area = np.average(area_data, axis=0)[1]
	std_area = np.std(area_data, axis=0)[1]
	avg_width = np.average(area_data, axis=0)[2]
	std_width = np.std(area_data, axis=0)[2]
	avg_std_width = np.average(area_data, axis=0)[3]
	avg_center = np.average(area_data, axis=0)[4]
	print (avg_area, std_area)
	print (area_data)
	with open('run_' + str(run) + '/run' + str(run) + '_surface_data.dat', "w") as output:
		output.write(str(avg_area) + '\t' + str(std_area) + '\t' + str(avg_width) + '\t' + str(avg_std_width) + '\t' + str(avg_center) + '\n')
