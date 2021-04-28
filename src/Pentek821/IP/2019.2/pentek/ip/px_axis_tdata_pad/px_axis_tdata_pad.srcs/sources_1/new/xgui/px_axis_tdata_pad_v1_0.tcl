# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "in_data_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "out_data_width" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "txt1" -parent ${Page_0} -text {low0 = Shift Left and Pad LSBs with Zeros 
upper0 = Pad MSBs with Zeros
upperx = Sign Extend MSBs
low0 = Treat as I/Q, Shift Left and Pad LSBs with Zeros
upper0 = Treat as I/Q, Pad MSBs with Zeros
upperx = Treat as I/Q, Sign Extend MSBs
}
  ipgui::add_param $IPINST -name "pad_type" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "has_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tuser" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tuser_width" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to update has_tready when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tready { PARAM_VALUE.has_tready } {
	# Procedure called to validate has_tready
	return true
}

proc update_PARAM_VALUE.has_tuser { PARAM_VALUE.has_tuser } {
	# Procedure called to update has_tuser when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tuser { PARAM_VALUE.has_tuser } {
	# Procedure called to validate has_tuser
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

proc update_PARAM_VALUE.pad_type { PARAM_VALUE.pad_type } {
	# Procedure called to update pad_type when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.pad_type { PARAM_VALUE.pad_type } {
	# Procedure called to validate pad_type
	return true
}

proc update_PARAM_VALUE.tuser_width { PARAM_VALUE.tuser_width } {
	# Procedure called to update tuser_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tuser_width { PARAM_VALUE.tuser_width } {
	# Procedure called to validate tuser_width
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

proc update_MODELPARAM_VALUE.pad_type { MODELPARAM_VALUE.pad_type PARAM_VALUE.pad_type } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.pad_type}] ${MODELPARAM_VALUE.pad_type}
}

proc update_MODELPARAM_VALUE.has_tready { MODELPARAM_VALUE.has_tready PARAM_VALUE.has_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tready}] ${MODELPARAM_VALUE.has_tready}
}

proc update_MODELPARAM_VALUE.has_tuser { MODELPARAM_VALUE.has_tuser PARAM_VALUE.has_tuser } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tuser}] ${MODELPARAM_VALUE.has_tuser}
}

proc update_MODELPARAM_VALUE.tuser_width { MODELPARAM_VALUE.tuser_width PARAM_VALUE.tuser_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tuser_width}] ${MODELPARAM_VALUE.tuser_width}
}

