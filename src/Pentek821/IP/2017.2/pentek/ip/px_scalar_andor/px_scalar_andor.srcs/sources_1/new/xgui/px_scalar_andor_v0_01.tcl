# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "a_en_inv" -parent ${Page_0}
  ipgui::add_param $IPINST -name "a_inv" -parent ${Page_0}
  ipgui::add_param $IPINST -name "b_en_inv" -parent ${Page_0}
  ipgui::add_param $IPINST -name "b_inv" -parent ${Page_0}
  ipgui::add_param $IPINST -name "o_inv" -parent ${Page_0}


}

proc update_PARAM_VALUE.a_en_inv { PARAM_VALUE.a_en_inv } {
	# Procedure called to update a_en_inv when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.a_en_inv { PARAM_VALUE.a_en_inv } {
	# Procedure called to validate a_en_inv
	return true
}

proc update_PARAM_VALUE.a_inv { PARAM_VALUE.a_inv } {
	# Procedure called to update a_inv when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.a_inv { PARAM_VALUE.a_inv } {
	# Procedure called to validate a_inv
	return true
}

proc update_PARAM_VALUE.b_en_inv { PARAM_VALUE.b_en_inv } {
	# Procedure called to update b_en_inv when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.b_en_inv { PARAM_VALUE.b_en_inv } {
	# Procedure called to validate b_en_inv
	return true
}

proc update_PARAM_VALUE.b_inv { PARAM_VALUE.b_inv } {
	# Procedure called to update b_inv when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.b_inv { PARAM_VALUE.b_inv } {
	# Procedure called to validate b_inv
	return true
}

proc update_PARAM_VALUE.o_inv { PARAM_VALUE.o_inv } {
	# Procedure called to update o_inv when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.o_inv { PARAM_VALUE.o_inv } {
	# Procedure called to validate o_inv
	return true
}


proc update_MODELPARAM_VALUE.a_inv { MODELPARAM_VALUE.a_inv PARAM_VALUE.a_inv } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.a_inv}] ${MODELPARAM_VALUE.a_inv}
}

proc update_MODELPARAM_VALUE.a_en_inv { MODELPARAM_VALUE.a_en_inv PARAM_VALUE.a_en_inv } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.a_en_inv}] ${MODELPARAM_VALUE.a_en_inv}
}

proc update_MODELPARAM_VALUE.b_inv { MODELPARAM_VALUE.b_inv PARAM_VALUE.b_inv } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.b_inv}] ${MODELPARAM_VALUE.b_inv}
}

proc update_MODELPARAM_VALUE.b_en_inv { MODELPARAM_VALUE.b_en_inv PARAM_VALUE.b_en_inv } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.b_en_inv}] ${MODELPARAM_VALUE.b_en_inv}
}

proc update_MODELPARAM_VALUE.o_inv { MODELPARAM_VALUE.o_inv PARAM_VALUE.o_inv } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.o_inv}] ${MODELPARAM_VALUE.o_inv}
}

