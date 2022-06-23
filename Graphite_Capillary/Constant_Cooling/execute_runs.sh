#!/bin/bash

for VARIABLE in 2 3
do
	echo $VARIABLE
	mkdir run_$VARIABLE
	sed -i -E "9 s/[0-9]+/$RANDOM/" in.config_10A
	sed -i -E "10 s/[0-9]+/$VARIABLE/" in.config_10A
	sed -i -E "11 s/[0-9]+/$VARIABLE/" in.config_10A

	mpirun -np 6 ~/LAMMPS_Source/lammps/src/lmp_mpi -in in.config_10A
done



