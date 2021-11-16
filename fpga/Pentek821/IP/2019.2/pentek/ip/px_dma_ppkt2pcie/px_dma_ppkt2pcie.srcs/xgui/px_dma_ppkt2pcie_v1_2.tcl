# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set lite [ipgui::add_param $IPINST -name "lite" -parent ${Page_0}]
  set_property tooltip {Uses Less Resources, but with 1/2 Maximum Throughput and only 16K Input FIFO} ${lite}
  ipgui::add_static_text $IPINST -name "text2" -parent ${Page_0} -text {Note: If DMA Lite is selected, FIFO size is a fixed 16k.
}
  ipgui::add_param $IPINST -name "input_word_width" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "fifo_size" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "text1" -parent ${Page_0} -text {0 = 32k, 1 = 64k, 2=128k}
  ipgui::add_param $IPINST -name "pcie_channel" -parent ${Page_0}
  ipgui::add_param $IPINST -name "has_fifo_full_led" -parent ${Page_0}


}

proc update_PARAM_VALUE.fifo_size { PARAM_VALUE.fifo_size } {
	# Procedure called to update fifo_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.fifo_size { PARAM_VALUE.fifo_size } {
	# Procedure called to validate fifo_size
	return true
}

proc update_PARAM_VALUE.has_fifo_full_led { PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to update has_fifo_full_led when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.has_fifo_full_led { PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to validate has_fifo_full_led
	return true
}

proc update_PARAM_VALUE.input_word_width { PARAM_VALUE.input_word_width } {
	# Procedure called to update input_word_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.input_word_width { PARAM_VALUE.input_word_width } {
	# Procedure called to validate input_word_width
	return true
}

proc update_PARAM_VALUE.lite { PARAM_VALUE.lite } {
	# Procedure called to update lite when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.lite { PARAM_VALUE.lite } {
	# Procedure called to validate lite
	return true
}

proc update_PARAM_VALUE.pcie_channel { PARAM_VALUE.pcie_channel } {
	# Procedure called to update pcie_channel when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.pcie_channel { PARAM_VALUE.pcie_channel } {
	# Procedure called to validate pcie_channel
	return true
}


proc update_MODELPARAM_VALUE.pcie_channel { MODELPARAM_VALUE.pcie_channel PARAM_VALUE.pcie_channel } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.pcie_channel}] ${MODELPARAM_VALUE.pcie_channel}
}

proc update_MODELPARAM_VALUE.input_word_width { MODELPARAM_VALUE.input_word_width PARAM_VALUE.input_word_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.input_word_width}] ${MODELPARAM_VALUE.input_word_width}
}

proc update_MODELPARAM_VALUE.fifo_size { MODELPARAM_VALUE.fifo_size PARAM_VALUE.fifo_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.fifo_size}] ${MODELPARAM_VALUE.fifo_size}
}

proc update_MODELPARAM_VALUE.has_fifo_full_led { MODELPARAM_VALUE.has_fifo_full_led PARAM_VALUE.has_fifo_full_led } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.has_fifo_full_led}] ${MODELPARAM_VALUE.has_fifo_full_led}
}

proc update_MODELPARAM_VALUE.lite { MODELPARAM_VALUE.lite PARAM_VALUE.lite } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.lite}] ${MODELPARAM_VALUE.lite}
}

