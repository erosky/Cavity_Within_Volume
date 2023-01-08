import matplotlib.pyplot as plt
import numpy as np
import matplotlib.patches as mpatches

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


# Create heatmap 2d array 5x5
nrows = 1
ncols = 12
(x, x_step) = np.linspace(left_lower10, right_upper10, num=ncols+1, retstep=True)
(y, y_step) = np.linspace(min(freezing_data[2]), max(freezing_data[2]), num=nrows+1, retstep=True)
print(min(freezing_data[2]))
print(max(freezing_data[2]))

N_array = []
y_min = min(freezing_data[2])
y_max = max(freezing_data[2])
for col in np.arange(ncols):
	n_events = 0
	x_min = x[col]
	x_max = x[col+1]
	for i in np.arange(len(freezing_data[0])):
		if ((freezing_data[1][i]>=x_min) & (freezing_data[1][i]<x_max)):
			n_events = n_events+1
	N_array.append(n_events)

print (N_array)

half_prob_array = np.add(N_array[0:6], N_array[11:5:-1])
print(half_prob_array)
full_prob_array = np.concatenate([half_prob_array, np.flip(half_prob_array)])
print(full_prob_array)

prob_array=[]
for N in full_prob_array:
	prob = N/(len(freezing_data[0])*x_step)
	prob_array.append(prob)
	
print (prob_array)
x_array = []
y_array = []

for i in np.arange(len(x)-1):
	x_array.append(x[i]+x_step/2)
for i in np.arange(len(y)-1):
	y_array.append(y[i]+y_step/2)


fig, ax = plt.subplots(constrained_layout=True)
sctr = plt.scatter(freezing_data[1], freezing_data[2], 1250.0, alpha=0.3, c=freezing_data[0], cmap='winter', norm=norm)
cheat = plt.scatter(-20, -20, 100.0, color='blue', alpha=0.5, label='Freezing locations')
plt.axvspan(left_lower10, left_upper8, alpha=0.5, color='red')
plt.axvspan(right_lower8, right_upper10, alpha=0.5, color='red')
plt.axvspan(0, left_lower10, alpha=0.5, color='tab:brown', hatch='xxx')
plt.axvspan(right_upper10, 150, alpha=0.5, color='tab:brown', hatch='xxx')
plt.ylim([-10,40])
plt.xlim([0,150])

bar = fig.colorbar(sctr,orientation='horizontal')
bar.set_label('Freezing temperature')


plt.xlabel('x position ($\AA$)')
plt.ylabel('y position ($\AA$)')

handles, labels = plt.gca().get_legend_handles_labels()
patch = mpatches.Patch(facecolor='red', edgecolor='red', alpha=0.5, label='Air-water interface')  

handles.extend([patch])
plt.legend(loc='lower left', handles=handles)

ax.set_aspect('equal')

figure_size = plt.gcf().get_size_inches()
plt.gcf().set_size_inches(1.25 * figure_size)

plt.savefig('xy_fancy.png', dpi=1000)

'''
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
'''

