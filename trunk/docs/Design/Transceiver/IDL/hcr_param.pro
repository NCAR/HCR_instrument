; AUTHOR: PEISANG TSAI
; DATE: 06/11/2010
; 
; THIS ROUTINE INCLUDES ALL HCR PHASE 0 PARAMETERS
; AND CONCLUDS ALL MEASUREMENTS PRIOR TO 05/21/2010
;
; SYSTEM PARAMETERS:
; W/G & COUPLER I.L. LOSS ON TX PATH = 1.6 dB
; W/G & SWITCH I.L. LOSS ON RX PATH = 1.7 dB
; TEFLON RADOME LOSS (ONE-WAY) = 0.13 dB
; 
;

function hcr_param, tao, verbose=verbose

IF (NOT keyword_set(verbose)) THEN verbose = 0


; CONSTANTS
systemp = 27  ; in Celcius
k = 1.38e-23  ; Boltzmann's constant
T0 = systemp + 273  
c = 3e8
f = 94.40625e9
lambda = c/f/0.01 ; centermeters
Bn = 700e3/tao    ; Hz, digital receiver bandwidth
Pt = 10^((32.-1.6-0.13)/10) ; Watts; assume Pt = +62dBm
w_sqr = kw_sqr(T0)
theda_az = 0.75 ; in degrees, 3dB beamwidth
theda_el = 0.68 ; in degrees
Gatx = 10^(46.21/10) ; antenna gain = 44.5dB
Garx = 10^(46.3/10) 
l = 10^(2./10)  ; atmospheric loss
lr = 10^(1.1/10)  ; recevier filter mismatch
Grx = 10^(39.48/10)


; RADAR CONSTANT CALCULATION
Kp = (6.75*2^14*alog(2)*lambda^2*lr)/(!pi^5*1e-17*Pt*Gatx*Garx*tao*theda_az*theda_el*w_sqr)


; NOISE FIGURE & NOISE TEMPERATURE
; based on measurement 04/07/2010, using Pentek system. From noise source to data system. 
;Nhot = 10^((-52.3)/10)
;Ncold = 10^((-65.8)/10)

;measurements on 4/27/10
Nhot = 10^((-37.6699)/10)
Ncold = 10^((-51.6152)/10)


; Y-FACTOR 
Y = Nhot/Ncold
ENR = 10^(20.84/10)
F = ENR/(Y-1)
l = 10^((1.7+0.13)/10) ; loss prior to LNA
Fsys =  l + (F-1) * l

; SYSTEM EQUIVILENT TEMPERATURE 
Te = (Fsys-1)*T0

; Tx front-end W/G loss is 1.5dB
; bench-top measured gain = 36.69 on 1/13/2010
; bench-top measured gain = 38.21dB 3/25/2010
; DR receiver measured gain from effective noise bandwidth 700kHz is 39.249dB 4/22/2010
; DR receiver measured gain injecting a W-band signal @ -60.18dBm is 39.48dB 5/21/2010
; theda3dBrx = 0.75 degree, Garx = 46.3 dB  (UWYOMING)
; theda3dBtx = 0.68 degree, Gatx = 46.21 dB (NOAA)


Pn = k*Te*Bn
Pnrx = Grx*k*Te*Bn

;CONSTRUCT HCR PARAMETER ARRAY
;[Y-FACTOR(Decimal), RX_BW(Hz), PW(us), Tsys(K), Fsys(Decimal), Pn(Watt), Kp(Decimal)]
PARAM = FLTARR(7)
PARAM(0) = Y
PARAM(1) = Bn
PARAM(2) = tao
PARAM(3) = Te
PARAM(4) = Fsys
PARAM(5) = Pn
PARAM(6) = kp



IF (verbose) THEN BEGIN
;ENDIF
print, 'Y-factor =', y
print, 'System bandwidth = ', Bn, '(Hz)'
print, 'System Equivilant Temp =', Te
print, 'System Noise Figure = ', decibel(Fsys)
print, 'RX noise power at LNA =', decibel(Pn) + 30, '(dBm)'
print, 'RX noise power at digitizer =', decibel(Pnrx) + 30 , '(dBm)'
print, 'Kp = ', decibel(kp)
print, 'HCR PARAMETER ARRAY IS', param
ENDIF

return,  param

end