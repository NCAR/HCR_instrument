; hcr radar cross-section & corner reflector
; peisang tsai
; date: May 20, 2010

; HCR corner reflector is determined to be 2.375 inch. 

pro w_trihedral, plot=plot, debug=debug

IF (NOT keyword_set(plot)) THEN plot = 0
IF (NOT keyword_set(debug)) THEN debug = 0

f = 94.40625e9
c = 3e8
lambda = c/f
R = findgen(500) 
Pt = 10^((32.-1.6-0.13)/10) ; Watts
Pr = 10^(-41./10) ; 1-dB compression for W-band Mixer

Dant = 0.3 ; antenna diameter(m)
theda3dB = 65*lambda/Dant
;G = 26000./theda3dB^2 ; Skolnik [2.54 & 2.55]
G = 10^(46.25/10)  ; average antenna gain for both TX/RX
Aant = lambda^2*G/(4*!pi)
Sigma_max = Pr*(4*!pi)^2*R^4/(Pt*G*Aant)

; trihedral corner reflector. Ulaby [10.27 & 10.28]
; Sigma_max assuming corner ref is at radar's line of sight
Aeff = sqrt(sigma_max*lambda^2/(4*!pi))
l = sqrt(Aeff/0.289)


; REVERSE ENGINEERING. L = 2.25 INCH
; Calculation based on a 2.25" corner reflector
lcr = 2.25*2.54/100 ; length = 2.25 inch
Aeffcr = lcr^2*0.289
sigma_max_cr = aeffcr^2*4*!pi/lambda^2
Prcr = sigma_max_cr*Pt*G*Aant/(r^4*(4*!pi)^2)




IF (plot) THEN BEGIN
; making plots.....yay~
device, decomposed =0   ; set graphic device to indexed color table
loadct, 0
window,0
!p.multi = [0,0,2]
plot, R, Sigma_max, xtitle='Range (m)', ytitle='Radar Cross Section (m^2)', color=0, background=255, charsize=2
plot, R, l*100, xtitle='Range (m)', ytitle='Maximum corner reflector length (cm)',color=0, background=255, charsize=2, /noerase
write_png,'HCR-Trihedral-Design.png', tvrd(true=1)
!p.multi=0
window, 1
plot, sin(theda3dB/180*!pi)*R, xtitle='Range (m)', ytitle='Pencil Beam dimension (m)',color=0, background=255, charsize=2, title='Beam spread vs. Range'
;print, 'Trihedral corner reflector length = (m)',l
write_png,'HCR-ant-beamwith.png', tvrd(true=1)

window,2
plot, R, 10*alog10(Prcr), xtitle='Range (m)', ytitle='Receive Power, Pt (dBm)', color=0, background = 255, charsize=2
write_png, 'HCR-CornerReflector-Pt.png', tvrd(true=1)
ENDIF

IF (debug) THEN BEGIN
stop
ENDIF

end

