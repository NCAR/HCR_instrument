# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "data_byte_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "data_stream_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "info_stream_delay" -parent ${Page_0}
  ipgui::add_param $IPINST -name "time_stream_delay" -parent ${Page_0}


}

proc update_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to update data_byte_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_byte_width { PARAM_VALUE.data_byte_width } {
	# Procedure called to validate data_byte_width
	return true
}

proc update_PARAM_VALUE.data_stream_delay { PARAM_VALUE.data_stream_delay } {
	# Procedure called to update data_stream_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_stream_delay { PARAM_VALUE.data_stream_delay } {
	# Procedure called to validate data_stream_delay
	return true
}

proc update_PARAM_VALUE.info_stream_delay { PARAM_VALUE.info_stream_delay } {
	# Procedure called to update info_stream_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.info_stream_delay { PARAM_VALUE.info_stream_delay } {
	# Procedure called to validate info_stream_delay
	return true
}

proc update_PARAM_VALUE.time_stream_delay { PARAM_VALUE.time_stream_delay } {
	# Procedure called to update time_stream_delay when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.time_stream_delay { PARAM_VALUE.time_stream_delay } {
	# Procedure called to validate time_stream_delay
	return true
}


proc update_MODELPARAM_VALUE.data_byte_width { MODELPARAM_VALUE.data_byte_width PARAM_VALUE.data_byte_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_byte_width}] ${MODELPARAM_VALUE.data_byte_width}
}

proc update_MODELPARAM_VALUE.data_stream_delay { MODELPARAM_VALUE.data_stream_delay PARAM_VALUE.data_stream_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_stream_delay}] ${MODELPARAM_VALUE.data_stream_delay}
}

proc update_MODELPARAM_VALUE.info_stream_delay { MODELPARAM_VALUE.info_stream_delay PARAM_VALUE.info_stream_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.info_stream_delay}] ${MODELPARAM_VALUE.info_stream_delay}
}

proc update_MODELPARAM_VALUE.time_stream_delay { MODELPARAM_VALUE.time_stream_delay PARAM_VALUE.time_stream_delay } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.time_stream_delay}] ${MODELPARAM_VALUE.time_stream_delay}
}

