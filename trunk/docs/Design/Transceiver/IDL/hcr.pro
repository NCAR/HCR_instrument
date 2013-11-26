; NetCDF conversion
; Peisang Tsai version_1, May 19,2008
; This code is develop for VVVV pulse schem for now
;


pro hcr, filename

; get structure info
t = 1.0D
prf = 0.0
gatenum = 0L
READU, lun, t, prf, rxpulsewidth, gatenum
print, t, prf, rxpulsewidth, gatenum
CLOSE, lun

stop
    lun=10
    openr, lun, datafile, /get_lun

    hdr = header_w()
    readu, lun, hdr
    st = struct_w(hdr.gates)
    ngate = long(hdr.gates)
    tao = long(hdr.pw)
    prt1 = 1./(hdr.prf2)
    prt2 = 1./hdr.prf1 - 1./hdr.prf2
    frame = assoc(lun,st,52)

    rng = 24*findgen(ngate)/1000.

; numbers of blocks in datafile
    fs = fstat(lun)
    blocksize = 4L*(ngate*4) + 2*(ngate*8) + 4*(4)	;size of the structure
    nblocks = 0 
    iblock = (fs.cur_ptr - 52)/blocksize
    nblocks = long((fs.size - fs.cur_ptr)/blocksize)

; check parameters
    ;print, 'nblocks=',nblocks

; define arrays
    shh = fltarr(nblocks,ngate)
    svv = fltarr(nblocks,ngate)
    shv = fltarr(nblocks,ngate)
    svh = fltarr(nblocks,ngate)
    d1 = complexarr(nblocks,ngate)
    d2 = complexarr(nblocks,ngate)
    azim = fltarr(nblocks)
    elev = fltarr(nblocks)
    sec = lonarr(nblocks)
    usec = lonarr(nblocks)
    ;scan_idx = intarr(nblocks)
    nf = fltarr(1,10)
    vel_uf = fltarr(nblocks,ngate)
    avg_nf = fltarr(nblocks)
; read in datafile
    for i = 0, nblocks-1 do begin
 	st = frame(iblock)
	shh(i,*) = st.shh
    	svv(i,*) = st.svv
    	shv(i,*) = st.shv
    	svh(i,*) = st.svh
	d1(i,*) = st.d1
	d2(i,*) = st.d2
	azim(i) = st.azim
	elev(i) = st.elev
	sec(i) = st.sec
	usec(i) = st.usec
        iblock = iblock + 1
    endfor
    
; noise floor estimate from data
    avg_nf = svv(*,ngate-1)
    print, 'avg_nf estimate by echo=',median(avg_nf)

; locate blank profiles (no TX)
    leak = where(10*alog10(svv(*,28)) lt 80)
    leak1 = shift(leak,1)
    tmp = max(leak-leak1, ft)
    IF (tmp eq 1) THEN BEGIN
      et = 1
      ft = size(leak)
      ft = ft[1]
    ENDIF ELSE BEGIN
      et = size(leak)
      et = et[1] - ft
    ENDELSE

; take out no-transmition data and align zero range to 
; klystron leakage, range bin#28
    IF (org) THEN BEGIN   
      shh = shh(*,28:ngate-1)    
      svv = svv(*,28:ngate-1)    
      shv = shv(*,28:ngate-1)    
      svh = svh(*,28:ngate-1)    
      d1 = d1(*,28:ngate-1)    
      d2 = d2(*,28:ngate-1)    
      ngate = ngate-28
      print, 'org option specified...'
    ENDIF ELSE BEGIN
      shh = shh(ft-1:nblocks-et,28:ngate-1)    
      svv = svv(ft-1:nblocks-et,28:ngate-1)    
      shv = shv(ft-1:nblocks-et,28:ngate-1)    
      svh = svh(ft-1:nblocks-et,28:ngate-1)    
      d1 = d1(ft-1:nblocks-et,28:ngate-1)    
      d2 = d2(ft-1:nblocks-et,28:ngate-1)
      vel_uf = vel_uf(ft-1:nblocks-et,28:ngate-1)
      azim = azim(ft-1:nblocks-et)    
      elev = elev(ft-1:nblocks-et)    
      sec = sec(ft-1:nblocks-et)    
      usec = usec(ft-1:nblocks-et)    
      ngate = ngate-28
      adj = size(shh)			;adjust size of nblocks
      nblocks = adj[1]	
      iblock = nblocks   		
      ;print, 'nblocks_adj = ', nblocks
    ENDELSE

; noise power estimate
    Fn_rec = 10^(13./10)	; estimated noise figure = 13dB
    L_rec = 10^(3./10)		; estimated loss in waveguies
    Fn = L_rec + (Fn_rec-1) * L_rec
    Pn = 4e-21*6.25e6*Fn	; estimate noise power kBTF = -90 dBm

