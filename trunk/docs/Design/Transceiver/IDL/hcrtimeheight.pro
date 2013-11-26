; HCR timeheight plotting program. Peisang Tsai 
; Last updated:04/30/2010
;
; Arguments: 
;       datafile: filename
;       nt: time length in seconds
;       ngates: number of gates in datafile
;       prf: prf (1/Hz)
;       avgnum: numbers of average
;       GateResolution: Radar range resolution accorting to TX pulse. (meters)
;       offline: offline = 1 for playback option


FUNCTION hcrtimeheight, datafile, nt=nt, offline=offline

;
 if (not keyword_set(offline)) then offline=0
 if (not keyword_set(nt)) then nt=300          ; 300 sec

;
; create plotting window on screen
;
    wid=10
    window, wid, title=datafile + '  (Right Click to Stop)', $
      xsize=640, ysize=480, xpos=100, ypos=100
;
; create plotting window in memory (pixmap).  We will draw on this one.
;
    pix=11
    window, pix, xsize=640, ysize=480, /pixmap

    openr, lun, datafile, /get_lun
;
; wait until header has been written to file...
;
;    fs = fstat(lun)
;    while (fs.size le 100) do begin
;       wait, 1
;       fs = fstat(lun)
;    endwhile
;
;    hdr = header_w()
;    readu, lun, hdr
;
;    st = struct_w(hdr.gates)
;    nr = hdr.gates
    r = GateResolution*findgen(ngates)/1000.    ; kilometers
    r2 = r*r


;
; calculate # data frames per second
;
    np = fix(prf/avgnum + 0.5)
    ;np = fix((2.0 * prf) / avgnum + .5)  ; profiles per one second
;
; associate input file with array variable 
;
    frame = assoc(lun, st, 52)

    blocksize = 4L*(nr*4) + 2*(nr*8) + 4*(4)
;
    !p.multi=[0,1,2]
    !y.title='Range (km)'
    !x.title='Time (s)'

    lambda = 3e8/94.40625e9

    pim = bytarr(nt, nr)
    vim = bytarr(nt, nr)
    im=0

    loadct, 39

    while (1) do begin
;
; set active window to the pixmap
;  
       wset, pix
;
; see if new data is available in the file, read up to most recent
;
       nblocks=0
       repeat begin     
          if (~offline) then wait, .1
          fs = fstat(lun)
          iblock = fs.cur_ptr/blocksize           
          nblocks = (fs.size - fs.cur_ptr)/blocksize
       endrep until (nblocks gt np)       

;       if (~offline) then iblock = iblock + nblocks

       pwr = fltarr(nr)
       vel = complexarr(nr)
       for i=0L, np-1 do begin 
          st = frame(iblock)   
          pwr = pwr + (st.svv + st.shv)/2
          vel = vel + st.d1
          iblock = iblock+1
      endfor

                  
      pim(im, *) = bytscl(decibel(pwr/np), min=20, max=90)
 
      plotimage, pim, imgyrange=[r(0), r(nr-1)], yrange=[0,r(nr-1)]

      tau = 1./hdr.prf2
      vel = atan(vel, /phase)*lambda/(4*!pi*tau)

      vim(im, *) = bytscl(vel, min=-5, max=5)

      plotimage, vim, imgyrange=[r(0), r(nr-1)], yrange=[0,r(nr-1)]

      im = im+1
      if (im ge nt) then im = 0      
;
; print position and time to window
;
      str = string('Az', st.azim, '  El', st.elev, format='(a,f7.3,a,f7.3)')
      xyouts, 10, 10, str + '  ' + systime(0, st.sec, /utc), /dev
;
; now, copy the pixmap to the display window
;
      wset, wid 
      device, copy=[0, 0, !d.x_vsize, !d.y_vsize, 0, 0, pix]
;
; check to see if a mouse button has been pressed.
;
      cursor, ix, iy, /nowait
      if (!mouse.button eq 4) then goto, at_eof $       ;   right click, exit
      else if (!mouse.button eq 1) then $
         cursor, ix, iy, /up  ; left button, freeze
             
  endwhile

at_eof:
    close, lun
    free_lun, lun
    wdelete, wid
    wdelete, pix
    return
  

end


