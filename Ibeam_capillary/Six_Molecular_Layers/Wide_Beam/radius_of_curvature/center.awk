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
# Outut file will have TIME, TEMP, YBIN, XMIN_TOP, XMAX_TOP, XMIN_BOT, XMAX_BOT, AREA_TOP, AREA_BOT, TOTAL_AREA


BEGIN { YBIN = 39.858 ;
	STEP = 1120000 ; 
	TOP = 20 ;
	BOTTOM = 17 ;
	YBIN_WIDTH = 3.066 ; XMIN = 9999 ; XMAX = -9999 ; start = 0 } 
{
	if ($2=="TIMESTEP") {
		if (start==1) { 
			print step*0.00001 "\t" 240-step*0.25*0.00001 "\t" YBIN "\t" XMIN "\t" XMAX "\t" (XMAX-XMIN) ; exit } ; 
			start = 0 ; t = 1 ; a = 0 ;  next 
	}
	if (t==1 && $0==STEP) { step = $0 ; t = 0 ; start = 1 ; next }
  	if ($2=="ATOMS" && start==1) {
		a = 1 ; next
	}
	if (a==1 && $2==2) {
		# top surface area
		if ($5<TOP && $5>BOTTOM) {
			if ($4>=YBIN && $4<YBIN+YBIN_WIDTH) {
				if ($3<XMIN) { XMIN = $3 } ;
				if ($3>XMAX) { XMAX = $3 } ;	
			}
		}
	}
}
#END {}
