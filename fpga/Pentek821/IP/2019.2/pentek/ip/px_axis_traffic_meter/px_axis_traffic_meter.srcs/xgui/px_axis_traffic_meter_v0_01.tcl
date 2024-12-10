# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "num_bytes" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "has_tkeep" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tlast" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tuser" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tuser_size" -parent ${Page_0}
  set init_clk_freq [ipgui::add_param $IPINST -name "init_clk_freq" -parent ${Page_0}]
  set_property tooltip {Clock Frequency Value at Reset in Hertz} ${init_clk_freq}
  ipgui::add_param $IPINST -name "div_factor" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "txt" -parent ${Page_0} -text {
The Value specified by "Clock Frequency Value at Reset" will be used to calculate clock cycles per second.

 It can be overridden by setting the control register.

The Divide Factor is used to keep the result to a 32-bit value.  

Therefore, if the data rate can exceed 4GBps, then you must set the Divide Factor to 2 or 4 and then multiply the reading by that factor to get the true Bytes per Second. }


}

proc update_PARAM_VALUE.div_factor { PARAM_VALUE.div_factor } {
	# Procedure called to update div_factor when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.div_factor { PARAM_VALUE.div_factor } {
	# Procedure called to validate div_factor
	return true
}

proc update_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to update has_tkeep when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to validate has_tkeep
	return true
}

proc update_PARAM_VALUE.has_tlast { PARAM_VALUE.has_tlast } {
	# Procedure called to update has_tlast when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tlast { PARAM_VALUE.has_tlast } {
	# Procedure called to validate has_tlast
	return true
}

proc update_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to update has_tready when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to validate has_tready
	return true
}

proc update_PARAM_VALUE.has_tuser { PARAM_VALUE.has_tuser } {
	# Procedure called to update has_tuser when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tuser { PARAM_VALUE.has_tuser } {
	# Procedure called to validate has_tuser
	return true
}

proc update_PARAM_VALUE.init_clk_freq { PARAM_VALUE.init_clk_freq } {
	# Procedure called to update init_clk_freq when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.init_clk_freq { PARAM_VALUE.init_clk_freq } {
	# Procedure called to validate init_clk_freq
	return true
}

proc update_PARAM_VALUE.num_bytes { PARAM_VALUE.num_bytes } {
	# Procedure called to update num_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_bytes { PARAM_VALUE.num_bytes } {
	# Procedure called to validate num_bytes
	return true
}

proc update_PARAM_VALUE.tuser_size { PARAM_VALUE.tuser_size } {
	# Procedure called to update tuser_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tuser_size { PARAM_VALUE.tuser_size } {
	# Procedure called to validate tuser_size
	return true
}


proc update_MODELPARAM_VALUE.init_clk_freq { MODELPARAM_VALUE.init_clk_freq PARAM_VALUE.init_clk_freq } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.init_clk_freq}] ${MODELPARAM_VALUE.init_clk_freq}
}

proc update_MODELPARAM_VALUE.div_factor { MODELPARAM_VALUE.div_factor PARAM_VALUE.div_factor } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.div_factor}] ${MODELPARAM_VALUE.div_factor}
}

proc update_MODELPARAM_VALUE.num_bytes { MODELPARAM_VALUE.num_bytes PARAM_VALUE.num_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_bytes}] ${MODELPARAM_VALUE.num_bytes}
}

proc update_MODELPARAM_VALUE.has_tkeep { MODELPARAM_VALUE.has_tkeep PARAM_VALUE.has_tkeep } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tkeep}] ${MODELPARAM_VALUE.has_tkeep}
}

proc update_MODELPARAM_VALUE.has_tready { MODELPARAM_VALUE.has_tready PARAM_VALUE.has_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tready}] ${MODELPARAM_VALUE.has_tready}
}

proc update_MODELPARAM_VALUE.has_tuser { MODELPARAM_VALUE.has_tuser PARAM_VALUE.has_tuser } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tuser}] ${MODELPARAM_VALUE.has_tuser}
}

proc update_MODELPARAM_VALUE.has_tlast { MODELPARAM_VALUE.has_tlast PARAM_VALUE.has_tlast } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tlast}] ${MODELPARAM_VALUE.has_tlast}
}

proc update_MODELPARAM_VALUE.tuser_size { MODELPARAM_VALUE.tuser_size PARAM_VALUE.tuser_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tuser_size}] ${MODELPARAM_VALUE.tuser_size}
}

