for VARIABLE in 2 3 4 5 6 7 8 9 10
do
	echo $VARIABLE
	mkdir run_$VARIABLE
	cp in.ibeam_cooling in.ibeam_cooling_$VARIABLE
	sed -i -E "9 s/[0-9]+/$RANDOM/" in.ibeam_cooling_$VARIABLE
	sed -i -E "10 s/[0-9]+/$VARIABLE/" in.ibeam_cooling_$VARIABLE
	sed -i -E "11 s/[0-9]+/$VARIABLE/" in.ibeam_cooling_$VARIABLE
done
