; THIS ROUTINE PROVIDE A LOOK-UP TABLE FOR LIQUID
; WATER PARAMETER (ABS(KW))^2

function kw_sqr, system_temp

IF (system_temp lt 273.) OR (system_temp gt 307.) THEN BEGIN
  print, ' System temperature range should be between 273K - 307K'
  print, ' Use default temperature for calculation. T = 300K'
  Kw_out = 0.8490

ENDIF ELSE BEGIN

idx = findgen(18)
abstemp = 273.
temp = abstemp + 2* idx

K2 = [0.6856, 0.7015, 0.7167, 0.7312, 0.7451, 0.7582, $
      0.7707, 0.7824, 0.7935, 0.8038, 0.8135, 0.8225, $
      0.8308, 0.8368, 0.8457, 0.8523, 0.8583, 0.8638 ]
      
idx_1 = where(temp lt system_temp)
idx_2 = where(temp gt system_temp)

IF (min(idx_2) - max(idx_1)) gt 1 THEN kw_out = k2[max(idx_1)+1] $
ELSE kw_out = (k2[max(idx_1)]+k2[min(idx_2)])/2

ENDELSE

return, Kw_out 
   
end