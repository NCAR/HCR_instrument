onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib px_adc12d1800_gainoffset_opt

do {wave.do}

view wave
view structure
view signals

do {px_adc12d1800_gainoffset.udo}

run -all

quit -force
