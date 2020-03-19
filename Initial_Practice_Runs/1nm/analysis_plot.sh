#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./analysis_run.sh RUN


# Create data file of wanted lines from the log file START to END
echo $1

run=$1
start=44
end=40044
logfile="./run_${run}/log.run_1nm_bubble_${run}"
directory="./analysis/run_${run}"
datafile="./analysis/run_${run}/run_1nm_bubble_${run}.dat"

temp="215-195"



# Convert timestep to ns, convert energies from kcal/mol to kJ/mol
sed "s/^[ \t]*//" ${logfile} | awk -v start=${start} -v end=${end} '{if ((NR>start)&&(NR<end)) { print $1/100000, $2, $3, $4, $5*4.184, $6*4.184, $7*4.184, $8, (215-($1/100000)) }}' > ${datafile}


# Plot and save Pot Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy - Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:7" > ${directory}/run_PE_${run}.svg

# Plot and save Pot Energy vs Temp
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy - Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [215:195] reverse; \
            set xtics 195,2; \
            plot '${datafile}' using 9:7 title 'PE'" > ${directory}/run_PEvT_${run}.svg

# Plot and save Pot Energy with Temperature
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Potential Energy vs Temperature - Sim ${temp}K'; \
            set y2tics -198000,2000; \
            set ytics nomirror; \
            set ylabel 'Temperature (K)'; \
            set y2label 'PE (kJ/mol)'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:2 axis x1y1 title 'Temperature', '${datafile}' using 1:7 axis x1y2 title 'PE'" > ${directory}/PEvTEMP_${run}.svg

# Plot and save Total Energy
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Total Energy - Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:5" > ${directory}/run_E_${run}.svg

# Plot and save Mean square disp
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Mean Square Displacement vs Time - Sim ${temp}K'; \
            set ylabel 'Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:8" > ${directory}/run_MSD_${run}.svg

# Plot and save Mean square disp with Temperature
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Mean Square Displacement and Temperature - Sim ${temp}K'; \
            set y2tics 0,1000; \
            set ytics nomirror; \
            set ylabel 'Temperature (K)'; \
            set y2label 'MSD (Angstroms)'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:2 axis x1y1 title 'Temperature', '${datafile}' using 1:8 axis x1y2 title 'MSD'" > ${directory}/MSDvTEMP_${run}.svg

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
gnuplot -e "set terminal svg background rgb 'white'; \
            set title 'Box Volume - Sim ${temp}K'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:4" > ${directory}/run_VOL_${run}.svg
