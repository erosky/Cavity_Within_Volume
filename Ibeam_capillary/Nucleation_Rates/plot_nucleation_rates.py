import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse

pressures=[1, -500, -1000]

het24_temps = [228, 234.5, 241]
het23_temps = [232, 237.5]

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


ells = [Ellipse((c_6[0], c_6[1]), pres_w_6, temp_h_6, 0, fc="r"), 
	Ellipse((c_8[0], c_8[1]), pres_w_8, temp_h_8, 0, fc="g"),
	Ellipse((c_10[0], c_10[1]), pres_w_10, temp_h_10, 0, fc="b")]



a = plt.subplot(111)

plt.plot(c_6[0], c_6[1], 'ro', label=r'18 angstrom capillary $Jhet=10^{24}$ m$^{-2}$s$^{-1}$') 
plt.plot(c_8[0], c_8[1], 'go', label=r'24 angstrom capillary $Jhet=10^{24}$ m$^{-2}$s$^{-1}$') 
plt.plot(c_10[0], c_10[1], 'bo', label=r'30 angstrom capillary $Jhet=10^{24}$ m$^{-2}$s$^{-1}$') 

plt.plot([1,-500], het23_temps, '--', label=r'MLmW $Jhet=10^{23}$ m$^{-2}$s$^{-1}$') 
plt.plot(pressures, het24_temps, '--', label=r'MLmW $Jhet=10^{24}$ m$^{-2}$s$^{-1}$') 

for e in ells:
    e.set_clip_box(a.bbox)
    e.set_alpha(0.2)
    a.add_artist(e)

plt.xlim(0, -1050)
plt.ylim(225, 245)
plt.xlabel('Pressure (atm)')
plt.ylabel('Temperature (K)')
a.invert_xaxis()

plt.legend(loc='upper center', bbox_to_anchor=(0.5, 1.05),
          ncol=2, fancybox=True, shadow=True, fontsize='small')

plt.savefig('Ibeam_freezing_rates.png', dpi=1000)
plt.show()
