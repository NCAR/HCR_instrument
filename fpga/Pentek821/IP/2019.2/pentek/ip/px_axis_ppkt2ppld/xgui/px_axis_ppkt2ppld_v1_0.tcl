# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "word_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "tdest_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "default_packet_size" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fifo_rst_in_n" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_override" -parent ${Page_0}


}

proc update_PARAM_VALUE.default_packet_size { PARAM_VALUE.default_packet_size } {
	# Procedure called to update default_packet_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.default_packet_size { PARAM_VALUE.default_packet_size } {
	# Procedure called to validate default_packet_size
	return true
}

proc update_PARAM_VALUE.has_fifo_rst_in_n { PARAM_VALUE.has_fifo_rst_in_n } {
	# Procedure called to update has_fifo_rst_in_n when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fifo_rst_in_n { PARAM_VALUE.has_fifo_rst_in_n } {
	# Procedure called to validate has_fifo_rst_in_n
	return true
}

proc update_PARAM_VALUE.has_override { PARAM_VALUE.has_override } {
	# Procedure called to update has_override when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_override { PARAM_VALUE.has_override } {
	# Procedure called to validate has_override
	return true
}

proc update_PARAM_VALUE.tdest_width { PARAM_VALUE.tdest_width } {
	# Procedure called to update tdest_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.tdest_width { PARAM_VALUE.tdest_width } {
	# Procedure called to validate tdest_width
	return true
}

proc update_PARAM_VALUE.word_width { PARAM_VALUE.word_width } {
	# Procedure called to update word_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.word_width { PARAM_VALUE.word_width } {
	# Procedure called to validate word_width
	return true
}


proc update_MODELPARAM_VALUE.word_width { MODELPARAM_VALUE.word_width PARAM_VALUE.word_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.word_width}] ${MODELPARAM_VALUE.word_width}
}

proc update_MODELPARAM_VALUE.default_packet_size { MODELPARAM_VALUE.default_packet_size PARAM_VALUE.default_packet_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.default_packet_size}] ${MODELPARAM_VALUE.default_packet_size}
}

proc update_MODELPARAM_VALUE.has_override { MODELPARAM_VALUE.has_override PARAM_VALUE.has_override } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_override}] ${MODELPARAM_VALUE.has_override}
}

proc update_MODELPARAM_VALUE.has_fifo_rst_in_n { MODELPARAM_VALUE.has_fifo_rst_in_n PARAM_VALUE.has_fifo_rst_in_n } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fifo_rst_in_n}] ${MODELPARAM_VALUE.has_fifo_rst_in_n}
}

proc update_MODELPARAM_VALUE.tdest_width { MODELPARAM_VALUE.tdest_width PARAM_VALUE.tdest_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.tdest_width}] ${MODELPARAM_VALUE.tdest_width}
}

