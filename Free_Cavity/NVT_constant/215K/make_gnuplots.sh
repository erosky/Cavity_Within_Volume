#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./analysis_run.sh RUN


# Create data file of wanted lines from the log file START to END
echo $1

run=$1
start=37
end=100037
logfile="./run_${run}/log.run_freecavity_constant_215"
directory="./analysis/run_${run}"
datafile="./analysis/run_${run}/run_freecavity_constant_${run}.dat"

temp="215-215"
pres="1 Atmosphere"



# Convert timestep to ns, convert energies from kcal/mol to kJ/mol
sed "s/^[ \t]*//" ${logfile} | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) { print $1/200000, $2, $3, $4, $5*4.184, $6*4.184, $7*4.184, $8 }}' > ${datafile}


# Plot and save Pot Energy
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PE_${pres}_${run}.png'; \
            set title 'Potential Energy - Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:7"


# Plot and save Total Energy
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/E_${pres}_${run}.png'; \
            set title 'Total Energy - Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:5"


# Plot and save Mean square disp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/MSD_${pres}_${run}.png'; \
            set title 'Mean Square Displacement vs Time - Sim ${temp}K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:8"


# Plot and save Volume
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/VOL_${pres}_${run}.png'; \
            set title 'Box Volume - Sim ${temp}K'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:4"

# Plot and save Pressure
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PRES_${pres}_${run}.png'; \
            set title 'Pressure - Sim ${temp}K'; \
            set ylabel 'Atmospheres'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:3"

