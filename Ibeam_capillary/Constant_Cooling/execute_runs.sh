#!/bin/bash

for VARIABLE in 1 2 3 4
do
	echo $VARIABLE
	mkdir run_$VARIABLE
	sed -i -E "9 s/[0-9]+/$RANDOM/" in.ibeam_cooling
	sed -i -E "10 s/[0-9]+/$VARIABLE/" in.ibeam_cooling
	sed -i -E "11 s/[0-9]+/$VARIABLE/" in.ibeam_cooling

	mpirun --use-hwthread-cpus ~/LAMMPS_Source/lammps/src/lmp_mpi -in in.ibeam_cooling
done



