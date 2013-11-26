  function hcrstruct, ngates

     struct = { STRUCT_HCR,  $
                time      :      $ ; h-channel (co-pol)
                svv       : fltarr(ngates),     $ ; v-channel (co-pol)
                shv       : fltarr(ngates),     $ ; v-channel (cross-pol)
                svh       : fltarr(ngates),     $ ; h-channel (cross-pol)
                d1        : complexarr(ngates), $ ; h pulse-pair
                d2        : complexarr(ngates), $ ; v pulse-pair
    azim      : 0.,                 $ ; position
    elev      : 0.,                 $ ; position
    sec       : 0L,                 $ ; time stamp
                usec      : 0L }

     return, s
  end
