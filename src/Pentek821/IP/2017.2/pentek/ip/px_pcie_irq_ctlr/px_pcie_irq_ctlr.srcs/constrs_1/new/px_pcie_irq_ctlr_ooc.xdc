#create_clock -period 4.000 -name saclk -waveform {0.000 2.000} [get_ports aclk]
create_clock -period 4.000 [get_ports aclk]