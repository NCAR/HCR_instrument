; This routine calculate the maximum radar cross-section along the alignment
; axis

pro hcr_cornerreflector, plot=plot, fix_pr=fix_pr, debug = debug

IF (NOT keyword_set(plot)) THEN plot = 0
IF (NOT keyword_set(fix_pr)) THEN fix_pr = 0
IF (NOT keyword_set(debug)) THEN debug = 0

c = 3e8
f = 94.40625e9
lambda = c/f

; CORNER REFLECTOR PARAMETERS , Ulaby eqn.[10.27 & 10.28]
length = 2.375  ; lengh in inch
l = length*2.54/100  ; length of each edge in meters
Aeff = l^2/sqrt(12.)    ; effective area of CR
Sigma_max = 4*!pi/(lambda^2)*Aeff^2

; ANTENNA PARAMETERS
;Ga_tx = 10^(46.21/10)  ; transmit antenna gain, UMASS
Ga_tx = 10^(46.21/10)  ; transmit antenna gain
Ga_rx = 10^(46.3/10)  ; receive antenna gain
Ae_ant = lambda^2*Ga_rx/(4.0*!pi) ; receive antenna effective area

; RADAR PARAMETERS
Pt = 10^((60.51-1.8-0.26)/10)      ; transmit power in milliwatts
r = 100L         ; range in meters
rng = findgen(600)

; ANTENNA OVERLAP EFFICIENCY
spacing_baseline = 19.25 * 2.54 /100    ; antenna spacing in meters
theda_tx = 0.68
theda_rx = 0.75
halfbeamW_tx = r * sin(theda_tx/180*!pi) / 2
halfbeamW_rx = r * sin(theda_rx/180*!pi) / 2
illuminated_tx_area = !pi* halfbeamW_tx^2

; BEAMWIDTH INTERCEPTION
; http://mathworld.wolfram.com/Circle-CircleIntersection.html
rtx = halfbeamw_tx
rrx = halfbeamw_rx
d = spacing_baseline
chord = sqrt((-1*d + rtx - rrx)*(-1*d - rtx + rrx)*(-1*d + rtx + rrx)*(d + rtx + rrx)) / d
theda_rx = 2 * ASIN(chord/(2*rrx))
theda_tx = 2 * ASIN(chord/(2*rtx))
Arx = !pi*rrx^2*(theda_rx/!pi*180)/360. - sqrt(rrx^2-(chord/2)^2)*chord/2
Atx = !pi*rtx^2*(theda_tx/!pi*180)/360. - sqrt(rtx^2-(chord/2)^2)*chord/2
P_illuminated = 1;(Arx + Atx) / (!pi*rtx^2)


; ILLUSTRATIONS
IF (plot) THEN BEGIN
DEVICE, DECOMPOSED = 0, retain = 2
window, 0, xsize=620, ysize=600
PLOT, FINDGEN(4), /NODATA, color = 0, background =255
TVCIRCLE, halfbeamW_tx, 2, 2, color = 0, /data
TVCIRCLE, halfbeamW_rx, 2-spacing_baseline, 2, color = 100, /data
ENDIF

; POWER RECEIVED, Skolnik eqn. [1.6]
Pr = Pt*P_illuminated*Ga_tx*sigma_max*Ae_ant/(4*!pi)^2/rng/rng/rng/rng

window, 1, xsize = 600, ysize = 400
plot, decibel(pr), title='Power Received from Corner reflector l=2.375 inch', xtitle = 'Range (m)',$
  ytitle='Power (dBm)', color=0, background = 255


; REVERSE ENGINEERING
IF (fix_pr) THEN BEGIN
;rng = findgen(350)
Pr_set = 10^(-20./10)
Sigma_sphere = Pr_set*(4*!pi)^2*rng*rng*rng*rng/(Pt*Ga_tx*Ae_ant)
radius = sqrt(sigma_sphere/!pi)
Aeff_trihedral_modified = sqrt((sigma_sphere*lambda^2)/(4*!pi))
l_trihedral_modified = sqrt(Aeff_trihedral_modified/0.289)
;window, 1
;plot, sigma_sphere, color = 0, background =255
END

; PARAMETERS CHECK
IF (debug) THEN BEGIN
print, 'CAL target range =', r, '(m)'
print, 'Calculated receive power = (dBm)', decibel(pr)
print, 'Illumination Percentage =', P_illuminated * 100, ' %'
END

stop

end