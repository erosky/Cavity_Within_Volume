#!/usr/bin/awk -f

# desired output:
# RUN TIMESTEP, NUMBER OF MOLECULES, DENSITY

BEGIN { STEP = 400000 ; 
	RUN = 30 ;
	ZMAX = 34.85 ;
	ZMIN = 15 ;
	XMAX = 96 ;
	XMIN = 61 ;
	YDIM = 36.49;
	VOL = (ZMAX-ZMIN)*(XMAX-XMIN)*YDIM ;
	N = 0 ; start = 0 } 
{
	if ($2=="TIMESTEP") {
		if (start==1) { print RUN "\t" STEP "\t" N "\t" N/VOL ; exit } ; 
		start = 0 ; t = 1 ; a = 0
	}
	if (t==1 && $0==STEP) { step = $0 ; t = 0 ; start = 1 ; next }
  	if ($2=="ATOMS" && start==1) {
		a = 1 ; next
	}
	if (a==1 && $2==2) {
		# select z-bin and core
		if ($5>=ZMIN && $5<ZMAX && $3>=XMIN && $3<XMAX) {
			N = N+1 ;
		}
	}
}
