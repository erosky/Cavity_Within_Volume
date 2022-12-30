import matplotlib.pyplot as plt
import numpy as np

surface_file = '../../interface_analysis/6layer_surface_data.txt'
surface_data = np.loadtxt(surface_file)
avg_width = surface_data[5]
std_width = surface_data[6]
avg_center = surface_data[7]

freezing_file = 'freezing_coordinates.dat'
freezing_data = np.loadtxt(freezing_file)
freezing_data = np.transpose(freezing_data)


max_width = avg_width + std_width
min_width = avg_width - std_width

left_lower = avg_center - max_width/2
left_upper = avg_center - min_width/2
right_lower = avg_center + min_width/2
right_upper = avg_center + max_width/2


norm = plt.Normalize(min(freezing_data[0]), max(freezing_data[0]))
scale = []
for f in freezing_data[0]:
	scale.append(f**10 * 500)
print(scale)	


fig = plt.figure()
sctr = plt.scatter(freezing_data[1], freezing_data[2], 1000.0, alpha=0.5, c=freezing_data[0], cmap='winter', norm=norm)
#ax.hist(freezing_data[0], density=False, bins=10, histtype='step')
plt.axvspan(left_lower, left_upper, alpha=0.5, color='red')
plt.axvspan(right_lower, right_upper, alpha=0.5, color='red')

bar = fig.colorbar(sctr)
bar.set_label('Freezing temperature')

plt.show()

