#!/usr/bin/python
# 1 atm
# take list of runs as input
# ex.
# python3 plot_all_runs.py 0 1 2 3 4 5 6

import sys
import numpy as np
import matplotlib.pyplot as plt

N_args = len(sys.argv)
inputs = sys.argv
runs = inputs[1:]


# create file for freezing temperatures in analysis folder
# data: RUN TEMP
temperature_file = 'analysis/freeze_temperatures_halfthresh_hardcavity_nvt_mW.dat'
f = open(temperature_file, "w")


# load data
data_dictionary = {}
freeze_temperatures = []

for run in runs:
	
	data_file = 'analysis/run_' + run + '/ice_ratio_smooth.dat'
	data = np.loadtxt(data_file)
	data = np.transpose(data)
	gradient = np.gradient(data[2])
	data = np.append(data, [gradient], axis=0)
	data_dictionary[run] = data

	peak = np.argwhere(data[2]>0.50)
	peak = peak[0][0]
	print (peak)
	freeze = data[1][peak]
	freeze_temperatures = np.append(freeze_temperatures, freeze)
	f.write(run + '\t' + str(freeze) + '\n')

	# time = data[0]
	# temp = data[1]
	# ice = data[2]
	# gradient = data[3]


# plot all trials on same plot, highlight freezing temperature
# calculate average freezing temperature and standard deviation
T_sum = 0
S_sum = 0

for T in freeze_temperatures:
	T_sum = T_sum + T
T_avg = T_sum/len(freeze_temperatures)

for T in freeze_temperatures:
	S_sum = S_sum + (T - T_avg)**2
S_avg = (S_sum/len(freeze_temperatures))**(0.5)


# create file for plot of all runs
all_runs_plot = 'analysis/all_runs_halfthresh_hardcavity_nvt_mW.png'

plt.figure(1)
plt.xlim(215,190)
plt.ylim(0,0.9)
plt.title('Freezing, NVT with 1.38nm "hard" cavity, mW Model')
plt.xlabel('Temperature (K)')
plt.ylabel('N ice / N total')
for run in runs:
	temp = data_dictionary[run][1]
	ice = data_dictionary[run][2]
	peak = np.argwhere(ice>0.50)
	peak = peak[0]
	plt.plot(temp, ice)
	plt.stem([temp[peak]], [ice[peak]], linefmt='C0:', markerfmt='C0.')
	plt.errorbar(T_avg, 0, xerr=S_avg, fmt='rd', uplims=True, lolims=True)
plt.savefig(all_runs_plot)


# plot gradients
all_gradients_plot = 'analysis/all_gradients_halfthresh_hardcavity_mW.png'

plt.figure(2)
plt.xlim(215,190)
plt.title('Freezing at NVT with 1.38nm "hard" cavity, mW Model')
plt.xlabel('Temperature (K)')
plt.ylabel('Rate of change for (N ice / N total)')
for run in runs:
	temp = data_dictionary[run][1]
	gradient = data_dictionary[run][3]
	ice = data_dictionary[run][2]
	peak = np.argwhere(ice>0.50)
	peak = peak[0]
	plt.plot(temp, gradient)
	plt.plot([temp[peak]], [gradient[peak]], 'k.')
	#plt.stem([temp[peak]], [gradient[peak]], linefmt='k:', markerfmt='k.', bottom=-0.01)
plt.savefig(all_gradients_plot)


# Write temp data to file
f.write('\n\nAverage freezing temperature: ' + str(T_avg) + '\nSigma: ' + str(S_avg))


# close data file
f.close()




