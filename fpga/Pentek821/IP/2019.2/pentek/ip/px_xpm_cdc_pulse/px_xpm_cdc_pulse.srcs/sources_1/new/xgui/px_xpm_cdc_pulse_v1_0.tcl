# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DEST_SYNC_FF" -parent ${Page_0}
  ipgui::add_param $IPINST -name "REG_OUTPUT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RST_USED" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SIM_ASSERT_CHK" -parent ${Page_0}


}

proc update_PARAM_VALUE.DEST_SYNC_FF { PARAM_VALUE.DEST_SYNC_FF } {
	# Procedure called to update DEST_SYNC_FF when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DEST_SYNC_FF { PARAM_VALUE.DEST_SYNC_FF } {
	# Procedure called to validate DEST_SYNC_FF
	return true
}

proc update_PARAM_VALUE.REG_OUTPUT { PARAM_VALUE.REG_OUTPUT } {
	# Procedure called to update REG_OUTPUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_OUTPUT { PARAM_VALUE.REG_OUTPUT } {
	# Procedure called to validate REG_OUTPUT
	return true
}

proc update_PARAM_VALUE.RST_USED { PARAM_VALUE.RST_USED } {
	# Procedure called to update RST_USED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RST_USED { PARAM_VALUE.RST_USED } {
	# Procedure called to validate RST_USED
	return true
}

proc update_PARAM_VALUE.SIM_ASSERT_CHK { PARAM_VALUE.SIM_ASSERT_CHK } {
	# Procedure called to update SIM_ASSERT_CHK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SIM_ASSERT_CHK { PARAM_VALUE.SIM_ASSERT_CHK } {
	# Procedure called to validate SIM_ASSERT_CHK
	return true
}


proc update_MODELPARAM_VALUE.DEST_SYNC_FF { MODELPARAM_VALUE.DEST_SYNC_FF PARAM_VALUE.DEST_SYNC_FF } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DEST_SYNC_FF}] ${MODELPARAM_VALUE.DEST_SYNC_FF}
}

proc update_MODELPARAM_VALUE.SIM_ASSERT_CHK { MODELPARAM_VALUE.SIM_ASSERT_CHK PARAM_VALUE.SIM_ASSERT_CHK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SIM_ASSERT_CHK}] ${MODELPARAM_VALUE.SIM_ASSERT_CHK}
}

proc update_MODELPARAM_VALUE.REG_OUTPUT { MODELPARAM_VALUE.REG_OUTPUT PARAM_VALUE.REG_OUTPUT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_OUTPUT}] ${MODELPARAM_VALUE.REG_OUTPUT}
}

proc update_MODELPARAM_VALUE.RST_USED { MODELPARAM_VALUE.RST_USED PARAM_VALUE.RST_USED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RST_USED}] ${MODELPARAM_VALUE.RST_USED}
}

