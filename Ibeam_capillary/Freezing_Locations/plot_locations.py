import matplotlib.pyplot as plt
import numpy as np

surface_file8 = '8layer_surface_data.txt'
surface_data8 = np.loadtxt(surface_file8)
avg_width8 = surface_data8[5]
std_width8 = surface_data8[6]
avg_center8 = surface_data8[7]

freezing_file8 = '8layer_freezing_coordinates.dat'
freezing_data8 = np.loadtxt(freezing_file8)
freezing_data8 = np.transpose(freezing_data8)


max_width8 = avg_width8 + std_width8
min_width8 = avg_width8 - std_width8

left_lower8 = avg_center8 - max_width8/2
left_upper8 = avg_center8 - min_width8/2
right_lower8 = avg_center8 + min_width8/2
right_upper8 = avg_center8 + max_width8/2


surface_file10 = '10layer_surface_data.txt'
surface_data10 = np.loadtxt(surface_file10)
avg_width10 = surface_data10[5]
std_width10 = surface_data10[6]
avg_center10 = surface_data10[7]

freezing_file10 = '10layer_freezing_coordinates.dat'
freezing_data10 = np.loadtxt(freezing_file10)
freezing_data10 = np.transpose(freezing_data10)


max_width10 = avg_width10 + std_width10
min_width10 = avg_width10 - std_width10

left_lower10 = avg_center10 - max_width10/2
left_upper10 = avg_center10 - min_width10/2
right_lower10 = avg_center10 + min_width10/2
right_upper10 = avg_center10 + max_width10/2


freezing_data = np.concatenate((freezing_data10, freezing_data8),axis=1)

norm = plt.Normalize(min(freezing_data[0]), max(freezing_data[0]))
scale = []
for f in freezing_data[0]:
	scale.append(f**10 * 500)
print(scale)	


fig = plt.figure()
sctr = plt.scatter(freezing_data[1], freezing_data[2], 1500.0, alpha=0.5, c=freezing_data[0], cmap='winter', norm=norm)
#ax.hist(freezing_data[0], density=False, bins=10, histtype='step')
plt.axvspan(left_lower10, left_upper8, alpha=0.5, color='red')
plt.axvspan(right_lower8, right_upper10, alpha=0.5, color='red')
bar = fig.colorbar(sctr)
bar.set_label('Freezing temperature')

plt.xlabel(' X-dimension of simulation box (Angstroms)')
plt.ylabel(' Y-dimension of simulation box (Angstroms)')

plt.savefig('xy_freezing_locations.png', dpi=1000)

