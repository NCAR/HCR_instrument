% Each row of the CSV file is data for a single time, and columns contain:
%    1 - time, seconds since 1970-01-01 00:00:00.0 UTC
%    2 - power value, dBm
%    3 - rotation angle, deg
%    4 - tilt angle, deg
%    5 - azimuth, deg
%    6 - elevation, deg
data = csvread("/tmp/beamPattern.csv");

% time
time = data(:,1);

% power, dBm
rcvdPower = data(:,2);

% Column 4 contains beam tilt angle, which we use for azimuth when doing 
% HCR ground-based corner reflector beam pattern measurement.
az = data(:,4);

% elevation
el = data(:,6);

% regular az/el grid to which we'll interpolate
xmin = -1.3;
xmax = 1.5;
xstep = 0.025;
xi = [xmin:xstep:xmax];

ymin = 1.2;
ymax = 4.0;
ystep = 0.025;
yi = [ymin:ystep:ymax]';

%Z = NaN(int32(floor((xmax - xmin) / xstep + 1)), int32(floor((ymax - ymin) / ystep + 1)))

Z = griddata(az, el, rcvdPower, xi, yi, 'linear');

%Plot it
figure;
surf(Z, 'EdgeColor', 'None');
view(2);