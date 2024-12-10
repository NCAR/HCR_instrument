# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "num_data_bytes" -parent ${Page_0}
  ipgui::add_param $IPINST -name "num_user_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tdata_value" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tuser_value" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tkeep_asserted" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tlast_asserted" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tvalid_asserted" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tready" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tlast" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tkeep" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to update has_tkeep when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to validate has_tkeep
	return true
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

proc update_PARAM_VALUE.num_data_bytes { PARAM_VALUE.num_data_bytes } {
	# Procedure called to update num_data_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_data_bytes { PARAM_VALUE.num_data_bytes } {
	# Procedure called to validate num_data_bytes
	return true
}

proc update_PARAM_VALUE.num_user_bits { PARAM_VALUE.num_user_bits } {
	# Procedure called to update num_user_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_user_bits { PARAM_VALUE.num_user_bits } {
	# Procedure called to validate num_user_bits
	return true
}

proc update_PARAM_VALUE.tdata_value { PARAM_VALUE.tdata_value } {
	# Procedure called to update tdata_value when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tdata_value { PARAM_VALUE.tdata_value } {
	# Procedure called to validate tdata_value
	return true
}

proc update_PARAM_VALUE.tkeep_asserted { PARAM_VALUE.tkeep_asserted } {
	# Procedure called to update tkeep_asserted when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tkeep_asserted { PARAM_VALUE.tkeep_asserted } {
	# Procedure called to validate tkeep_asserted
	return true
}

proc update_PARAM_VALUE.tlast_asserted { PARAM_VALUE.tlast_asserted } {
	# Procedure called to update tlast_asserted when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tlast_asserted { PARAM_VALUE.tlast_asserted } {
	# Procedure called to validate tlast_asserted
	return true
}

proc update_PARAM_VALUE.tuser_value { PARAM_VALUE.tuser_value } {
	# Procedure called to update tuser_value when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tuser_value { PARAM_VALUE.tuser_value } {
	# Procedure called to validate tuser_value
	return true
}

proc update_PARAM_VALUE.tvalid_asserted { PARAM_VALUE.tvalid_asserted } {
	# Procedure called to update tvalid_asserted when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tvalid_asserted { PARAM_VALUE.tvalid_asserted } {
	# Procedure called to validate tvalid_asserted
	return true
}


proc update_MODELPARAM_VALUE.num_data_bytes { MODELPARAM_VALUE.num_data_bytes PARAM_VALUE.num_data_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_data_bytes}] ${MODELPARAM_VALUE.num_data_bytes}
}

proc update_MODELPARAM_VALUE.num_user_bits { MODELPARAM_VALUE.num_user_bits PARAM_VALUE.num_user_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_user_bits}] ${MODELPARAM_VALUE.num_user_bits}
}

proc update_MODELPARAM_VALUE.tdata_value { MODELPARAM_VALUE.tdata_value PARAM_VALUE.tdata_value } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tdata_value}] ${MODELPARAM_VALUE.tdata_value}
}

proc update_MODELPARAM_VALUE.tuser_value { MODELPARAM_VALUE.tuser_value PARAM_VALUE.tuser_value } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tuser_value}] ${MODELPARAM_VALUE.tuser_value}
}

proc update_MODELPARAM_VALUE.tlast_asserted { MODELPARAM_VALUE.tlast_asserted PARAM_VALUE.tlast_asserted } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tlast_asserted}] ${MODELPARAM_VALUE.tlast_asserted}
}

proc update_MODELPARAM_VALUE.tvalid_asserted { MODELPARAM_VALUE.tvalid_asserted PARAM_VALUE.tvalid_asserted } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tvalid_asserted}] ${MODELPARAM_VALUE.tvalid_asserted}
}

proc update_MODELPARAM_VALUE.tkeep_asserted { MODELPARAM_VALUE.tkeep_asserted PARAM_VALUE.tkeep_asserted } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tkeep_asserted}] ${MODELPARAM_VALUE.tkeep_asserted}
}

proc update_MODELPARAM_VALUE.has_tready { MODELPARAM_VALUE.has_tready PARAM_VALUE.has_tready } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tready}] ${MODELPARAM_VALUE.has_tready}
}

proc update_MODELPARAM_VALUE.has_tlast { MODELPARAM_VALUE.has_tlast PARAM_VALUE.has_tlast } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tlast}] ${MODELPARAM_VALUE.has_tlast}
}

proc update_MODELPARAM_VALUE.has_tkeep { MODELPARAM_VALUE.has_tkeep PARAM_VALUE.has_tkeep } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tkeep}] ${MODELPARAM_VALUE.has_tkeep}
}

