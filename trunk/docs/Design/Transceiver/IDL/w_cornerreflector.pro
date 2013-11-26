; This routine calculate the corner reflector dimension according to HCR radar parameters
; AUTHOR: PEISANG TSAI
; DATE:06/09/2010

pro w_cornerreflector, plot=plot

IF (NOT keyword_set(plot)) THEN plot = 0

c = 3e8
f = 94.40625e9
lambda = c/f
rng = findgen(350)    ; range in meters


; ANTENNA PARAMETERS
Ga_tx = 10^(46.21/10)  ; transmit antenna gain
Ga_rx = 10^(46.3/10)  ; receive antenna gain
Ae_ant = lambda^2*Ga_rx/(4.0*!pi) ; receive antenna effective area

; RADAR PARAMETERS
Pt = 10^((62.-1.8-0.26)/10)      ; transmit power in milliwatts
Pr = 10^(-23./10)

; RCS, Skolnik eqn. [1.6]
Sigma_CR = (Pr*(4*!pi)^2*rng^4)/(Pt*Ga_tx*Ae_ant) 

; CORNER REFLECTOR PARAMETERS , Ulaby eqn.[10.27 & 10.28]
Aeff_CR = sqrt((Sigma_CR*lambda^2)/(4*!pi))
l_CR = sqrt(Aeff_CR*sqrt(12.))



IF (plot) THEN BEGIN
device, decomposed = 0
window, 0, xsize = 600, ysize = 500
plot, l_cr*100/2.54, color=0, background = 255, title = 'W-band Corner Reflector Dimension Pr = -23 dBm', $
     xtitle = 'Range (m)', ytitle = 'Length of Edge (inch)'
ENDIF
stop

end