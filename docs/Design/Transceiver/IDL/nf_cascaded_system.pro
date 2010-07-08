; Research receiver configuration
; author: peisang tsai
; date: 06/09/2010

pro nf_cascaded_system

; PARAMETERS 
; RADOME ONE-WAY LOSS = 0.13 dB
; WAVEGUIDE LOSS PRIOR TO Quinstar QWZ-WT15 = 1.3 dB
; Quinstar QWZ-WT15 INSERTION LOSS = 0.4 dB
;


; HCR cascade RF system noise figure calculation [Skolnik 11.4]
; 5 network in cascade 
F1 = 10^(1.83/10)   ; loss prior to LNA
G1 = 1/F1
F2 = 10^(4.5/10)
G2 = 10^(22.5/10)   ; gain for LNA
F3 = 10^(1.5/10)
G3 = 1/F3
F4 = 10^(0.8/10)
G4 = 1/F4
;F5 = 10^(7.8/10)    ; Farran Power Amplifier
;G5 = 10^(27.0/10)   ; Farran Power Amplifier
F5 = 10^(8.5/10)
G5 = 10^(-7.0/10)
F0 = F1 + (F2-1)/G1 + (F3-1)/(G1*G2) + (F4-1)/(G1*G2*G3) + (F5-1)/(G1*G2*G3*G4) 
;Te2 = (F0+1)*T0

; Tx front-end W/G loss is 1.5dB
; RX NF = 7.5dB
; bench-top measured gain = 36.69 on 1/13/2010
; bench-top measured gain = 38.21dB 3/25/2010
; DR receiver measured gain from effective noise bandwidth 700kHz is 39.249dB 4/22/2010
; DR receiver measured gain injecting a W-band signal @ -60.18dBm is 39.48dB 5/21/2010
; theda3dBrx = 0.75 degree, Garx = 46.3 dB  (UWYOMING)
; theda3dBtx = 0.68 degree, Gatx = 46.21 dB (NOAA)
print, decibel(F0)
stop
end