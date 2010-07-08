; This routine solve two equation for circles and calculate the intercept 
; area

pro beamoverlap

d = 19.25 * 2.54 /100    ; antenna spacing in meters
theda_tx = 0.68
theda_rx = 0.75
rng = findgen(1000)
r = rng * sin(theda_tx/180*!pi) / 2   ; transmit antenna beamwidth vs range. meters
a = rng * sin(theda_rx/180*!pi) / 2   ; receive antenna beamwidth vs range. meters

; SOLVE FOR INTERCEPT POINTS
x = (a^2-d^2-r^2)/(2*d)
y = sqrt(-x^2+r^2)



  ; TX SIDE AREA
  theda = 2 * ATAN((x(40:536)/y(40:536))
  area_tx = !pi*r^2*theda/360 - x(40:536)*y(40:536)
  ; RX SIDE AREA
  theda2 = 2 * ATAN((x(40:536)-d)/y(40:536))
  area_rx = !pi*a^2*(theda/360.) - (x(40:536)-d) * y(40:536)
  percentage = (area_tx + area_rx) / (!pi * r^2)

 


  ; TX SIDE AREA
  theda = 2* ATAN(x(rng)/y(rng))
  area_tx = !pi*r^2*(360-theda)/360. + x(rng) * y(rng)
  ; RX SIDE AREA
  theda2 = 2 * ATAN((x(rng)+d)/y(rng))
  area_rx = !pi*a^2*(theda/360.) - (x(rng)+d) * y(rng)
  percentage = (area_tx + area_rx) / (!pi * r^2)
;ENDIF






; PLOT X & Y SOLUTIONS
window, 0, xsize = 650, ysize=600
!p.multi=[0,1,2]
plot, x, xtitle='x', background = 255, color=0
plot, y, xtitle='y', background = 255, color=0









stop
end