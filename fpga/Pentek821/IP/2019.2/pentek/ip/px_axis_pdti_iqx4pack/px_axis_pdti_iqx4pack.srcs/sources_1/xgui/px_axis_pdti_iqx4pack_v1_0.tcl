# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "gate_sync_pps_style" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {0 = TUSER(71:64) = ----3210  

1 = TUSER(71:64) = 33221100  

2 = TUSER(71:64) = 32103210  }


}

proc update_PARAM_VALUE.gate_sync_pps_style { PARAM_VALUE.gate_sync_pps_style } {
	# Procedure called to update gate_sync_pps_style when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.gate_sync_pps_style { PARAM_VALUE.gate_sync_pps_style } {
	# Procedure called to validate gate_sync_pps_style
	return true
}


proc update_MODELPARAM_VALUE.gate_sync_pps_style { MODELPARAM_VALUE.gate_sync_pps_style PARAM_VALUE.gate_sync_pps_style } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.gate_sync_pps_style}] ${MODELPARAM_VALUE.gate_sync_pps_style}
}

