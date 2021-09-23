#!/usr/bin/awk -f

# desired output:
# TIMESTEP, TIME, TEMP, ICE, WATER, TOTAL, ICE_RATIO

# TOTAL is the number of atoms in simulation, must remain constant throughout sim
# threshold is the order parameter threshold between ice and liquid

# sim timestep is 10 fs each step, 0.000001 ns
# id type x y z vx vy vz c_3[1] c_3[2] c_3[3] c_3[4] c_3[5] c_2[1] c_2[2] c_2[3] c_2[4] c_2[5] c_2[6]


BEGIN { TOTAL = 4199 ; threshold = 0.54 ; ice = 0 ; start = 0 } 
{
	if ($2=="TIMESTEP") {
		if (start==1) { 
			print step "\t" step*0.00001 "\t" 230-step*0.25*0.00001 "\t" ice "\t" TOTAL-ice "\t" TOTAL "\t" ice/TOTAL
		} ; 
		t = 1 ; a = 0 ; next 
	}
	if (t==1) { step = $0 ; t = 0 ; start = 1 ; next }
  if ($2=="ATOMS") {
		a = 1 ; ice = 0 ; water = 0 ; next
	}
	if (a==1 && $10>threshold && $5>20.5 && $5<38.5) { ice++ }
}
END { print step "\t" step*0.00001 "\t" 230-step*0.25*0.00001 "\t" ice "\t" TOTAL-ice "\t" TOTAL "\t" ice/TOTAL }
