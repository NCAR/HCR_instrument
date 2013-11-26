; HCR sensitivity investigation
; Peisang Tsai
; Update: Mar, 08, 2010

pro hcrsensitivity

c = 3e8
f = 94.40625e9
lambda = c/f
Pt = 10^(62./10)
Ga = 10^(44.5/10)
tau = 200e-9
Dant = 0.3 ; antenna diameter(m)
theda3dB = 65*lambda/Dant

;radar dwell time = 100ms
;Td = theda3dB*60/(360*n) where n is the rotation per minute
Td = 100e-3   
n = (theda3dB/180*!pi)/(6*Td)   ;rad/second
n_degree = n/!pi*180





stop

end