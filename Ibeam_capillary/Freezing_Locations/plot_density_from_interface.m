L8_file = fopen('8layer_freezing_coordinates.dat','r');
L10_file = fopen('10layer_freezing_coordinates.dat','r');
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];



L8_coordinates = fscanf(L8_file,formatSpec,sizeA);
L10_coordinates = fscanf(L10_file,formatSpec,sizeA);

L8_center = 78.71;
L8_edge1 = 78.71 - (56.6982/2);
L8_edge2 = 78.71 + (56.6982/2);

L10_center = 78.6793;
L10_edge1 = 78.6793 - (60.853/2);
L10_edge2 = 78.6793 + (60.853/2);


% Plotting a PDF of freezing location distance from nearest edge
% Zero is at the edge and x-axis is distance from edge

X_events = [];

for i = 1:length(L8_coordinates)
    x = L8_coordinates(2,i);
    if x>L8_center
        x_value = L8_edge2 - x;
    end
    if x<=L8_center
        x_value = x - L8_edge1;
    end
    X_events = [X_events, x_value];
end

for i = 1:length(L10_coordinates)
    x = L10_coordinates(2,i);
    if x>L10_center
        x_value = L10_edge2 - x;
    end
    if x<=L10_center
        x_value = x - L10_edge1;
    end
    X_events = [X_events, x_value];
end

X_events

binWidth = 5.0;
pd = fitdist(transpose(X_events),'Gamma');
lastVal = ceil(max(X_events));
binEdges = 0:binWidth:lastVal+1;
binCenters = binWidth/2:binWidth:lastVal+1-binWidth/2;
[N,edges] = histcounts(X_events,binEdges)
err = sqrt(N)/(binWidth*length(X_events))
y = N./(binWidth*length(X_events))

h1 = figure(1);
xgrid = linspace(0,30,100);
h = histogram(X_events,binEdges,'Normalization','pdf');
hold on
er = errorbar(binCenters,y,err, "o", 'LineWidth', 1, 'Color', 'k');
xlabel('Distance from three phase contact line (Angstroms)');
ylabel('Probability Density (A^-^1)');
%pdfEst = pdf(pd,xgrid);
%line(xgrid,pdfEst,'LineWidth', 2, 'Color', 'k')
hold off