
connect_debug_port u_ila_0/probe0 [get_nets [list {gpio_regs/ctl3_out[0]} ]]
connect_debug_port u_ila_0/probe1 [get_nets [list {gpio_regs/control_flags[0]} {gpio_regs/control_flags[1]} ]]


connect_debug_port u_ila_0/probe2 [get_nets [list gpio_regs/controller_running]]





set_property MARK_DEBUG true [get_nets dataio_intrfc_i/dataio_intrfc_i/syncbus_a/U0/gate_trig_se_out]
connect_debug_port u_ila_0/probe20 [get_nets [list gpio_regs/ROT_A]]
connect_debug_port u_ila_0/probe21 [get_nets [list gpio_regs/ROT_B]]



connect_debug_port u_ila_1/probe5 [get_nets [list {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[0]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[1]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[2]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[3]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[4]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[5]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[6]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[7]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[8]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[9]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[10]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[11]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[12]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[13]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[14]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[15]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[16]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[17]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[18]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[19]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[20]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[21]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[22]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[23]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[24]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[25]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[26]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[27]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[28]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[29]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[30]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[31]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[32]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[33]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[34]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[35]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[36]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[37]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[38]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[39]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[40]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[41]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[42]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[43]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[44]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[45]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[46]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[47]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[48]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[49]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[50]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[51]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[52]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[53]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[54]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[55]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[56]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[57]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[58]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[59]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[60]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[61]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[62]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[63]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[64]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[65]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[66]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[67]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[68]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[69]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[70]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[71]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[72]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[73]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[74]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[75]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[76]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[77]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[78]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[79]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[80]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[81]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[82]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[83]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[84]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[85]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[86]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[87]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[88]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[89]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[90]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[91]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[92]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[93]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[94]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[95]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[96]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[97]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[98]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[99]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[100]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[101]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[102]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[103]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[104]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[105]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[106]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[107]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[108]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[109]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[110]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[111]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[112]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[113]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[114]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[115]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[116]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[117]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[118]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[119]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[120]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[121]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[122]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[123]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[124]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[125]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[126]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tuser[127]}]]
connect_debug_port u_ila_1/probe6 [get_nets [list {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[0]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[1]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[2]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[3]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[4]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[5]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[6]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[7]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[8]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[9]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[10]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[11]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[12]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[13]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[14]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[15]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[16]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[17]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[18]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[19]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[20]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[21]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[22]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[23]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[24]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[25]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[26]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[27]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[28]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[29]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[30]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tdata[31]}]]
connect_debug_port u_ila_1/probe7 [get_nets [list {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[0]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[1]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[2]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[3]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[4]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[5]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[6]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[7]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[8]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[9]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[10]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[11]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[12]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[13]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[14]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[15]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[16]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[17]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[18]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[19]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[20]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[21]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[22]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[23]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[24]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[25]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[26]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[27]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[28]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[29]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[30]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[31]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[32]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[33]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[34]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[35]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[36]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[37]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[38]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[39]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[40]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[41]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[42]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[43]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[44]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[45]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[46]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[47]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[48]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[49]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[50]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[51]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[52]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[53]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[54]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[55]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[56]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[57]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[58]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[59]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[60]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[61]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[62]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[63]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[64]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[65]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[66]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[67]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[68]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[69]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[70]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[71]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[72]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[73]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[74]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[75]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[76]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[77]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[78]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[79]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[80]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[81]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[82]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[83]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[84]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[85]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[86]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[87]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[88]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[89]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[90]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[91]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[92]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[93]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[94]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[95]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[96]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[97]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[98]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[99]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[100]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[101]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[102]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[103]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[104]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[105]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[106]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[107]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[108]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[109]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[110]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[111]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[112]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[113]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[114]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[115]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[116]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[117]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[118]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[119]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[120]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[121]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[122]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[123]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[124]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[125]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[126]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tuser[127]}]]
connect_debug_port u_ila_1/probe8 [get_nets [list {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[0]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[1]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[2]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[3]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[4]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[5]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[6]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[7]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[8]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[9]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[10]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[11]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[12]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[13]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[14]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[15]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[16]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[17]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[18]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[19]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[20]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[21]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[22]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tdata[23]}]]
connect_debug_port u_ila_1/probe9 [get_nets [list {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_config_tdata[0]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_config_tdata[1]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_config_tdata[2]}]]
connect_debug_port u_ila_1/probe10 [get_nets [list {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[0]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[1]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[2]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[3]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[4]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[5]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[6]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[7]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[8]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[9]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[10]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[11]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[12]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[13]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[14]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[15]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[16]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[17]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[18]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[19]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[20]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[21]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[22]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[23]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[24]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[25]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[26]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[27]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[28]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[29]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[30]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[31]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[32]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[33]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[34]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[35]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[36]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[37]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[38]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[39]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[40]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[41]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[42]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[43]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[44]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[45]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[46]} {user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tdata[47]}]]
connect_debug_port u_ila_1/probe11 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/axis_data_fifo_0_M_AXIS_TREADY]]
connect_debug_port u_ila_1/probe12 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/axis_data_fifo_0_M_AXIS_TVALID]]
connect_debug_port u_ila_1/probe15 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/event_s_reload_tlast_missing]]
connect_debug_port u_ila_1/probe16 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/event_s_reload_tlast_unexpected]]
connect_debug_port u_ila_1/probe20 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tready]]
connect_debug_port u_ila_1/probe21 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/m_axis_data_tvalid]]
connect_debug_port u_ila_1/probe25 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_config_tready]]
connect_debug_port u_ila_1/probe26 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_config_tvalid]]
connect_debug_port u_ila_1/probe27 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tready]]
connect_debug_port u_ila_1/probe28 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_data_tvalid]]
connect_debug_port u_ila_1/probe29 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tready]]
connect_debug_port u_ila_1/probe30 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/fir/pulse_fir/s_axis_reload_tvalid]]
connect_debug_port dbg_hub/clk [get_nets clk]




