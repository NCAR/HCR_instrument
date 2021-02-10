
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] sources_1/new/gui/px_axil_nativefifo_ctlr_v0_01.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "number_fifo_data_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fifo_write_intrfc" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fifo_read_intrfc" -parent ${Page_0}
  ipgui::add_param $IPINST -name "read_latency" -parent ${Page_0} -layout horizontal


}

proc update_PARAM_VALUE.read_latency { PARAM_VALUE.read_latency PARAM_VALUE.has_fifo_read_intrfc } {
	# Procedure called to update read_latency when any of the dependent parameters in the arguments change
	
	set read_latency ${PARAM_VALUE.read_latency}
	set has_fifo_read_intrfc ${PARAM_VALUE.has_fifo_read_intrfc}
	set values(has_fifo_read_intrfc) [get_property value $has_fifo_read_intrfc]
	if { [gen_USERPARAMETER_read_latency_ENABLEMENT $values(has_fifo_read_intrfc)] } {
		set_property enabled true $read_latency
	} else {
		set_property enabled false $read_latency
	}
}

proc validate_PARAM_VALUE.read_latency { PARAM_VALUE.read_latency } {
	# Procedure called to validate read_latency
	return true
}

proc update_PARAM_VALUE.has_fifo_read_intrfc { PARAM_VALUE.has_fifo_read_intrfc } {
	# Procedure called to update has_fifo_read_intrfc when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fifo_read_intrfc { PARAM_VALUE.has_fifo_read_intrfc } {
	# Procedure called to validate has_fifo_read_intrfc
	return true
}

proc update_PARAM_VALUE.has_fifo_write_intrfc { PARAM_VALUE.has_fifo_write_intrfc } {
	# Procedure called to update has_fifo_write_intrfc when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fifo_write_intrfc { PARAM_VALUE.has_fifo_write_intrfc } {
	# Procedure called to validate has_fifo_write_intrfc
	return true
}

proc update_PARAM_VALUE.number_fifo_data_bits { PARAM_VALUE.number_fifo_data_bits } {
	# Procedure called to update number_fifo_data_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.number_fifo_data_bits { PARAM_VALUE.number_fifo_data_bits } {
	# Procedure called to validate number_fifo_data_bits
	return true
}


proc update_MODELPARAM_VALUE.number_fifo_data_bits { MODELPARAM_VALUE.number_fifo_data_bits PARAM_VALUE.number_fifo_data_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.number_fifo_data_bits}] ${MODELPARAM_VALUE.number_fifo_data_bits}
}

proc update_MODELPARAM_VALUE.has_fifo_read_intrfc { MODELPARAM_VALUE.has_fifo_read_intrfc PARAM_VALUE.has_fifo_read_intrfc } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fifo_read_intrfc}] ${MODELPARAM_VALUE.has_fifo_read_intrfc}
}

proc update_MODELPARAM_VALUE.has_fifo_write_intrfc { MODELPARAM_VALUE.has_fifo_write_intrfc PARAM_VALUE.has_fifo_write_intrfc } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fifo_write_intrfc}] ${MODELPARAM_VALUE.has_fifo_write_intrfc}
}

proc update_MODELPARAM_VALUE.read_latency { MODELPARAM_VALUE.read_latency PARAM_VALUE.read_latency } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.read_latency}] ${MODELPARAM_VALUE.read_latency}
}

