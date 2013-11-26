; Last modified: 04/23/2010

pro noisefigure

systemp = 27
k = 1.38e-23  ; Boltzmann's constant
T0 = systemp + 273  
c = 3e8
f = 94.40625e9

Bn = 700e3  ; effective bandwidth for 1MHz of Pentek is 700kHz. 
rxbandwidth = 1e6 
rxpulsewidth = 1e-6

; based on measurement 04/07/2010, using Pentek system. From noise source to data system. 
Nhot = 10^((-52.3)/10)
Ncold = 10^((-65.8)/10)

Y = Nhot/Ncold
ENR = 10^(20.84/10)
F = ENR/(Y-1)
l = 10^((1.7+0.26)/10)
Fsys =  l + (F-1) * l


; Receiver noise temperature
; Cascading 
Te = (Fsys-1)*T0
print, 'Measured system noise figure (dB) = ', 10*alog10(Fsys)
Print, 'System Equivalent temperature (K) =',Te


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
; measured gain = 36.69 on 1/13/2010
; Measured gain = 38.21dB 3/25/2010
; calculated gain from noise source cal = 37.7dB 4/7/10 into 2MHz BW
; calculated gain from effective noise bandwidth 700kHz is 39.249dB 4/22/2010
; theda3dBrx = 0.75 degree, Garx = 46.3 dB
; theda3dBtx = 0.68 degree, Gatx = 44.5 dB

Grx = 10^(39.249/10)
Pn = k*Te*Bn
Pnrx = Grx*k*Te*Bn
;Smin = k*T0*Bn*10^(F/10)

print, 'Receiver Noise Power at RX IF(156.25MHz) is (dBm) ', 10*alog10(Pnrx)+30
Print, 'Receiver Noise power at output of Antenna is (dBm)',10*alog10(Pn)+30
;print, 'Minimum detectable signal at RX IF is (dBm)', 10*alog10(Smin)+30


; receiver cal using Doviak&Zrnic (eqn. 4.14)
; Z = Kp*R^2*Pr, where Pr=snr*Pn. Kp = radar constant
    lambda = c/f ; meters
    thedatx = 0.68*180/!pi ; 3dB beamwidth
    thedarx = 0.75*180/!pi
    Pt = 10^((32.-1.6-0.13)/10)  ; assume Pt = +62 dBm
    Gatx = 10^(46.21/10) ; antenna gain = 44.5dB
    Garx = 10^(46.3/10) 
    l = 10^(2./10)  ; atmospheric loss
    
    SNR = 10^(0./10)  ; 0dB SNR
    Pr = snr*Pnrx
    print, 10*alog10(pr)
    
; Using Doviak & Zrnic (Eqn. 4.35)
; Z = Kp*Pr*r^2 
    Kp2 = (6.75*2^14*alog(2)*lambda^2*l^2)/(!pi^5*1e-17*Pt*Garx*Gatx*Grx*rxpulsewidth*thedatx*thedarx*0.9)
    print,10*alog10(kp2)    
    
    rng = 75*findgen(100)
    r2 = transpose(rng*rng)
 
    Z = Kp2*Pnrx*snr*r2
    z_db = decibel(Z)







stop
end