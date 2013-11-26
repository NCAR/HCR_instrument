; cascade system noise figure
; peisang Tsai 03-02-2010

pro cascadenf

k = 1.38e-23  ; Boltzmann's constant
T0 = 290  ; standard temperature, room temp, Kelvin
Bn = 20e6
Nin = k*T0*Bn

; Receiver Consideration
Lwg = 10^(1.74/10)
Gwg = 1/Lwg

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

print, 'noise figure of HCR sytem is ', 10*alog10(F0)


stop
end