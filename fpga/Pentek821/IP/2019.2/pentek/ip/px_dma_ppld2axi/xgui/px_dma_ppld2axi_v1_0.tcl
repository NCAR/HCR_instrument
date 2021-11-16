# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "channel_id" -parent ${Page_0}
  ipgui::add_param $IPINST -name "channel_id_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "data_axi_addr_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "desc_axi_addr_width" -parent ${Page_0}


}

proc update_PARAM_VALUE.channel_id { PARAM_VALUE.channel_id } {
	# Procedure called to update channel_id when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.channel_id { PARAM_VALUE.channel_id } {
	# Procedure called to validate channel_id
	return true
}

proc update_PARAM_VALUE.channel_id_width { PARAM_VALUE.channel_id_width } {
	# Procedure called to update channel_id_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.channel_id_width { PARAM_VALUE.channel_id_width } {
	# Procedure called to validate channel_id_width
	return true
}

proc update_PARAM_VALUE.data_axi_addr_width { PARAM_VALUE.data_axi_addr_width } {
	# Procedure called to update data_axi_addr_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.data_axi_addr_width { PARAM_VALUE.data_axi_addr_width } {
	# Procedure called to validate data_axi_addr_width
	return true
}

proc update_PARAM_VALUE.desc_axi_addr_width { PARAM_VALUE.desc_axi_addr_width } {
	# Procedure called to update desc_axi_addr_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.desc_axi_addr_width { PARAM_VALUE.desc_axi_addr_width } {
	# Procedure called to validate desc_axi_addr_width
	return true
}


proc update_MODELPARAM_VALUE.channel_id { MODELPARAM_VALUE.channel_id PARAM_VALUE.channel_id } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.channel_id}] ${MODELPARAM_VALUE.channel_id}
}

proc update_MODELPARAM_VALUE.desc_axi_addr_width { MODELPARAM_VALUE.desc_axi_addr_width PARAM_VALUE.desc_axi_addr_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.desc_axi_addr_width}] ${MODELPARAM_VALUE.desc_axi_addr_width}
}

proc update_MODELPARAM_VALUE.data_axi_addr_width { MODELPARAM_VALUE.data_axi_addr_width PARAM_VALUE.data_axi_addr_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.data_axi_addr_width}] ${MODELPARAM_VALUE.data_axi_addr_width}
}

proc update_MODELPARAM_VALUE.channel_id_width { MODELPARAM_VALUE.channel_id_width PARAM_VALUE.channel_id_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.channel_id_width}] ${MODELPARAM_VALUE.channel_id_width}
}

