# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "id" -parent ${Page_0}
  ipgui::add_param $IPINST -name "in_tdata_bytes" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "out_tdata_bytes" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "default_strt_addr" -parent ${Page_0}
  ipgui::add_param $IPINST -name "default_dw_size" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_in_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fifo_full_led" -parent ${Page_0}
  set has_bypass_full_led [ipgui::add_param $IPINST -name "has_bypass_full_led" -parent ${Page_0}]
  set_property tooltip {Use when in bypass mode, a FIFO external to this core should be source of LED signal.} ${has_bypass_full_led}


}

proc update_PARAM_VALUE.default_dw_size { PARAM_VALUE.default_dw_size } {
	# Procedure called to update default_dw_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_dw_size { PARAM_VALUE.default_dw_size } {
	# Procedure called to validate default_dw_size
	return true
}

proc update_PARAM_VALUE.default_strt_addr { PARAM_VALUE.default_strt_addr } {
	# Procedure called to update default_strt_addr when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_strt_addr { PARAM_VALUE.default_strt_addr } {
	# Procedure called to validate default_strt_addr
	return true
}

proc update_PARAM_VALUE.has_bypass_full_led { PARAM_VALUE.has_bypass_full_led } {
	# Procedure called to update has_bypass_full_led when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_bypass_full_led { PARAM_VALUE.has_bypass_full_led } {
	# Procedure called to validate has_bypass_full_led
	return true
}

proc update_PARAM_VALUE.has_fifo_full_led { PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to update has_fifo_full_led when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fifo_full_led { PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to validate has_fifo_full_led
	return true
}

proc update_PARAM_VALUE.has_in_tready { PARAM_VALUE.has_in_tready } {
	# Procedure called to update has_in_tready when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_in_tready { PARAM_VALUE.has_in_tready } {
	# Procedure called to validate has_in_tready
	return true
}

proc update_PARAM_VALUE.id { PARAM_VALUE.id } {
	# Procedure called to update id when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.id { PARAM_VALUE.id } {
	# Procedure called to validate id
	return true
}

proc update_PARAM_VALUE.in_tdata_bytes { PARAM_VALUE.in_tdata_bytes } {
	# Procedure called to update in_tdata_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.in_tdata_bytes { PARAM_VALUE.in_tdata_bytes } {
	# Procedure called to validate in_tdata_bytes
	return true
}

proc update_PARAM_VALUE.out_tdata_bytes { PARAM_VALUE.out_tdata_bytes } {
	# Procedure called to update out_tdata_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_tdata_bytes { PARAM_VALUE.out_tdata_bytes } {
	# Procedure called to validate out_tdata_bytes
	return true
}


proc update_MODELPARAM_VALUE.id { MODELPARAM_VALUE.id PARAM_VALUE.id } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.id}] ${MODELPARAM_VALUE.id}
}

proc update_MODELPARAM_VALUE.has_in_tready { MODELPARAM_VALUE.has_in_tready PARAM_VALUE.has_in_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_in_tready}] ${MODELPARAM_VALUE.has_in_tready}
}

proc update_MODELPARAM_VALUE.in_tdata_bytes { MODELPARAM_VALUE.in_tdata_bytes PARAM_VALUE.in_tdata_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.in_tdata_bytes}] ${MODELPARAM_VALUE.in_tdata_bytes}
}

proc update_MODELPARAM_VALUE.out_tdata_bytes { MODELPARAM_VALUE.out_tdata_bytes PARAM_VALUE.out_tdata_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_tdata_bytes}] ${MODELPARAM_VALUE.out_tdata_bytes}
}

proc update_MODELPARAM_VALUE.default_strt_addr { MODELPARAM_VALUE.default_strt_addr PARAM_VALUE.default_strt_addr } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_strt_addr}] ${MODELPARAM_VALUE.default_strt_addr}
}

proc update_MODELPARAM_VALUE.default_dw_size { MODELPARAM_VALUE.default_dw_size PARAM_VALUE.default_dw_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_dw_size}] ${MODELPARAM_VALUE.default_dw_size}
}

proc update_MODELPARAM_VALUE.has_fifo_full_led { MODELPARAM_VALUE.has_fifo_full_led PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fifo_full_led}] ${MODELPARAM_VALUE.has_fifo_full_led}
}

proc update_MODELPARAM_VALUE.has_bypass_full_led { MODELPARAM_VALUE.has_bypass_full_led PARAM_VALUE.has_bypass_full_led } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_bypass_full_led}] ${MODELPARAM_VALUE.has_bypass_full_led}
}

