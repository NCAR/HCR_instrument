; IDL ROUTINE TO READ HCR TIME-SERIES DATA
; AUTHER: PEISANG TSAI
; DATE: MAY 20, 2010
;
; Data format is described below
; [8-Byte float time in seconds since 1970 UTC][4-byte float; prf][4-Byte integer; ngates][2-Byte integer I][2-Byte integer Q]...
; 
; ARGUMENTS: 
; FILENAME: *.DAT
; /PLOT: OUTPUTS REFLECTIVITY, SNR, SPECTRAL WIDTH AND VELOCITY PLOTS
; /DEBUG:
; /VERBOSE: PRINTS VARIABLES 
; /WRITE_DATA: OUTPUT A DATA FILE (*.txt) WITH ALL FIELDS 

; NOTE: for each 100MB data at prf = 6975.45, data = 22.803 seconds long

pro hcr_readdat_more, filename1, filename2, filename3, filename4, plot=plot, debug=debug, verbose=verbose, write_data = write_data, umass=umass

IF (NOT keyword_set(plot)) THEN plot = 0
IF (NOT keyword_set(debug)) THEN debug = 0
IF (NOT keyword_set(verbose)) THEN verbose = 0
IF (NOT keyword_set(write_data)) THEN write_data = 0
IF (NOT keyword_set(umass)) THEN umass = 0

;;;; ************************* RADAR PARANETER BANK ************************* ;;;;
effectiveBW = 700e3 ; reveiver bandwidth
tao = 1.0 ; microseconds Pentek digitizer pulsewidth
rangeresolution = 3e8 * tao * 0.5e-6 / 2000.0   ; kilometers
lambda = 3e8/94.40625e9   ; meters
avgnum = 200L

;;;; ************************************************************************ ;;;;

; DATA FILE INFO
OPENR, lun, filename, /GET_LUN
status = FSTAT(lun)

t = 1.0D
prf = 0.0
gatenum = 0L
READU, lun, t, prf, rxpulsewidth, gatenum
print, t, prf, rxpulsewidth, gatenum
CLOSE, lun


; RAW STRUCTURE INFO
raysize = 20 + 4*gatenum  ; DATA SIZE (BYTES) FOR 1 RAY
start_ptr = status.cur_ptr/raysize
tsSize = LONG((status.size - status.cur_ptr)/raysize)

; HCR DATA STRUCTURE PER RAY
OPENR, lun, filename, /GET_LUN
data = {a, time:0.0D, prt:0.0, rxpulsewidth:0.0, ngates:0L,iqdata:INTARR(2*gatenum)}
hcrdata = REPLICATE(data, tsSize)
READU, lun, hcrdata
FREE_LUN, lun

; CONSTRUCT I & Q DATA ARRAY
iqdata = TRANSPOSE(hcrdata.iqdata)
idata = INTARR(tsSize,gatenum)
qdata = idata

; CREATE ARRAY INDEX, EXTRACT I & Q FROM IQDATA
odd_idx = INDGEN(gatenum, /LONG)
even_idx = 2*odd_idx
odd_idx = 2*odd_idx-1
odd_idx = SHIFT(odd_idx, -1)
odd_idx(gatenum -1) = 2 * gatenum - 1

idata = iqdata(0:tsSize-1,[even_idx])
qdata = iqdata(0:tsSize-1,[odd_idx])

; CONVERT ARRAY INTO FLOAT.
idata = 1.0 * (idata)
qdata = 1.0 * (qdata)

; CONSTRUCT COMPLEX IQ ARRAY
GoComplex = COMPLEXARR(tsSize, gatenum)
GoComplex(0:tsSize-1,*) = COMPLEX(idata(0:tsSize-1,*),qdata(0:tsSize-1,*))


; DECLARE PROCESS ARRAY TYPE: FLOAT
shh = idata
shh = FLOAT(GoComplex * CONJ(GoComplex))

; calibrated to known -20dBm signal
; 57.67 dB is the raw value for -20dBm known power level.
calibration = 57.6664 - (-20)  
cal_decimal = 10^(calibration/10)


; RADAR CONSTANT
Kp = hcr_radarconstant(tao)   

