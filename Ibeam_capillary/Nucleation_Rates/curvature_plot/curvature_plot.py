
import matplotlib.pyplot as plt
import matplotlib.image as image
import numpy as np

from numpy import sin, cos, pi, linspace


dimx = 157.504
dimz_full = 39.85034643610105
dimz_10 = 39.85
dimz_8 = 33.92
dimz_6 = 26.85


im_6 = image.imread('setup6L.png')
im_8 = image.imread('setup8L.png')
im_10 = image.imread('setup10L.png')

anglesR = linspace(3*pi/4, 5*pi/4, 20)
anglesL = linspace(-pi/4, pi/4, 20)

# 10 Layer data
r_10 = 21.24
a_10 = 125.156
b_10 = 24.8
c_10 = 78.7
x_10 = [109, 103.9, 109]
y_10 = [38.6, 25, 11]

arc_xR_10 = r_10 * cos(anglesR) + a_10
arc_yR_10 = r_10 * sin(anglesR) + b_10
arc_xL_10 = r_10 * cos(anglesL) + (c_10 -(a_10-c_10))
arc_yL_10 = r_10 * sin(anglesL) + b_10

# 8 Layer data
r_8 = 26.4
a_8 = 131
b_8 = 22
c_8 = 78.7
x_8 = [107.06, 104.6, 107.06]
y_8 = [33, 22, 11]

arc_xR_8 = r_8 * cos(anglesR) + a_8
arc_yR_8 = r_8 * sin(anglesR) + b_8
arc_xL_8 = r_8 * cos(anglesL) + (c_8 -(a_8-c_8))
arc_yL_8 = r_8 * sin(anglesL) + b_8


# 6 Layer data
r_6 = 17.9
a_6 = 120.9
b_6 = 18.3
c_6 = 78.9
x_6 = [104.5, 103, 104.5]
y_6 = [25.6, 18.4, 11]


arc_xR_6 = r_6 * cos(anglesR) + a_6
arc_yR_6 = r_6 * sin(anglesR) + b_6
arc_xL_6 = r_6 * cos(anglesL) + (c_6 -(a_6-c_6))
arc_yL_6 = r_6 * sin(anglesL) + b_6



### PLOT ###

fig, ax = plt.subplots(3, sharex=True)
fig.suptitle('Capillary curvature')

ax[0].imshow(im_10, extent=(0, dimx, 0, dimz_10))
ax[0].plot(arc_xR_10, arc_yR_10, color = 'red', lw = 3)
ax[0].plot(arc_xL_10, arc_yL_10, color = 'red', lw = 3)
ax[0].plot(x_10, y_10, 'o', color = 'black')
ax[0].plot(a_10, b_10, 'o', color = 'green')
ax[0].annotate('R='+str(r_10), xy=(a_10+2, b_10), xycoords='data', fontsize=10)


ax[1].imshow(im_8, extent=(0, dimx, 0, dimz_8))
ax[1].plot(arc_xR_8, arc_yR_8, color = 'red', lw = 3)
ax[1].plot(arc_xL_8, arc_yL_8, color = 'red', lw = 3)
ax[1].plot(x_8, y_8, 'o', color = 'black')
ax[1].plot(a_8, b_8, 'o', color = 'green')
ax[1].annotate('R='+str(r_8), xy=(a_8+2, b_8), xycoords='data', fontsize=10)


ax[2].imshow(im_6, extent=(0, dimx, 0, dimz_6))
ax[2].plot(arc_xR_6, arc_yR_6, color = 'red', lw = 3)
ax[2].plot(arc_xL_6, arc_yL_6, color = 'red', lw = 3)
ax[2].plot(x_6, y_6, 'o', color = 'black')
ax[2].plot(a_6, b_6, 'o', color = 'green')
ax[2].annotate('R='+str(r_6), xy=(a_6+2, b_6), xycoords='data', fontsize=10)


ax[0].set_ylabel("angstroms")
ax[0].set_xlim(0, dimx)
ax[0].set_ylim(0, dimz_full)
ax[1].set_xlim(0, dimx)
ax[1].set_ylim(0, dimz_full)
ax[2].set_xlim(0, dimx)
ax[2].set_ylim(0, dimz_full)
ax[2].set_xlabel("angstroms")

plt.savefig('Ibeam_Curvature.png', dpi=1000)

plt.show()

