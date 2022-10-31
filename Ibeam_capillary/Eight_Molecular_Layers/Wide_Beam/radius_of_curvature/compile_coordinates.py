import numpy as np

output = 'coordinates.dat'
y1 = 33
y2 = 22
y3 = 11

data_file = '../interface_analysis/8layer_surface_data.txt'
data = np.loadtxt(data_file)

center_file = '8layer_center_data.txt'
center_data = np.loadtxt(center_file)

center = data[7]
width = data[5]

x1 = center + (width/2)
x3 = x1

x2 = center_data[2] + (center_data[0]/2)

f = open(output, "w")
f.write(str(x1) + '\t' + str(y1) + '\n')
f.write(str(x2) + '\t' + str(y2) + '\n')
f.write(str(x3) + '\t' + str(y3) + '\n')

#data = np.transpose(data)
