# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "text1" -parent ${Page_0} -text {When checked, the channel number in the TUSER stream will be substituted with CHANNEL.}
  set sub_chan [ipgui::add_param $IPINST -name "sub_chan" -parent ${Page_0}]
  set_property tooltip {Substitute Channel Numberin TUSER with a new value} ${sub_chan}
  set chan [ipgui::add_param $IPINST -name "chan" -parent ${Page_0}]
  set_property tooltip {Channel number to substitute if substitute is enabled.} ${chan}
  ipgui::add_param $IPINST -name "out_res" -parent ${Page_0} -widget comboBox


}

proc update_PARAM_VALUE.chan { PARAM_VALUE.chan } {
	# Procedure called to update chan when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.chan { PARAM_VALUE.chan } {
	# Procedure called to validate chan
	return true
}

proc update_PARAM_VALUE.out_res { PARAM_VALUE.out_res } {
	# Procedure called to update out_res when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_res { PARAM_VALUE.out_res } {
	# Procedure called to validate out_res
	return true
}

proc update_PARAM_VALUE.sub_chan { PARAM_VALUE.sub_chan } {
	# Procedure called to update sub_chan when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sub_chan { PARAM_VALUE.sub_chan } {
	# Procedure called to validate sub_chan
	return true
}


proc update_MODELPARAM_VALUE.out_res { MODELPARAM_VALUE.out_res PARAM_VALUE.out_res } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_res}] ${MODELPARAM_VALUE.out_res}
}

proc update_MODELPARAM_VALUE.sub_chan { MODELPARAM_VALUE.sub_chan PARAM_VALUE.sub_chan } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sub_chan}] ${MODELPARAM_VALUE.sub_chan}
}

proc update_MODELPARAM_VALUE.chan { MODELPARAM_VALUE.chan PARAM_VALUE.chan } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.chan}] ${MODELPARAM_VALUE.chan}
}

