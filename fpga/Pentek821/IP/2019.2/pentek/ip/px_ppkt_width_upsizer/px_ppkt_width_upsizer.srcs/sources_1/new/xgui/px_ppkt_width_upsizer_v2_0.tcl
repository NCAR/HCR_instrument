# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "WORD_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "OUT_WORD_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {Output width must be greater than input width.}


}

proc update_PARAM_VALUE.OUT_WORD_WIDTH { PARAM_VALUE.OUT_WORD_WIDTH } {
	# Procedure called to update OUT_WORD_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_WORD_WIDTH { PARAM_VALUE.OUT_WORD_WIDTH } {
	# Procedure called to validate OUT_WORD_WIDTH
	return true
}

proc update_PARAM_VALUE.WORD_WIDTH { PARAM_VALUE.WORD_WIDTH } {
	# Procedure called to update WORD_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WORD_WIDTH { PARAM_VALUE.WORD_WIDTH } {
	# Procedure called to validate WORD_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.WORD_WIDTH { MODELPARAM_VALUE.WORD_WIDTH PARAM_VALUE.WORD_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WORD_WIDTH}] ${MODELPARAM_VALUE.WORD_WIDTH}
}

proc update_MODELPARAM_VALUE.OUT_WORD_WIDTH { MODELPARAM_VALUE.OUT_WORD_WIDTH PARAM_VALUE.OUT_WORD_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_WORD_WIDTH}] ${MODELPARAM_VALUE.OUT_WORD_WIDTH}
}

