; IDL function to calculate HCR parameters based on measurement data and specifications
; This function is called during raw data process.
; AUTHOR: Peisang Tsai
; Last modified: 04/26/2010
; 

pro hcr_noisefigure


systemp = 27  ; 80 F
k = 1.38e-23  ; Boltzmann's constant
T0 = systemp + 273  
c = 3e8
f = 94.40625e9

Bn = 700e3  ; effective bandwidth for 1MHz of Pentek is 700kHz. 
print, 'effective BW  is', Bn

; based on measurement 04/07/2010, using Pentek system. From noise source to data system. 
;Nhot = 10^((-52.3)/10)
;Ncold = 10^((-65.8)/10)

;measurements on 4/27/10
Nhot = 10^((-37.6699)/10)
Ncold = 10^((-51.6152)/10)

Y = Nhot/Ncold
ENR = 10^(20.84/10)
F = ENR/(Y-1)
l = 10^((1.7+0.13)/10) ; loss prior to LNA
Fsys =  l + (F-1) * l


; Receiver noise temperature
; Cascading 
Te = (Fsys-1)*T0


; HCR cascade RF system noise figure calculation [Skolnik 11.4]
; 5 network in cascade 
F1 = 10^(2.65/10)   ; Receiver waveguide + waveguide switch loss + radome loss
G1 = 1/F1
F2 = 10^(4.5/10)
G2 = 10^(20.46/10)
F3 = 10^(1.5/10)
G3 = 1/F3
F4 = 10^(0.8/10)
G4 = 1/F4
F5 = 10^(7.8/10)
G5 = 10^(27/10)
F0 = F1 + (F2-1)/G1 + (F3-1)/(G1*G2) + (F4-1)/(G1*G2*G3) + (F5-1)/(G1*G2*G3*G4)
Te2 = (F0+1)*T0

; Tx front-end W/G loss is 1.5dB
; RX NF = 7.5dB
; bench-top measured gain = 36.69 on 1/13/2010
; bench-top measured gain = 38.21dB 3/25/2010
; DR receiver measured gain from effective noise bandwidth 700kHz is 39.249dB 4/22/2010
; DR receiver measured gain injecting a W-band signal @ -60.18dBm is 39.48dB 5/21/2010
; theda3dBrx = 0.75 degree, Garx = 46.3 dB  (UWYOMING)
; theda3dBtx = 0.68 degree, Gatx = 46.21 dB (NOAA)

Grx = 10^(39.48/10)
Pn = k*Te*Bn
Pnrx = Grx*k*Te*Bn
Smin = k*T0*Bn*10^(F/10)

print, 'Measured system noise figure (dB) = ', 10*alog10(Fsys)
Print, 'System Equivalent temperature (K) =',Te

print, 'Receiver Noise Power at RX IF(156.25MHz) is (dBm) ', 10*alog10(Pnrx)+30
Print, 'Receiver Noise power at LNA is (dBm)',10*alog10(Pn)+30,' (Bn =',Bn , ')'
print, 'Minimum detectable signal at RX IF is (dBm)', 10*alog10(Smin)+30
print, 'ENR Noise source (hot) noise power at LNA is', decibel(Pn)+30+20.84

    stop
end