# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set add_input_regs [ipgui::add_param $IPINST -name "add_input_regs" -parent ${Page_0}]
  set_property tooltip {Add Input Register (Adds one clock latency)} ${add_input_regs}
  set data_byte_width [ipgui::add_param $IPINST -name "data_byte_width" -parent ${Page_0}]
  set_property tooltip {Data Byte Width (Number of Bytes)} ${data_byte_width}
  ipgui::add_param $IPINST -name "num_input_streams" -parent ${Page_0}


}

proc update_PARAM_VALUE.add_input_regs { PARAM_VALUE.add_input_regs } {
	# Procedure called to update add_input_regs when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.add_input_regs { PARAM_VALUE.add_input_regs } {
	# Procedure called to validate add_input_regs
	return true
}

proc update_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to update data_byte_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to validate data_byte_width
	return true
}

proc update_PARAM_VALUE.num_input_streams { PARAM_VALUE.num_input_streams } {
	# Procedure called to update num_input_streams when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_input_streams { PARAM_VALUE.num_input_streams } {
	# Procedure called to validate num_input_streams
	return true
}


proc update_MODELPARAM_VALUE.data_byte_width { MODELPARAM_VALUE.data_byte_width PARAM_VALUE.data_byte_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_byte_width}] ${MODELPARAM_VALUE.data_byte_width}
}

proc update_MODELPARAM_VALUE.num_input_streams { MODELPARAM_VALUE.num_input_streams PARAM_VALUE.num_input_streams } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_input_streams}] ${MODELPARAM_VALUE.num_input_streams}
}

proc update_MODELPARAM_VALUE.add_input_regs { MODELPARAM_VALUE.add_input_regs PARAM_VALUE.add_input_regs } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.add_input_regs}] ${MODELPARAM_VALUE.add_input_regs}
}

