# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_static_text $IPINST -name "addrtxt" -parent ${Page_0} -text {This Core Is Compatible with the Gen3 PCIe Core when
set to 256-bit AXI-S interface and Address Aligned
Mode Selected.
}
  ipgui::add_static_text $IPINST -name "spc1" -parent ${Page_0} -text {}
  ipgui::add_param $IPINST -name "num_addr_bits" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "spc" -parent ${Page_0} -text {}
  ipgui::add_param $IPINST -name "bar0_addr_translation" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar0_size_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar1_addr_translation" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar1_size_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar2_addr_translation" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar2_size_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar3_addr_translation" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar3_size_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar4_addr_translation" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar4_size_bits" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar5_addr_translation" -parent ${Page_0}
  ipgui::add_param $IPINST -name "bar5_size_bits" -parent ${Page_0}


}

proc update_PARAM_VALUE.bar0_addr_translation { PARAM_VALUE.bar0_addr_translation } {
	# Procedure called to update bar0_addr_translation when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar0_addr_translation { PARAM_VALUE.bar0_addr_translation } {
	# Procedure called to validate bar0_addr_translation
	return true
}

proc update_PARAM_VALUE.bar0_size_bits { PARAM_VALUE.bar0_size_bits } {
	# Procedure called to update bar0_size_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar0_size_bits { PARAM_VALUE.bar0_size_bits } {
	# Procedure called to validate bar0_size_bits
	return true
}

proc update_PARAM_VALUE.bar1_addr_translation { PARAM_VALUE.bar1_addr_translation } {
	# Procedure called to update bar1_addr_translation when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar1_addr_translation { PARAM_VALUE.bar1_addr_translation } {
	# Procedure called to validate bar1_addr_translation
	return true
}

proc update_PARAM_VALUE.bar1_size_bits { PARAM_VALUE.bar1_size_bits } {
	# Procedure called to update bar1_size_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar1_size_bits { PARAM_VALUE.bar1_size_bits } {
	# Procedure called to validate bar1_size_bits
	return true
}

proc update_PARAM_VALUE.bar2_addr_translation { PARAM_VALUE.bar2_addr_translation } {
	# Procedure called to update bar2_addr_translation when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar2_addr_translation { PARAM_VALUE.bar2_addr_translation } {
	# Procedure called to validate bar2_addr_translation
	return true
}

proc update_PARAM_VALUE.bar2_size_bits { PARAM_VALUE.bar2_size_bits } {
	# Procedure called to update bar2_size_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar2_size_bits { PARAM_VALUE.bar2_size_bits } {
	# Procedure called to validate bar2_size_bits
	return true
}

proc update_PARAM_VALUE.bar3_addr_translation { PARAM_VALUE.bar3_addr_translation } {
	# Procedure called to update bar3_addr_translation when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar3_addr_translation { PARAM_VALUE.bar3_addr_translation } {
	# Procedure called to validate bar3_addr_translation
	return true
}

proc update_PARAM_VALUE.bar3_size_bits { PARAM_VALUE.bar3_size_bits } {
	# Procedure called to update bar3_size_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar3_size_bits { PARAM_VALUE.bar3_size_bits } {
	# Procedure called to validate bar3_size_bits
	return true
}

proc update_PARAM_VALUE.bar4_addr_translation { PARAM_VALUE.bar4_addr_translation } {
	# Procedure called to update bar4_addr_translation when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar4_addr_translation { PARAM_VALUE.bar4_addr_translation } {
	# Procedure called to validate bar4_addr_translation
	return true
}

proc update_PARAM_VALUE.bar4_size_bits { PARAM_VALUE.bar4_size_bits } {
	# Procedure called to update bar4_size_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar4_size_bits { PARAM_VALUE.bar4_size_bits } {
	# Procedure called to validate bar4_size_bits
	return true
}

proc update_PARAM_VALUE.bar5_addr_translation { PARAM_VALUE.bar5_addr_translation } {
	# Procedure called to update bar5_addr_translation when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar5_addr_translation { PARAM_VALUE.bar5_addr_translation } {
	# Procedure called to validate bar5_addr_translation
	return true
}

