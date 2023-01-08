L8_file = fopen('8layer_freezing_coordinates.dat','r');
L10_file = fopen('10layer_freezing_coordinates.dat','r');
formatSpec = '%f %f %f %f';
sizeA = [4 Inf];



L8_coordinates = fscanf(L8_file,formatSpec,sizeA);
L10_coordinates = fscanf(L10_file,formatSpec,sizeA);

L8_center = 21.991;
L8_edge1 = 21.991 - (23.88/2);
L8_edge2 = 21.991 + (23.88/2);

L10_center = 24.956;
L10_edge1 = 24.956 - (29.788/2);
L10_edge2 = 24.956 + (29.788/2);


% Plotting a PDF of freezing location distance from nearest edge
% Zero is at the edge and x-axis is distance from edge

X_events = [];

for i = 1:length(L8_coordinates)
    x = L8_coordinates(4,i);
    if x>L8_center
        x_value = L8_edge2 - x;
    end
    if x<=L8_center
        x_value = x - L8_edge1;
    end
    X_events = [X_events, x_value];
end

for i = 1:length(L10_coordinates)
    x = L10_coordinates(4,i);
    if x>L10_center
        x_value = L10_edge2 - x;
    end
    if x<=L10_center
        x_value = x - L10_edge1;
    end
    X_events = [X_events, x_value];
end

binWidth = 1.0;

pd = fitdist(transpose(X_events),'Gamma');
lastVal = ceil(max(X_events));
binEdges = 0:binWidth:lastVal+1;
binCtrs = binEdges(1:end-1) + binWidth/2;

% 25th and 75th percentile
r25 = icdf(pd,0.01)
r75 = icdf(pd,0.99)


h1 = figure(1);
xgrid = linspace(0,15,100);
h = histogram(X_events,binEdges,'Normalization','pdf');
xlabel('Distance from substrate (\AA)','interpreter','latex');
ylabel('Probability Density (\AA$^{-1}$)','interpreter','latex');
pdfEst = pdf(pd,xgrid);
line(xgrid,pdfEst,'LineWidth', 2, 'Color', 'k')
hold on
line([r25, r25], [0,1.0], 'LineWidth', 2, 'Color', 'b', 'Linestyle','--');
hold on;
line([r75, r75], [0,1.0], 'LineWidth', 2, 'Color', 'b', 'Linestyle','--');
view([90 -90])
hold off
% iz=linspace(r25,r75,40);
% yz=pdf(pd,iz);
% area(iz,yz)