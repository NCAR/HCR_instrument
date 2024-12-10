# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DEST_SYNC_FF" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RST_ACTIVE_HIGH" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {0 = Active Low

1 = Active High}


}

proc update_PARAM_VALUE.DEST_SYNC_FF { PARAM_VALUE.DEST_SYNC_FF } {
	# Procedure called to update DEST_SYNC_FF when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEST_SYNC_FF { PARAM_VALUE.DEST_SYNC_FF } {
	# Procedure called to validate DEST_SYNC_FF
	return true
}

proc update_PARAM_VALUE.RST_ACTIVE_HIGH { PARAM_VALUE.RST_ACTIVE_HIGH } {
	# Procedure called to update RST_ACTIVE_HIGH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RST_ACTIVE_HIGH { PARAM_VALUE.RST_ACTIVE_HIGH } {
	# Procedure called to validate RST_ACTIVE_HIGH
	return true
}


proc update_MODELPARAM_VALUE.DEST_SYNC_FF { MODELPARAM_VALUE.DEST_SYNC_FF PARAM_VALUE.DEST_SYNC_FF } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEST_SYNC_FF}] ${MODELPARAM_VALUE.DEST_SYNC_FF}
}

proc update_MODELPARAM_VALUE.RST_ACTIVE_HIGH { MODELPARAM_VALUE.RST_ACTIVE_HIGH PARAM_VALUE.RST_ACTIVE_HIGH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RST_ACTIVE_HIGH}] ${MODELPARAM_VALUE.RST_ACTIVE_HIGH}
}