proc update_PARAM_VALUE.bar5_size_bits { PARAM_VALUE.bar5_size_bits } {
	# Procedure called to update bar5_size_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.bar5_size_bits { PARAM_VALUE.bar5_size_bits } {
	# Procedure called to validate bar5_size_bits
	return true
}

proc update_PARAM_VALUE.num_addr_bits { PARAM_VALUE.num_addr_bits } {
	# Procedure called to update num_addr_bits when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.num_addr_bits { PARAM_VALUE.num_addr_bits } {
	# Procedure called to validate num_addr_bits
	return true
}


proc update_MODELPARAM_VALUE.num_addr_bits { MODELPARAM_VALUE.num_addr_bits PARAM_VALUE.num_addr_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.num_addr_bits}] ${MODELPARAM_VALUE.num_addr_bits}
}

proc update_MODELPARAM_VALUE.bar0_size_bits { MODELPARAM_VALUE.bar0_size_bits PARAM_VALUE.bar0_size_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar0_size_bits}] ${MODELPARAM_VALUE.bar0_size_bits}
}

proc update_MODELPARAM_VALUE.bar0_addr_translation { MODELPARAM_VALUE.bar0_addr_translation PARAM_VALUE.bar0_addr_translation } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar0_addr_translation}] ${MODELPARAM_VALUE.bar0_addr_translation}
}

proc update_MODELPARAM_VALUE.bar1_size_bits { MODELPARAM_VALUE.bar1_size_bits PARAM_VALUE.bar1_size_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar1_size_bits}] ${MODELPARAM_VALUE.bar1_size_bits}
}

proc update_MODELPARAM_VALUE.bar1_addr_translation { MODELPARAM_VALUE.bar1_addr_translation PARAM_VALUE.bar1_addr_translation } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar1_addr_translation}] ${MODELPARAM_VALUE.bar1_addr_translation}
}

proc update_MODELPARAM_VALUE.bar2_size_bits { MODELPARAM_VALUE.bar2_size_bits PARAM_VALUE.bar2_size_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar2_size_bits}] ${MODELPARAM_VALUE.bar2_size_bits}
}

proc update_MODELPARAM_VALUE.bar2_addr_translation { MODELPARAM_VALUE.bar2_addr_translation PARAM_VALUE.bar2_addr_translation } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar2_addr_translation}] ${MODELPARAM_VALUE.bar2_addr_translation}
}

proc update_MODELPARAM_VALUE.bar3_size_bits { MODELPARAM_VALUE.bar3_size_bits PARAM_VALUE.bar3_size_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar3_size_bits}] ${MODELPARAM_VALUE.bar3_size_bits}
}

proc update_MODELPARAM_VALUE.bar3_addr_translation { MODELPARAM_VALUE.bar3_addr_translation PARAM_VALUE.bar3_addr_translation } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar3_addr_translation}] ${MODELPARAM_VALUE.bar3_addr_translation}
}

proc update_MODELPARAM_VALUE.bar4_size_bits { MODELPARAM_VALUE.bar4_size_bits PARAM_VALUE.bar4_size_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar4_size_bits}] ${MODELPARAM_VALUE.bar4_size_bits}
}

proc update_MODELPARAM_VALUE.bar4_addr_translation { MODELPARAM_VALUE.bar4_addr_translation PARAM_VALUE.bar4_addr_translation } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar4_addr_translation}] ${MODELPARAM_VALUE.bar4_addr_translation}
}

proc update_MODELPARAM_VALUE.bar5_size_bits { MODELPARAM_VALUE.bar5_size_bits PARAM_VALUE.bar5_size_bits } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar5_size_bits}] ${MODELPARAM_VALUE.bar5_size_bits}
}

proc update_MODELPARAM_VALUE.bar5_addr_translation { MODELPARAM_VALUE.bar5_addr_translation PARAM_VALUE.bar5_addr_translation } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.bar5_addr_translation}] ${MODELPARAM_VALUE.bar5_addr_translation}
}

