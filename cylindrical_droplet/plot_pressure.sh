#!/bin/bash

# USAGE: ./validate_water.sh DATA_FILE OUTPUT_FILE


#awk '{print $1}' $1
echo $1
echo $2


datafile=$1
output=$2


# Plot and save Pressure
gnuplot -e "set terminal png size 1000,600; \
            set output '${output}_pressure.png'; \
            set title 'Pressure'; \
            set ylabel 'atm'; \
            set xlabel '10^-5 ns'; \
            set style data lines; \
            plot '${datafile}' using 1:3"


# Plot and save Volume
gnuplot -e "set terminal png size 1000,600; \
            set output '${output}_volume.png'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel '10^-5 (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:4"
