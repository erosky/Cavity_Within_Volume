#!/bin/bash

# Verify that system is equilibrated by looking for 
# stable potential evergy and mean square displacement
# USAGE: ./analysis_run.sh RUN


# Create data file of wanted lines from the log file START to END
echo $1

run=$1
start=66 
end=30066 
logfile="./Constant_Cooling/run_${run}/log.run_ibeam_cooling_${run}"
directory="./analysis/run_${run}"
datafile="./analysis/run_${run}/run_ibeam_cooling_${run}.dat"

temp="240-225"
pres="6Layers"
Tstart=240
Tend=225



# Convert timestep to ns, convert energies from kcal/mol to kJ/mol
sed "s/^[ \t]*//" ${logfile} | awk -v start=${start} -v end=${end} -v T=${Tstart} '{if ((NR>start)&&(NR<end)) { print $1/100000, $2, $3, $4, $5*4.184, $6*4.184, $7*4.184, $8, (T-0.25*($1/100000)) }}' > ${datafile}


# Plot and save Pot Energy
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PE_${pres}_${run}.png'; \
            set title 'Potential Energy - MLmW, Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:7"

# Plot and save Pot Energy vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PEvT_${pres}_${run}.png'; \
            set title 'Potential Energy - MLmW, ${pres}'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [${Tstart}:${Tend}] reverse; \
            set xtics ${Tend},2; \
            plot '${datafile}' using 13:7 title 'PE'"

# Plot and save Total Energy
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/E_${pres}_${run}.png'; \
            set title 'Total Energy - MLmW, Sim ${temp}K'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:5"

# Plot and save Total Energy vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/EvT_${pres}_${run}.png'; \
            set title 'Total Energy - MLmW, ${pres}'; \
            set ylabel 'kJ/mol'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [${Tstart}:${Tend}] reverse; \
            set xtics ${Tend},2; \
            plot '${datafile}' using 13:5 title 'Total Energy'"

# Plot and save Volume
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/VOL_${pres}_${run}.png'; \
            set title 'Box Volume - MLmW, Sim ${temp}K'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:4"

# Plot and save Volume vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/VOLvT_${pres}_${run}.png'; \
            set title 'Box Volume - MLmW, Sim ${pres}'; \
            set ylabel 'Cubic Angstroms'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [${Tstart}:${Tend}] reverse; \
            set xtics ${Tend},2; \
            plot '${datafile}' using 13:4 title 'VOL'"

# Plot and save Pressure
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PRES_${pres}_${run}.png'; \
            set title 'Pressure - ML-mW, Sim ${temp}K'; \
            set ylabel 'Pressure (atm)'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:3"
            
# Plot and save Stress
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/STRESS_${pres}_${run}.png'; \
            set title 'Stress Pressure - ML-mW, Sim ${temp}K'; \
            set ylabel 'Pressure (atm)'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:8"
            

# Plot and save Pressure vs Temp
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/PRESvT_${pres}_${run}.png'; \
            set title 'Pressure - ML-mW, Sim ${pres}'; \
            set ylabel 'Pressure (atm)'; \
            set xlabel 'Temperature (K)'; \
            set style data lines; \
            set xrange [${Tstart}:${Tend}] reverse; \
            set xtics ${Tend},2; \
            plot '${datafile}' using 13:3 title 'PRES'"
            
            
# Plot and save Temeprature
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/TEMP_${pres}_${run}.png'; \
            set title 'Temperature - ML-mW, Sim ${temp}K'; \
            set ylabel 'Temperature (K)'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:2"
       
            
# Plot and save MSD
gnuplot -e "set terminal png size 1000,600; \
            set output '${directory}/MSD_${pres}_${run}.png'; \
            set title 'MSD - ML-mW, Sim ${temp}K'; \
            set ylabel 'Displacement (A)'; \
            set xlabel 'Time (ns)'; \
            set style data lines; \
            plot '${datafile}' using 1:9"
