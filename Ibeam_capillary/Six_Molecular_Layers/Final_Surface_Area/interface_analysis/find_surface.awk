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


BEGIN { YBIN = 82.782 ;
	STEP = 1920000 ;
	TOTAL = 1794 ; 
	ZTOP = 26 ;
	ZBOTTOM = 12 ;
	YBIN_WIDTH = 3.066 ; XMIN_TOP = 9999 ; XMAX_TOP = -9999 ; XMIN_BOT = 9999 ; XMAX_BOT = -9999 ; start = 0 } 
{
	if ($2=="TIMESTEP") {
		if (start==1) { 
			print step*0.00001 "\t" 240-step*0.25*0.00001 "\t" YBIN "\t" XMIN_TOP "\t" XMAX_TOP "\t" XMIN_BOT "\t" XMAX_BOT "\t" (XMAX_TOP-XMIN_TOP)*YBIN_WIDTH "\t" (XMAX_BOT-XMIN_BOT)*YBIN_WIDTH "\t" (XMAX_TOP-XMIN_TOP)*YBIN_WIDTH+(XMAX_BOT-XMIN_BOT)*YBIN_WIDTH} ; 
			start = 0 ; t = 1 ; a = 0 ;  close("done") 
	}
	if (t==1 && $0==STEP) { step = $0 ; t = 0 ; start = 1 ; next }
  	if ($2=="ATOMS" && start==1) {
		a = 1 ; next
	}
	if (a==1 && $2==2) {
		# top surface area
		if ($5>ZTOP) {
			if ($4>=YBIN && $4<YBIN+YBIN_WIDTH) {
				if ($3<XMIN_TOP) { XMIN_TOP = $3 } ;
				if ($3>XMAX_TOP) { XMAX_TOP = $3 } ;	
			}
		}
		# bottom surface area
		if ($5<ZBOTTOM) {
			if ($4>=YBIN && $4<YBIN+YBIN_WIDTH) {
				if ($3<XMIN_BOT) { XMIN_BOT = $3 } ;
				if ($3>XMAX_BOT) { XMAX_BOT = $3 } ;	
			}
		}
	}
}
#END {}
