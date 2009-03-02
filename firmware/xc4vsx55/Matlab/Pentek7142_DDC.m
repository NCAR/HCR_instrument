function Pentek7142_DDC(Pentek_file,samps)
% Pentek7142 plots time series and FFT of data acquired from Pentek P7142
% Assumes data has been imported to array "data"
% data is arranged in 3 columns: index, I, Q. I and Q are not true
% quadrature signals but are taken as successive downsampled points of the
% original signal. Sample rate is 125 MHz, downsaple factor = 8.

% Arguments: Pentek P7142 data filename, number of samples

error(nargchk(2, 2, nargin)) %check for correct number of arguments
Pdata = uiimport(Pentek_file) %import Pentek data file
k = 1;
nsamps = str2num(samps); % must convert samps to number because it is read as string from stdin
comb = complex(Pdata.data(1000:1000+nsamps,2),Pdata.data(1000:1000+nsamps,3)); %read into file to avoid data problem at start
figure(1);
title('Pentek P7142 DDC Time Series');
xlabel('Sample Number');
ylabel('P7142 Counts');
hold on;
plot(real(comb),'b');
plot(imag(comb),'r');
hold off;
mi = mean(real(comb)) % this is DC offset of I in counts
mq = mean(real(comb)) % this is DC offset of Q in counts

fs = 15.625e6;                   % sampling rate = 125MHz/8
%f=0:fs/(nsamps-1):fs/2-1;       % frequency range vector for single sided FFT
f=-fs/2:fs/(nsamps-1):fs/2;           % frequency range vector
figure(2);
title('Pentek P7142 DDC Power Spectrum');
xlabel('Frequency in MHz: -Fs/2 to Fs/2');
ylabel('Magnitude in dBm');
w = window(@hamming,nsamps);    % generate hamming window
for i=1:1:nsamps
    wcr(i) = w(i)*real(comb(i));  % apply window to real part
    wci(i) = w(i)*imag(comb(i));  % apply window to imaginary part
end
wcomb = complex(wcr,wci);
scale = 1000/(50*(2^30));       % converts counts to milliwatts
fts = ((1/(nsamps))*fftshift(fft(wcomb,nsamps)));
Ps = 10*log10(scale*power(abs(fts),2));
% Normalize power spectrum to 0 dB
% m1 = max(Ps);
% m2 = max(m1);
hold on
plot(f, Ps);
hold off
    
%compute power from timeseries and zeroth moment of fft!
for i=1:1:nsamps
    t1(i) = real(comb(i))^2 + imag(comb(i))^2;
end
v2 = scale*power(abs(1/nsamps*fft(comb,nsamps)),2);
Pts = 10*log10(scale*sum(t1)/nsamps)  % power in dBm from timeseries
Pfs = 10*log10(sum(v2))               % power in dBm from FFT -- use non-windowed FFT to compute power
                                      % because lose ~4 dB in window!
clear function;
end