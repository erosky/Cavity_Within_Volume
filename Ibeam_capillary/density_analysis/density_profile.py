# plot and analyze total surface area
# interested to know, how variable the total surface area is over different timesteps

import numpy as np
import matplotlib.pyplot as plt
import os
import pandas as pd

eight = np.loadtxt('Eight_Layer/average_profile.dat')
ten = np.loadtxt('Ten_Layer/average_profile.dat')

#eight = np.transpose(eight_data)
#ten = np.transpose(ten_data)

print(eight)

## Plot the results
plt.figure(1)
plt.plot(eight[0], eight[1], 'o--', label="24A thick")
plt.plot(ten[0], ten[1], 'o--', label="30A thick")
plt.legend()
plt.show()