connect_debug_port u_ila_0/probe5 [get_nets [list user_block2_i/user_block2_i/position_encoder_0/aresetn]]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 2 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list dataio_intrfc_i/dataio_intrfc_i/sample_clk_gen/cdc_clka/U0/sample_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {mt_pulse[0]} {mt_pulse[1]} {mt_pulse[2]} {mt_pulse[3]} {mt_pulse[4]} {mt_pulse[5]} {mt_pulse[6]} {mt_pulse[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {gpio_regs/status_flags[0]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 19 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[0]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[1]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[2]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[3]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[4]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[5]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[6]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[7]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[8]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[9]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[10]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[11]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[12]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[13]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[14]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[15]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[16]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[17]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_1[18]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 19 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[0]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[1]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[2]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[3]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[4]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[5]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[6]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[7]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[8]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[9]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[10]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[11]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[12]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[13]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[14]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[15]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[16]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[17]} {user_block2_i/user_block2_i/position_encoder_0/pos_enc_0[18]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {user_block2_i/user_block2_i/position_encoder_0/ctl_reg[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list gpio_regs/control_hvn]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list user_block1_i/user_block1_i/controller_running]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list gpio_regs/ext_clk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list user_block2_i/user_block2_i/dsp_ch0/in_pdti_1_TVALID]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list gpio_regs/pps_edge]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list gpio_regs/PPS_TO_CONTROLLER_OUT_i_1_n_0]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list user_block2_i/user_block2_i/position_encoder_0/ROT_A]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list user_block2_i/user_block2_i/position_encoder_0/ROT_B]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list gpio_regs/sync_pulse_clk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list user_block2_i/user_block2_i/position_encoder_0/TILT_A]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list gpio_regs/TILT_A]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list gpio_regs/TILT_B]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list user_block2_i/user_block2_i/position_encoder_0/TILT_B]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list data_acq_i/adc0_fifo_full_stat]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list data_acq_i/adc1_fifo_full_stat]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list data_acq_i/adc2_fifo_full_stat]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axis_ppkt_aresetn]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axis_ppkt_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axis_ppkt_tready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axis_ppkt_tvalid]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 2 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list pcie_intrfc_wrapper_i/pcie_intrfc_i/pcie3_ultrascale_0/U0/gt_top_i/phy_clk_i/CLK_USERCLK]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 1 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/irq]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 1 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/m_axis_pcie_rq_tlast]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 1 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/m_axis_pcie_rq_tready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
set_property port_width 1 [get_debug_ports u_ila_1/probe3]
connect_debug_port u_ila_1/probe3 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/m_axis_pcie_rq_tvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
set_property port_width 1 [get_debug_ports u_ila_1/probe4]
connect_debug_port u_ila_1/probe4 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_aresetn]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
set_property port_width 1 [get_debug_ports u_ila_1/probe5]
connect_debug_port u_ila_1/probe5 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_arready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe6]
set_property port_width 1 [get_debug_ports u_ila_1/probe6]
connect_debug_port u_ila_1/probe6 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_arvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe7]
set_property port_width 1 [get_debug_ports u_ila_1/probe7]
connect_debug_port u_ila_1/probe7 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_awready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe8]
set_property port_width 1 [get_debug_ports u_ila_1/probe8]
connect_debug_port u_ila_1/probe8 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_awvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe9]
set_property port_width 1 [get_debug_ports u_ila_1/probe9]
connect_debug_port u_ila_1/probe9 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_bready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe10]
set_property port_width 1 [get_debug_ports u_ila_1/probe10]
connect_debug_port u_ila_1/probe10 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_bvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe11]
set_property port_width 1 [get_debug_ports u_ila_1/probe11]
connect_debug_port u_ila_1/probe11 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_rready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe12]
set_property port_width 1 [get_debug_ports u_ila_1/probe12]
connect_debug_port u_ila_1/probe12 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_rvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe13]
set_property port_width 1 [get_debug_ports u_ila_1/probe13]
connect_debug_port u_ila_1/probe13 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_wready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe14]
set_property port_width 1 [get_debug_ports u_ila_1/probe14]
connect_debug_port u_ila_1/probe14 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_csr_wvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe15]
set_property port_width 1 [get_debug_ports u_ila_1/probe15]
connect_debug_port u_ila_1/probe15 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_arready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe16]
set_property port_width 1 [get_debug_ports u_ila_1/probe16]
connect_debug_port u_ila_1/probe16 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_arvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe17]
set_property port_width 1 [get_debug_ports u_ila_1/probe17]
connect_debug_port u_ila_1/probe17 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_awready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe18]
set_property port_width 1 [get_debug_ports u_ila_1/probe18]
connect_debug_port u_ila_1/probe18 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_awvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe19]
set_property port_width 1 [get_debug_ports u_ila_1/probe19]
connect_debug_port u_ila_1/probe19 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_bready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe20]
set_property port_width 1 [get_debug_ports u_ila_1/probe20]
connect_debug_port u_ila_1/probe20 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_bvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe21]
set_property port_width 1 [get_debug_ports u_ila_1/probe21]
connect_debug_port u_ila_1/probe21 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_rready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe22]
set_property port_width 1 [get_debug_ports u_ila_1/probe22]
connect_debug_port u_ila_1/probe22 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_rvalid]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe23]
set_property port_width 1 [get_debug_ports u_ila_1/probe23]
connect_debug_port u_ila_1/probe23 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_wready]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe24]
set_property port_width 1 [get_debug_ports u_ila_1/probe24]
connect_debug_port u_ila_1/probe24 [get_nets [list data_acq_i/data_acq_i/adc_ch0_acq/dma_ppkt2pcie/s_axi_descr_wvalid]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets axis_dac_pdti_aclk]
