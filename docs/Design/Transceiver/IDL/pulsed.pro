pro pulsed

theda = findgen(1000)/1000*2*!pi
f = 94.40625e9
prf = 10e3
pw = 1e-6
sinewave = sin(theda)

plot, sin(theda)/theda
stop
end
