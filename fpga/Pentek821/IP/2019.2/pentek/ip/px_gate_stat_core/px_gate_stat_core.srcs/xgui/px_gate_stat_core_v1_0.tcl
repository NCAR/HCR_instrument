# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Data_width" -parent ${Page_0} -widget comboBox
  ipgui::add_static_text $IPINST -name "Data Width" -parent ${Page_0} -text {

16 Bits - 2 bytes per clock cycle



32 Bits - 4 bytes per clock cycle



64 Bits - 8 bytes per clock cycle



128 Bits - 16 bytes per clock cycle



256 Bits - 32 bytes per clock cycle}


}

proc update_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to update Data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to validate Data_width
	return true
}


proc update_MODELPARAM_VALUE.Data_width { MODELPARAM_VALUE.Data_width PARAM_VALUE.Data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Data_width}] ${MODELPARAM_VALUE.Data_width}
}

