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
# Outut file will have YBIN, N, XMIN, XMAX, XWIDTH, BIN_VOLUME, BIN_DENSITY



BEGIN { STEP = 47500 ; 
	XBIN = 120 ;
	XBIN_WIDTH = 3.0 ;
	Z_MIN = 19.0 ;
	Z_MAX = 25.0 ;
	N = 0 ; VOL = 727.7498 ; start = 0 } 
{
	if ($2=="TIMESTEP") {
		if (start==1) { print XBIN "\t" N "\t" N/VOL ; exit } ; 
		start = 0 ; t = 1 ; a = 0
	}
	if (t==1 && $0==STEP) { step = $0 ; t = 0 ; start = 1 ; next }
  	if ($2=="ATOMS" && start==1) {
		a = 1 ; next
	}
	if (a==1 && $2==2) {
		# select x-bin and core
		if ($3>=XBIN && $3<XBIN+XBIN_WIDTH && $5>=Z_MIN && $5<Z_MAX) {
			N = N+1 ;
		}
	}
}
#END {}
