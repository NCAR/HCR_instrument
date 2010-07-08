; Radar equation
; Peisang Tsai
; Date: February 24, 2010

pro hcrspec

c = 3e8 ; speed of light
f = 94.40625e9  ;TX frequency 94.40625GHz
lambda = c/f
GAtx = 10^(44.5/10)  ; Transmit Ant gain = 44.5 dB
GArx = 10^(47.4/10)  ; Receive Ant gain = 47.4 dB
Ptx = 10^(6./10);10^(62.0/10)  ; Transmit Power 62 dBm
R = 200 ; (m)
B = 20e6 ; RX bandwidth (Hz)
; Antenna system Skolnik [2.55 & 2.56]
D_Ant_tx = 0.3 ; meter
D_Ant_rx = 0.3 ; meter
;theda3dB = 65*lambda/D_Ant_tx  ; antenna 3dB beamwidth in degree
;Gant_tx = 10*alog10(26000./theda3dB^2)  ;dB, assuming pencil beam
Aeff = lambda^2*G/(4*!pi)



; System Noise Temperature Calculation
systemp = 27
Tn = systemp + 273  ; system temp in Kelvin
k = 1.38e-23  ; Boltzmann's constant
Bn = 20e6  ; Bandwidth = 20MHz
Grx = 10^(36.69/10)   ; measured gain = 36.69 on 1/13/2010

Pn = Grx*k*Tn*B

;Pr = Ptx*GAtx*GArx*lambda^2*sigma_r/((4*!pi)^3*R^4)

Sigma_r = Pr*(4*!pi)^3*R^4/(Ptx*GAtx*GArx*lambda^2)

stop
end