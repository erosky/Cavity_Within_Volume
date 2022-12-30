import matplotlib.pyplot as plt
import matplotlib.image as image
import numpy as np

backx = 2475
dimx = 157.504
backz = 786
dimz = 39.85034643610105 + 10.062000000000001

graphite = image.imread('graphite_backdrop.png')
print (graphite.shape)

surface_file = '../../interface_analysis/10layer_surface_data.txt'
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
plt.imshow(graphite, extent=(0, dimx, 0, dimz))
#plt.plot([109, 103.9, 109], [38.6, 25, 11], color = 'green')
sctr = plt.scatter(freezing_data[1], freezing_data[3], 500.0, alpha=0.5, c=freezing_data[0], cmap='winter', norm=norm)
#ax.hist(freezing_data[0], density=False, bins=10, histtype='step')
plt.axvspan(left_lower, left_upper, alpha=0.5, color='red')
plt.axvspan(right_lower, right_upper, alpha=0.5, color='red')

bar = fig.colorbar(sctr,orientation='horizontal')
bar.set_label('Freezing temperature')
plt.xlabel(' X-dimension of simulation box (Angstroms)')
plt.ylabel(' Z-dimension of simulation box (Angstroms)')

plt.savefig('xz_freezing_locations.png', dpi=1000)
