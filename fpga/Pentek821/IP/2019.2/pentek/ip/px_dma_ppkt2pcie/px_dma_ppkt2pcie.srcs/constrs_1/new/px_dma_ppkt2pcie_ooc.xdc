#create_clock -period 4.000 -name aclk [get_ports aclk]
create_clock -period 4.000 [get_ports aclk]

set_property MAX_FANOUT 8 [get_cells -hierarchical *reader_inst/*]