; SNR estimate
    snr = svv/mean(avg_nf) -1	; in decimal
    cal = decibel(mean(avg_nf)) - (decibel(Pn) + 30)	; data cal constant
    snr_db = decibel(snr)
    print, 'cal constant =',cal

;   create dummy load to stupid NetCDF-SOLO converter...
    dummy = intarr(ngate,nblocks)
    dummy(*,*) = 0.

; receiver cal using Doviak&Zrnic (eqn. 4.14)
; Z = Kp*R^2*Pr, where Pr=snr*Pn. Kp = radar constant
    c = 3e8
    lambda = c/95.04e9
    theta = .18*180/!pi	; 3dB beamwidth
    pw = hdr.pw*1e-9
    Pt = 10^(26./10)	; assume Pt = 56 dBm
    G = 10^(59./10)	; antenna gain = 59dB
    l = 10^(2./10)	; atmospheric loss
    Kp = 1/(8.76097e-08*l^2*lambda^2/(Pt*G^2*pw*theta^2)*1e18)
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

; position alignment
    azim_ctr = (azim + shift(azim,1))/2
    azim_ctr(0) = azim(1) - (azim(2)-azim(1))
    elev_ctr = (elev + shift(elev,1))/2
    elev_ctr(0) = elev(1) - (elev(2)-elev(1))

; scan detection, locate segments of scans
    ;azim = w_posfix(azim)
    ;elev = w_posfix(elev)

    brk_pt = w_setindices(azim_ctr(0:nblocks-1),elev_ctr(0:nblocks-1))
    itr = size(brk_pt,/dimensions)
    print, '# scans=', itr  
    print, 'segments are: ',brk_pt

; position plot for the entire raw data set
    wid = 11
    window, wid, title=datafile + '    Postion Info', xsize=650,$
                 ysize=450, xpos=730,ypos=0
    plot, azim, position=[0.1,0.1,0.48,0.95], xtitle='Time (min)', $
          subtitle='Azimuth',psym=2
    plot, elev, position=[0.58,0.1,0.96,0.95], /NOERASE, $
          xtitle='Time (min)', subtitle='Elevation',psym=2
    
; NetCDF generation
    IF (cdf) THEN BEGIN
      s1=0
      j=0
      FOR i=0,itr[0]-1 DO BEGIN

	s2 = brk_pt(j)
    	date = systime(0,sec(s1),/UTC)
    	d = bin_date(date)
        IF (corr) THEN BEGIN
           cdf_name = 'W' + string(d(0),d(1),d(2),d(3),d(4),d(5), $
                         format='(i4.4,5(i2.2))') + 'Zs' + $
                         string(i+1, format='(i2.2)') + '.corr.nc'
        ENDIF ELSE BEGIN
           cdf_name = 'W' + string(d(0),d(1),d(2),d(3),d(4),d(5), $
        	         format='(i4.4,5(i2.2))') + 'Zs' + $
                	 string(i+1, format='(i2.2)') + '.nc'
        ENDELSE
    	ncid = w2ncdf(cdf_name, s2-s1, ngate, azim(s1:s2-1), $
                 	 elev(s1:s2-1), sec(s1:s2-1),$
              		 tao, lat, lon, rot)

	z_tran = transpose(z(s1:s2-1,*))
        vel_uf_tran = transpose(vel_uf(s1:s2-1,*))
	phi_d1_tran = transpose(phi_d1(s1:s2-1,*))
	w_tran = transpose(w(s1:s2-1,*))
        snr_db_tran = transpose(snr_db(s1:s2-1,*))

    	w_data2ncdf, ncid, s2-s1, ngate, z_tran, /ZH
    	w_data2ncdf, ncid, s2-s1, ngate, vel_uf_tran, /VU
    	w_data2ncdf, ncid, s2-s1, ngate, phi_d1_tran, /VF
    	w_data2ncdf, ncid, s2-s1, ngate, w_tran, /W
    	w_data2ncdf, ncid, s2-s1, ngate, dummy(*,s1:s2-1), /ZDR
    	w_data2ncdf, ncid, s2-s1, ngate, dummy(*,s1:s2-1), /RHV
    	w_data2ncdf, ncid, s2-s1, ngate, dummy(*,s1:s2-1), /PHI
    	w_data2ncdf, ncid, s2-s1, ngate, dummy(*,s1:s2-1), /KDP
    	w_data2ncdf, ncid, s2-s1, ngate, snr_db_tran, /SNR

    	ncdf_close, ncid
    	print, 'NetCDF created.', cdf_name
    	s1 = s2 + 1
    	j = j + 1
      ENDFOR
   ENDIF
;stop
end
