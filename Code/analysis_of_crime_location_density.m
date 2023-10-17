%this file is the density plot of location and adding the bondaries of
%community area
crime = readtable('Crimes_2022.csv');
lat = crime.Latitude;
lon = crime.Longitude;
drawBoundary("CommAreas_fixed.csv");
hold on;
geodensityplot(lat,lon);
geobasemap topographic;

