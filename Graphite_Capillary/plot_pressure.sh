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
            plot '${datafile}' using 1:3 title 'Box Pressure',\
            '${datafile}' using 1:8 title 'Droplet',\
            '${datafile}' using 1:9 title 'Core',\
            '${datafile}' using 1:10 title 'Surface'"

            
            