IF (umass) THEN BEGIN
; for UMASS Ant datasets
Radar_constant = decibel(Kp) + 18.2649
Kp = 10^(Radar_constant/10)
print, 'Kp with UMASS =', decibel(kp)
ENDIF

; APPLY AVERAGING
testavg = FLTARR(avgnum, gatenum)
avgpwr = FLTARR(tsSize/avgnum, gatenum)
avgang = COMPLEXARR(tsSize/avgnum, gatenum)
dlag1 = COMPLEXARR(tsSize-1, gatenum)
avgdlag1 = COMPLEXARR(tsSize/avgnum, gatenum)

FOR i = 0L, tsSize-2 DO BEGIN
  dlag1 (i, *) = GoComplex(i, *) * CONJ(GoComplex(i+1, *))
ENDFOR

FOR k =0L, tsSize/avgnum-1 DO BEGIN
  testavg = shh( k * avgnum:(k + 1) * avgnum - 1, *)
  testang = GoComplex( k * avgnum:(k + 1) * avgnum - 1, *)
  avglag = dlag1(k * avgnum:(k+1) *avgnum -1, *)
  avgpwr(k, *) = TOTAL(testavg,1)/avgnum
  avgang(k, *) = TOTAL(testang,1)/avgnum
  avgdlag1(k, *) = TOTAL(avglag, 1)/avgnum
ENDFOR

; AVERAGED RAW DATA ARRAY: RXAVGPWR (CALIBRATED TO DIGITIZER)
rxavgpwr = avgpwr/cal_decimal

; APPLY RANGE CORRECTION
rng = rangeresolution * findgen(gatenum)
r2 = rebin(transpose(rng*rng),tsSize/avgnum, gatenum)

; SAMPLE NOISE FLOOR FROM DATASETS
rxnoisefloor = median(rxavgpwr(*, gatenum-10:gatenum-1))

; calculate velocity Doviak&Zrnic [eqn. 6.58]
phi_d1 = -atan(avgdlag1, /PHASE)*lambda/(4*!pi)*prf

; REFLECTIVITY
SNR = rxavgpwr/rxnoisefloor;-1

Pn = 10^(-106.398/10)

Z = Kp*Pn*snr*r2
;Z = Kp*rxavgpwr*r2

; SPECTRAL WIDTH (eqn. 6.27), Doviak&Zrnic, another solution....
s = avgpwr - rxnoisefloor
w = lambda*prf/(2*!pi*SQRT(2))*SQRT(ABS(ALOG(s)-ALOG(ABS(avgdlag1)*(1+1/snr))))

; COMPARISION WITH NEXRAD DATA. SMOOTHING DATA INTO ONE BEAM
nexrad_beam = z(*, 44:58)
;avg_nexrad = total(z(*, 44:58), 2)/15.
weighing = gaussian([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], [1,7,5.9957])
weight_array = FLTARR(15, 610)
FOR i = 0, 609 DO BEGIN
weight_array(*, i) = weighing(0,*)
ENDFOR

result = nexrad_beam # weight_array





DEVICE, DECOMPOSED = 0
window, 0, Xsize = 600, ysize = 400
plot, decibel(result(*,100)), xtitle='Time', ytitle='Reflectivity (dBZ)', title = filename, color = 0, background =255, xrange=[0,609], xstyle=1
window, 2, xsize = 600, ysize = 400
plot, weighing, title='Gaussian Function', color = 0, background =255


a = hcr_param(tao)


IF (verbose) THEN BEGIN
print, 'Number of average is ', avgnum
print, 'current_ptr =', status.cur_ptr
print, 'filesize =', status.size
print, 'data calibration value=', calibration
print, 'Radar Constant is ', decibel(Kp)
print, 'Reference Noise Power is ', decibel(pn)
ENDIF


IF (plot) THEN BEGIN
window, 1, xsize=800, ysize=1200,title=filename
loadct, 39
!p.multi=[0,1,2]
!p.charsize=1.5
plotheight = 5.0  ; kilometers
startrng = 3.0    ; kilometers

plotimage,bytscl(decibel(z), min = -50, max = 10), $
                xtitle='Reflectivity  (dBZ)', ytitle='Height (km)',/NOERASE,$ 
                position=[0.1,0.55,0.89,0.97],$
                imgyrange=[0,max(rng)] , yrange = [startrng,plotheight], $
                imgxrange=[0,tsSize/avgnum-1];$
                title=filename
