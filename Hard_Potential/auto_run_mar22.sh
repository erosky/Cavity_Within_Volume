#!/bin/bash


cd mW_215_to_190_nvt

for VARIABLE in 1 2 3 4
do
	echo $VARIABLE
	mkdir run_$VARIABLE
	sed -i -E "4 s/[0-9]+/$RANDOM/" in.bulk_min-eq-sim
	sed -i -E "5 s/[0-9]+/$VARIABLE/" in.bulk_min-eq-sim
	sed -i -E "6 s/[0-9]+/$VARIABLE/" in.bulk_min-eq-sim

	mpirun -np 12 ../../lmp_mpi -in in.bulk_min-eq-sim
done



