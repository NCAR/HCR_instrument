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
dbmPower = data(:,2);

% power, mW
linPower = exp(log(10) * (dbmPower * 0.1));

% Column 4 contains beam tilt angle, which we use for azimuth when doing 
% HCR ground-based corner reflector beam pattern measurement.
az = data(:,4);

% elevation
el = data(:,6);

% regular az/el grid to which we'll interpolate
azmin = 0.0;
azmax = 2.6;
azstep = 0.05;
azi = [azmin:azstep:azmax];

elmin = 0.8;
elmax = 4.3;
elstep = 0.05;
eli = [elmin:elstep:elmax]';

naz = length(azi);
nel = length(eli);

PowerSum = NaN(naz, nel);
SumCount = zeros(naz, nel);
for i = 1:size(time)
    % Get the array indices closest to the current az/el
    ix = int16((az(i) - azmin) / azstep) + 1;
    if (ix < 1 || ix > naz)
        continue
    end
    
    iy = int16((el(i) - elmin) / elstep) + 1;
    if (iy < 1 || iy > nel)
        continue
    end
    
    % Add to the power sum for this point, and increment the count of values 
    % contained in the sum
    if (SumCount(ix, iy) == 0)
        PowerSum(ix, iy) = linPower(i);
    else
        PowerSum(ix, iy) += linPower(i);
    end
    SumCount(ix, iy)++;
end

% Elementwise division to go from summed power to average power at each point
Z = PowerSum ./ SumCount;

% interpolate to fill in NaNs
Z(isnan(Z)) = interp1(find(~isnan(Z)), Z(~isnan(Z)), find(isnan(Z)), 'linear');

% filter to smooth things a bit
lightFilter = true
if (lightFilter)
    % mild 3x3 filter
    h = [.06 .12 .06; .12 .28 .12; .06 .12 .06];
else
    % moderate 5x5 filter
    h = [.00 .02 .03 .02 .00;
         .02 .06 .08 .06 .02;
         .03 .08 .16 .08 .03;
         .02 .06 .08 .06 .02;
         .00 .02 .03 .02 .00]
end
Z = filter2(h, Z);

% convert from mW to dBm
Z = 10 * log10(Z);

%Plot it
figure;
surf(eli, azi, Z, 'EdgeColor', 'None');
plotwidth = max(azmax - azmin, elmax - elmin);
axis([elmin elmin+plotwidth azmin azmin+plotwidth -120 -40]);
set(gca, 'CLim', [-120 -40]);
xlabel('elevation')
ylabel('azimuth')
zlabel('dBm')
%% The following two lines add a colorbar, but note that adding a colorbar 
%% disables dragging on the plot to change the view.
%bar = colorbar;
%xlabel(bar, 'dBm')