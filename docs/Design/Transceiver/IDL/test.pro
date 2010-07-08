pro test

systemp = 27
k = 1.38e-23  ; Boltzmann's constant
T0 = systemp + 273 
Bn = 4e6  ; Bandwidth = 20MHz

nf = 10^(7.5/10) ; NF = 6dB
Te = (nf+1)*T0

Pn = k*Te*Bn
print, te
print, 10*alog10(pn)+30


stop
end