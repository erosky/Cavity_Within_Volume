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
# YBIN_WIDTH = 3
# Angstroms

# Output one file for every 40,000 timesteps
# Outut file will have YBIN, XMIN_TOP, XMAX_TOP, XMIN_BOT, XMAX_BOT, AREA_TOP, AREA_BOT, TOTAL_AREA


BEGIN { YBIN = 0 ; 
	TOTAL = 1794 ; YBIN_WIDTH = 3 ; threshold = 0.54 ; ice = 0 ; TOP_SA = 0 ; BOTTOM_SA = 0 ; start = 0 } 
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
	if (a==1 && $2==2) {
		if ($10>threshold) { ice++ } ;
		for (bin = 0; bin >= 68.92-YBIN_WIDTH; bin = bin+YBIN_WIDTH) {
			xmin = 9999 ; xmax = -9999 ; bin_area = 0 ;
			if (a==1 && $2==2 && $4>=bin && $4<bin+YBIN_WIDTH && $5<ZBOTTOM) { 
				if ($3<xmin) { xmin = $3 } ;
				if ($3>xmax) { xmax = $3 } ;
			}
		}
	}
}
END { print step "\t" step*0.00001 "\t" 240-step*0.25*0.00001 "\t" ice/TOTAL "\t" TOP_SA "\t" BOTTOM_SA "\t" TOP_SA+BOTTOM_SA }
