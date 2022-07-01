#!/usr/bin/awk -f

# desired output:
# TIMESTEP, TIME, TEMP, ICE_RATIO, TOP_SA, BOTTOM_SA, TOTAL_SA

# TOTAL is the number of atoms in simulation, must remain constant throughout sim
# threshold is the order parameter threshold between ice and liquid

# sim timestep is 10 fs each step, 0.000001 ns
# ZTOP_UPPER
# ZTOP_LOWER
# ZBOTTOM_UPPER
# ZBOTTOM_LOWER
# YBIN_WIDTH




BEGIN { TOTAL = 1794 ; threshold = 0.54 ; ice = 0 ; start = 0 } 
{
	if ($2=="TIMESTEP") {
		if (start==1) { 
			print step "\t" step*0.00001 "\t" 240-step*0.25*0.00001 "\t" ice/TOTAL "\t" TOP_SA "\t" BOTTOM_SA "\t" TOP_SA+BOTTOM_SA
		} ; 
		t = 1 ; a = 0 ; next 
	}
	if (t==1) { step = $0 ; t = 0 ; start = 1 ; next }
  if ($2=="ATOMS") {
		a = 1 ; ice = 0 ; water = 0 ; next
	}
	if (a==1 && $10>threshold && $2==2) { ice++ }
}
END { print step "\t" step*0.00001 "\t" 240-step*0.25*0.00001 "\t" ice "\t" TOTAL-ice "\t" TOTAL "\t" ice/TOTAL }