colorbar, position=[0.93,0.55,0.97,0.97],maxrange=10,minrange=-50,$
                /vertical   
     
loadct_rb
plotimage, bytscl(phi_d1, min=-6, max=6), xtitle='Velocity (m/s)',$
                ytitle='Height (m)',imgyrange=[0,max(rng)],/NOERASE,$
                position=[0.1,0.04,0.89,0.5], yrange=[startrng,plotheight],imgxrange=[0, tsSize/avgnum-1]
colorbar, position=[0.93,0.04,0.97,0.5],maxrange=6,minrange=-6,$
              /vertical
                
;plotimage,bytscl(decibel(z), min = -50, max = 10), $
;                xtitle='Reflectivity  (dBZ)', ytitle='Height (km)',/NOERASE,$ 
;                position=[0.1,0.75,0.90,0.94],$
;                imgyrange=[0,max(rng)] , yrange = [0,plotheight], $
;                imgxrange=[0,tsSize/avgnum-1];$
;                title=filename
;colorbar, position=[0.93,0.75,0.97,0.94],maxrange=10,minrange=-50,$
;                /vertical   
     
;plotimage, bytscl(decibel(snr), min=-20, max=60), $
;                xtitle='Signal to Noise Ratio (dB)',ytitle='Height (m)',$
;                imgyrange=[0,max(rng)], position=[0.1,0.52,0.90,0.71],$
;                /NOERASE, yrange=[0,plotheight],imgxrange=[0,tsSize/avgnum-1]
;colorbar, position=[0.93,0.52,0.97,0.71],maxrange=60,minrange=-20,$
;                /vertical
      
;plotimage, bytscl(w, min=0, max=2.), $
;                xtitle='SpectralWidth (m/s)',ytitle='Height (m)',$
;                imgyrange=[0,max(rng)],position=[0.1,0.28,0.90,0.47],$
;                yrange=[0,plotheight],/NOERASE,imgxrange=[0,tsSize/avgnum-1]
;colorbar, maxrange=2.,minrange=0.,position=[0.93,0.28,0.97,0.47],$
;                /vertical
     
;loadct_rb
;plotimage, bytscl(phi_d1, min=-6, max=6), xtitle='Velocity (m/s)',$
;                ytitle='Height (m)',imgyrange=[0,max(rng)],/NOERASE,$
;                position=[0.1,0.04,0.90,0.25], yrange=[0,plotheight],imgxrange=[0, tsSize/avgnum-1]
;colorbar, position=[0.93,0.04,0.97,0.25],maxrange=6,minrange=-6,$
;              /vertical   
ENDIF


IF (debug) THEN BEGIN
; investigation
;window, 0, xsize = 800, ysize = 800
;!p.multi = [0,1,2]
;plot, decibel(rxavgpwr(100, *)), xtitle=' average rx power'
;plot, decibel(snr(100,*)), xtitle='SNR'
;plot, decibel(rxavgpwr(*, 5))
;print, 'rxavgpwr is ', median(decibel(rxavgpwr(*, 20:99)))
print, 'median calibrated RX power is', decibel(median(rxavgpwr(*,5)))
print, 'mean calibrated RX power is', decibel(mean(rxavgpwr(*,5)))
ENDIF


IF (write_data) THEN BEGIN
str = STRMID(filename, 0, 23) + 'txt'
OPENW, 10, str

FOR i = 0, tsSize/avgnum-1 DO BEGIN
  PRINTF, 10, GoComplex(i, *)
  PRINTF, 10, z(i, *)
  PRINTF, 10, w(i, *)
  PRINTF, 10, phi_d1(i, *)
ENDFOR

CLOSE, 10
ENDIF



; converting time
txttime = STRARR(tsSize/avgnum)
time = hcrdata.time
FOR i = 0L, tsSize/avgnum-1 DO BEGIN
txttime(i) = STRMID(cmsystime(time(i*avgnum)), 11, 8)
ENDFOR
deltat = 1.0/prf ;seconds
timetag = FINDGEN(tsSize/avgnum)/prf*avgnum  ; time tag in seconds



stop
end
