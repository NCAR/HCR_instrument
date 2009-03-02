function Pentek7142(Pentek_file,samps)
% Pentek7142 plots time series and FFT of data acquired from Pentek P7142
% Assumes data has been imported to array "data"
% data is arranged in 3 columns: index, I, Q. I and Q are not true
% quadrature signals but are taken as successive downsampled points of the
% original signal. Sample rate is 125 MHz, downsaple factor = 5.

% Arguments: Pentek P7142 data filename, number of samples

error(nargchk(2, 2, nargin)) %check for correct number of arguments
Pdata = uiimport(Pentek_file) %import Pentek data file
k = 1;
nsamps = str2num(samps); % must convert samps to number because it is read as string from stdin
for i=1:1:nsamps
    comb(k)= Pdata.data(i,2);
    comb(k+1)= Pdata.data(i,3);
    k = k + 2;
end
figure(1);
title('Pentek P7142 Time Series');
xlabel('Sample Number');
ylabel('P7142 Counts');
hold on;
plot(comb(1:nsamps));
hold off;
m = mean(comb(1:nsamps)) % this is DC offset in counts

fs = 25e6;                      % sampling rate = 125MHz/5
f=0:fs/(nsamps-1):fs/2-1;       % frequency range vector for single sided FFT
% f=-fs/2:fs/(nsamps-1):fs/2;           % frequency range vector
figure(2);
title('Pentek P7142 Power Spectrum');
xlabel('Frequency in MHz: DC to Fs/2');
ylabel('Magnitude in dBm');
w = window(@hamming,nsamps);    % generate hamming window
for i=1:1:nsamps
    wcomb(i)=w(i)*comb(i);      % apply window
end
scale = 1000/(50*(2^30));       % converts counts to milliwatts
fts = ((1/(nsamps))*fft(wcomb,nsamps));
Ps = 10*log10(scale*power(abs(fts),2));
% Normalize power spectrum to 0 dB
% m1 = max(Ps);
% m2 = max(m1);
hold on
plot(f, Ps(1:nsamps/2));
hold off
%compute power from timeseries and zeroth moment of fft!
for i=1:1:nsamps
    t1(i) = comb(i)^2;
    t2(i) = (comb(i)- m)^2; % with dc offset removed
end
v2 = scale*power(abs(1/nsamps*fft(comb,nsamps)),2);
Pts = 10*log10(scale*sum(t1)/nsamps)  % power in dBm from timeseries
Ptsndc = 10*log10(scale*sum(t2)/nsamps)  % power in dBm from timeseries with dc removed!
Pfs = 10*log10(sum(v2))               % power in dBm from FFT -- use non-windowed FFT to compute power
                                      % because lose ~4 dB in window!
clear function;
end