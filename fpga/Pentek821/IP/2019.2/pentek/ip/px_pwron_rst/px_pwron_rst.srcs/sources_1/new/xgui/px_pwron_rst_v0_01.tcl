# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "has_rst_input" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_rst_n_output" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_rst_output" -parent ${Page_0}
  ipgui::add_param $IPINST -name "rst_clk_cycles" -parent ${Page_0}


}

proc update_PARAM_VALUE.has_rst_input { PARAM_VALUE.has_rst_input } {
	# Procedure called to update has_rst_input when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_rst_input { PARAM_VALUE.has_rst_input } {
	# Procedure called to validate has_rst_input
	return true
}

proc update_PARAM_VALUE.has_rst_n_output { PARAM_VALUE.has_rst_n_output } {
	# Procedure called to update has_rst_n_output when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_rst_n_output { PARAM_VALUE.has_rst_n_output } {
	# Procedure called to validate has_rst_n_output
	return true
}

proc update_PARAM_VALUE.has_rst_output { PARAM_VALUE.has_rst_output } {
	# Procedure called to update has_rst_output when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_rst_output { PARAM_VALUE.has_rst_output } {
	# Procedure called to validate has_rst_output
	return true
}

proc update_PARAM_VALUE.rst_clk_cycles { PARAM_VALUE.rst_clk_cycles } {
	# Procedure called to update rst_clk_cycles when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.rst_clk_cycles { PARAM_VALUE.rst_clk_cycles } {
	# Procedure called to validate rst_clk_cycles
	return true
}


proc update_MODELPARAM_VALUE.rst_clk_cycles { MODELPARAM_VALUE.rst_clk_cycles PARAM_VALUE.rst_clk_cycles } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.rst_clk_cycles}] ${MODELPARAM_VALUE.rst_clk_cycles}
}

proc update_MODELPARAM_VALUE.has_rst_input { MODELPARAM_VALUE.has_rst_input PARAM_VALUE.has_rst_input } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_rst_input}] ${MODELPARAM_VALUE.has_rst_input}
}

proc update_MODELPARAM_VALUE.has_rst_output { MODELPARAM_VALUE.has_rst_output PARAM_VALUE.has_rst_output } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_rst_output}] ${MODELPARAM_VALUE.has_rst_output}
}

proc update_MODELPARAM_VALUE.has_rst_n_output { MODELPARAM_VALUE.has_rst_n_output PARAM_VALUE.has_rst_n_output } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_rst_n_output}] ${MODELPARAM_VALUE.has_rst_n_output}
}

