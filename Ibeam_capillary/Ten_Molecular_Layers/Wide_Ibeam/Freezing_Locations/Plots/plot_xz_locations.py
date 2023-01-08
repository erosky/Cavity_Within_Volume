import matplotlib.pyplot as plt
import matplotlib.image as image
import numpy as np
import matplotlib.patches as mpatches

backx = 2475
dimx = 157.504
backz = 786
dimz = 39.85034643610105 + 10.062000000000001

# Arc data
anglesR = np.linspace(3*np.pi/4, 5*np.pi/4, 20)
anglesL = np.linspace(-np.pi/4, np.pi/4, 20)

r_10 = 21.24
a_10 = 125.156
b_10 = 24.8
c_10 = 78.7
x_10 = [109, 103.9, 109]
y_10 = [38.6, 25, 11]

arc_xR_10 = r_10 * np.cos(anglesR) + a_10
arc_yR_10 = r_10 * np.sin(anglesR) + b_10
arc_xL_10 = r_10 * np.cos(anglesL) + (c_10 -(a_10-c_10))
arc_yL_10 = r_10 * np.sin(anglesL) + b_10

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


fig, ax = plt.subplots(constrained_layout=True)
plt.imshow(graphite, extent=(0, dimx, 0, dimz))
plt.axhspan(0, 10, alpha=0.5, color='tab:brown', hatch='xxx')
plt.axhspan(40, 50, alpha=0.5, color='tab:brown', hatch='xxx')
#plt.plot([109, 103.9, 109], [38.6, 25, 11], color = 'green')
sctr = plt.scatter(freezing_data[1], freezing_data[3], 1000.0, alpha=0.3, c=freezing_data[0], cmap='winter', norm=norm)
cheat = plt.scatter(-20, -20, 100.0, color='blue', alpha=0.5, label='Freezing locations')
#ax.hist(freezing_data[0], density=False, bins=10, histtype='step')
#plt.axvspan(left_lower, left_upper, alpha=0.5, color='red')
#plt.axvspan(right_lower, right_upper, alpha=0.5, color='red')
plt.plot(arc_xR_10, arc_yR_10, color = 'red', alpha=0.5, lw = 10)
plt.plot(arc_xL_10, arc_yL_10, color = 'red', alpha=0.5, lw = 10)

bar = fig.colorbar(sctr,orientation='horizontal')
bar.set_label('Freezing temperature')
plt.xlabel('x position ($\AA$)')
plt.ylabel('z position ($\AA$)')
plt.ylim([0,50])
plt.xlim([0,150])


handles, labels = plt.gca().get_legend_handles_labels()
patch = mpatches.Patch(facecolor='red', edgecolor='red', alpha=0.5, label='Air-water interface')  

handles.extend([patch])
plt.legend(loc='lower left', handles=handles)

ax.set_aspect('equal')


figure_size = plt.gcf().get_size_inches()
plt.gcf().set_size_inches(1.25 * figure_size)
plt.savefig('xz_freezing_locations.png', dpi=1000)
