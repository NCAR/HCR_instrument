# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set id_filter_val [ipgui::add_param $IPINST -name "id_filter_val" -parent ${Page_0}]
  set_property tooltip {Id Filter Value} ${id_filter_val}
  ipgui::add_param $IPINST -name "tid_size" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tdata_bytes" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tuser" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tuser_size" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tkeep" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_tlast" -parent ${Page_0}


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

proc update_PARAM_VALUE.has_tuser { PARAM_VALUE.has_tuser } {
	# Procedure called to update has_tuser when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tuser { PARAM_VALUE.has_tuser } {
	# Procedure called to validate has_tuser
	return true
}

proc update_PARAM_VALUE.id_filter_val { PARAM_VALUE.id_filter_val } {
	# Procedure called to update id_filter_val when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.id_filter_val { PARAM_VALUE.id_filter_val } {
	# Procedure called to validate id_filter_val
	return true
}

proc update_PARAM_VALUE.tdata_bytes { PARAM_VALUE.tdata_bytes } {
	# Procedure called to update tdata_bytes when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tdata_bytes { PARAM_VALUE.tdata_bytes } {
	# Procedure called to validate tdata_bytes
	return true
}

proc update_PARAM_VALUE.tid_size { PARAM_VALUE.tid_size } {
	# Procedure called to update tid_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tid_size { PARAM_VALUE.tid_size } {
	# Procedure called to validate tid_size
	return true
}

proc update_PARAM_VALUE.tuser_size { PARAM_VALUE.tuser_size } {
	# Procedure called to update tuser_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tuser_size { PARAM_VALUE.tuser_size } {
	# Procedure called to validate tuser_size
	return true
}


proc update_MODELPARAM_VALUE.id_filter_val { MODELPARAM_VALUE.id_filter_val PARAM_VALUE.id_filter_val } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.id_filter_val}] ${MODELPARAM_VALUE.id_filter_val}
}

proc update_MODELPARAM_VALUE.has_tuser { MODELPARAM_VALUE.has_tuser PARAM_VALUE.has_tuser } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tuser}] ${MODELPARAM_VALUE.has_tuser}
}

proc update_MODELPARAM_VALUE.has_tlast { MODELPARAM_VALUE.has_tlast PARAM_VALUE.has_tlast } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tlast}] ${MODELPARAM_VALUE.has_tlast}
}

proc update_MODELPARAM_VALUE.has_tkeep { MODELPARAM_VALUE.has_tkeep PARAM_VALUE.has_tkeep } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tkeep}] ${MODELPARAM_VALUE.has_tkeep}
}

proc update_MODELPARAM_VALUE.tid_size { MODELPARAM_VALUE.tid_size PARAM_VALUE.tid_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tid_size}] ${MODELPARAM_VALUE.tid_size}
}

proc update_MODELPARAM_VALUE.tdata_bytes { MODELPARAM_VALUE.tdata_bytes PARAM_VALUE.tdata_bytes } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tdata_bytes}] ${MODELPARAM_VALUE.tdata_bytes}
}

proc update_MODELPARAM_VALUE.tuser_size { MODELPARAM_VALUE.tuser_size PARAM_VALUE.tuser_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tuser_size}] ${MODELPARAM_VALUE.tuser_size}
}

