# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "has_tlast" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tuser" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tdata_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tuser_width" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_tlast { PARAM_VALUE.has_tlast } {
	# Procedure called to update has_tlast when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tlast { PARAM_VALUE.has_tlast } {
	# Procedure called to validate has_tlast
	return true
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

proc update_PARAM_VALUE.tdata_width { PARAM_VALUE.tdata_width } {
	# Procedure called to update tdata_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tdata_width { PARAM_VALUE.tdata_width } {
	# Procedure called to validate tdata_width
	return true
}

proc update_PARAM_VALUE.tuser_width { PARAM_VALUE.tuser_width } {
	# Procedure called to update tuser_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tuser_width { PARAM_VALUE.tuser_width } {
	# Procedure called to validate tuser_width
	return true
}


proc update_MODELPARAM_VALUE.tdata_width { MODELPARAM_VALUE.tdata_width PARAM_VALUE.tdata_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tdata_width}] ${MODELPARAM_VALUE.tdata_width}
}

proc update_MODELPARAM_VALUE.tuser_width { MODELPARAM_VALUE.tuser_width PARAM_VALUE.tuser_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tuser_width}] ${MODELPARAM_VALUE.tuser_width}
}

proc update_MODELPARAM_VALUE.has_tuser { MODELPARAM_VALUE.has_tuser PARAM_VALUE.has_tuser } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tuser}] ${MODELPARAM_VALUE.has_tuser}
}

proc update_MODELPARAM_VALUE.has_tready { MODELPARAM_VALUE.has_tready PARAM_VALUE.has_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tready}] ${MODELPARAM_VALUE.has_tready}
}

proc update_MODELPARAM_VALUE.has_tlast { MODELPARAM_VALUE.has_tlast PARAM_VALUE.has_tlast } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tlast}] ${MODELPARAM_VALUE.has_tlast}
}

