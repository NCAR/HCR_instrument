# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "rnd_type" -parent ${Page_0} -layout horizontal
  ipgui::add_static_text $IPINST -name "txt" -parent ${Page_0} -text {0 = Round to Nearest (0.5 Rounds Up)

1 = Round to Nearest Even (0.5 Rounds to Even Value)

2 = Round Symetrically Around Zero (0.5 and -0.5 Round away from Zero)



 }
  ipgui::add_param $IPINST -name "in_data_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "out_data_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_sat_out" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_sat_out { PARAM_VALUE.has_sat_out } {
	# Procedure called to update has_sat_out when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_sat_out { PARAM_VALUE.has_sat_out } {
	# Procedure called to validate has_sat_out
	return true
}

proc update_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to update has_tready when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to validate has_tready
	return true
}

proc update_PARAM_VALUE.in_data_width { PARAM_VALUE.in_data_width } {
	# Procedure called to update in_data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.in_data_width { PARAM_VALUE.in_data_width } {
	# Procedure called to validate in_data_width
	return true
}

proc update_PARAM_VALUE.out_data_width { PARAM_VALUE.out_data_width } {
	# Procedure called to update out_data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.out_data_width { PARAM_VALUE.out_data_width } {
	# Procedure called to validate out_data_width
	return true
}

proc update_PARAM_VALUE.rnd_type { PARAM_VALUE.rnd_type } {
	# Procedure called to update rnd_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.rnd_type { PARAM_VALUE.rnd_type } {
	# Procedure called to validate rnd_type
	return true
}


proc update_MODELPARAM_VALUE.in_data_width { MODELPARAM_VALUE.in_data_width PARAM_VALUE.in_data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.in_data_width}] ${MODELPARAM_VALUE.in_data_width}
}

proc update_MODELPARAM_VALUE.out_data_width { MODELPARAM_VALUE.out_data_width PARAM_VALUE.out_data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.out_data_width}] ${MODELPARAM_VALUE.out_data_width}
}

proc update_MODELPARAM_VALUE.rnd_type { MODELPARAM_VALUE.rnd_type PARAM_VALUE.rnd_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.rnd_type}] ${MODELPARAM_VALUE.rnd_type}
}

proc update_MODELPARAM_VALUE.has_tready { MODELPARAM_VALUE.has_tready PARAM_VALUE.has_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tready}] ${MODELPARAM_VALUE.has_tready}
}

proc update_MODELPARAM_VALUE.has_sat_out { MODELPARAM_VALUE.has_sat_out PARAM_VALUE.has_sat_out } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_sat_out}] ${MODELPARAM_VALUE.has_sat_out}
}

