import numpy as np

coordinate_file = 'coordinates.dat'
coordinates = np.loadtxt(coordinate_file, max_rows=3)
print (coordinates)

A = coordinates[0]
B = coordinates[1]
C = coordinates[2]

x1 = A[0]
y1 = A[1]
x2 = B[0]
y2 = B[1]
x3 = C[0]
y3 = C[1]



# importing library sympy
from sympy import symbols, Eq, solve
  
# defining symbols used in equations
# or unknown variables
a, b, R = symbols('a, b, R')
  
# defining equations
eq1 = Eq(((x1-a)**2+(y1-b)**2), R**2)
print("Equation 1:")
print(eq1)
eq2 = Eq(((x2-a)**2+(y2-b)**2), R**2)
print("Equation 2")
print(eq2)
eq3 = Eq(((x3-a)**2+(y3-b)**2), R**2)
print("Equation 3")
print(eq3)
  
# solving the equation
solution = solve((eq1, eq2, eq3), (a, b, R))

print("Values of 3 unknown variable are as follows:")
print(solution)

output = 'coordinates.dat'
f = open(output, "a")
f.write(str(solution))



