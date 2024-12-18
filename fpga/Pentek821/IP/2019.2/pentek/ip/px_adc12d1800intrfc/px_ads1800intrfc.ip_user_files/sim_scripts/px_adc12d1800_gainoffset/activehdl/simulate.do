onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+px_adc12d1800_gainoffset -L xil_defaultlib -L xpm -L xbip_dsp48_wrapper_v3_0_4 -L xbip_utils_v3_0_10 -L xbip_pipe_v3_0_6 -L xbip_dsp48_macro_v3_0_17 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.px_adc12d1800_gainoffset xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {px_adc12d1800_gainoffset.udo}

run -all

endsim

quit -force
