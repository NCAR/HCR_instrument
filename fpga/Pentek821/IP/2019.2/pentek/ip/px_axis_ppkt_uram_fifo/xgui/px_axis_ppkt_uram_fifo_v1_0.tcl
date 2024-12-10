# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "data_width_bytes" -parent ${Page_0}
  ipgui::add_param $IPINST -name "fifo_depth" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_in_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_in_reset" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fifo_ovfl_led" -parent ${Page_0}


}

proc update_PARAM_VALUE.data_width_bytes { PARAM_VALUE.data_width_bytes } {
	# Procedure called to update data_width_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_width_bytes { PARAM_VALUE.data_width_bytes } {
	# Procedure called to validate data_width_bytes
	return true
}

proc update_PARAM_VALUE.fifo_depth { PARAM_VALUE.fifo_depth } {
	# Procedure called to update fifo_depth when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.fifo_depth { PARAM_VALUE.fifo_depth } {
	# Procedure called to validate fifo_depth
	return true
}

proc update_PARAM_VALUE.has_fifo_ovfl_led { PARAM_VALUE.has_fifo_ovfl_led } {
	# Procedure called to update has_fifo_ovfl_led when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fifo_ovfl_led { PARAM_VALUE.has_fifo_ovfl_led } {
	# Procedure called to validate has_fifo_ovfl_led
	return true
}

proc update_PARAM_VALUE.has_in_reset { PARAM_VALUE.has_in_reset } {
	# Procedure called to update has_in_reset when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_in_reset { PARAM_VALUE.has_in_reset } {
	# Procedure called to validate has_in_reset
	return true
}

proc update_PARAM_VALUE.has_in_tready { PARAM_VALUE.has_in_tready } {
	# Procedure called to update has_in_tready when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_in_tready { PARAM_VALUE.has_in_tready } {
	# Procedure called to validate has_in_tready
	return true
}


proc update_MODELPARAM_VALUE.has_in_tready { MODELPARAM_VALUE.has_in_tready PARAM_VALUE.has_in_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_in_tready}] ${MODELPARAM_VALUE.has_in_tready}
}

proc update_MODELPARAM_VALUE.has_in_reset { MODELPARAM_VALUE.has_in_reset PARAM_VALUE.has_in_reset } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_in_reset}] ${MODELPARAM_VALUE.has_in_reset}
}

proc update_MODELPARAM_VALUE.has_fifo_ovfl_led { MODELPARAM_VALUE.has_fifo_ovfl_led PARAM_VALUE.has_fifo_ovfl_led } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fifo_ovfl_led}] ${MODELPARAM_VALUE.has_fifo_ovfl_led}
}

proc update_MODELPARAM_VALUE.data_width_bytes { MODELPARAM_VALUE.data_width_bytes PARAM_VALUE.data_width_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_width_bytes}] ${MODELPARAM_VALUE.data_width_bytes}
}

proc update_MODELPARAM_VALUE.fifo_depth { MODELPARAM_VALUE.fifo_depth PARAM_VALUE.fifo_depth } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.fifo_depth}] ${MODELPARAM_VALUE.fifo_depth}
}

