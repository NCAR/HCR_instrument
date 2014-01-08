% Each row of the CSV file is data for a single time, and columns contain:
%    1 - time, seconds since 1970-01-01 00:00:00.0 UTC
%    2 - power value, dBm
%    3 - rotation angle, deg
%    4 - tilt angle, deg
%    5 - azimuth, deg
%    6 - elevation, deg
data = csvread('beamPattern.csv');

% time
time = data(:,1);

% get strings for earliest and latest times of the data
unixEpoch = datenum('1970/01/01', 'yyyy/mm/dd');
minTime = unixEpoch + min(time) / 86400.;
minTimeStr = datestr(minTime);
maxTime = unixEpoch + max(time) / 86400.;
maxTimeStr = datestr(maxTime);

% power, dBm
dbmPower = data(:,2);

% power, mW
linPower = exp(log(10) * (dbmPower * 0.1));

% Column 4 contains beam tilt angle, which we use for azimuth when doing 
% HCR ground-based corner reflector beam pattern measurement.
az = data(:,4);

% elevation
el = data(:,6);

% regular az/el grid to which we'll interpolate
azmin = input('Minimum azimuth for the grid: ');
azmax = input('Maximum azimuth for the grid: ');
fprintf('\n');
azstep = 0.05;
azi = [azmin:azstep:azmax];

elmin = input('Minimum elevation for the grid: ');
elmax = input('Maximum elevation for the grid: ');
elstep = 0.05;
eli = [elmin:elstep:elmax]';

naz = length(azi);
nel = length(eli);

% Sum the data onto the nearest points of a regularly spaced grid. Also keep a 
% count at each point so we can calculate average power where we have
% multiple data values for a single grid point.
PowerSum = NaN(nel, naz);
SumCount = zeros(nel, naz);
for i = 1:length(time)
    % Get the array indices closest to the current az/el
    ic = int16((az(i) - azmin) / azstep) + 1;
    if (ic < 1 || ic > naz)
        continue
    end
    
    ir = int16((el(i) - elmin) / elstep) + 1;
    if (ir < 1 || ir > nel)
        continue
    end
    
    % Add to the power sum for this point, and increment the count of values 
    % contained in the sum
    if (SumCount(ir, ic) == 0)
        PowerSum(ir, ic) = linPower(i);
    else
        PowerSum(ir, ic) = PowerSum(ir, ic) + linPower(i);
    end
    SumCount(ir, ic) = SumCount(ir, ic) + 1;
end

% Elementwise division to go from summed power to average power at each grid 
% point
Z = PowerSum ./ SumCount;

% Pull the non-NaN data from the grid into 1-d arrays of azimuth, elevation, 
% and linear power.
[Y, X] = find(~isnan(Z));
for i = 1:length(X)
    ic = X(i);
    ir = Y(i);
    goodAz(i) = azmin + (ic - 1) * azstep;
    goodEl(i) = elmin + (ir - 1) * elstep;
    goodPower(i) = Z(ir, ic);
end

%Plot the non-NaN points from the raw gridded data
figure;
plot3(goodAz, goodEl, 10 * log10(goodPower), '.');
plotwidth = max(azmax - azmin, elmax - elmin);
axis([azmin azmin+plotwidth elmin elmin+plotwidth -120 -40]);
set(gca, 'CLim', [-120 -40]);
title(sprintf('Gridded and averaged powers %s to %s', minTimeStr, maxTimeStr));
xlabel('azimuth')
ylabel('elevation')
zlabel('dBm')

% Now rebuild the scattered good data points into a 2-d array using griddata.
% This will perform a 2-d interpolation to fill points without data.
smoothZ = griddata(goodAz, goodEl, goodPower, azi, eli);

% Smooth things a bit, using a mild 3x3 filter
h = [.06 .12 .06; .12 .28 .12; .06 .12 .06];
smoothZ = filter2(h, smoothZ);

% convert from mW to dBm
Z = 10 * log10(Z);
smoothZ = real(10 * log10(smoothZ));

%%Plot raw gridded data surface
%figure;
%surf(azi, eli, Z, 'EdgeColor', 'None');
%plotwidth = max(azmax - azmin, elmax - elmin);
%axis([azmin azmin+plotwidth elmin elmin+plotwidth -120 -40]);
%set(gca, 'CLim', [-120 -40]);
%title(sprintf('Raw Beam Pattern %s to %s', minTimeStr, maxTimeStr));
%xlabel('azimuth')
%ylabel('elevation')
%zlabel('dBm')
%%% The following two lines add a colorbar, but note that adding a colorbar 
%%% in Octave disables dragging on the plot to change the view.
%%bar = colorbar;
%%xlabel(bar, 'dBm')

%Plot the interpolated/smoothed data
figure;
surf(azi, eli, smoothZ, 'EdgeColor', 'None');
plotwidth = max(azmax - azmin, elmax - elmin);
axis([azmin azmin+plotwidth elmin elmin+plotwidth -120 -40]);
set(gca, 'CLim', [-120 -40]);
title(sprintf('Interpolated Beam Pattern %s to %s', minTimeStr, maxTimeStr));
xlabel('azimuth')
ylabel('elevation')
zlabel('dBm')
%% The following two lines add a colorbar, but note that adding a colorbar 
%% in Octave disables dragging on the plot to change the view.
%bar = colorbar;
%xlabel(bar, 'dBm')
