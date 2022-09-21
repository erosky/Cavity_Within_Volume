# plot and analyze total surface area
# interested to know, how variable the total surface area is over different timesteps

import numpy as np
import matplotlib.pyplot as plt
import os
import pandas as pd

output = "24A_x_profile.dat"

timesteps = list(range(25000, 47500, 500))
xbin_edges = list(range(40, 122, 2))
print (len(xbin_edges))


## ybin columns are labels for data in each zbin dataframe
xbin_columns = ['XBIN', 'N', 'XBIN_DENSITY']

data = []
## Load the data structure outlined above
##

for step in timesteps:
	xbin_data = np.loadtxt('./x_profile/'+str(step)+'.dat')
	xbin_data = xbin_data.transpose()
	data.append(xbin_data[2])


avg_data = np.mean(data, axis=0)
print(len(avg_data))	

f = open(output, 'w')
for bin in range(41):
	print (xbin_edges[bin])
	f.write(str(xbin_edges[bin]) + '\t' + str(avg_data[bin]) + '\n')
f.close()

# Plot profile
plt.figure(1)
plt.plot(xbin_edges, avg_data)
plt.show()


##
##
'''
## Average over every timestep to profuce a new data structure. The new data structure is a dictionary of time averaged zbin_data
## zbin_edges are the keys to time_avg_dict
time_avg_dict = {}

# Theres gonna be a dictionary with eight keys, each array inside each key must be averaged over the other timesteps

for zbin in zbin_edges:
	zbin_dict = {}
	time_avg_dict[zbin] = zbin_dict
	zbin_arrays = []
	for step in timesteps:
		zbin_arrays.append(timestep_dict[step][zbin])
	time_avg_data = np.average(zbin_arrays, axis=0)
	zbin_dict['dataframe'] = pd.DataFrame(time_avg_data, columns=ybin_columns)



## Now we will sum over the y-slices to add to the zbin_dict dictionaries
density_data = []
width_data = []
fraction_data = []

for zbin in zbin_edges:
	dataset = time_avg_dict[zbin]
	df = dataset['dataframe']
	N = df['N'].sum()
	V = df['YBIN_VOLUME'].sum()
	zbin_density = N/V
	avg_density = df['YBIN_DENSITY'].mean()
	avg_width = df['XWIDTH'].mean()
	# write data
	time_avg_dict[zbin]['N'] = N
	time_avg_dict[zbin]['density'] = zbin_density
	density_data.append(zbin_density)
	time_avg_dict[zbin]['avg_density'] = avg_density
	time_avg_dict[zbin]['fraction'] = N/N_total
	fraction_data.append(N/N_total)
	time_avg_dict[zbin]['width'] = avg_width
	width_data.append(avg_width)


print(time_avg_dict)
## zbin keys are the per z slice data options available in each z layer. They are the keys to each zbin_data_dict.
zbin_keys = ['dataframe', 'density', 'N', 'fraction', 'width']


## Plot the results
plt.figure(1)
plt.plot(zbin_edges, density_data)
plt.show()




'''



