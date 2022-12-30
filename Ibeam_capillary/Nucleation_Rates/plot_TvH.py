import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse
from scipy.optimize import curve_fit

pressures=[1, -500, -1000]
het24_temps = [228, 234.5, 241]
het23_temps = [232, 237.5]

ref = 227.8

# y-axis --> delta T above 1 atm, no interface
cap_T = [ref, 230.48, 231.75]
d_T = []
for t in cap_T:
	d_T.append(t-ref)
	
bounds= [4/2, 2.63/2, 2.55/2]





# x-axis --> 1/H
inv_H = [0, 333333333.333, 416666666.667]

# best fit of data
def linear(x,a,b):
	return a*x+b

popt, pcov = curve_fit(linear, inv_H, d_T, sigma=bounds)
print (popt)
print (pcov)


fit_H = [0, 333333333.333, 416666666.667, 500000000]
fit = []
for p in fit_H:
	fit.append(popt[0]*p+popt[1])


T_6 = [234-ref]
inv_6 = [555555555.556]
T6_low = [3.3/2]
T6_up = [3.3/2]

# 6 Layer Ibeam
c_6 = [-685, 235.67]
pres_max_6 = 370
pres_min_6 = 1000
pres_w_6 = 630
temp_h_6 = 6


# 8 Layer Ibeam
c_8 = [-475, 233]
pres_max_8 = 250
pres_min_8 = 700
pres_w_8 = 450
temp_h_8 = 4


# 10 Layer Ibeam
c_10 = [-500, 232]
pres_max_10 = 300
pres_min_10 = 700
pres_w_10 = 400
temp_h_10 = 4





a = plt.subplot(111)


plt.errorbar(inv_H[0], d_T[0], yerr=[bounds[0]], fmt='ko', capsize=3.0, label=r'h=$\infty$')
plt.errorbar(inv_H[1], d_T[1], yerr=[bounds[1]], fmt='gD', capsize=3.0, label='h=30 $\AA$')
plt.errorbar(inv_H[2], d_T[2], yerr=[bounds[2]], fmt='bD', capsize=3.0, label='h=24 $\AA$')
plt.errorbar(inv_6, T_6, yerr=[T6_low,T6_up], fmt='rD', fillstyle='none', capsize=3.0, label='h=18 $\AA$')

plt.errorbar(fit_H, fit, yerr=None, fmt='k--') 
#plt.errorbar(fit_H, fit, yerr=None, fmt='k--', label=r'Linear fit of slope $\Delta T \cdot h$') 

plt.text(0, 3, r'Slope $= 9.3$ K$\cdot$nm', fontsize = 10)

#plt.xlim(0, 0.2)
plt.ylim(-3, 11)
plt.xlabel(r'1/h (m$^{-1}$)')
plt.ylabel(r'$\Delta$T (K)')




#plt.legend(loc='upper left', bbox_to_anchor=(0.5, 1.05), ncol=1, fancybox=True, shadow=True)
plt.legend(loc='upper center', mode = "expand", ncol = 4)


plt.savefig('TvH_legend.png', dpi=1000)
