# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "out_res" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.out_res { PARAM_VALUE.out_res } {
	# Procedure called to update out_res when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_res { PARAM_VALUE.out_res } {
	# Procedure called to validate out_res
	return true
}


proc update_MODELPARAM_VALUE.out_res { MODELPARAM_VALUE.out_res PARAM_VALUE.out_res } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_res}] ${MODELPARAM_VALUE.out_res}
}

