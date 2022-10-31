# plot and analyze total surface area
# interested to know, how variable the total surface area is over different timesteps
# output surface area info for each run
# output to runN_surface_data.txt
# 

import numpy as np
import matplotlib.pyplot as plt


runs = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
steps = list(range(0, 1120000, 160000))


for run in runs:
	area_data = [] # total_surface_area, average_width
	timestep_out = open('run_' + str(run) + '/timestep_center_data.dat', "a")
	timestep_out.seek(0) 
	timestep_out.truncate()
	
	for step in steps:
		
		data_file = 'run_' + str(run) + '/timesteps/' + str(step) + '.dat'
		data = np.loadtxt(data_file)
		data = np.transpose(data)
	
	
		# average width of ibeam at center
		widths = data[5]
		average_width = np.average(widths)
		std_width = np.std(widths)
		
		centers = (data[4]+data[3])/2
		average_center = np.average(centers)		
		
		area_data.append([step, average_width, std_width, average_center])
		timestep_out.write(str(step)+'\t'+'\t'+str(average_width)+'\t'+str(std_width)+'\t'+str(average_center)+'\n')

	# Print run averages
	# average total surface area
	avg_width = np.average(area_data, axis=0)[1]
	std_width = np.std(area_data, axis=0)[1]
	avg_std_width = np.average(area_data, axis=0)[2]
	avg_center = np.average(area_data, axis=0)[3]
	print (area_data)
	with open('run_' + str(run) + '/run' + str(run) + '_center_data.dat', "w") as output:
		output.write(str(avg_width) + '\t' + str(avg_std_width) + '\t' + str(avg_center) + '\n')
