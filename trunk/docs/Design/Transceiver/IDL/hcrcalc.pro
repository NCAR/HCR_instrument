; NetCDF conversion
; Peisang Tsai version_1, May 19,2008
; This code is develop for VVVV pulse schem for now
;
; Argument:
;	- 'org', program will show the raw data, including no TX data
;	- 'lat', latitude info 
;	- 'lon', longitue info
;	- 'rot', rotation info
;	- 'cdf', does NetCDF conversion
; 	- 'corr', apply position and Doppler correction
;	- 'wtpos', write a png file for position data

pro hcrcalc


; noise power estimate
    Bn = 2e6
    Fn_rec = 10^(7.53846/10)	; estimated noise figure = 13dB
    L_rec = 10^(1.3/10)		; estimated loss in waveguies
    Fn = L_rec + (Fn_rec-1) * L_rec
    Pn = 4e-21*Bn*Fn	; estimate noise power kBTF 

; SNR estimate
;    snr = svv/mean(avg_nf) -1	; in decimal
;    cal = decibel(mean(avg_nf)) - (decibel(Pn) + 30)	; data cal constant
;    snr_db = decibel(snr)
;    print, 'cal constant =',cal


; receiver cal using Doviak&Zrnic (eqn. 4.14)
; Z = Kp*R^2*Pr, where Pr=snr*Pn. Kp = radar constant
    c = 3e8
    f = 94.40625e9
    lambda = c/f
    Dant = 0.3 ; antenna diameter(m)
    theda3dB = 65*lambda/Dant
    theta = theda3dB*180/!pi	; 3dB beamwidth radian
    pw = 1e6
    Pt = 10^(32./10)	; assume Pt = 62 dBm
    G = 10^(44.5/10)	; antenna gain (tx) = 44.5dB
    l = 10^(2./10)	; atmospheric loss
    Kp = 1/(8.76097e-08*l^2*lambda^2/(Pt*G^2*pw*theta^2)*1e18)
    stop
    rng = 24*findgen(ngate)
    r2 = rebin(transpose(rng*rng),nblocks, ngate)
 
    Z = Kp*Pn*snr*r2
    z_db = decibel(Z)

; Calculate velocity using Doviak&Zrnic (eqn. 7.6a) 
    phi_d1 = -atan(d1, /PHASE)*lambda/(4*!pi*prt2)
    phi_d2 = -atan(d2, /PHASE)*lambda/(4*!pi*prt1)

; Doppler Velocity correction
    vel_um = lambda/(4*(prt1-prt2))
    vel_uf = lambda/(4*!pi*(prt1-prt2))*atan(d1/d2, /PHASE)

; spectral width, (eqn. 7.7), this method is noisier than single pulse 
; pair estimation
    ;w = lambda/(2*!pi*(sqrt(2*(prt2^2-prt1^2))))*sqrt(alog(abs(phi_d1/phi_d2)))

; (eqn. 6.27), Doviak&Zrnic, another solution....
    s = svv - mean(avg_nf)
    w = lambda/(2*!pi*prt1*1.414)*sqrt(abs(alog(s)-alog(abs(d1)*(1+1/snr))))


stop
end
