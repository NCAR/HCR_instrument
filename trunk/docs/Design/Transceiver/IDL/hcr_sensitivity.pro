pro hcr_sensitivity

; CONSTANTS
systemp = 27  ; in Celcius
k = 1.38e-23  ; Boltzmann's constant
T0 = systemp + 273  
c = 3e8
f = 94.40625e9
lambda = c/f;/0.01 ; centermeters

Pt = 10^((32.-1.6-0.13)/10) ; Watts; assume Pt = +62dBm
;w_sqr = 0.842150  ;0.7582 for 10C
w_sqr = kw_sqr(T0)
theda_rx = 0.75 ; in degrees, 3dB beamwidth
theda_tx = 0.68 ; in degrees
Gatx = 10^(46.21/10) ; antenna gain = 44.5dB
Garx = 10^(46.3/10) 
l = 10^(2./10)  ; atmospheric loss
lr = 10^(1.1/10)  ; recevier filter mismatch
Grx = 10^(0.0/10)
Tao = 0.5 ; microseconds
corr = Tao/0.5
Bn = 700e3*corr    ; Hz, digital receiver bandwidth
R = 1000.
Param = hcr_param(tao)


Z = 1e18*(2^10*alog(2)*lambda^2*lr)/(!pi^3*Pt*Gatx*Garx*c*tao*theda_rx*w_sqr)*Param(5)*R^2
print, 'MDZ for hcr is', decibel(Z) + 30


; MESSAGES FOR RUNNING THIS ROUTINE
PRINT, 'Make sure the function "hcr_param" returns Pn_dbm instead of radar constant Kp'
PRINT, 'Receiver Bandwidth = (kHz)', Bn/1e3
PRINT, 'Transmit Pulse Width = (us)', Tao

STOP
END
