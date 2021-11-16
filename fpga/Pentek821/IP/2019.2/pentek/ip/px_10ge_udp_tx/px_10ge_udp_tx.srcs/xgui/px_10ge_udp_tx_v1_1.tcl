# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  set has_tkeep [ipgui::add_param $IPINST -name "has_tkeep"]
  set_property tooltip {Enable if you would like to specify a tkeep. If not internal tkeep defaults to FF} ${has_tkeep}
  ipgui::add_param $IPINST -name "mac_source_init"
  ipgui::add_param $IPINST -name "mac_dest_init"
  ipgui::add_param $IPINST -name "ip_source_init"
  ipgui::add_param $IPINST -name "ip_dest_init"
  ipgui::add_param $IPINST -name "udp_port_source_init"
  ipgui::add_param $IPINST -name "udp_port_dest_init"

}

proc update_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to update has_tkeep when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_tkeep { PARAM_VALUE.has_tkeep } {
	# Procedure called to validate has_tkeep
	return true
}

proc update_PARAM_VALUE.ip_dest_init { PARAM_VALUE.ip_dest_init } {
	# Procedure called to update ip_dest_init when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ip_dest_init { PARAM_VALUE.ip_dest_init } {
	# Procedure called to validate ip_dest_init
	return true
}

proc update_PARAM_VALUE.ip_source_init { PARAM_VALUE.ip_source_init } {
	# Procedure called to update ip_source_init when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ip_source_init { PARAM_VALUE.ip_source_init } {
	# Procedure called to validate ip_source_init
	return true
}

proc update_PARAM_VALUE.mac_dest_init { PARAM_VALUE.mac_dest_init } {
	# Procedure called to update mac_dest_init when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.mac_dest_init { PARAM_VALUE.mac_dest_init } {
	# Procedure called to validate mac_dest_init
	return true
}

proc update_PARAM_VALUE.mac_source_init { PARAM_VALUE.mac_source_init } {
	# Procedure called to update mac_source_init when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.mac_source_init { PARAM_VALUE.mac_source_init } {
	# Procedure called to validate mac_source_init
	return true
}

proc update_PARAM_VALUE.udp_port_dest_init { PARAM_VALUE.udp_port_dest_init } {
	# Procedure called to update udp_port_dest_init when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.udp_port_dest_init { PARAM_VALUE.udp_port_dest_init } {
	# Procedure called to validate udp_port_dest_init
	return true
}

proc update_PARAM_VALUE.udp_port_source_init { PARAM_VALUE.udp_port_source_init } {
	# Procedure called to update udp_port_source_init when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.udp_port_source_init { PARAM_VALUE.udp_port_source_init } {
	# Procedure called to validate udp_port_source_init
	return true
}


proc update_MODELPARAM_VALUE.has_tkeep { MODELPARAM_VALUE.has_tkeep PARAM_VALUE.has_tkeep } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_tkeep}] ${MODELPARAM_VALUE.has_tkeep}
}

proc update_MODELPARAM_VALUE.mac_source_init { MODELPARAM_VALUE.mac_source_init PARAM_VALUE.mac_source_init } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.mac_source_init}] ${MODELPARAM_VALUE.mac_source_init}
}

proc update_MODELPARAM_VALUE.mac_dest_init { MODELPARAM_VALUE.mac_dest_init PARAM_VALUE.mac_dest_init } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.mac_dest_init}] ${MODELPARAM_VALUE.mac_dest_init}
}

proc update_MODELPARAM_VALUE.ip_source_init { MODELPARAM_VALUE.ip_source_init PARAM_VALUE.ip_source_init } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ip_source_init}] ${MODELPARAM_VALUE.ip_source_init}
}

proc update_MODELPARAM_VALUE.ip_dest_init { MODELPARAM_VALUE.ip_dest_init PARAM_VALUE.ip_dest_init } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ip_dest_init}] ${MODELPARAM_VALUE.ip_dest_init}
}

proc update_MODELPARAM_VALUE.udp_port_source_init { MODELPARAM_VALUE.udp_port_source_init PARAM_VALUE.udp_port_source_init } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.udp_port_source_init}] ${MODELPARAM_VALUE.udp_port_source_init}
}

proc update_MODELPARAM_VALUE.udp_port_dest_init { MODELPARAM_VALUE.udp_port_dest_init PARAM_VALUE.udp_port_dest_init } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.udp_port_dest_init}] ${MODELPARAM_VALUE.udp_port_dest_init}
}

