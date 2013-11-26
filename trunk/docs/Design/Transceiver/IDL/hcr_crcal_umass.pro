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

pro hcrcrcal_umass, debug=debug

IF (NOT keyword_set(debug)) THEN debug = 0

;pt = findgen(19)
;height = (184 - 48 + 6 * pt) * 2.54 / 100

height = [244, 250, 253, 256, 259, 262, 265, 271, 277]



; received raw power at the pentek (calibrated), in dBm
rawpwr = [-22.4897, -21.6781, -21.0708, -20.6355, $
          -20.7263, -21.0407, -22.0657, -22.5055, $
          -22.5246 ]


receiver_gain = 16.1 ; dB

pwr = rawpwr - receiver_gain



window, 1, xsize = 600, ysize = 450
device, decomposed =0   ; set graphic device to indexed color table
loadct, 0          
plot, height, pwr, color = 0, background = 255, $
      title = 'HCR Corner Reflector Measurement - UMASS Lens Antenna 05/17/2010 EL = 2.4 deg Rng = 100 m ', $
      xtitle =' Height (m)', ytitle = 'Received Power at Antenna (dBm)'

write_png,'HCR_CornerRef_Cal_UMASS_05172010.png', tvrd(true=1)

IF (debug) THEN BEGIN
stop
ENDIF



end
