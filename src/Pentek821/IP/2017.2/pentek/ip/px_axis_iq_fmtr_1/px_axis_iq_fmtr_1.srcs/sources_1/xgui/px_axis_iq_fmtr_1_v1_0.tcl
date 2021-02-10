# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "out_type" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "text1" -parent ${Page_0} -text {Type 0 - 32-bit Bus with packed 16-bit I/Q or unpacked 24-bit consrecutive I/Q.

Type 1 - 48-bit Bus with packed 24-bit I/Q}


}

proc update_PARAM_VALUE.out_type { PARAM_VALUE.out_type } {
	# Procedure called to update out_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_type { PARAM_VALUE.out_type } {
	# Procedure called to validate out_type
	return true
}


proc update_MODELPARAM_VALUE.out_type { MODELPARAM_VALUE.out_type PARAM_VALUE.out_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_type}] ${MODELPARAM_VALUE.out_type}
}

