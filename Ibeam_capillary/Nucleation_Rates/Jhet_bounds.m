function [Tfcenters, Jhet, wlow, whi] = Jhet_bounds(Tf, c, droparea, numberofbins);
%formulas and Equn #s are from Zobrist et al.; JPC C; 111, 2007; pg. 2151
%Tf is a list of freezing temperatures in C (temperatures, not supercooling)
%c is the cooling rate; use a positive number; decreasing T is implied here
%drop area is the area of contact between droplet and substrate
%numberofbins is the number of data points you want in the temperature range.
%the units for c and droparea will dictate the units of Jhet
%Aug. 2, 2020; Will Cantrell
%This is a revision of an earlier code written by WC that wasn't well documented
% November 9, 2021; Elise Rosky
% Revised code to print data needed to compute upper and lower bounds (wlow, whi) on the nucleation rates
% Computing upper and lower feduciary limits from Koop et al 1997, equations 13a,b
% with a confidence level x = 0.99
% There is 99% certainty that the true nucleation rate falls between the upper and lower bounds
%Ex: [Tfcenters, Jhet, wlow, whi] = Jhet2(Tf, c, droparea, numberofbins);

numbins = numberofbins;
Tfcenters = [];
Ttot = [];
wlow = [];
whi = [];


Tfedges = zeros(numbins+1,1); Tfedges(1) = min(Tf)-.01; Tfedges(end) = max(Tf)+.01;
dT = Tfedges(end) - Tfedges(1);
increment = dT/numbins;
for i = 1:numbins
    Tfedges(i+1) = Tfedges(i) + increment;
    Tfcenters(i) = Tfedges(i) + increment/2;
end


%now go through and find freezing events
freezingeventsinbin = zeros(numbins,1);
Jbin = zeros(numbins,1);
for i = 1:numbins
    Tfsinbin = find(Tf>Tfedges(i) & Tf<Tfedges(i+1)); %Tf(i) is the lower temperature
    freezingeventsinbin(i) = length(Tfsinbin); %this is the number of Tfs that fell between the bin edges
    
    %find the number unfrozen at bin end and use it to calculate 1st term in Equn 13
    unfrzn = find(Tf < Tfedges(i));
    numunfrzn = length(unfrzn);
    timeunfrzn = increment/c*numunfrzn;
    
    %calculate the contribution to time from droplets that froze
    tfrzn = zeros(size(Tfsinbin));
    for j = 1:length(Tfsinbin)
        tfrzn(j) = ( Tfedges(i+1)-Tf(Tfsinbin(j)) )/c;
    end
    
    ttotforbin = timeunfrzn+sum(tfrzn);
    
    % Use equations 13 a,b from Koop et.al. to find upper and lower bounds
    wlow(i) = 1/ttotforbin*(freezingeventsinbin(i)-[1+(2*freezingeventsinbin(i))^0.5 * erfinv(2*0.99 - 1)]);
    whi(i) = 1/ttotforbin*(freezingeventsinbin(i)+[1+(2*freezingeventsinbin(i))^0.5 * erfinv(2*0.99 - 1)]);
    
    Jbin(i) = freezingeventsinbin(i)/ttotforbin;
    
end

Jhet = Jbin./droparea;

