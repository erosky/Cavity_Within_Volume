#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./analysis_run.sh RUN


# Create data file of wanted lines from the log file START to END
echo $1

run=$1
start=45
end=160045
logfile="./run_${run}/log.run_hardcavity_freeze_${run}"
directory="./analysis/run_${run}"
datafile="./analysis/run_${run}/run_hardcavity_freeze_${run}.dat"

temp="215-190"
pres="1 Atmosphere"



# Convert timestep to ns, convert energies from kcal/mol to kJ/mol
sed "s/^[ \t]*//" ${logfile} | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) { print $1/100000, $2, $3, $4, $5*4.184, $6*4.184, $7*4.184, $8, (215-($1/100000)) }}' > ${datafile}


# Plot and save Pot Energy
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PE_${pres}_${run}.png'; \
            set title 'Potential Energy - Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:7"

# Plot and save Pot Energy vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PEvT_${pres}_${run}.png'; \
            set title 'Potential Energy - ${pres}'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [210:190] reverse; \
            set xtics 190,2; \
            plot '${datafile}' using 9:7 title 'PE'"

# Plot and save Total Energy
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/E_${pres}_${run}.png'; \
            set title 'Total Energy - Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:5"

# Plot and save Total Energy vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/EvT_${pres}_${run}.png'; \
            set title 'Total Energy - ${pres}'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [210:190] reverse; \
            set xtics 190,2; \
            plot '${datafile}' using 9:5 title 'Total Energy'"

# Plot and save Mean square disp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/MSD_${pres}_${run}.png'; \
            set title 'Mean Square Displacement vs Time - Sim ${temp}K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:8"

# Plot and save MSD vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/MSDvT_${pres}_${run}.png'; \
            set title 'Mean Square Displacement vs Temp - Sim ${pres}'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [210:190] reverse; \
            set xtics 190,2; \
            plot '${datafile}' using 9:8 title 'MSD'"

# Plot and save Pressure vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PRESvT_${pres}_${run}.png'; \
            set title 'Pressure - Sim ${pres}'; \
            set ylabel 'Atmosphere'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [210:190] reverse; \
            set xtics 190,2; \
            plot '${datafile}' using 9:3 title 'PRES'"

# Plot and save Volume
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/VOL_${pres}_${run}.png'; \
            set title 'Box Volume - Sim ${temp}K'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:4"

# Plot and save Volume vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/VOLvT_${pres}_${run}.png'; \
            set title 'Box Volume - Sim ${pres}'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [210:190] reverse; \
            set xtics 190,2; \
            plot '${datafile}' using 9:4 title 'VOL'"
