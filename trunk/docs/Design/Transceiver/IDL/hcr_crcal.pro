; AUTHOR: Peisang Tsai
; DATE: 05/20/2010
;
; THIS ROUTINE IS TO PLOT THE MEASURED RECEIVED POWER AT PENTEK DIGITIZER
; WITH THE FOLLOWING SET UP ON 05/19/2010
; CORNER REFLECTOR DIMENSION : 2.375 INCH
; DISTANCE FROM THE RADAR = 100 METERS
; REFLECTOR/ELEVATION ANGLE = 1.4 DEGREES
; 
; CORNER REFLECTOR HEIGHT IS CALCULATED BY TAN(1.4)*100 AND COMPARE WITH
; PREVIOUS MEASUREMENTS. THE GROUND OFFSET IS 2.2 METERS
; 
; ANTENNA WAS ALIGNED/PEAKED WITH THE FAR-RANGE (~7km) MOUNTAIN PRIOR TO 
; THIS MEASUREMENT.
;
; ANTENNA USED: TX:NOAA W-BAND CASSAGRAIN; RX: UWYOMING W-BAND CASSAGRAIN
; 
; RECEIVER SETUP: REMOVED W-BAND POWER AMP AND INSTALLED THE 30dB W/G
; ATTENUATOR FOR THIS MEASUREMENT. GOAL: AVOIDING SATURATION AT W-BAND
; MIXER. 

pro hcrcrcal, debug=debug

IF (NOT keyword_set(debug)) THEN debug = 0

pt = findgen(19)
height = (184 - 48 + 6 * pt) * 2.54 / 100

; received raw power at the pentek (calibrated), in dBm
rawpwr = [-64.8356,-64.5056,-69.0840,-60.1602, $
          -52.6926,-45.4442,-40.4049,-36.5556, $
          -32.8397,-30.5204,-29.6962,-29.3106, $
          -29.3776,-29.4100,-29.6563,-30.4616, $
          -31.5630,-36.0477,-40.9253 ]

receiver_gain = -10.84 ; dB

pwr = rawpwr - receiver_gain



window, 1, xsize = 600, ysize = 450
device, decomposed =0   ; set graphic device to indexed color table
loadct, 0          
plot, height, pwr, color = 0, background = 255, $
      title = 'HCR Corner Reflector Measurement 05/19/2010 EL = 1.4 deg Rng = 100 m ', $
      xtitle =' Height (m)', ytitle = 'Received Power at Antenna (dBm)'

;write_png,'HCR_CornerRef_Cal_05192010.png', tvrd(true=1)

IF (debug) THEN BEGIN
stop
ENDIF



end
